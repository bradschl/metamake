# ------------------------------------------------------------------ STACK PUSH
sp                      := $(sp).x
dirstack_$(sp)          := $(d)
d                       := $(dir)

# ------------------------------------------------------------- LOCAL VARIABLES
TARGET_NAME_$(d)        := application
SRC_$(d)                := $(call FIND_SOURCE_IN_DIR, $(d)/src)
SRC_ARM_$(d)            := $(call FIND_SOURCE_IN_DIR, $(d)/src_arm)
INCLUDE_$(d)            := $(d)/include

# ----------------------------------------------------------------- LOCAL BUILD
$(call BEGIN_ARCH_BUILD, HOST)
  $(call IMPORT_DEPS,       libbar)               # Import build dependencies
  $(call ADD_CXX_INCLUDE,   $(INCLUDE_$(d)))      # Add local include path
  $(call BUILD_SOURCE,      $(SRC_$(d)))          # Build objects
  $(call CXX_LINK,          $(TARGET_NAME_$(d)))  # Build output executable
  $(call APPEND_ALL_TARGET_VAR)                   # Add output executable to ALL_TARGETS
$(call END_ARCH_BUILD)


OUTPUT_ELF_NAME_$(d)    :=

$(call BEGIN_ARCH_BUILD, ARM_CM4)
  $(call IMPORT_DEPS,       libbar)               # Import build dependencies
  $(call ADD_CXX_INCLUDE,   $(INCLUDE_$(d)))      # Add local include path
  $(call BUILD_SOURCE,      $(SRC_$(d)))          # Build objects
  $(call BUILD_SOURCE,      $(SRC_ARM_$(d)))      # Build ARM only objects

  # ARM build requires an extra linker flag to build
  LF                        := -T ldscripts/application.ld
  $(call CXX_LINK,          $(TARGET_NAME_$(d)).elf)
  
  # The output elf file is not the final target, a custom step is needed for that
  $(call APPEND_TARGET_TO_VAR, OUTPUT_ELF_NAME_$(d))
$(call END_ARCH_BUILD)

# Custom step to build a hex file from the output elf file
ALL_TARGETS := $(ALL_TARGETS) $(OUTPUT_ELF_NAME_$(d):%.elf=%.hex)
$(OUTPUT_ELF_NAME_$(d):%.elf=%.hex): $(OUTPUT_ELF_NAME_$(d))
	$(call GET_ARCH_PREFIX, ARM_CM4)objcopy -O ihex $< $@
	$(call GET_ARCH_PREFIX, ARM_CM4)size $<


# ------------------------------------------------------------------- POP STACK
d                       := $(dirstack_$(sp))
sp                      := $(basename $(sp))
