
SBB=find ./ -regex ".*\.png" | sed -e "s/png/sbb/g"
MBB=find ./ -regex ".*\.png" | sed -e "s/png/mbb/g"
XBB=find ./ -regex ".*\.png" | sed -e "s/png/xbb/g"

PNG=find ./ -regex ".*\.svg" | sed -e "s/svg/png/g"

.SUFFIXES: .svg .png
.PHONY:	clean all

all: $(shell $(PNG))
	$(MAKE) -C ./ $(shell $(XBB))
	$(MAKE) -C static
# for systems without dvipdfmx, use SBB or MBB accordingly

%.png : %.svg
	inkscape -f $< -e $*.png -d 300
#	convert $< $*.png
#	if you want to use imagemagick, comment out 'inkscape...' and use 'convert...'

%.mbb : %.png
	ebb -O -m $< > $@

%.sbb : %.png
	ebb -O $< > $@		# standard bb

%.xbb : %.png
	ebb -O -x $< > $@

clean:
	-rm -f $$(find ./ -regex ".*bb")
	-rm -f $(shell $(PNG)) # only those made from svg
