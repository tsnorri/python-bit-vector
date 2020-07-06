-include ../local.mk
include ../common.mk


PREPROCESSED = bit_vector/bit_vector_support.pxi
GENERATED_SOURCES =	bit_vector/bit_vector.cpp $(PREPROCESSED)

SETUP_PY_CMD =		CC="$(CC)" \
					CXX="$(CXX)" \
					INCLUDE_DIRS="$(INCLUDE_DIRS)" \
					LIB_DIRS="$(LIB_DIRS)" \
					LIBRARIES="$(LIBRARIES)" \
					EXTRA_CXXFLAGS="$(EXTRA_CXXFLAGS)" \
					EXTRA_LDFLAGS="$(EXTRA_LDFLAGS)" \
					$(PYTHON) setup.py

all: build_ext

build_ext: $(PREPROCESSED)
	$(SETUP_PY_CMD) build_ext --inplace

bdist_wheel: $(PREPROCESSED)
	$(SETUP_PY_CMD) bdist_wheel

clean:
	$(RM) $(GENERATED_SOURCES)
	$(RM) -r build

%.pxi: %.pxi.tpl %.pxi.vars
	$(PYTHON) process_template.py --template $< --variables $(word 2,$^) > $@
