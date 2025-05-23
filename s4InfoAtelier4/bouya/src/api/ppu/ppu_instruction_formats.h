#ifndef _PPU_INSTRUCTION_FORMATS_H_
#define _PPU_INSTRUCTION_FORMATS_H_


/**
  * \brief Defines the SetViewportOffset instruction's format.
  */
typedef union {
  struct {
	uint32_t PADDING         : 9;
    uint32_t viewportOffsetY : 9;
    uint32_t viewportOffsetX : 10;
    uint32_t opCode          : 4;
  } fields;

  uint32_t instruction;
} SetViewportOffsetInstruction;


/**
  * \brief Defines the SetBackgroundTileID instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING      : 10;
    uint32_t tileRowIndex : 6;
    uint32_t tileColIndex : 7;
    uint32_t tileID       : 5;
    uint32_t opCode       : 4;
  } fields;

  uint32_t instruction;
} SetBackgroundTileIDInstruction;


/**
  * \brief Defines the SetBackgroundTileColor instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING            : 12;
    uint32_t tilePixelColorCode : 5;
    uint32_t tilePixelPosY      : 3;
    uint32_t tilePixelPosX      : 3;
    uint32_t tileIndex          : 5;
    uint32_t opCode             : 4;
  } fields;

  uint32_t instruction;
} SetBackgroundTileColorInstruction;


/**
  * \brief Defines the SetActorTileID instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING : 21;
    uint32_t tileID  : 4;
    uint32_t actorID : 3;
    uint32_t opCode  : 4;
  } fields;

  uint32_t instruction;
} SetActorTileIDInstruction;


/**
  * \brief Defines the SetActorTileColor instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING        : 11;
    uint32_t pixelColorCode : 5;
    uint32_t pixelRowIndex  : 4;
    uint32_t pixelColIndex  : 4;
    uint32_t tileID         : 4;
    uint32_t opCode         : 4;
  } fields;

  uint32_t instruction;
} SetActorTileColorInstruction;


/**
  * \brief Defines the SetActorPosition instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING : 6;
    uint32_t y       : 9;
    uint32_t x       : 10;
    uint32_t actorID : 3;
    uint32_t opCode  : 4;
  } fields;

  uint32_t instruction;
} SetActorPositionInstruction;


/**
  * \brief Defines the MoveActorPosition instruction's format.
  */
typedef union {
  struct {
    uint32_t PADDING : 17;
    uint32_t deltaY  : 4;
    uint32_t deltaX  : 4;
    uint32_t actorID : 3;
    uint32_t opCode  : 4;
  } fields;

  uint32_t instruction;
} MoveActorPositionInstruction;


#endif // _PPU_INSTRUCTION_FORMATS_H_
