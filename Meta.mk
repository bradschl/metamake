# Copyright (c) 2015 Bradley Kim Schleusner < bradschl@gmail.com >
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# --------------------------------------------------------------- DOCUMENTATION
# See README.md for documentation, or the github project page
# https://github.com/bradschl/metamake


# ------------------------------------------------------------- MAKEFILE TWEAKS
# Disable implicit rules
.SUFFIXES:

# Enable secondary expansion for recipe dependency variables that may not
# be defined at the time that the meta rules are expanded
.SECONDEXPANSION:


# ------------------------------------------------------------------ VERSIONING
# API breaking version
METAMAKE_MAJOR_VERSION  := 1
# Bug fix version within the API
METAMAKE_MINOR_VERSION  := 2


# ------------------------------------------------------------ BUILD CONSTRUCTS

# $(1) - Architecture - variable name
# $(2) - Build directory
BEGIN_DEFINE_ARCH       = $(eval $(call EVAL_BEGIN_DEFINE_ARCH,$(strip $(1)),$(strip $(2))))
END_DEFINE_ARCH         = $(eval $(call EVAL_END_DEFINE_ARCH))

# $(1) - Architecture - variable name
BEGIN_APPEND_ARCH_FLAGS = $(eval $(call EVAL_BEGIN_APPEND_ARCH_FLAGS,$(strip $(1))))
END_APPEND_ARCH_FLAGS   = $(eval $(call EVAL_END_APPEND_ARCH_FLAGS))

# $(1) - Architecture - variable name
BEGIN_ARCH_BUILD        = $(eval $(call EVAL_BEGIN_ARCH_BUILD,$(strip $(1))))
END_ARCH_BUILD          = $(eval $(EVAL_END_ARCH_BUILD))

BEGIN_UNIVERSAL_BUILD   = $(eval $(EVAL_BEGIN_UNIVERSAL_BUILD))
END_UNIVERSAL_BUILD     = $(eval $(EVAL_END_UNIVERSAL_BUILD))


# $(1) - Includes (paths)
ADD_C_INCLUDE           = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_C_INCLUDE,$$$$(strip $$(1)))))

# $(1) - Includes (paths)
ADD_CXX_INCLUDE         = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_CXX_INCLUDE,$$$$(strip $$(1)))))

# $(1) - Includes (paths)
ADD_SYSTEM_INCLUDE      = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_SYS_INCLUDE,$$$$(strip $$(1)))))

# $(1) - Flags
ADD_CF_FLAG             = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_CF_FLAG,$$$$(strip $$(1)))))

# $(1) - Flags
ADD_CXXF_FLAG           = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_CXXF_FLAG,$$$$(strip $$(1)))))

# $(1) - Flags
ADD_LF_FLAG             = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_LF_FLAG,$$$$(strip $$(1)))))

# $(1) - Flags
ADD_LL_FLAG             = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_LL_FLAG,$$$$(strip $$(1)))))

# $(1) - Custom build step dependencies
ADD_CUSTOM_BUILD_DEP    = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_CUSTOM_BUILD_DEP,$$$$(strip $$(1)))))

# $(1) - Custom link step dependencies
ADD_CUSTOM_LINK_DEP     = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_ADD_CUSTOM_LINK_DEP,$$$$(strip $$(1)))))

# $(1) - Source files, .c .cpp .cc .S
BUILD_SOURCE            = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$(call CALL_PUSH_LOCAL_PARAMS_) \
                         $$$$(eval $$$$(call EVAL_BUILD_SOURCE,$$$$(strip $$(1)))))

# $(1) - Output executable name
CXX_LINK                = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$(call CALL_PUSH_LOCAL_PARAMS_) \
                         $$$$(eval $$$$(call EVAL_CXX_LINK_RULE,$$$$(strip $$(1)))))

# $(1) - Output executable name
CC_LINK                 = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$(call CALL_PUSH_LOCAL_PARAMS_) \
                         $$$$(eval $$$$(call EVAL_C_LINK_RULE,$$$$(strip $$(1)))))

# $(1) - Library base name
MAKE_LIRARY             = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_AR_RULE,$$$$(strip $$(1)),$$$$(call LIBNAME_TO_LIBA,$$(1)))))

# $(1) - Dependency friendly names
IMPORT_DEPS             = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_IMPORT_DEPS,$$$$(strip $$(1)))))

# Export build targets to the 'all' target
APPEND_ALL_TARGET_VAR   = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval ALL_TARGETS := $$$$(ALL_TARGETS) $$$$(LAST_TARGET_)))

# $(1) - Friendly dependency name
EXPORT_SHALLOW_DEPS     = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(call EVAL_EXPORT_SHALLOW_DEPS,$$$$(strip $$(1))))) \
    $(eval PRE_EXPORT_LIST_ := $$(value PRE_EXPORT_LIST_) $$(1))


# $(1) - Variable name
APPEND_TARGET_TO_VAR    = \
    $(eval BUILD_CMD_ := $$(value BUILD_CMD_) \
                         $$$$(eval $$$$(strip $$(1)) := $$$$($$(strip $$(1))) $$$$(LAST_TARGET_)))


# ----------------------------------------------------------------- OTHER TOOLS

# $(1) - Architecture name
GET_ARCH_PREFIX         = $(strip \
    $(eval $(call EVAL_ASSERT_ARCH,$(strip $(1)))) \
    $($(strip $(1))_PREFIX))

# (1) - Directory to search
FIND_SOURCE_IN_DIR      = $(shell find $(strip $(1)) -name "*.cpp" -or -name "*.cc" -or -name "*.c" -or -name "*.S")


# --------------------------------------------------------- INTERNAL META RULES

# $(1) - Source files
C_SRC_TO_OBJ            = $(strip $(patsubst %.c,$(OBJ_DIR)/%.o,$(1)))
CPP_SRC_TO_OBJ          = $(strip $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(1)))
CC_SRC_TO_OBJ           = $(strip $(patsubst %.cc,$(OBJ_DIR)/%.o,$(1)))
S_SRC_TO_OBJ            = $(strip $(patsubst %.S,$(OBJ_DIR)/%.o,$(1)))

# $(1) - library base name
LIBNAME_TO_LIBA         = $(strip $(LIB_DIR)/lib$(strip $(1)).a)

# In-recipe rule
MAKE_DIRECTORY 	        = @mkdir -p $(@D)

# (none)
CALL_PUSH_LOCAL_PARAMS_ = $$(eval CF := $(CF)) \
                          $$(eval CXXF := $(CXXF)) \
                          $$(eval LF := $(LF)) \
                          $$(eval LL := $(LL))


# (none)
define EVAL_CLEAR_LOCAL_PARAMS
  CF                    :=
  CXXF                  :=
  LF                    :=
  LL                    :=
endef


# $(1) - Architecture name
# $(2) - Build directory
define EVAL_BEGIN_DEFINE_ARCH
  ifeq ($(1),)
    $$(error Architecture name not defined)
  endif
  ifeq ($(2),)
    $$(error Architecture build directory not defined)
  endif
  ifneq ($$(filter $(1), $$(ALL_ARCH_LIST_)),)
    $$(error Architecture has already been defined)
  endif

  ARCH_                 := $(1)
  BUILD_DIR_            := $(2)

  PREFIX                :=

  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))

  $$(eval $$(call EVAL_CLEAN_RULE,$(2)))
endef


define EVAL_END_DEFINE_ARCH
  $(ARCH_)_PREFIX       := $(PREFIX)
  $(ARCH_)CF            := $($(ARCH_)CF) $(CF)
  $(ARCH_)CXXF          := $($(ARCH_)CXXF) $(CXXF)
  $(ARCH_)LF            := $($(ARCH_)LF) $(LF)
  $(ARCH_)LL            := $($(ARCH_)LL) $(LL)
  $(ARCH_)_BUILD_DIR    := $(BUILD_DIR_)

  ALL_ARCH_LIST_        := $$(ALL_ARCH_LIST_) $(ARCH_)

  ARCH_                 :=
  BUILD_DIR_            :=

  PREFIX                :=
  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))
endef


# $(1) - Arch name
define EVAL_BEGIN_ARCH_BUILD

  ifeq ($(1),)
    $$(error Missing architecture name)
  endif

  ifeq ($$(filter $(1), $$(ALL_ARCH_LIST_)),)
    $$(error Architecture has not been defined yet)
  endif

  AS                    := $$($(1)_PREFIX)as
  AR                    := $$($(1)_PREFIX)ar
  CC                    := $$($(1)_PREFIX)gcc
  CXX                   := $$($(1)_PREFIX)g++
  LD                    := $$($(1)_PREFIX)ld
  NM                    := $$($(1)_PREFIX)nm
  STRIP                 := $$($(1)_PREFIX)strip
  OBJCOPY               := $$($(1)_PREFIX)objcopy
  OBJDUMP               := $$($(1)_PREFIX)objdump

  BUILD_DIR             := $$($(1)_BUILD_DIR)
  OBJ_DIR               := $$($(1)_BUILD_DIR)/obj
  LIB_DIR               := $$($(1)_BUILD_DIR)/lib
  BIN_DIR               := $$($(1)_BUILD_DIR)/bin

  ARCH                  := $(1)

  OBJS                  :=
  LIBS_BASENAME         :=
  LAST_TARGET_          :=

  # Locally created dependencies
  LDEP_CF_              :=
  LDEP_CXXF_            :=
  LDEP_LF_              :=
  LDEP_LL_              :=
  LDEP_LINK_            :=

  # Local (hidden) flags
  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))

  # Imported dependencies
  DEPS_CF_              :=
  DEPS_CXXF_            :=
  DEPS_LF_              :=
  DEPS_LL_              :=
  DEPS_LINK_            :=
  DEPS_BUILD_           :=

  # Post-expansion rules
  PRE_EXPORT_LIST_      :=
  BUILD_CMD_            :=
endef


define EVAL_END_ARCH_BUILD
  # Expand the meta rules
  $$(eval $$(BUILD_CMD_))

  AS                    := false
  AR                    := false
  CC                    := false
  CXX                   := false
  LD                    := false
  NM                    := false
  STRIP                 := false
  OBJCOPY               := false
  OBJDUMP               := false

  BUILD_DIR             :=
  OBJ_DIR               :=
  LIB_DIR               :=
  BIN_DIR               :=

  ARCH                  :=

  OBJS                  :=
  LIBS_BASENAME         :=
  LAST_TARGET_          :=

  # Locally created dependencies
  LDEP_CF_              :=
  LDEP_CXXF_            :=
  LDEP_LF_              :=
  LDEP_LL_              :=
  LDEP_LINK_            :=

  # Local (hidden) flags
  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))

  # Imported dependencies
  DEPS_CF_              :=
  DEPS_CXXF_            :=
  DEPS_LF_              :=
  DEPS_LL_              :=
  DEPS_LINK_            :=
  DEPS_BUILD_           :=

  # Post-expansion rules
  PRE_EXPORT_LIST_      :=
  BUILD_CMD_            :=
endef


define EVAL_BEGIN_UNIVERSAL_BUILD
  # Local build rule
  PRE_EXPORT_LIST_      :=
  BUILD_CMD_            :=

  # Local (hidden) flags
  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))
endef


define EVAL_END_UNIVERSAL_BUILD
  # Universal build rules
  UNIV_BUILD_CMD_       := $$(value BUILD_CMD_)
  UNIV_PRE_EXPORT_LIST_ := $$(value PRE_EXPORT_LIST_)

  # Expand the universal rule for each known architecture
  $$(foreach arch,$$(ALL_ARCH_LIST_),$$(eval $$(call EVAL_EXPAND_UNIV_DEPS,$$(arch))))

  UNIV_BUILD_CMD_       :=
  UNIV_PRE_EXPORT_LIST_ :=

  # Local build rule
  PRE_EXPORT_LIST_      :=
  BUILD_CMD_            :=

  # Local (hidden) flags
  $$(eval $$(EVAL_CLEAR_LOCAL_PARAMS))
endef

# $(1) - Arch name
define EVAL_EXPAND_UNIV_DEPS
  $$(foreach dep,$$(UNIV_PRE_EXPORT_LIST_),$$(eval $$(call EVAL_EXPAND_UNIV_DEP,$(1),$$(dep))))
endef

# $(1) - Arch name
# $(2) - Dep name
define EVAL_EXPAND_UNIV_DEP
  # Only expand the rule if the dep has not already been exported
  ifeq ($$(filter $(1)_$(2),$$(EXPORTED_DEP_NAMES_)),)
    $$(call BEGIN_ARCH_BUILD, $(1))
      $$(eval $$(UNIV_BUILD_CMD_))
    $$(call END_ARCH_BUILD)
  endif
endef


# $(1) - Object to clean
define EVAL_CLEAN_RULE
CLEAN_TARGETS           := $$(CLEAN_TARGETS) $(1)_CLEAN

.PHONY: $(1)_CLEAN
$(1)_CLEAN:
	$$(Q)rm -rf $(1)
endef


# $(1) - Source files
define EVAL_BUILD_SOURCE
  LAST_TARGET_          :=

  _SRC_                 := $$(filter %.c,$(1))
  ifneq ($$(_SRC_),)
    $$(foreach f,$$(_SRC_),$$(eval $$(call EVAL_C_RULE,$$(f),$$(call C_SRC_TO_OBJ,$$(f)))))
  endif

  _SRC_                 := $$(filter %.cpp,$(1))
  ifneq ($$(_SRC_),)
    $$(foreach f,$$(_SRC_),$$(eval $$(call EVAL_CPP_RULE,$$(f),$$(call CPP_SRC_TO_OBJ,$$(f)))))
  endif

  _SRC_                 := $$(filter %.cc,$(1))
  ifneq ($$(_SRC_),)
    $$(foreach f,$$(_SRC_),$$(eval $$(call EVAL_CPP_RULE,$$(f),$$(call CC_SRC_TO_OBJ,$$(f)))))
  endif

  _SRC_                 := $$(filter %.S,$(1))
  ifneq ($$(_SRC_),)
    $$(foreach f,$$(_SRC_),$$(eval $$(call EVAL_ASM_RULE,$$(f),$$(call S_SRC_TO_OBJ,$$(f)))))
  endif

  _SRC_                 :=
endef


# $(1) - Output name
define EVAL_CXX_LINK_RULE
LAST_TARGET_            := $(BIN_DIR)/$(1)

$(BIN_DIR)/$(1)_CXX_LINK_CMD  = \
    $(CXX) $$($(ARCH)CF) $(CF) $(DEPS_CF_) $(LDEP_CF_) \
    $$($(ARCH)CXXF) $(CXXF) $(DEPS_CXXF_) $(LDEP_CXXF_) \
    $$($(ARCH)LF) $(LF) $(DEPS_LF_) $(LDEP_LF_) \
    -o $$@ $$(filter %.o,$$^) \
    $$($(ARCH)LL) $(LL) $(DEPS_LL_) $(LDEP_LL_)

$(BIN_DIR)/$(1): $(OBJS) $$(value DEPS_LINK_) $$(value LDEP_LINK_)
	$$(MAKE_DIRECTORY)
	@echo "CXX LINK $$@"
	$$(Q)$$($(BIN_DIR)/$(1)_CXX_LINK_CMD)
endef


# $(1) - Output name
define EVAL_C_LINK_RULE
LAST_TARGET_            := $(BIN_DIR)/$(1)

$(BIN_DIR)/$(1)_CC_LINK_CMD  = \
    $(CC) $$($(ARCH)CF) $(CF) $(DEPS_CF_) $(LDEP_CF_) \
    $$($(ARCH)LF) $(LF) $(DEPS_LF_) $(LDEP_LF_) \
    -o $$@ $$(filter %.o,$$^) \
    $$($(ARCH)LL) $(LL) $(DEPS_LL_) $(LDEP_LL_)

$(BIN_DIR)/$(1): $(OBJS) $$(value DEPS_LINK_) $$(value LDEP_LINK_)
    $$(MAKE_DIRECTORY)
    @echo "CC LINK $$@"
    $$(Q)$$($(BIN_DIR)/$(1)_CC_LINK_CMD)
endef


# (1) - Source filename
# (2) - Object filename
define EVAL_C_RULE
OBJS                    := $$(OBJS) $(2)
LAST_TARGET_            := $$(LAST_TARGET_) $(2)

$(2)_CC_CMD             = \
    $(CC) $$($(ARCH)CF) $(CF) $(DEPS_CF_) $(LDEP_CF_) \
    -MMD -MP -MT '$(2)' -MF '$(2).d' \
    -o $$@ -c $$<

_M_BUILD_DEP_$(2)       = $(value DEPS_BUILD_)

$(2): $(1) $$(_M_BUILD_DEP_$(2))
	$$(MAKE_DIRECTORY)
	@echo "CC $(1) --> $(2)"
	$$(Q)$$($(2)_CC_CMD)

-include $(2).d
endef


# (1) - Source filename
# (2) - Object filename
define EVAL_CPP_RULE
OBJS                    := $$(OBJS) $(2)
LAST_TARGET_            := $$(LAST_TARGET_) $(2)

$(2)_CXX_CMD            = \
    $(CXX) $$($(ARCH)CF) $(CF) $(DEPS_CF_) $(LDEP_CF_) \
    $$($(ARCH)CXXF) $(CXXF) $(DEPS_CXXF_) $(LDEP_CXXF_) \
    -MMD -MP -MT '$(2)' -MF '$(2).d' \
    -o $$@ -c $$<

_M_BUILD_DEP_$(2)       = $(value DEPS_BUILD_)

$(2): $(1) $$(_M_BUILD_DEP_$(2))
	$$(MAKE_DIRECTORY)
	@echo "CXX $(1) --> $$@"
	$$(Q)$$($(2)_CXX_CMD)

-include $(2).d
endef


# (1) - Source filename
# (2) - Object filename
define EVAL_ASM_RULE
OBJS                    := $$(OBJS) $(2)
LAST_TARGET_            := $$(LAST_TARGET_) $(2)

_M_BUILD_DEP_$(2)       = $(value DEPS_BUILD_)

$(2): $(1) $$(_M_BUILD_DEP_$(2))
	$$(MAKE_DIRECTORY)
	@echo "AS $(1) --> $$@"
	$$(Q)$(AS) -g -o $$@ -c $$<
endef


# (1) - Library base name
# (2) - Archive filename
define EVAL_AR_RULE
LDEP_LINK_              := $$(value LDEP_LINK_) $(2)
LIBS_BASENAME           := $$(LIBS_BASENAME) $(1)
LAST_TARGET_            := $(2)

_M_BUILD_DEP_$(2)       = $(value DEPS_BUILD_)

$(2): $(OBJS) $$(_M_BUILD_DEP_$(2))
	$$(MAKE_DIRECTORY)
	@echo "AR $(OBJS) --> $$@"
	$$(Q)$(AR) -r $$@ $(OBJS)
endef


# $(1) - Export symbol name
define EVAL_EXPORT_SHALLOW_DEPS
  EXPORTED_DEP_NAMES_       := $$(EXPORTED_DEP_NAMES_) $(ARCH)_$(1)

  $(ARCH)DEPS_CF_$(1)       := $$(value LDEP_CF_)
  $(ARCH)DEPS_CXXF_$(1)     := $$(value LDEP_CXXF_)

  $(ARCH)DEPS_BUILD_$(1)    := $$(value DEPS_BUILD_)
  $(ARCH)DEPS_LINK_$(1)     := $$(value LDEP_LINK_)

  ifneq ($(LIBS_BASENAME),)
    $(ARCH)DEPS_LF_$(1)     := $$(value LDEP_LF_) -L$(LIB_DIR)
    $(ARCH)DEPS_LL_$(1)     := $$(value LDEP_LL_) $(patsubst %,-l%,$(LIBS_BASENAME))
  else
    $(ARCH)DEPS_LF_$(1)     := $$(value LDEP_LF_)
    $(ARCH)DEPS_LL_$(1)     := $$(value LDEP_LL_)
  endif
endef


# $(1) - Import symbol name
define EVAL_IMPORT_DEP
  IMPORTED_DEP_NAMES_   := $$(IMPORTED_DEP_NAMES_) $(ARCH)_$(1)

  DEPS_BUILD_           := $$(value DEPS_BUILD_) $$$$($(ARCH)DEPS_BUILD_$(1))
  DEPS_LINK_            := $$(value DEPS_LINK_) $$$$($(ARCH)DEPS_LINK_$(1))
  DEPS_CF_              := $$(value DEPS_CF_) $$$$($(ARCH)DEPS_CF_$(1))
  DEPS_CXXF_            := $$(value DEPS_CXXF_) $$$$($(ARCH)DEPS_CXXF_$(1))
  DEPS_LF_              := $$(value DEPS_LF_) $$$$($(ARCH)DEPS_LF_$(1))
  DEPS_LL_              := $$(value DEPS_LL_) $$$$($(ARCH)DEPS_LL_$(1))
endef


# (1) - Import symbol names
define EVAL_IMPORT_DEPS
  $$(foreach dep,$(1),$$(eval $$(call EVAL_IMPORT_DEP,$$(dep))))
endef


# (1) - Architecture prefix
define EVAL_BEGIN_APPEND_ARCH_FLAGS
  ARCH                  := $(1)

  CF                    :=
  CXXF                  :=
  LF                    :=
  LL                    :=
endef


define EVAL_END_APPEND_ARCH_FLAGS
  $(ARCH)CF             := $$($(ARCH)CF) $$(CF)
  $(ARCH)CXXF           := $$($(ARCH)CXXF) $$(CXXF)
  $(ARCH)LF             := $$($(ARCH)LF) $$(LF)
  $(ARCH)LL             := $$($(ARCH)LL) $$(LL)

  ARCH                  :=

  CF                    :=
  CXXF                  :=
  LF                    :=
  LL                    :=
endef


# $(1) - Include path
define EVAL_ADD_C_INCLUDE
  LDEP_CF_              := $$(value LDEP_CF_) $$(patsubst %,-I%,$(1))
endef

# $(1) - Include path
define EVAL_ADD_CXX_INCLUDE
  LDEP_CXXF_            := $$(value LDEP_CXXF_) $$(patsubst %,-I%,$(1))
endef

# $(1) - System include path
define EVAL_ADD_SYS_INCLUDE
  LDEP_CF_              := $$(value LDEP_CF_) $$(patsubst %,-isystem %,$(1))
endef

# $(1) - Flags
define EVAL_ADD_CF_FLAG
  LDEP_CF_              := $$(value LDEP_CF_) $(1)
endef

# $(1) - Flags
define EVAL_ADD_CXXF_FLAG
  LDEP_CXXF_            := $$(value LDEP_CXXF_) $(1)
endef

# $(1) - Flags
define EVAL_ADD_LF_FLAG
  LDEP_LF_              := $$(value LDEP_LF_) $(1)
endef

# $(1) - Flags
define EVAL_ADD_LL_FLAG
  LDEP_LL_              := $$(value LDEP_LL_) $(1)
endef

# $(1) - Custom build step dependencies
define EVAL_ADD_CUSTOM_BUILD_DEP
  DEPS_BUILD_           := $$(value DEPS_BUILD_) $(1)
endef

# $(1) - Custom link step dependencies
define EVAL_ADD_CUSTOM_LINK_DEP
  LDEP_LINK_            := $$(value LDEP_LINK_) $(1)
endef

# $(1) - Architecture name
define EVAL_ASSERT_ARCH
  ifeq ($$(filter $(1), $$(ALL_ARCH_LIST_)),)
    $$(error Architecture $(1) has not been defined)
  endif
endef


# -------------------------------------------------------------- INTERNAL RULES


# $(1) - Dependency name to check for
define EVAL_CHECK_IS_EXPORTED
  ifeq ($$(filter $(1),$$(EXPORTED_DEP_NAMES_)),)
    $$(error Dependency $(1) was imported, but never exported)
  endif
endef
define EVAL_COMPARE_IMPORT_EXPORT_LIST
  $$(foreach dep,$$(IMPORTED_DEP_NAMES_),$$(eval $$(call EVAL_CHECK_IS_EXPORTED,$$(dep))))
endef
# This checks that all IMPORT_DEPS were eventually matched with an
# EXPORT_SHALLOW_DEPS
.PHONY: METAMAKE_CHECK_EXPORT_LIST
METAMAKE_CHECK_EXPORT_LIST: $$(eval $$(EVAL_COMPARE_IMPORT_EXPORT_LIST)) ;

# ALL_TARGETS wrapper
.PHONY: METAMAKE_ALL
METAMAKE_ALL: $$(ALL_TARGETS) ;

# CLEAN_TARGETS wrapper
.PHONY: METAMAKE_CLEAN
METAMAKE_CLEAN: $$(CLEAN_TARGETS) ;

