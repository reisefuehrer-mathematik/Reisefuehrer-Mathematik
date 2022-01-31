LATEX = pdflatex
MKDIR_P = mkdir -p
RM = rm

OUT_DIR = ./out
SRC_DIR = .
BOOK_OUT_DIR = $(OUT_DIR)/buch
BOOK_SRC_DIR = $(SRC_DIR)/buch
VB_OUT_DIR = $(OUT_DIR)/vorbereitungsblaetter
VB_SRC_DIR = $(SRC_DIR)/vorbereitungsblaetter

STY_FILES = $(shell find $(SRC_DIR) -name "*.sty")
BOOK_CLS = $(SRC_DIR)/buch.cls

VB_FOLDERS = $(shell find $(VB_SRC_DIR) -maxdepth 1 -mindepth 1 -type d -printf "%f\n")
VB_SRC_FILES = $(wildcard $(VB_SRC_DIR)/$(VB_FOLDERS)/*.tex)
VB_OUT_FILES = $(patsubst  $(VB_SRC_DIR)/%.tex,$(VB_OUT_DIR)/%.aux,$(VB_SRC_FILES))
VB_TARGETS = $(foreach dir,$(VB_FOLDERS),$(shell find $(VB_SRC_DIR)/$(dir) -name "*.tex" -printf "$(dir)-%f\n"))

$(BOOK_OUT_DIR)/main.aux: $(BOOK_SRC_DIR)/main.tex $(BOOK_CLS) $(STY_FILES)
	$(MKDIR_P) $(BOOK_OUT_DIR);\
	export TEXINPUTS=".;./buch/;";\
	$(LATEX) -output-directory=$(BOOK_OUT_DIR) $(BOOK_SRC_DIR)/main.tex;\
	$(LATEX) -output-directory=$(BOOK_OUT_DIR) $(BOOK_SRC_DIR)/main.tex;

$(VB_OUT_DIR)/%.aux: $(VB_SRC_DIR)/%.tex book
	$(MKDIR_P) $(@D);\
	export TEXINPUTS=".;";\
	$(LATEX) -output-directory=$(@D) $<;

book: $(BOOK_OUT_DIR)/main.aux

vb-all: $(VB_OUT_FILES)

all: book vb-all
	
clean:
	$(RM) -r $(BOOK_OUT_DIR)
	$(RM) -r $(VB_OUT_DIR)

.PHONY: all clean