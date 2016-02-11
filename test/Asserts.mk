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

# ------------------------------------------------------------------ ASSERTIONS
# Assertion level
LEVEL ?= error


# Assert $(1) == $(2)
# $(1) - LHS
# $(2) - RHS
M_ASSERT_EQ = $(eval $(call M_EVAL_ASSERT_EQ,$(strip $(1)),$(strip $(2))))
define M_EVAL_ASSERT_EQ
  ifneq ($(1)),$(2))
    $$($(LEVEL) M_ASSERT_EQ failed, "$(1)" does not equal "$(2)")
  endif
endef


# Assert $(1) is contained within $(2)
M_ASSERT_CONTAINS = $(eval $(call M_EVAL_ASSERT_CONTAINS,$(strip $(1)),$(strip $(2))))
define M_EVAL_ASSERT_CONTAINS
  ifeq ($$(filter $(1),$(2)),)
    $$($(LEVEL) M_ASSERT_CONTAINS failed, "$(1)" is not contained in "$(2)")
  endif
endef


