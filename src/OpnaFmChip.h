// OpnaFmChip.h
#pragma once

#include "IFmSoundChip.h"
#include "fmgen/opna.h"

class OpnaFmChip : public IFmSoundChip {
    FM::OPNA opna;
public:
    OpnaFmChip() : opna() {}
    void Reset() override { opna.Reset(); }
    void SetReg(uint addr, uint data) override { opna.SetReg(addr, data); }
    void Mix(FM::Sample* buffer, int nsamples) override {
        opna.Mix(buffer, nsamples);
    }

    bool Init(uint c, uint r, bool ipflag = false, const char* path = 0) override {
        return opna.Init(c, r, ipflag, path);
    }

    void SetRate(uint bc, uint rate, bool ipflag = false) override {
        opna.SetRate(bc, rate, ipflag);
    }

    uint GetReg(uint addr) override { return opna.GetReg(addr); }

    uint8* GetADPCMBuffer() override { return opna.GetADPCMBuffer(); }

    void SetVolumeFM(int vol) override { opna.SetVolumeFM(vol); }
    void SetVolumePSG(int vol) override { opna.SetVolumePSG(vol); }

    bool Count(int32 us) override {
        return opna.Count(us);
	}
};