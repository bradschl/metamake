# ------------------------------------------------------------------ STACK PUSH
sp                      := $(sp).x
dirstack_$(sp)          := $(d)
d                       := $(dir)

# ------------------------------------------------------------- LOCAL VARIABLES
DEP_NAME_$(d) 			:= libbar
LIB_NAME_$(d)           := bar
SRC_$(d)                := $(call FIND_SOURCE_IN_DIR, $(d)/src)
INCLUDE_$(d)            := $(d)/include

# ----------------------------------------------------------------- LOCAL BUILD
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_C_INCLUDE,         $(INCLUDE_$(d)))      # Add local include path
  $(call BUILD_SOURCE,          $(SRC_$(d)))          # Build objects
  $(call MAKE_LIRARY,           $(LIB_NAME_$(d)))     # Make objects from previous steps into a lib
  $(call EXPORT_SHALLOW_DEPS,   $(DEP_NAME_$(d)))     # Export the dependencies for building against this lib
$(call END_UNIVERSAL_BUILD)


# ------------------------------------------------------------------- POP STACK
d                       := $(dirstack_$(sp))
sp                      := $(basename $(sp))
