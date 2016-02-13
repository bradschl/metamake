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

TEST_SRC                := src/TRACE_src.cpp
.PHONY: $(TEST_SRC)

TEST_EXEC               := TRACE_exec

$(call BEGIN_ARCH_BUILD, TRACE_ARCH)

  CF                    := HIDDEN_cf
  CXXF                  := HIDDEN_cxxf
  LF                    := HIDDEN_lf
  LL                    := HIDDEN_ll

  $(call ADD_CF_FLAG,           LOCAL_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_lf)
  $(call ADD_LL_FLAG,           LOCAL_ll)

  $(call BUILD_SOURCE,      	$(TEST_SRC))
  $(call APPEND_TARGET_TO_VAR, 	TRACE_targetObj) # Trace source build step

  $(call CXX_LINK,              $(TEST_EXEC))
  $(call APPEND_TARGET_TO_VAR,  TRACE_targetExec) # Trace linking step

$(call END_ARCH_BUILD)


# ----------------------------------------------------------------------- TESTS

# Use second expansion to intercept the dependencies
$(TRACE_targetObj): $$(eval $$(M_TEST_cxx_build_has_arch_flags))
define M_TEST_cxx_build_has_arch_flags
  $(info Running M_TEST_cxx_build_has_arch_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # $$(info $$(TARGET_NAME) depends on: $$(TARGET_DEPS))
  # $$(info $$(TARGET_NAME) build command: $$(TARGET_BUILD_CMD))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    M_ARCH_prefix-g++,      $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_cf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_cxxf,            $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_cxx_build_has_arch_flags)
endef

$(TRACE_targetObj): $$(eval $$(M_TEST_cxx_build_has_local_flags))
define M_TEST_cxx_build_has_local_flags
  $(info Running M_TEST_cxx_build_has_local_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    LOCAL_cf,               $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_cxxf,             $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_cxx_build_has_local_flags)
endef

$(TRACE_targetObj): $$(eval $$(M_TEST_cxx_build_has_hidden_flags))
define M_TEST_cxx_build_has_hidden_flags
  $(info Running M_TEST_cxx_build_has_hidden_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    HIDDEN_cf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    HIDDEN_cxxf,            $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_cxx_build_has_hidden_flags)
endef



$(TRACE_targetExec): $$(eval $$(M_TEST_cxx_link_has_arch_flags))
define M_TEST_cxx_link_has_arch_flags
  $(info Running M_TEST_cxx_link_has_arch_flags...)

  # Target info
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_LINK_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    M_ARCH_prefix-g++,      $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_cf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_cxxf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_lf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    M_ARCH_ll,              $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_cxx_link_has_arch_flags)
endef

$(TRACE_targetExec): $$(eval $$(M_TEST_cxx_link_has_local_flags))
define M_TEST_cxx_link_has_local_flags
  $(info Running M_TEST_cxx_link_has_local_flags...)

  # Target info
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_LINK_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    LOCAL_cf,               $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_cxxf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_lf,               $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_ll,               $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_cxx_link_has_local_flags)
endef

$(TRACE_targetExec): $$(eval $$(M_TESY_cxx_link_has_hidden_flags))
define M_TESY_cxx_link_has_hidden_flags
  $(info Running M_TESY_cxx_link_has_hidden_flags...)

  # Target info
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CXX_LINK_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS,    HIDDEN_cf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    HIDDEN_cxxf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    HIDDEN_lf,              $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    HIDDEN_ll,              $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TESY_cxx_link_has_hidden_flags)
endef


# --------------------------------------------------------------- RUN ALL TESTS
.PHONY: all
all: 
	@echo "Test finished"

