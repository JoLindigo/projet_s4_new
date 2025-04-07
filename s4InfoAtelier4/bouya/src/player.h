#ifndef __PLAYER_H_
#define __PLAYER_H_

enum PlayerAnimation {IDLE, JUMP, RUNNING};

struct Player {
    int x;
    int y;
    enum PlayerAnimation CurrentAnimation;
};

struct Player* initialize_player();
void move_player(struct Player*, int, int);
#endif
