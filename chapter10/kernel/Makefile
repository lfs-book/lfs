INPUT = $(wildcard *.toml)
OUTPUT = $(patsubst %.toml, %.xml, $(INPUT))

ifeq ($(KERNEL_TREE),)
$(error "must set KERNEL_TREE=/path/to/kernel/source")
endif

all: $(OUTPUT)

kernel.version: s-kernel-version; @true
s-kernel-version: Makefile kernel_version.py
	./kernel_version.py $(KERNEL_TREE) > tmp-kernel.version
	if ! diff tmp-kernel.version $@ 2>/dev/null >/dev/null; then \
		mv tmp-kernel.version kernel.version;                    \
	fi
	touch s-kernel-version

%.xml: %.toml kernel-config.py kernel_version.py kernel.version
	./kernel-config.py $(KERNEL_TREE) $< > $@
