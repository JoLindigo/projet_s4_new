#ifndef _RENDERER_H__
#define _RENDERER_H__
#include "player.h"
#include "tilemap.h"
#include "mycolorRegister.h"
#include "api/ppu/ppu.h"
#include <stdio.h>


struct Renderer{
	uint8_t animationCounter;
	uint8_t lastAnimationTick;
	uint8_t lastBackgroundShift;
	uint8_t isBackgroundDirty;
};

struct Renderer* init_renderer();
void draw(struct Renderer* renderer, struct Player* p, struct TileMap* tm, uint8_t* gameTime);

#endif
