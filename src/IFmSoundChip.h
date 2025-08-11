// IFmSoundChip.h
#pragma once
#include "fmgen/opna.h"
#include "fmgen/types.h"

class IFmSoundChip {
public:
    virtual ~IFmSoundChip() = default;
    virtual void Reset() = 0;
    virtual bool Init(uint c, uint r, bool ipflag = false, const char* path = 0) = 0;
    virtual void SetRate(uint clock, uint rate, bool ipflag = false) = 0;
    virtual void SetVolumeFM(int vol) = 0;
    virtual void SetVolumePSG(int vol) = 0;
    virtual uint8* GetADPCMBuffer() = 0;

    virtual uint GetReg(uint addr) = 0;
    virtual void SetReg(uint addr, uint data) = 0;

    virtual bool Count(int32 us) = 0;

    virtual void Mix(FM::Sample* buffer, int nsamples) = 0;
};
