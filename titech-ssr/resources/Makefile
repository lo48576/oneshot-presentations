.PHONY: all clean

PDF_OUTPUTS = cc-by-4_0.pdf

all: $(PDF_OUTPUTS)

clean:
	-rm -rf $(PDF_OUTPUTS)

cc-by-4_0.pdf: cc-by-4_0.svg
	rsvg-convert -f pdf -o $@ $<
