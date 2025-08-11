#include "YmFmChip.h"

#define LOG_WRITES (0)
// run this many dummy clocks of each chip before generating
#define EXTRA_CLOCKS (0)

// enable this to run the nuked OPN2 core in parallel; output is not captured,
// but logging can be added to observe behaviors
#define RUN_NUKED_OPN2 (0)

// enumeration of the different types of chips we support
enum chip_type
{
	CHIP_YM2149,
	CHIP_YM2151,
	CHIP_YM2203,
	CHIP_YM2413,
	CHIP_YM2608,
	CHIP_YM2610,
	CHIP_YM2612,
	CHIP_YM3526,
	CHIP_Y8950,
	CHIP_YM3812,
	CHIP_YMF262,
	CHIP_YMF278B,
	CHIP_TYPES
};


//*********************************************************
//  CLASSES
//*********************************************************

// ======================> vgm_chip_base

// abstract base class for a Yamaha chip; we keep a list of these for processing
// as new commands come in
class vgm_chip_base
{
public:
	// construction
	vgm_chip_base(uint32_t clock, chip_type type, char const *name) :
		m_type(type),
		m_name(name)
	{
	}

	// destruction
	virtual ~vgm_chip_base()
	{
	}

	// タイマーを進める
	virtual void advance_timer(int us) { }

	// simple getters
	chip_type type() const { return m_type; }
	virtual uint32_t sample_rate() const = 0;

    virtual uint8_t read(uint32_t adr) = 0;

	// IRQ読み出し
	bool read_irq() {
		return irq_asserted;
	}

	// ADPCMバッファの設定
	virtual void set_adpcm(uint8_t* buf, int len) {
		adpcm_buf = buf;
		adpcm_buflen = len;
	}

	// required methods for derived classes to implement
	virtual void write(uint32_t reg, uint8_t data) = 0;
	virtual void generate(emulated_time output_start, emulated_time output_step, int32_t *buffer) = 0;

	// write data to the ADPCM-A buffer
	void write_data(ymfm::access_class type, uint32_t base, uint32_t length, uint8_t const *src)
	{
		uint32_t end = base + length;
		if (end > m_data[type].size())
			m_data[type].resize(end);
		memcpy(&m_data[type][base], src, length);
	}

	// seek within the PCM stream
	void seek_pcm(uint32_t pos) { m_pcm_offset = pos; }
	uint8_t read_pcm() { 
		auto &pcm = m_data[ymfm::ACCESS_PCM];
		return (m_pcm_offset < pcm.size()) ? pcm[m_pcm_offset++] : 0; 
	}

protected:
	uint8_t* adpcm_buf = nullptr;
	int adpcm_buflen = 0;
	bool irq_asserted = false;
	// internal state
	chip_type m_type;
	std::string m_name;
	std::vector<uint8_t> m_data[ymfm::ACCESS_CLASSES];
	uint32_t m_pcm_offset = 0;
#if (CAPTURE_NATIVE)
public:
	std::vector<int32_t> m_native_data;
#endif
#if (RUN_NUKED_OPN2)
public:
	nuked::ym3438_t *m_external = nullptr;
	std::vector<int32_t> m_nuked_data;
#endif
};


// ======================> vgm_chip

// actual chip-specific implementation class; includes implementatino of the
// ymfm_interface as needed for vgmplay purposes
template<typename ChipType>
class vgm_chip : public vgm_chip_base, public ymfm::ymfm_interface
{
public:
	// construction
	vgm_chip(uint32_t clock, chip_type type, char const *name) :
		vgm_chip_base(clock, type, name),
		m_chip(*this),
		m_clock(clock),
		m_clocks(0),
		m_step(0x100000000ull / m_chip.sample_rate(clock)),
		m_pos(0)
	{
		m_clock_per_us = (m_clock / 1000000);
		m_chip.reset();
	}

	// タイマーを進める
	virtual void advance_timer(int us) override {
		if (first_timer_enable) {
			first_timer_duration -= us * m_clock_per_us;
			if (first_timer_duration <= 0) {
				m_engine->engine_timer_expired(0);
			}
		}

		if (second_timer_enable) {
			second_timer_duration -= us * m_clock_per_us;
			if (second_timer_duration <= 0) {
				m_engine->engine_timer_expired(1);
			}
		}
	}

	// タイマー設定
	virtual void ymfm_set_timer(uint32_t tnum, int32_t duration_in_clocks) {
		if (tnum == 0) {
			if (duration_in_clocks < 0) {
				first_timer_enable = false;
				first_timer_duration = 0;
			} else {
				first_timer_enable = true;
				first_timer_duration += duration_in_clocks;
			}
		}
		if (tnum == 1) {
			if (duration_in_clocks < 0) {
				second_timer_enable = false;
				second_timer_duration = 0;
			}
			else {
				second_timer_enable = true;
				second_timer_duration += duration_in_clocks;
			}
		}
	}


	virtual void ymfm_update_irq(bool asserted) override {
		irq_asserted = asserted;
	}

    virtual uint8_t read(uint32_t adr) override {
		uint32_t addr1 = 0xffff, addr2 = 0xffff;
		uint8_t data1 = 0;

		addr1 = 0 + 2 * ((adr >> 8) & 3);
		data1 = adr & 0xff;
		addr2 = addr1 + ((m_type == CHIP_YM2149) ? 2 : 1);

		m_chip.write(addr1, data1);

        return m_chip.read(addr2);
    }

	virtual uint32_t sample_rate() const override
	{
		return m_chip.sample_rate(m_clock);
	}

	// チップへの書き込み
	virtual void write(uint32_t reg, uint8_t data) override
	{
		uint32_t addr1 = 0xffff, addr2 = 0xffff;
		uint8_t data1 = 0, data2 = 0;
		addr1 = 0 + 2 * ((reg >> 8) & 3);
		data1 = reg & 0xff;
		addr2 = addr1 + ((m_type == CHIP_YM2149) ? 2 : 1);
		data2 = data;
		if (addr1 != 0xffff)
		{
			m_chip.write(addr1, data1);
			m_chip.write(addr2, data2);
		}
	}

	// generate one output sample of output
	virtual void generate(emulated_time output_start, emulated_time output_step, int32_t *buffer) override
	{
		for ( ; m_pos <= output_start; m_pos += m_step)
		{
			m_chip.generate(&m_output);
		}

		// add the final result to the buffer
		if (m_type == CHIP_YM2203)
		{
			int32_t out0 = m_output.data[0];
			int32_t out1 = m_output.data[1 % ChipType::OUTPUTS];
			int32_t out2 = m_output.data[2 % ChipType::OUTPUTS];
			int32_t out3 = m_output.data[3 % ChipType::OUTPUTS];
			*buffer++ += out0 + out1 + out2 + out3;
			*buffer++ += out0 + out1 + out2 + out3;
		}
		else if (m_type == CHIP_YM2608 || m_type == CHIP_YM2610)
		{
			int32_t out0 = m_output.data[0];
			int32_t out1 = m_output.data[1 % ChipType::OUTPUTS];
			int32_t out2 = m_output.data[2 % ChipType::OUTPUTS];
			*buffer++ += out0 + out2;
			*buffer++ += out1 + out2;
		}
		else if (m_type == CHIP_YMF278B)
		{
			*buffer++ += m_output.data[4 % ChipType::OUTPUTS];
			*buffer++ += m_output.data[5 % ChipType::OUTPUTS];
		}
		else if (ChipType::OUTPUTS == 1)
		{
			*buffer++ += m_output.data[0];
			*buffer++ += m_output.data[0];
		}
		else
		{
			*buffer++ += m_output.data[0];
			*buffer++ += m_output.data[1 % ChipType::OUTPUTS];
		}
		m_clocks++;
	}

protected:
	// handle a read from the buffer
	virtual uint8_t ymfm_external_read(ymfm::access_class type, uint32_t offset) override
	{
		if (type == ymfm::ACCESS_ADPCM_B)
		{
			if (offset >= (uint32_t)adpcm_buflen)
				return 0;

			return adpcm_buf[offset];
		}

		auto &data = m_data[type];
		return (offset < data.size()) ? data[offset] : 0;
	}

	bool first_timer_enable = false;
	bool second_timer_enable = false;
	int32_t first_timer_duration = 0;
	int32_t second_timer_duration = 0;

	// internal state
	ChipType m_chip;
	uint32_t m_clock_per_us;
	uint32_t m_clock;
	uint64_t m_clocks;
	typename ChipType::output_data m_output;
	emulated_time m_step;
	emulated_time m_pos;
	std::vector<std::pair<uint32_t, uint8_t>> m_queue;
};


//*********************************************************
//  GLOBAL HELPERS
//*********************************************************

vgm_chip_base* current_chip = nullptr;


// 新規 YM2608作成
vgm_chip<ymfm::ym2608> *new2608(uint32_t clock)
{
	char const* chipname = "YM2608";
	uint32_t clockval = clock & 0x3fffffff;
	int numchips = 1;
	printf("Adding %s @ %dHz\n", chipname, clockval);

	vgm_chip<ymfm::ym2608> *chip = new vgm_chip<ymfm::ym2608>(clockval, CHIP_YM2608, chipname);


	FILE* rom = fopen("ym2608_adpcm_rom.bin", "rb");
	if (rom == nullptr)
		fprintf(stderr, "Warning: YM2608 enabled but ym2608_adpcm_rom.bin not found\n");
	else
	{
		fseek(rom, 0, SEEK_END);
		uint32_t size = ftell(rom);
		fseek(rom, 0, SEEK_SET);
		std::vector<uint8_t> temp(size);
		fread(&temp[0], 1, size, rom);
		fclose(rom);
		chip->write_data(ymfm::ACCESS_ADPCM_A, 0, size, &temp[0]);
	}
	return chip;
}


YmFmChip::YmFmChip() {
	adpcmbuf = new uint8_t[0x40000];
	output_rate = 44100;
    output_step = 0x100000000ull / output_rate;
	output_pos = 0;
	// 初期化時にADPCMバッファをゼロクリア
	memset(adpcmbuf, 0, 0x40000);
}

YmFmChip::~YmFmChip() {
    delete[] adpcmbuf;
}

void YmFmChip::Reset() {
}

bool YmFmChip::Init(uint c, uint r, bool ipflag, const char* path) {
	return true;
}

// レジスタ書き込み
void YmFmChip::SetReg(uint addr, uint data) {
	current_chip->write(addr, data);
}

void YmFmChip::SetRate(uint bc, uint rate, bool ipflag) {
    // チップ作成。作成とクロック設定、初期化を分けられないため
	current_chip = new2608(bc);
	current_chip->set_adpcm(adpcmbuf, 0x40000);
	current_chip->write(0x29, 0xff);

    output_rate = rate;
    output_step = 0x100000000ull / output_rate;
	output_pos = 0;
}

uint YmFmChip::GetReg(uint addr) {
	return current_chip->read(addr);
}

uint8* YmFmChip::GetADPCMBuffer() {
    return adpcmbuf;
}

void YmFmChip::SetVolumeFM(int vol) {
}

void YmFmChip::SetVolumePSG(int vol) {
}

// マイクロ秒を加算する timer-Bが発火するとtrueとなる
bool YmFmChip::Count(int32_t us) {
	count_us += us;
	current_chip->advance_timer(us);
	return current_chip->read_irq();
}

void YmFmChip::Mix(FM::Sample* buffer, int nsamples) {
	// サンプルバッファが空になったら、チップからサンプルを生成する
	for (int i = 0; i < nsamples; i++) {
		int32_t outputs[2] = { 0 };
		current_chip->generate(output_pos, output_step, outputs);
		output_pos += output_step;
		buffer[0] = outputs[0];
		buffer[1] = outputs[1];
		buffer += 2;
	}
}