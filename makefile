# File extensions
SOURCE_EXT=elm

# Files
SOURCES=src/mainpage.elm

all:
	elm make $(SOURCES) --output=index.html

format:
	elm-format $(SOURCES)

reactor:
	elm reactor
