#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "pcmentry.h"

PcmEntry::PcmEntry() {
	adrl = 0;
	adrh = 0;
	pcmopt = 0;
	filesize = 0;
	memset(name, 0x00, sizeof(name));
	pcmstart = 0;
	data = NULL;
}

PcmEntry::~PcmEntry() {
    if (data != NULL) delete[] data;
}

void PcmEntry::SetEntry(unsigned char *entry) {
	memset(entry, 0x00, 0x20);

	int len = strlen(name);
	strncpy((char*)entry, name, 16);
	if (len < 16) memset(entry + len, 0x20, 16 - len);
	unsigned int adpcmsize = filesize & 0xfffffffc;


	WriteWord(entry + 0x10, 0x00);
	WriteWord(entry + 0x12, filesize);
	WriteWord(entry + 0x1a, pcmopt);
	WriteWord(entry + 0x1c, pcmstart);
	WriteWord(entry + 0x1e, adpcmsize);
}

int PcmEntry::GetLength() {
	return filesize;
}

void PcmEntry::WriteWord(unsigned char *data, int value) {
	data[0] = value & 0xff;
	data[1] = (value >> 8) & 0xff;
}

void PcmEntry::SetStart(int start) {
	pcmstart = start;
}

bool PcmEntry::SetData(const char *name, const char *binfile) {
	strcpy(this->name, name);

    FILE *fp = fopen(binfile, "rb");
    if (fp == NULL) { return false; }

    fseek(fp,0,SEEK_END);
    filesize = (int)ftell(fp);
    fseek(fp,0,SEEK_SET);

    data = new unsigned char[filesize];
    fread(data, filesize, 1, fp);
    fclose(fp);

    return true;
}

