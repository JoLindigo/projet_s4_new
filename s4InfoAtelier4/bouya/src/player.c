#include "player.h"

struct Player initialize_player(){
    struct Player player;
    player.x = 90;
    player.y = 64;
    player.CurrentAnimation = RUNNING;
    return player;
}

void move_player(struct Player* player, int x, int y) {
    player->x += x;
    player->y += y;
}
