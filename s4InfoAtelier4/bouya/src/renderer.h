#ifndef _RENDERER_H__
#define _RENDERER_H__
#include "player.h"
#include "tilemap.h"
#include "mycolorRegister.h"
#include "api/ppu/ppu.h"
#include <stdio.h>


struct Renderer{
	uint8_t animationCounter;
	u32 lastAnimationTick;
	u32 lastBackgroundShift;
	uint8_t isBackgroundDirty;
	u8 backgroundTick;
	u8 backgroundOffset;
};

struct Renderer init_renderer();
void draw(struct Renderer* renderer, struct Player* p, struct TileMap tm, u32* gameTime);

#endif
