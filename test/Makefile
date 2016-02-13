# ---------------------------------------------------------------- DEFAULT GOAL
.DEFAULT_GOAL           := all


# ------------------------------------------------------------------ META RULES

# $(1) - Directory to call
M_MAKE_TEST_CALL        = $(eval $(call M_EVAL_MAKE_TEST_CALL,$(strip $(1))))
define M_EVAL_MAKE_TEST_CALL

ALL_TESTS               := $(ALL_TESTS) $(1)

.PHONY: $(1)
$(1):
	$(MAKE) -C $(1)
endef


# ---------------------------------------------------------------- GLOBAL RULES

TEST_DIRS         		:= $(shell find . -type d -and -not -name ".")
$(foreach test,$(TEST_DIRS), $(call M_MAKE_TEST_CALL,$(test)))

.PHONY: all
all: $(ALL_TESTS)
	@echo "===== All tests finished ====="

