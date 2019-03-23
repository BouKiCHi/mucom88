#pragma once

enum TimerModeEnum { TimerNormal = 0, TimerHigh = 1, };

class Setting {
public:
	TimerModeEnum TimerMode;

	Setting();
	~Setting();

	void SetTimerMode(int Level);

};

