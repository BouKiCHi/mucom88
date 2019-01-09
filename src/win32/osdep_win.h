// OsDependent 
// BouKiCHi 2019

#ifndef _OS_DEP_WIN_H_
#define _OS_DEP_WIN_H_

#include <stdint.h>
#include "../osdep.h"
#include "soundds.h"
#include "realchip.h"

class mucomvm;

class OsDependentWin32 : public OsDependent {
public:
	OsDependentWin32();
	~OsDependentWin32();

	// COMの初期化(最初の１回のみ)
	bool CoInitialize();

	// サウンド
	bool InitAudio(void *hwnd, int Rate, int BufferSize);
	void FreeAudio();
	bool SendAudio();
	void WaitSendingAudio();

	// 実チップ
	bool InitRealChip();
	void FreeRealChip();
	void ResetRealChip();
	int CheckRealChip();
	void OutputRealChip(unsigned int Register, unsigned int Data);
	void OutputRealChipAdpcm(void *pData, int size);

	// タイマー
	bool InitTimer();
	void FreeTimer();
	void UpdateTimer();
	void ResetTime();
	int GetElapsedTime();

	// 時間
	int GetMilliseconds();
	void Delay(int ms);


private:
	//		親のVMインスタンス
	mucomvm *vm;

	//		サウンド再生
	WinSoundDriver::DriverDS *snddrv;
	HWND master_window;

	//		タイマー
	static void CALLBACK TimeProc(UINT, UINT, DWORD, DWORD, DWORD);
	static DWORD WINAPI vThreadFunc(LPVOID pParam);

	int StartThread(void);
	int StopThread(void);
	void StreamSend(void);
	void ThreadFunc(void);

	UINT timer_period;
	UINT timerid;

	bool threadflag;

	int64_t last_ft;

	HANDLE hevent;
	HANDLE hthread;
	DWORD threadid;
	LONG sending;

	//		実チップ対応
	realchip *RealChipInstance;

};


#endif
