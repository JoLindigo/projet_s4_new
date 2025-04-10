#include "obstacle.h"
#include <stdlib.h>

struct Obstacle obstacles[MAX_OBSTACLES];

// reset des obstacles
void init_obstacles() {
    for (int i = 0; i < MAX_OBSTACLES; i++){
        obstacles[i].active = 0;
    }
}

void spawn_obstacle_group(int x, int y){  // x,y = coordinees ou on veut placer l'obstacle
    int group_size = (rand() % 2) + 1;    // Random 1 ou 2 obstacles
    int spawned = 0;

    for (int i = 0; i < MAX_OBSTACLES && spawned < group_size; i++){
        if (!obstacles[i].active){ // On check si obstacle i est libre
            obstacles[i].x = x + spawned * 16; 
            obstacles[i].y = y;
            obstacles[i].active = 1;
            spawned++;
        }    
    } 
}

// Met a jour les obstacles actifs en fonction du scroll horizontal
void update_obstacles(struct TileMap* map, int scroll_x){
    for (int i = 0; i < MAX_OBSTACLES; i++){
        if (obstacles[i].active){
            int screen_x = obstacles[i].x - scroll_x;  // Calculer la position a l'ecran

            if (screen_x + 16 < 0) {
                // Hors de l'ecran a gauche, disable
                obstacles[i].active = 0;
            }
            else if (screen_x < 256) {
                // Visible, on dessine l'obstacle a terre
                int tile_x = screen_x / 8;
                int tile_y = 28; // rangee du sol dans tilemap

                if (tile_x >= 0 && tile_x < map->width) {
                    map->tiles[tile_x][tile_y].tileId = 0;
                }
            }    
        }
    }
}

// Genere les obstacles a une intervale quelconque 
void generate_obstacles(struct TileMap* map, int scroll_x) {
    static int last_spawn_x = 0;
    int interval = rand() % 50 + 50; // Intervalle aleatoire entre 50 et 100 pixels

    if (scroll_x - last_spawn_x >= interval) {
        int obstacle_x = scroll_x + 100;  // Position X du nouvel obstacle (à droite de l'écran)
        int obstacle_y = 28;  // Position Y sur le sol

        // Générer un ou deux obstacles à la fois
        spawn_obstacle_group(obstacle_x, obstacle_y);

        last_spawn_x = scroll_x;
    }
}
