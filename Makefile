# Build prerequisites
#
#   1. a sane GNU system
#   2. embedmd (https://github.com/campoy/embedmd)

.PHONY: all clean

SOURCES := $(sort $(wildcard chapters/*.md))
SQL := $(wildcard chapters/sql/*.sql)
PROCESSED := $(SOURCES:chapters/%.md=manuscript/%.md)

all: manuscript/Book.txt manuscript/README.md manuscript/SUMMARY.md $(PROCESSED)

manuscript/Book.txt: $(SOURCES)
	mkdir -p manuscript
	echo $(^:chapters/%.md=%.md) | xargs -n 1 > $@

manuscript/README.md: $(SOURCES)
	mkdir -p manuscript
	ln -s 00-introduction.md $@

manuscript/SUMMARY.md: $(SOURCES)
	mkdir -p manuscript
	echo -e "# Summary\n" > $@
	echo $^ | xargs -n 1 ./summary-item >> $@

manuscript/%.md: chapters/%.md $(SQL)
	embedmd $< | sed '/^<!-- vim:/d' > $@

clean:
	rm -fr manuscript
