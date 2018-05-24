# File extensions
SOURCE_EXT=elm

# Files
SOURCES=$(wildcard *.$(SOURCE_EXT))

all: 
	elm-make $(SOURCES)

format:
	elm-format $(SOURCES)

reactor:
	elm-reactor -a 0.0.0.0
