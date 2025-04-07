#include "engine.h"

void ShiftBackground(struct Renderer* r, struct TileMap* tm, uint8_t* gameTime){
	if(*gameTime >= r->lastBackgroundShift + 10){
		for(uint8_t i = 0; i < tm->width; i++) {
			for(uint8_t j = 0; j < tm->height; j++) {
				uint8_t newX = i+1;
				if(newX == tm->width){
					tm->tiles[i][j] = tm->tiles[0][j];
				}else{
					tm->tiles[i][j] = tm->tiles[newX][j];
				}
			}
		}
		r->isBackgroundDirty = 1;
		r->lastBackgroundShift = *gameTime;
	}
}


void ENGINE_Start(){
    static uint8_t gameTime = 0;
    XTime tStartTime, tElapsedTime;
    static int width = 340;
    static int height = 120;

    struct Player* p = initialize_player();
    struct TileMap* tm = initialize_map(width, height);
    XTime_GetTime(&tStartTime);
    struct Renderer* r = init_renderer();

    while (1) {
    	XTime_GetTime(&tElapsedTime);
        gameTime = (tElapsedTime - tStartTime) / COUNTS_PER_SECOND;
        ShiftBackground(r, tm, &gameTime);
        draw(r, p, tm, &gameTime);
    }
}

