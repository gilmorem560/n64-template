#
# N64 Makefile template
#

include $(ROOT)/usr/include/make/PRdefs

#FINAL = YES
ifeq ($(FINAL), YES)
OPTIMIZER	= -O2
LCDEFS		= -DNDEBUG -D_FINALROM -DF3DEX_GBI_2
N64LIB		= -lgultra_rom
else
OPTIMIZER	= -g
LCDEFS		= -DDEBUG -DF3DEX_GBI_2
N64LIB		= -lgultra_d
endif

APP	=	main.out
TARGETS	=	main.n64
CODEFILES =	boot.c
CODEOBJECTS =	$(CODEFILES:.c=.o)
CODESEGMENT = 	codesegment.o
OBJECTS	=	$(CODESEGMENT)

LCINCS =	-I.
LCOPTS =	-G 0
LDFLAGS =	$(MKDEPOPT) -L$(ROOT)/usr/lib $(N64LIB) -L$(GCCDIR)/mipse/lib -lkmc

LDIRT =		$(APP)

default: $(TARGETS)

include $(COMMONRULES)

$(CODESEGMENT): $(CODEOBJECTS)
	$(LD) -o $(CODESEGMENT) -r $(CODEOBJECTS) $(LDFLAGS)

ifeq ($(FINAL), YES)
$(TARGETS) $(APP):	spec $(OBJECTS)
	$(MAKEROM) -s 9 -r $(TARGETS) -e $(APP) spec
	makemask $(TARGETS)
else
$(TARGETS) $(APP):	spec $(OBJECTS)
	$(MAKEROM) -r $(TARGETS) -e $(APP) spec
endif

# for exeGCC CELF
ifeq ($(GCC_CELF), ON)
ifneq ($(FINAL), YES)
CELFDIR = .
include $(CELFRULES)
$(CODEOBJECTS):	$(CELFINFOFILES)
endif
endif