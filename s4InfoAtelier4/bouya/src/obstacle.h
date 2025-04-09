#ifndef __PLATFORME_H_
#define __PLATFORME_H_

#include "tilemap.h" 

#define MAX_OBSTACLES 6 // 8 max - 1 (player) - 1 (ennemy)

struct Obstacle {
    int x; 
    int y;
    int active; // 0 = dispo, 1 = utilisé
};

// Liste d'acteurs obstacles
extern struct Obstacle obstacles[MAX_OBSTACLES];

// Fonction pour reset tous les obstacles
void init_obstacles();

// Genere 1 ou 2 obstacles
void spawn_obstacle_group(int x, int y);

// Update des obstacle selon scoll position
void update_obstacles(struct TileMap* map, int scroll_x);

// Genere periodiquement de nouveaux obstacles en fonction du scroll
void generate_obstacles(struct TileMap* map, int scroll_x);

#endif