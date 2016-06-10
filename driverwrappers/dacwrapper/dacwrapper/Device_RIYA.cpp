//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#include "Device_RIYA.h"
#include "windows.h"
#include <thread>

Device_RIYA::Device_RIYA()
{
	pointPeriod = 10000;
	ready = false;
}

Device_RIYA::~Device_RIYA()
{
	if (ready)
		StopRiyaDevice(riyaDeviceNum);
	if (riyaDeviceNum == 0)
		CloseAllRiyaDevices();
}

int Device_RIYA::Init(UINT8 pRiyaDeviceNum)
{
	HINSTANCE riyaLibrary = LoadLibrary(L"RiyaNetServer.dll");

	// Retrieve a pointer to each of the RIYA library functions,
	// and check to make sure that the pointer is valid...
	OpenAllRiyaDevices = (riyaFuncPtr1)GetProcAddress(riyaLibrary, "RiOpenDevices");
	if (!OpenAllRiyaDevices)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine RiOpenDevice!" << endl;
		return 0;
	}

	CloseAllRiyaDevices = (riyaFuncPtr2)GetProcAddress(riyaLibrary, "RiCloseDevices");
	if (CloseAllRiyaDevices == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine RiCloseDevices!" << endl;
		return 0;
	}

	InitRiyaDevice = (riyaFuncPtr3)GetProcAddress(riyaLibrary, "Ri_InitChanal");
	if (InitRiyaDevice == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine Ri_InitChanal!" << endl;
		return 0;
	}

	RiyaReadyForNextFrame = (riyaFuncPtr4)GetProcAddress(riyaLibrary, "Ri_SetIntCh");
	if (RiyaReadyForNextFrame == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine Ri_SetIntCh!" << endl;
		return 0;
	}

	StopRiyaDevice = (riyaFuncPtr4)GetProcAddress(riyaLibrary, "RiStopShow");
	if (StopRiyaDevice == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine RiStopShow!" << endl;
		return 0;
	}

	TransferFrameToBuffer = (riyaFuncPtr5)GetProcAddress(riyaLibrary, "RiSetShowCadr");
	if (TransferFrameToBuffer == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine RiSetShowCadr!" << endl;
		return 0;
	}

	GetIDVersionNumber = (riyaFuncPtr6)GetProcAddress(riyaLibrary, "GetVersionID");
	if (GetIDVersionNumber == NULL)
	{
		//logFile << "Device_RIYA::Open() - Can't load library routine RI_GetDevDesc!" << endl;
		return 0;
	}

	// We have the RIYA library routines we need.  Now look to see
	// if any physical devices are present...
	if (pRiyaDeviceNum == 0)
	{
		UINT8 riyaDevicesNumTotal = OpenAllRiyaDevices();
		//logFile << "Device_RIYA::Open() - Device count = " << (M_UINT16)riyaDevicesNum << endl;

		if (riyaDevicesNumTotal == 0)
		{
			//logFile << "Device_RIYA::Open() - No RIYA devices found!" << endl;
			return -1;
		}

		if (riyaDevicesNumTotal == 255)
		{
			//logFile << "Device_RIYA::Open() - No RIYA Drivers found!" << endl;
			return -2;
		}
	}


	 //Initialize the RIYA device
	riyaDeviceNum = pRiyaDeviceNum;
	InitRiyaDevice(riyaDeviceNum, RIYA_DEVICE_ATTRIBUTES);

	ready = true;
	return 1;
}

void Device_RIYA::outputFrameThreaded(int scanRate, int bufferSize, UINT8* bufferAddress)
{
	while (RiyaReadyForNextFrame(riyaDeviceNum) == 0);

	pointPeriod = (UINT)(1.0 / (double)scanRate * 33333333.3);

	TransferFrameToBuffer(	riyaDeviceNum,
							(UINT8*)bufferAddress,
							(UINT)bufferSize,
							pointPeriod,
							RIYA_FRAME_ATTRIBUTES_SYNC);
}

int Device_RIYA::OutputFrame(int scanRate, int bufferSize, UINT8* bufferAddress)
{
	if (!ready) 
		return 0;
	
	std::thread outputThread (&Device_RIYA::outputFrameThreaded,	this,	scanRate,
																			bufferSize,
																			bufferAddress);

	outputThread.detach();

	return 1;
}

int Device_RIYA::GetID()
{
	if (ready)
		return GetIDVersionNumber(riyaDeviceNum);
	else
		return -1;
}