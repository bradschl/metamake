# ---------------------------------------------------------------- DEFAULT GOAL
.DEFAULT_GOAL           := all


# ------------------------------------------------------------------ META RULES
# This must be included before any meta rules are used
# Change the path as needed
include ../../Meta.mk


# --------------------------------------------------------------------- VERBOSE
ifeq ("$(origin V)", "command line")
  ENABLE_VERBOSE        = $(V)
endif
ifndef ENABLE_VERBOSE
  ENABLE_VERBOSE        = 1
endif

ifeq ($(ENABLE_VERBOSE),1)
  Q                     =
else
  Q                     = @
endif


# --------------------------------------------------------- BUILD ARCHITECTURES
CM4_ALL_FLAGS           := \
    -O2 -g3 -Wall \
    -mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp \
    -DCORE_M4 \
    --specs=nano.specs

$(call BEGIN_DEFINE_ARCH,  ARM_CM4,	    build/arm_cm4)
  PREFIX                := arm-none-eabi-
  ASF                   := $(CM4_ALL_FLAGS)
  CF                    := $(CM4_ALL_FLAGS) -std=c99
  CXXF                  := $(CM4_ALL_FLAGS) -std=c++14 -fno-exceptions -fno-rtti
  LF                    :=
  LL                    :=
$(call END_DEFINE_ARCH)


HOST_ALL_FLAGS          := -O0 -g3 -Wall -Wextra

$(call BEGIN_DEFINE_ARCH,  HOST,        build/host)
  PREFIX                :=
  CF                    := $(HOST_ALL_FLAGS)
  CXXF                  := $(HOST_ALL_FLAGS) -fno-rtti
  LF                    :=
  LL                    :=
$(call END_DEFINE_ARCH)


# ------------------------------------------------------------- BUILD FRAGMENTS
# Fragments are included in no particular order

dir         := application
include $(dir)/Rules.mk

dir         := libbar
include $(dir)/Rules.mk


# ---------------------------------------------------------------- GLOBAL RULES
.PHONY: all
all: METAMAKE_ALL
	@echo "===== All build finished ====="

.PHONY: clean
clean: METAMAKE_CLEAN
	@echo "===== Clean finished ====="

.PHONY: clean-all
clean-all: $(CLEAN_ALL_TARGETS) METAMAKE_CLEAN
	@echo "===== Clean-all finished ====="

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Build all top level targets"
	@echo "  clean      - Clean intermediate build files"
	@echo "  clean-all  - Clean everything"
