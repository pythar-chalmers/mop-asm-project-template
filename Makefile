.PHONY: build clean

ARM_SOURCES	= $(wildcard src/*.asm)
OBJ 		= $(ARM_SOURCES:.asm=.o)
SREC		= $(OBJ:.o=.s19)

AS		= arm-none-eabi-as
AS_FLAGS	= -march=armv6-m -g

LD		= arm-none-eabi-ld
LD_FLAGS	= -T md407-ram.x

OBJCPY		= arm-none-eabi-objcopy 
OBJCPY_FLAGS	=

BUILD_DIR	= build
BUILD_BIN	= MOP

%.o : %.asm
	mkdir -p ${BUILD_DIR} 
	${AS} ${AS_FLAGS} $< -o $@  

build : ${OBJ}
	${LD} ${LD_FLAGS} $< -o ${BUILD_DIR}/${BUILD_BIN}
	${OBJCPY} -O srec ${OBJ} ${SREC}
	mv ${OBJ} ${BUILD_DIR}/
	mv ${SREC} ${BUILD_DIR}/


clean:
	rm -rf src/*.o src/*.gch build/ *.o


.all: clean build
