#include "player.h"

struct Player* initialize_player(){
    struct Player* player = malloc(sizeof(struct Player));
    player->x = 90;
    player->y = 90;
    player->CurrentAnimation = RUNNING;
    return player;
}

void move_player(struct Player* player, int x, int y) {
    player->x += x;
    player->y += y;
}
