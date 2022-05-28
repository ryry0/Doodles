# File extensions
SOURCE_EXT=elm

# Files
SOURCES=src/Main.elm

all:
	elm make $(SOURCES) --output=index.html

format:
	elm-format $(SOURCES)

reactor:
	elm reactor
