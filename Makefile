# Build prerequisites
#
#   1. a sane GNU system
#   2. embedmd

.PHONY: all clean

all: BOOK.md

BOOK.md: chapters/*.md
	ls chapters/*.md | xargs embedmd | grep -v '^<!-- vim:' > BOOK.md

clean:
	rm -f BOOK.md
