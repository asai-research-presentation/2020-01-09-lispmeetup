
PNG=find ./ -regex ".*\.svg" | sed -e "s/svg/png/g"

.SUFFIXES: .svg .png
.PHONY:	clean all

all: $(shell $(PNG))
	$(MAKE) -C static
	./makebb.sh

%.png : %.svg
	inkscape -f $< -e $*.png -d 300
#	convert $< $*.png
#	if you want to use imagemagick, comment out 'inkscape...' and use 'convert...'

clean:
	-rm *bb *.png
	$(MAKE) -C static clean
