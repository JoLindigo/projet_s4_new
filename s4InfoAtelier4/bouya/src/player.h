#ifndef __PLAYER_H_
#define __PLAYER_H_
#include "common.h"

enum PlayerAnimation {IDLE, JUMP, RUNNING};

struct Player {
	u16 x;
	u16 y;
    enum PlayerAnimation CurrentAnimation;
};

struct Player initialize_player(u16 height, u16 width);
void move_player(struct Player*, int, int);
#endif
