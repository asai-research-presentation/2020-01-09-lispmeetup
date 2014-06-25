
SBB=find ./ -regex ".*\.jpg" | sed -e "s/jpg/sbb/g"
MBB=find ./ -regex ".*\.jpg" | sed -e "s/jpg/mbb/g"
XBB=find ./ -regex ".*\.jpg" | sed -e "s/jpg/xbb/g"

JPG=find ./ -regex ".*\.svg" | sed -e "s/svg/jpg/g"

.SUFFIXES: .svg .jpg
.PHONY:	clean all

all: $(shell $(JPG))
	$(MAKE) -C ./ $(shell $(XBB))
# for systems without dvipdfmx, use SBB or MBB accordingly

%.jpg : %.svg
	inkscape -f $< -e $*.jpg -d 300
#	convert $< $*.jpg
#	if you want to use imagemagick, comment out 'inkscape...' and use 'convert...'

%.mbb : %.jpg
	ebb -O -m $< > $@

%.sbb : %.jpg
	ebb -O $< > $@		# standard bb

%.xbb : %.jpg
	ebb -O -x $< > $@

clean:
	-rm -f $$(find ./ -regex ".*bb")
	-rm -f $(shell $(JPG)) # only those made from svg
