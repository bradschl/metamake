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
  ASF                   := M_ARCH_asf
  CF                    := M_ARCH_cf
  CXXF                  := M_ARCH_cxxf
  LF                    := M_ARCH_lf
  LL                    := M_ARCH_ll
$(call END_DEFINE_ARCH)


# -------------------------------------------------------------- TEST CONSTRUCT
# TRACE_1_targetDep has no imports
# TRACE_2_targetDep imports TRACE_1_targetDep

.PHONY: TRACE_1_targetSrc_as.S
.PHONY: TRACE_1_targetSrc_cc.c
.PHONY: TRACE_1_targetSrc_cxx.cpp
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call ADD_AS_INCLUDE,        LOCAL_1_as_include)
  $(call ADD_C_INCLUDE,         LOCAL_1_cc_include)
  $(call ADD_CXX_INCLUDE,       LOCAL_1_cxx_include)

  $(call BUILD_SOURCE,          TRACE_1_targetSrc_as.S)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetObj_S) # Trace source build step

  $(call BUILD_SOURCE,          TRACE_1_targetSrc_cc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetObj_cc) # Trace source build step

  $(call BUILD_SOURCE,          TRACE_1_targetSrc_cxx.cpp)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetObj_cxx) # Trace source build step

  $(call MAKE_LIRARY,           TRACE_1_library)
  $(call EXPORT_SHALLOW_DEPS,   TRACE_1_targetDep)
$(call END_ARCH_BUILD)

.PHONY: TRACE_2_targetSrc_as.S
.PHONY: TRACE_2_targetSrc_cc.c
.PHONY: TRACE_2_targetSrc_cxx.cpp
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_1_targetDep)

  $(call ADD_AS_INCLUDE,        LOCAL_2_as_include)
  $(call ADD_C_INCLUDE,         LOCAL_2_cc_include)
  $(call ADD_CXX_INCLUDE,       LOCAL_2_cxx_include)

  $(call BUILD_SOURCE,          TRACE_2_targetSrc_as.S)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetObj_S) # Trace source build step

  $(call BUILD_SOURCE,          TRACE_2_targetSrc_cc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetObj_cc) # Trace source build step

  $(call BUILD_SOURCE,          TRACE_2_targetSrc_cxx.cpp)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetObj_cxx) # Trace source build step

  $(call MAKE_LIRARY,           TRACE_2_library)
  $(call EXPORT_SHALLOW_DEPS,   TRACE_2_targetDep)
$(call END_ARCH_BUILD)


# ----------------------------------------------------------------------- TESTS

# Use second expansion to intercept the dependencies
$(TRACE_1_targetObj_S): $$(eval $$(M_TEST_TRACE_1_as_include))
define M_TEST_TRACE_1_as_include
  $(info Running M_TEST_TRACE_1_as_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_AS_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_1_as_include)
endef

$(TRACE_1_targetObj_cc): $$(eval $$(M_TEST_TRACE_1_cc_include))
define M_TEST_TRACE_1_cc_include
  $(info Running M_TEST_TRACE_1_cc_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_1_cc_include)
endef

$(TRACE_1_targetObj_cxx): $$(eval $$(M_TEST_TRACE_1_cxx_include))
define M_TEST_TRACE_1_cxx_include
  $(info Running M_TEST_TRACE_1_cxx_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_1_cxx_include)
endef

$(TRACE_2_targetObj_S): $$(eval $$(M_TEST_TRACE_2_as_include))
define M_TEST_TRACE_2_as_include
  $(info Running M_TEST_TRACE_2_as_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_AS_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_2_as_include)
endef

$(TRACE_2_targetObj_cc): $$(eval $$(M_TEST_TRACE_2_cc_include))
define M_TEST_TRACE_2_cc_include
  $(info Running M_TEST_TRACE_2_cc_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_2_cc_include)
endef

$(TRACE_2_targetObj_cxx): $$(eval $$(M_TEST_TRACE_2_cxx_include))
define M_TEST_TRACE_2_cxx_include
  $(info Running M_TEST_TRACE_2_cxx_include...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_1_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_1_cxx_include,  $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  -ILOCAL_2_as_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_2_cc_include,   $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    -ILOCAL_2_cxx_include,  $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_2_cxx_include)
endef

# --------------------------------------------------------------- RUN ALL TESTS
.PHONY: all
all:
	@echo "Test finished"

