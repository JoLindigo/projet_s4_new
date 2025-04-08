#ifndef __PLAYER_H_
#define __PLAYER_H_
#include "common.h"

enum PlayerAnimation {IDLE, JUMP, RUNNING};

struct Player {
	u8 x;
	u8 y;
    enum PlayerAnimation CurrentAnimation;
};

struct Player initialize_player();
void move_player(struct Player*, int, int);
#endif
