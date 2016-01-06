# ------------------------------------------------------------------ STACK PUSH
sp                      := $(sp).x
dirstack_$(sp)          := $(d)
d                       := $(dir)

# ------------------------------------------------------------- LOCAL VARIABLES
GTEST_REPO_URL_$(d)     := https://github.com/google/googletest.git
GTEST_COMMIT_$(d)       := 13206d6f53aaff844f2d3595a01ac83a29e383db

REPO_DIR_$(d)           := $(d)/build
REPO_TEMP_DIR_$(d)      := $(REPO_DIR_$(d)).temp

SRC_$(d)                := $(REPO_DIR_$(d))/googletest/src/gtest-all.cc \
                           $(REPO_DIR_$(d))/googlemock/src/gmock-all.cc

# ----------------------------------------------------------------- LOCAL RULES

# Only delete the repo if a clean-all is ran
CLEAN_ALL_TARGETS := $(CLEAN_ALL_TARGETS) CLEAN_$(d)
.PHONY: CLEAN_$(d)
CLEAN_$(d): d           := $(d)
CLEAN_$(d):
	rm -rf $(REPO_DIR_$(d))


# Pull the repo
$(REPO_DIR_$(d)): d     := $(d)
$(REPO_DIR_$(d)):
	rm -rf $(REPO_TEMP_DIR_$(d)) $(REPO_DIR_$(d))
	mkdir -p $(REPO_TEMP_DIR_$(d))
	cd $(REPO_TEMP_DIR_$(d)) && \
		git clone $(GTEST_REPO_URL_$(d)) ./ && \
		git reset --hard $(GTEST_COMMIT_$(d))
	mv $(REPO_TEMP_DIR_$(d)) $(REPO_DIR_$(d))


# Universal build for gmockgtest
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_SYSTEM_INCLUDE,    $(REPO_DIR_$(d))/googletest/include)
  $(call ADD_CXX_INCLUDE,       $(REPO_DIR_$(d))/googletest)
  $(call ADD_SYSTEM_INCLUDE,    $(REPO_DIR_$(d))/googlemock/include)
  $(call ADD_CXX_INCLUDE,       $(REPO_DIR_$(d))/googlemock)

  # Don't let anything build against this lib until the repo is in place,
  # else the header files and source files won't be available
  $(call ADD_CUSTOM_BUILD_DEP,  $(REPO_DIR_$(d)))

  $(call ADD_CXXF_FLAG,         -pthread)
  $(call BUILD_SOURCE,          $(SRC_$(d)))
  $(call MAKE_LIRARY,           gmockgtest)
  $(call EXPORT_SHALLOW_DEPS,   gmockgtest)
$(call END_UNIVERSAL_BUILD)


# ------------------------------------------------------------------- POP STACK
d                       := $(dirstack_$(sp))
sp                      := $(basename $(sp))
