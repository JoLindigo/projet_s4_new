#ifndef _RENDERER_H__
#define _RENDERER_H__
#include "player.h"
#include "tilemap.h"
#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "mycolorRegister.h"

void init_renderer();
void draw(struct Player* p, struct TileMap* tm);

#endif
