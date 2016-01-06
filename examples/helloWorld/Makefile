# ---------------------------------------------------------------- GLOBAL RULES
# Since the `all` rule appears as the first recipe, it will be the default
# one to be ran
.PHONY: all
all: METAMAKE_ALL
	@echo "===== All build finished ====="

.PHONY: clean
clean: METAMAKE_CLEAN
	@echo "===== Clean finished ====="

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Build all top level targets"
	@echo "  clean      - Clean intermediate build files"

# ------------------------------------------------------------------ META RULES
# This must be included before any meta rules are used
include ../../Meta.mk

# --------------------------------------------------------- BUILD ARCHITECTURES

$(call BEGIN_DEFINE_ARCH, HOST_RELEASE, build/host/release)
  PREFIX        :=
  CF            := -O3
$(call END_DEFINE_ARCH)

$(call BEGIN_DEFINE_ARCH, HOST_DEBUG, build/host/debug)
  PREFIX        :=
  CF            := -O0 -g3
$(call END_DEFINE_ARCH)


# ----------------------------------------------------------------------- BUILD

MY_SOURCE := $(call FIND_SOURCE_IN_DIR, src)

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,   include)
  $(call BUILD_SOURCE,      $(MY_SOURCE))
  $(call CXX_LINK,          application)
  $(call APPEND_ALL_TARGET_VAR)

  # Work-around to get universal builds to work with executables. Universal
  # builds must export a dependency or they will not be evaluated
  $(call EXPORT_SHALLOW_DEPS, application)
$(call END_UNIVERSAL_BUILD)
