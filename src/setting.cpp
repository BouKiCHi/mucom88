#include "setting.h"

Setting::Setting() {
	TimerMode = TimerHigh;
}

Setting::~Setting() {
}

void Setting::SetTimerMode(int Level) {
	switch (Level) {
		case 1:
			TimerMode = TimerHigh;
			break;
		default:
			TimerMode = TimerNormal;
		break;
	}	
}