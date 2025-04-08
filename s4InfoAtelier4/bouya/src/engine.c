#include "engine.h"
#include "api/ppu/ppu.h"

void ShiftBackground(struct Renderer* r, struct TileMap* tm, u32* gameTime){
	if(*gameTime >= r->lastBackgroundShift && *gameTime <= 128000){
		r->isBackgroundDirty = 1;
		r->backgroundOffset = r->backgroundOffset + 1;
		print("background dirty");
		if(*gameTime + 2000 >= 128000){
			r->lastBackgroundShift = 2000;
		}else {
			r->lastBackgroundShift = *gameTime + 2000;
		}
	}
}


void ENGINE_Start(){
    u32 gameTime = 0;
    XTime tStartTime, tElapsedTime;
    u16 width = 128;
    u16 height = 64;

    struct Player p = initialize_player();
    struct Renderer r = init_renderer();
    struct TileMap tm = initialize_map(width, height);
    XTime_GetTime(&tStartTime);

    while (1) {
    	XTime_GetTime(&tElapsedTime);
        gameTime = ((u32)tElapsedTime - (u32)tStartTime) / (u32)(COUNTS_PER_SECOND / 10000);
        printf("%d \n", gameTime);
        ShiftBackground(&r, &tm, &gameTime);
        draw(&r, &p, tm, &gameTime);
    }
}

