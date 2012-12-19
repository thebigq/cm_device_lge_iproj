#!/bin/sh

PRODUCT_REMOVE_FILES=""

PRODUCT_REMOVE_RES="{layout,drawable,mipmap,menu,xml}-{large,sw580,sw600,sw768,xlarge}*"

# Keep only en, fr, it, de, es
PACKAGE_REMOVE_FILES="
	LatinIME.apk:res/{raw,xml}-{ar,bg,cs,cs-ZZ,da,el,fa,fi,hr,hr-AL,hu,hu-ZZ,iw,ka,nb,nl,nl-BE,pl,pt,ru,sr,sv,tr}"
