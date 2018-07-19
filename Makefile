#
# Makefile for the Freescale network device drivers.
#
KERNEL_DIR ?= /lib/modules/$(shell uname -r)/build
PWD ?= $(shell pwd)

obj-m += dpaa_eth_im.o

KERNEL_MAKE_OPTS := -C $(KERNEL_DIR) M=$(PWD)
ifneq ($(ARCH),)
KERNEL_MAKE_OPTS += ARCH=$(ARCH)
endif
ifneq ($(CROSS_COMPILE),)
KERNEL_MAKE_OPTS += CROSS_COMPILE=$(CROSS_COMPILE)
endif

build:
	$(MAKE) $(KERNEL_MAKE_OPTS) modules

install: modules_install

modules_install:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules_install

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean
	rm -f $(hostprogs) *~
