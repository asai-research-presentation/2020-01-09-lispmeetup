
scss = $(shell ls *.scss)

.PHONY: all clean

all: $(scss)

%.css: %.scss
	sass $< $@

clean:
	-rm $(scss)
