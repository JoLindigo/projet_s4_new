#include "player.h"

struct Player initialize_player(u16 height, u16 width){
    struct Player player;
    player.x = width;
    player.y = height;
    player.CurrentAnimation = RUNNING;
    return player;
}

void move_player(struct Player* player, int x, int y) {
    player->x += x;
    player->y += y;
}
