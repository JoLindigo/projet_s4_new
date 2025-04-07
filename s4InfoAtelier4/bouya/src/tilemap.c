#include "tilemap.h"

static struct Tile* initialize_default_tiles(){
    struct Tile* tiles = calloc(32, sizeof(struct Tile*));
    tiles[0].type = EMPTY;
    tiles[0].tileId = 0;
    tiles[1].type = WALL;
    tiles[1].tileId = 1;
    tiles[2].type = WALL2;
    tiles[2].tileId = 2;
    return tiles;
}

struct TileMap* initialize_map(int width, int height) {
    struct TileMap* map = malloc(sizeof(struct TileMap));
    map->width = width;
    map->height = height;

    //Default tiles
    struct Tile* defaultTiles = initialize_default_tiles();


    map->tiles = calloc(map->width, sizeof(struct Tile**));
    for (int i = 0; i < map->width; i++) {
        map->tiles[i] = calloc(map->width, sizeof(struct Tile*));
        for (int j = 0; j < map->height; j++) {
			if((j % 2 == 0 && i % 2 == 0) || (j % 2 != 0 && i % 2 != 0)) {
				map->tiles[i][j] = defaultTiles[1];
			}
			else{
				map->tiles[i][j] = defaultTiles[2];
			}
        }
    }

    return map;
}
