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
# TRACE_3_targetDep imports TRACE_2_targetDep and TRACE_1_targetDep

.PHONY: TRACE_3_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_2_targetDep TRACE_1_targetDep)
  $(call ADD_ASF_FLAG,          LOCAL_3_asf)
  $(call ADD_CF_FLAG,           LOCAL_3_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_3_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_3_lf)
  $(call ADD_LL_FLAG,           LOCAL_3_ll)

  $(call BUILD_SOURCE,          TRACE_3_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_3_targetObj) # Trace source build step

  $(call MAKE_LIBRARY,          TRACE_3_library)
  $(call APPEND_TARGET_TO_VAR,  TRACE_3_targetLib) # Trace library build step

  $(call EXPORT_SHALLOW_DEPS,   TRACE_3_targetDep)
$(call END_ARCH_BUILD)

.PHONY: TRACE_2_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_1_targetDep)
  $(call ADD_ASF_FLAG,          LOCAL_2_asf)
  $(call ADD_CF_FLAG,           LOCAL_2_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_2_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_2_lf)
  $(call ADD_LL_FLAG,           LOCAL_2_ll)

  $(call BUILD_SOURCE,          TRACE_2_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetObj) # Trace source build step

  $(call MAKE_LIBRARY,          TRACE_2_library)
  $(call APPEND_TARGET_TO_VAR,  TRACE_2_targetLib) # Trace library build step

  $(call EXPORT_SHALLOW_DEPS,   TRACE_2_targetDep)
$(call END_ARCH_BUILD)

.PHONY: TRACE_1_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call ADD_ASF_FLAG,          LOCAL_1_asf)
  $(call ADD_CF_FLAG,           LOCAL_1_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_1_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_1_lf)
  $(call ADD_LL_FLAG,           LOCAL_1_ll)

  $(call BUILD_SOURCE,          TRACE_1_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetObj) # Trace source build step

  $(call MAKE_LIBRARY,          TRACE_1_library)
  $(call APPEND_TARGET_TO_VAR,  TRACE_1_targetLib) # Trace library build step

  $(call EXPORT_SHALLOW_DEPS,   TRACE_1_targetDep)
$(call END_ARCH_BUILD)


# TRACE_4_targetExec has no imports
# TRACE_5_targetExec imports TRACE_1_targetDep
# TRACE_6_targetExec imports TRACE_2_targetDep and TRACE_1_targetDep

.PHONY: TRACE_4_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call ADD_ASF_FLAG,          LOCAL_4_asf)
  $(call ADD_CF_FLAG,           LOCAL_4_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_4_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_4_lf)
  $(call ADD_LL_FLAG,           LOCAL_4_ll)

  $(call BUILD_SOURCE,          TRACE_4_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_4_targetObj) # Trace source build step

  $(call CC_LINK,               TRACE_4_exec)
  $(call APPEND_TARGET_TO_VAR,  TRACE_4_targetExec) # Target executable build step
$(call END_ARCH_BUILD)

.PHONY: TRACE_5_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_1_targetDep)

  $(call ADD_ASF_FLAG,          LOCAL_5_asf)
  $(call ADD_CF_FLAG,           LOCAL_5_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_5_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_5_lf)
  $(call ADD_LL_FLAG,           LOCAL_5_ll)

  $(call BUILD_SOURCE,          TRACE_5_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_5_targetObj) # Trace source build step

  $(call CC_LINK,               TRACE_5_exec)
  $(call APPEND_TARGET_TO_VAR,  TRACE_5_targetExec) # Target executable build step
$(call END_ARCH_BUILD)

.PHONY: TRACE_6_targetSrc.c
$(call BEGIN_ARCH_BUILD, TRACE_ARCH)
  $(call IMPORT_DEPS,           TRACE_2_targetDep TRACE_1_targetDep)

  $(call ADD_ASF_FLAG,          LOCAL_6_asf)
  $(call ADD_CF_FLAG,           LOCAL_6_cf)
  $(call ADD_CXXF_FLAG,         LOCAL_6_cxxf)
  $(call ADD_LF_FLAG,           LOCAL_6_lf)
  $(call ADD_LL_FLAG,           LOCAL_6_ll)

  $(call BUILD_SOURCE,          TRACE_6_targetSrc.c)
  $(call APPEND_TARGET_TO_VAR,  TRACE_6_targetObj) # Trace source build step

  $(call CC_LINK,               TRACE_6_exec)
  $(call APPEND_TARGET_TO_VAR,  TRACE_6_targetExec) # Target executable build step
$(call END_ARCH_BUILD)


# ----------------------------------------------------------------------- TESTS

# Use second expansion to intercept the dependencies
$(TRACE_1_targetObj): $$(eval $$(M_TEST_TRACE_1_target_import_deps))
define M_TEST_TRACE_1_target_import_deps
  $(info Running M_TEST_TRACE_1_target_import_deps...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_1_target_import_deps)
endef


$(TRACE_2_targetObj): $$(eval $$(M_TEST_TRACE_2_target_import_deps))
define M_TEST_TRACE_2_target_import_deps
  $(info Running M_TEST_TRACE_2_target_import_deps...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_2_target_import_deps)
endef


$(TRACE_3_targetObj): $$(eval $$(M_TEST_TRACE_3_target_import_deps))
define M_TEST_TRACE_3_target_import_deps
  $(info Running M_TEST_TRACE_3_target_import_deps...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  # Asserts
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_3_target_import_deps)
endef


$(TRACE_4_targetObj): $$(eval $$(M_TEST_TRACE_4_cc_target_has_flags))
define M_TEST_TRACE_4_cc_target_has_flags
  $(info Running M_TEST_TRACE_4_cc_target_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_4_cc_target_has_flags)
endef


$(TRACE_5_targetObj): $$(eval $$(M_TEST_TRACE_5_cc_target_has_flags))
define M_TEST_TRACE_5_cc_target_has_flags
  $(info Running M_TEST_TRACE_5_cc_target_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_5_cc_target_has_flags)
endef


$(TRACE_6_targetObj): $$(eval $$(M_TEST_TRACE_6_cc_target_has_flags))
define M_TEST_TRACE_6_cc_target_has_flags
  $(info Running M_TEST_TRACE_6_cc_target_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_BUILD_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_6_cc_target_has_flags)
endef


$(TRACE_4_targetExec): $$(eval $$(M_TEST_TRACE_4_cc_link_has_flags))
define M_TEST_TRACE_4_cc_link_has_flags
  $(info Running M_TEST_TRACE_4_cc_link_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_LINK_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_4_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_4_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_ll,             $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_4_cc_link_has_flags)
endef


$(TRACE_5_targetExec): $$(eval $$(M_TEST_TRACE_5_cc_link_has_flags))
define M_TEST_TRACE_5_cc_link_has_flags
  $(info Running M_TEST_TRACE_5_cc_link_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_LINK_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_5_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_5_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_ll,             $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_5_cc_link_has_flags)
endef


$(TRACE_6_targetExec): $$(eval $$(M_TEST_TRACE_6_cc_link_has_flags))
define M_TEST_TRACE_6_cc_link_has_flags
  $(info Running M_TEST_TRACE_6_cc_link_has_flags...)

  # Target info
  # Since this is evaluated during second expansion, we have access to $^, etc
  TARGET_NAME           := $$@
  TARGET_DEPS           := $$^
  TARGET_BUILD_CMD      := $$($$(call M_GET_CC_LINK_CMD, $$(TARGET_NAME)))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_1_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_1_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_2_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_2_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_3_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_4_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_5_ll,             $$(TARGET_BUILD_CMD))

  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_asf,            $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_6_cf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS_N,  LOCAL_6_cxxf,           $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_6_lf,             $$(TARGET_BUILD_CMD))
  $$(call M_ASSERT_CONTAINS,    LOCAL_6_ll,             $$(TARGET_BUILD_CMD))

  $$(info ...Finished M_TEST_TRACE_6_cc_link_has_flags)
endef


# --------------------------------------------------------------- RUN ALL TESTS
.PHONY: all
all:
	@echo "Test finished"

