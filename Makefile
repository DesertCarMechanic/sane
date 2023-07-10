
LIB_NAME = sane
SRC_DIR = src
SRC_FILES ?= sane.c
SRC_PATHS = $(patsubst %.c, $(SRC_DIR)/%.c, $(SRC_FILES))

HEADER_FILES = sane.h

COBJECTS = $(patsubst %.c, %.o, $(SRC_FILES))

PACKAGES ?=
PKGCONFIG = pkg-config
COMPILER_FLAGS = -std=c99 -Wall
CFLAGS = $(if $(PACKAGES), $(shell $(PKGCONFIG) --cflags $(PACKAGES)),)
LIBS = $(if $(PACKAGES), $(shell $(PKGCONFIG) --libs $(PACKAGES)),)
INSTALL_DIR = /usr/lib
INCLUDE_DIR = /usr/include/$(LIB_NAME)

all: compile library
debug: compile_debug library

compile: $(SRC_PATHS)
	$(CC) -fpic -c $(COMPILER_FLAGS) $(CFLAGS) $(LIBS) $(SRC_PATHS)

library: $(COBJECTS)
	$(CC) -shared $(COBJECTS) -o lib$(LIB_NAME).so 

compile_debug: $(SRC_PATHS)
	$(CC) -fpic -c --verbose -g $(COMPILER_FLAGS) $(CFLAGS) $(LIBS) $(SRC_PATHS)

install: lib$(LIB_NAME).so $(patsubst %.h, $(SRC_DIR)/%.h, $(HEADER_FILES))
	chmod 755 lib$(LIB_NAME).so
	cp lib$(LIB_NAME).so $(INSTALL_DIR)
	mkdir -p $(INCLUDE_DIR)
	for header in $(HEADER_FILES); do \
		cp $(SRC_DIR)/$$header $(INCLUDE_DIR); \
	done
	ldconfig -n $(INSTALL_DIR)

uninstall:
	$(RM) $(INSTALL_DIR)/lib$(LIB_NAME).so
	for header in $(HEADER_FILES); do \
		$(RM) $(INCLUDE_DIR)/$$header; \
	done
	rmdir $(INCLUDE_DIR)

clean:
	$(RM) *.o *.so core*


.PHONY: all clean
