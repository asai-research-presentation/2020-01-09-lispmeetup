
scss = $(shell ls *.scss)
css = default.css layout.css projector.css
.PHONY: all clean

all: $(css)

%.css: $(scss)
	sass $< $@

clean:
	-rm *.css *.map
