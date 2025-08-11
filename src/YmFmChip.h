// YmFmChip.h
#pragma once

#include "ymfm.h"
#include "ymfm_opn.h"

#include "IFmSoundChip.h"


//*********************************************************
//  GLOBAL TYPES
//*********************************************************

// we use an int64_t as emulated time, as a 32.32 fixed point value
using emulated_time = int64_t;

class YmFmChip : public IFmSoundChip {
public:
    YmFmChip();
    ~YmFmChip();

    void Reset();
    bool Init(uint c, uint r, bool ipflag = false, const char* path = 0);

    void SetRate(uint bc, uint rate, bool ipflag = false);

    uint8* GetADPCMBuffer();

    void SetVolumeFM(int vol);
    void SetVolumePSG(int vol);

    void SetReg(uint addr, uint data);
    uint GetReg(uint addr);

    bool Count(int32 us);

    void Mix(FM::Sample* buffer, int nsamples);

private:
    uint8* adpcmbuf;
    emulated_time output_step = 0;
    emulated_time output_pos = 0;

	// サンプルを進めるための時間
    emulated_time count_us = 0;

    int output_rate = 44100;
};