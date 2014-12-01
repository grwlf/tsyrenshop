# This Makefile was generated by the Cake3
# https://github.com/grwlf/cake3

GUARD = .cake3/GUARD_$(1)_$(shell echo $($(1)) | md5sum | cut -d ' ' -f 1)

ifeq ($(MAIN),1)
unexport MAIN

# Main section

URCC = $(shell $(shell urweb -print-ccompiler) -print-prog-name=gcc)
URINCL = -I$(shell urweb -print-cinclude) 
URVERSION = $(shell urweb -version)
.PHONY: all
all: ./Makefile ./TS.exe ./TS.sql
.PHONY: dropdb
dropdb: ./Makefile ./TS.db
./TS.db: ./Makefile ./TS.exe ./TS.sql
	dropdb --if-exists TS
	createdb TS
	psql -f ./TS.sql TS
	touch ./TS.db
./TS.exe: .fix-multy1
./TS.urp: ./Makefile ./StyleSoup.ur ./TS.ur ./TS.urs ./XmlGen.ur ./lib/uru3/Bootstrap/lib.urp ./lib/urweb-monad-pack/lib.urp ./lib/urweb-prelude/lib.urp .cake3/tmp__TS_in autogen/TS_css.ur autogen/TS_css.urs autogen/TS_css_c.h autogen/TS_css_c.o
	cat .cake3/tmp__TS_in > ./TS.urp
.cake3/tmp__TS_in: ./Makefile
	-rm -rf .cake3/tmp__TS_in
	echo 'allow mime text/javascript' >> .cake3/tmp__TS_in
	echo 'allow mime text/css' >> .cake3/tmp__TS_in
	echo 'allow mime image/jpeg' >> .cake3/tmp__TS_in
	echo 'allow mime image/png' >> .cake3/tmp__TS_in
	echo 'allow mime image/gif' >> .cake3/tmp__TS_in
	echo 'allow mime application/octet-stream' >> .cake3/tmp__TS_in
	echo 'allow url /TS/*' >> .cake3/tmp__TS_in
	echo 'allow url http://github.com*' >> .cake3/tmp__TS_in
	echo 'allow url http://impredicative.com*' >> .cake3/tmp__TS_in
	echo 'allow url http://hit.msk.ru*' >> .cake3/tmp__TS_in
	echo 'debug' >> .cake3/tmp__TS_in
	echo 'library ./lib/uru3/Bootstrap' >> .cake3/tmp__TS_in
	echo 'library ./lib/urweb-monad-pack' >> .cake3/tmp__TS_in
	echo 'library ./lib/urweb-prelude' >> .cake3/tmp__TS_in
	echo 'sql ./TS.sql' >> .cake3/tmp__TS_in
	echo 'database dbname=TS' >> .cake3/tmp__TS_in
	echo 'rewrite all TS/main' >> .cake3/tmp__TS_in
	echo 'include autogen/TS_css_c.h' >> .cake3/tmp__TS_in
	echo 'link autogen/TS_css_c.o' >> .cake3/tmp__TS_in
	echo 'ffi autogen/TS_css_c' >> .cake3/tmp__TS_in
	echo 'ffi autogen/TS_css_js' >> .cake3/tmp__TS_in
	echo 'allow mime text/css' >> .cake3/tmp__TS_in
	echo 'safeGet TS_css/blobpage' >> .cake3/tmp__TS_in
	echo 'safeGet TS_css/blob' >> .cake3/tmp__TS_in
	echo '' >> .cake3/tmp__TS_in
	echo 'autogen/TS_css' >> .cake3/tmp__TS_in
	echo '$$/list' >> .cake3/tmp__TS_in
	echo '$$/option' >> .cake3/tmp__TS_in
	echo '$$/string' >> .cake3/tmp__TS_in
	echo '$$/char' >> .cake3/tmp__TS_in
	echo './StyleSoup' >> .cake3/tmp__TS_in
	echo './XmlGen' >> .cake3/tmp__TS_in
	echo './TS' >> .cake3/tmp__TS_in
./lib/urweb-monad-pack/lib.urp: ./Makefile ./lib/urweb-monad-pack/error.ur ./lib/urweb-monad-pack/identity.ur ./lib/urweb-monad-pack/pure.ur ./lib/urweb-monad-pack/state.ur .cake3/tmp__liburweb-monad-packlib_in
	cat .cake3/tmp__liburweb-monad-packlib_in > ./lib/urweb-monad-pack/lib.urp
.cake3/tmp__liburweb-monad-packlib_in: ./Makefile
	-rm -rf .cake3/tmp__liburweb-monad-packlib_in
	echo '' >> .cake3/tmp__liburweb-monad-packlib_in
	echo '../.././lib/urweb-monad-pack/error' >> .cake3/tmp__liburweb-monad-packlib_in
	echo '../.././lib/urweb-monad-pack/state' >> .cake3/tmp__liburweb-monad-packlib_in
	echo '../.././lib/urweb-monad-pack/identity' >> .cake3/tmp__liburweb-monad-packlib_in
	echo '../.././lib/urweb-monad-pack/pure' >> .cake3/tmp__liburweb-monad-packlib_in
./lib/uru3/Bootstrap/lib.urp: ./Makefile ./lib/uru3/Bootstrap/../JQuery/lib.urp ./lib/uru3/Bootstrap/../Uru/lib.urp ./lib/uru3/Bootstrap/Bootstrap.ur ./lib/uru3/Bootstrap/Bootstrap.urs ./lib/uru3/Bootstrap/FormSignin.ur .cake3/tmp__liburu3Bootstraplib_in autogen/Bootstrap_css.ur autogen/Bootstrap_css.urs autogen/Bootstrap_css_c.h autogen/Bootstrap_css_c.o autogen/Bootstrap_min_js.ur autogen/Bootstrap_min_js.urs autogen/Bootstrap_min_js_c.h autogen/Bootstrap_min_js_c.o autogen/Bootstrap_theme_css.ur autogen/Bootstrap_theme_css.urs autogen/Bootstrap_theme_css_c.h autogen/Bootstrap_theme_css_c.o autogen/FormSignin_css.ur autogen/FormSignin_css.urs autogen/FormSignin_css_c.h autogen/FormSignin_css_c.o autogen/Glyphicons_halflings_regular_eot.ur autogen/Glyphicons_halflings_regular_eot.urs autogen/Glyphicons_halflings_regular_eot_c.h autogen/Glyphicons_halflings_regular_eot_c.o autogen/Glyphicons_halflings_regular_svg.ur autogen/Glyphicons_halflings_regular_svg.urs autogen/Glyphicons_halflings_regular_svg_c.h autogen/Glyphicons_halflings_regular_svg_c.o autogen/Glyphicons_halflings_regular_ttf.ur autogen/Glyphicons_halflings_regular_ttf.urs autogen/Glyphicons_halflings_regular_ttf_c.h autogen/Glyphicons_halflings_regular_ttf_c.o autogen/Glyphicons_halflings_regular_woff.ur autogen/Glyphicons_halflings_regular_woff.urs autogen/Glyphicons_halflings_regular_woff_c.h autogen/Glyphicons_halflings_regular_woff_c.o
	cat .cake3/tmp__liburu3Bootstraplib_in > ./lib/uru3/Bootstrap/lib.urp
.cake3/tmp__liburu3Bootstraplib_in: ./Makefile
	-rm -rf .cake3/tmp__liburu3Bootstraplib_in
	echo 'rewrite style Bootstrap/bs3_table table' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'rewrite style Bootstrap/* [-]' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'library ../../.././lib/uru3/Bootstrap/../Uru' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'library ../../.././lib/uru3/Bootstrap/../JQuery' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Glyphicons_halflings_regular_eot_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Glyphicons_halflings_regular_eot_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_eot_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_eot_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime application/vnd.ms-fontobject' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_eot/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_eot/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Glyphicons_halflings_regular_svg_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Glyphicons_halflings_regular_svg_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_svg_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_svg_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime image/svg+xml' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_svg/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_svg/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Glyphicons_halflings_regular_ttf_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Glyphicons_halflings_regular_ttf_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_ttf_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_ttf_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime application/x-font-ttf' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_ttf/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_ttf/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Glyphicons_halflings_regular_woff_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Glyphicons_halflings_regular_woff_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_woff_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Glyphicons_halflings_regular_woff_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime application/font-woff' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_woff/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Glyphicons_halflings_regular_woff/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Bootstrap_css_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Bootstrap_css_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_css_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_css_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime text/css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_css/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_css/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Bootstrap_theme_css_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Bootstrap_theme_css_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_theme_css_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_theme_css_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime text/css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_theme_css/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_theme_css/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/Bootstrap_min_js_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/Bootstrap_min_js_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_min_js_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/Bootstrap_min_js_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime text/javascript' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_min_js/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet Bootstrap_min_js/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'include ../../../autogen/FormSignin_css_c.h' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'link ../../../autogen/FormSignin_css_c.o' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/FormSignin_css_c' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'ffi ../../../autogen/FormSignin_css_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'allow mime text/css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet FormSignin_css/blobpage' >> .cake3/tmp__liburu3Bootstraplib_in
	echo 'safeGet FormSignin_css/blob' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Glyphicons_halflings_regular_eot' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Glyphicons_halflings_regular_svg' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Glyphicons_halflings_regular_ttf' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Glyphicons_halflings_regular_woff' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Bootstrap_css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Bootstrap_theme_css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/Bootstrap_min_js' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../.././lib/uru3/Bootstrap/Bootstrap' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../../autogen/FormSignin_css' >> .cake3/tmp__liburu3Bootstraplib_in
	echo '../../.././lib/uru3/Bootstrap/FormSignin' >> .cake3/tmp__liburu3Bootstraplib_in
./lib/urweb-prelude/lib.urp: ./Makefile ./lib/urweb-prelude/src/Prelude.ur .cake3/tmp__liburweb-preludelib_in
	cat .cake3/tmp__liburweb-preludelib_in > ./lib/urweb-prelude/lib.urp
.cake3/tmp__liburweb-preludelib_in: ./Makefile
	-rm -rf .cake3/tmp__liburweb-preludelib_in
	echo '' >> .cake3/tmp__liburweb-preludelib_in
	echo '$$/list' >> .cake3/tmp__liburweb-preludelib_in
	echo '../.././lib/urweb-prelude/src/Prelude' >> .cake3/tmp__liburweb-preludelib_in
./TS.sql: .fix-multy1
.INTERMEDIATE: .fix-multy1
.fix-multy1: ./Makefile ./TS.urp $(call GUARD,URVERSION)
	urweb -dbms postgres ./TS
autogen/Bootstrap_css_c.o: ./Makefile autogen/Bootstrap_css_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Bootstrap_css_c.o autogen/Bootstrap_css_c.c
autogen/Bootstrap_min_js_c.o: ./Makefile autogen/Bootstrap_min_js_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Bootstrap_min_js_c.o autogen/Bootstrap_min_js_c.c
autogen/Bootstrap_theme_css_c.o: ./Makefile autogen/Bootstrap_theme_css_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Bootstrap_theme_css_c.o autogen/Bootstrap_theme_css_c.c
autogen/FormSignin_css_c.o: ./Makefile autogen/FormSignin_css_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/FormSignin_css_c.o autogen/FormSignin_css_c.c
autogen/Glyphicons_halflings_regular_eot_c.o: ./Makefile autogen/Glyphicons_halflings_regular_eot_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Glyphicons_halflings_regular_eot_c.o autogen/Glyphicons_halflings_regular_eot_c.c
autogen/Glyphicons_halflings_regular_svg_c.o: ./Makefile autogen/Glyphicons_halflings_regular_svg_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Glyphicons_halflings_regular_svg_c.o autogen/Glyphicons_halflings_regular_svg_c.c
autogen/Glyphicons_halflings_regular_ttf_c.o: ./Makefile autogen/Glyphicons_halflings_regular_ttf_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Glyphicons_halflings_regular_ttf_c.o autogen/Glyphicons_halflings_regular_ttf_c.c
autogen/Glyphicons_halflings_regular_woff_c.o: ./Makefile autogen/Glyphicons_halflings_regular_woff_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/Glyphicons_halflings_regular_woff_c.o autogen/Glyphicons_halflings_regular_woff_c.c
autogen/TS_css_c.o: ./Makefile autogen/TS_css_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS)  -o autogen/TS_css_c.o autogen/TS_css_c.c
$(call GUARD,URCC):
	rm -f .cake3/GUARD_URCC_*
	touch $@
$(call GUARD,URINCL):
	rm -f .cake3/GUARD_URINCL_*
	touch $@
$(call GUARD,URVERSION):
	rm -f .cake3/GUARD_URVERSION_*
	touch $@
$(call GUARD,UR_CFLAGS):
	rm -f .cake3/GUARD_UR_CFLAGS_*
	touch $@

else

# Prebuild/postbuild section

ifneq ($(MAKECMDGOALS),clean)

.PHONY: all
all: .fix-multy1
.PHONY: dropdb
dropdb: .fix-multy1
.PHONY: ./TS.db
./TS.db: .fix-multy1
.PHONY: ./TS.exe
./TS.exe: .fix-multy1
.PHONY: ./TS.urp
./TS.urp: .fix-multy1
.PHONY: .cake3/tmp__TS_in
.cake3/tmp__TS_in: .fix-multy1
.PHONY: ./lib/urweb-monad-pack/lib.urp
./lib/urweb-monad-pack/lib.urp: .fix-multy1
.PHONY: .cake3/tmp__liburweb-monad-packlib_in
.cake3/tmp__liburweb-monad-packlib_in: .fix-multy1
.PHONY: ./lib/uru3/Bootstrap/lib.urp
./lib/uru3/Bootstrap/lib.urp: .fix-multy1
.PHONY: .cake3/tmp__liburu3Bootstraplib_in
.cake3/tmp__liburu3Bootstraplib_in: .fix-multy1
.PHONY: ./lib/urweb-prelude/lib.urp
./lib/urweb-prelude/lib.urp: .fix-multy1
.PHONY: .cake3/tmp__liburweb-preludelib_in
.cake3/tmp__liburweb-preludelib_in: .fix-multy1
.PHONY: ./TS.sql
./TS.sql: .fix-multy1
.INTERMEDIATE: .fix-multy1
.fix-multy1: 
	-mkdir .cake3
	$(MAKE) -C ./lib/uru3/Bootstrap/../Uru -f Makefile 
	$(MAKE) -C ./lib/uru3/Bootstrap/../JQuery -f Makefile 
	MAIN=1 $(MAKE) -f ./Makefile $(MAKECMDGOALS)
.PHONY: autogen/Bootstrap_css_c.o
autogen/Bootstrap_css_c.o: .fix-multy1
.PHONY: autogen/Bootstrap_min_js_c.o
autogen/Bootstrap_min_js_c.o: .fix-multy1
.PHONY: autogen/Bootstrap_theme_css_c.o
autogen/Bootstrap_theme_css_c.o: .fix-multy1
.PHONY: autogen/FormSignin_css_c.o
autogen/FormSignin_css_c.o: .fix-multy1
.PHONY: autogen/Glyphicons_halflings_regular_eot_c.o
autogen/Glyphicons_halflings_regular_eot_c.o: .fix-multy1
.PHONY: autogen/Glyphicons_halflings_regular_svg_c.o
autogen/Glyphicons_halflings_regular_svg_c.o: .fix-multy1
.PHONY: autogen/Glyphicons_halflings_regular_ttf_c.o
autogen/Glyphicons_halflings_regular_ttf_c.o: .fix-multy1
.PHONY: autogen/Glyphicons_halflings_regular_woff_c.o
autogen/Glyphicons_halflings_regular_woff_c.o: .fix-multy1
.PHONY: autogen/TS_css_c.o
autogen/TS_css_c.o: .fix-multy1

endif
.PHONY: clean
clean: 
	-rm ./TS.db ./TS.exe ./TS.sql ./TS.urp ./lib/uru3/Bootstrap/lib.urp ./lib/urweb-monad-pack/lib.urp ./lib/urweb-prelude/lib.urp .cake3/tmp__TS_in .cake3/tmp__liburu3Bootstraplib_in .cake3/tmp__liburweb-monad-packlib_in .cake3/tmp__liburweb-preludelib_in autogen/Bootstrap_css_c.o autogen/Bootstrap_min_js_c.o autogen/Bootstrap_theme_css_c.o autogen/FormSignin_css_c.o autogen/Glyphicons_halflings_regular_eot_c.o autogen/Glyphicons_halflings_regular_svg_c.o autogen/Glyphicons_halflings_regular_ttf_c.o autogen/Glyphicons_halflings_regular_woff_c.o autogen/TS_css_c.o
	-rm -rf .cake3

endif
