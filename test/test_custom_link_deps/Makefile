# Copyright (c) 2016 Bradley Kim Schleusner < bradschl@gmail.com >
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

# ---------------------------------------------------------------- DEFAULT GOAL
.DEFAULT_GOAL           := all


# ------------------------------------------------------------------ META RULES
include ../../Meta.mk
include ../Asserts.mk


# ----------------------------------------------------------- TEST ARCHITECTURE
$(call BEGIN_DEFINE_ARCH, TRACE_ARCH, build_TRACE_ARCH)
  PREFIX                := M_ARCH_prefix-
  CF                    := M_ARCH_cf
  CXXF                  := M_ARCH_cxxf
  LF                    := M_ARCH_lf
  LL                    := M_ARCH_ll
$(call END_DEFINE_ARCH)


# -------------------------------------------------------------- TEST CONSTRUCT

.PHONY: TRACE_CUSTOM_LINK_STEP
TRACE_CUSTOM_LINK_STEP: ;

# TRACE_1_targetDep has no imports, has a custom link dependency
# TRACE_2_targetExec imports TRACE_1_targetDep, inherits the custom
#   link dependency

.PHONY: TRACE_1_targetSrc.cpp
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call ADD_CUSTOM_LINK_DEP,   TRACE_CUSTOM_LINK_STEP)

  $(call BUILD_SOURCE,          TRACE_1_targetSrc.cpp)

  $(call MAKE_LIRARY,           TRACE_1_library)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetLib) # Trace library link step

  $(call EXPORT_SHALLOW_DEPS,   TRACE_1_targetDep)
$(call END_ARCH_BUILD)


.PHONY: TRACE_2_targetSrc.cpp
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_1_targetDep)

  $(call BUILD_SOURCE,          TRACE_2_targetSrc.cpp)

  $(call CXX_LINK,              TRACE_2_exec)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetExec) # Target executable linking target

$(call END_ARCH_BUILD)


# ----------------------------------------------------------------------- TESTS

$(TRACE_2_targetExec): $$(eval $$(M_TEST_TRACE_2_target_has_custom_link_dep))
define M_TEST_TRACE_2_target_has_custom_link_dep
  $(info Running M_TEST_TRACE_2_target_has_custom_link_dep...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  # TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    $$(TRACE_1_targetLib),      $$(TARGET_DEPS))
  $$(call M_ASSERT_CONTAINS,    TRACE_CUSTOM_LINK_STEP,     $$(TARGET_DEPS))

  $$(info ...Finished M_TEST_TRACE_2_target_has_custom_link_dep)
endef


# --------------------------------------------------------------- RUN ALL TESTS
.PHONY: all
all: 
	@echo "Test finished"

