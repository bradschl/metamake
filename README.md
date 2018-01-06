# metaMake
metaMake is a GNU Make makefile fragment that allows for building multiple architectures in parallel with human friendly dependency tracking between target objects.

High-level steps for writing a Makefile with metaMake rules:
1. Add in the "all" and "clean" targets. Optionally configure the verbosity of the build
2. Define the architectures
3. Build artifacts

## Build Philosophy

#### What does this project do:
- Provide a set of makefile meta rules for building multiple architectures simultaneously. (i.e. Bare-metal target, and host for unit tests)
- Provide a set of makefile meta rules for importing and exporting build dependency information between fragments within a build. This allows for many small reusable libraries to be handled in a sane manner during a build
- Build code for any architecture known in the build system (universal build)

#### What doesn't this project do:
- This does not replace autotools or cmake. Those build systems are designed for detecting the build environment and adapting the build system accordingly. This build system is for when the target environment is known (bare-metal). (Also, neither of those build systems build for multiple architectures at the same time without some hackery)
- This does not hide the details of using or writing a Makefile. This project only provides meta rules that hopefully make it easier to write and maintain a Makefile

#### Assumptions
- These makefile meta rules where designed with bare-metal targets in mind, where simultaneous architecture builds are desirable for building target code and unit test code at the same time
- These makefile meta rules where designed to build C, C++, and assembly.
- These makefile meta rules where designed for GCC compilers


## Using this Project
All of the meta rules for metaMake are stored in `Meta.mk`. This file can be copied into other projects and modified as needed. See the examples for how to use it.

Also, be careful mixing tabs and spaces inside the makefiles. Only recipes can use **tabs**, all other forms of indentation must use **spaces**.


## Recommended File Layout
For the majority of projects, everything can be put in a single `Makefile`.

If the project is large, or a build hierarchy is needed, then it is recommended to use a non-recursive make fragment system. In this setup, there is a top level `Makefile` that includes rule fragments. Each library or executable in the build system should be nested in a directory with a `Rules.mk` file. The `Rules.mk` file specifies the rules and recipes required to build that library or executable.

See the Example project for a look at how the top level `Makefile` and `Rules.mk` can be setup. The fragment system is inspired by [this non-recursive makefile solution](http://evbergen.home.xs4all.nl/nonrecursive-make.html).


## Meta-Rules Setup

#### The "all" and "clean" Targets
The meta rules append to two variables, ```ALL_TARGETS``` and ```CLEAN_TARGETS```. The ```ALL_TARGETS``` variable contains a list of real targets (physical files) that should be build by the ```all``` rule. The ```CLEAN_TARGETS``` variable contains a list of phony targets (target that are not files) that should be used as a prerequisite for a ```clean``` target. The following fragment is useful to have in the top level makefile.
```Makefile
# ---------------------------------------------------------------- DEFAULT GOAL
# Set the default goal, in case none is specified
.DEFAULT_GOAL           := all

# ------------------------------------------------------------------ META RULES
# This must be included before any meta rules are used
include Meta.mk


# ........ other stuff - Architecture definition, build rules, etc


# ---------------------------------------------------------------- GLOBAL RULES

.PHONY: all
all: $(ALL_TARGETS)
	@echo "===== All build finished ====="

.PHONY: clean
clean: $(CLEAN_TARGETS)
	@echo "===== Clean finished ====="

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Build all top level targets"
	@echo "  clean      - Clean intermediate build files"
```
Be careful with mixing spaces and tabs. Tabs must be used for a recipe, spaces must be used for indentation everywhere else in a makefile.

Also, note that the ```clean``` and ```all``` recipe lines are at the bottom of the file. That is because the variables ```ALL_TARGETS``` and ```CLEAN_TARGETS``` will be expanded immediately for the recipe line, and will therefore not contain anything if they come before the meta rules. A workaround to that is to use secondary expansion on the recipe lines, or better yet, just depend on the ```METAMAKE_ALL``` and ```METAMAKE_CLEAN``` phony targets.
```Makefile
# ---------------------------------------------------------------- GLOBAL RULES
# Since the `all` rule appears as the first recipe, it will be the default
# one to be ran
.PHONY: all
all: METAMAKE_ALL
	@echo "===== All build finished ====="

.PHONY: clean
clean: METAMAKE_CLEAN
	@echo "===== Clean finished ====="

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all        - Build all top level targets"
	@echo "  clean      - Clean intermediate build files"

# ------------------------------------------------------------------ META RULES
# This must be included before any meta rules are used
include Meta.mk


# ........ other stuff - Architecture definition, build rules, etc


```

#### Quiet and Verbose Output
Defining ```Q = @``` in the top level `Makefile` will set the output to quiet. Defining ``` Q = ``` will set the output to verbose.

The following fragment is useful to have in the top level makefile if you want the optionally turn verbose mode on or off.
```Makefile
ifeq ("$(origin V)", "command line")
  ENABLE_VERBOSE        = $(V)
endif
ifndef ENABLE_VERBOSE
  ENABLE_VERBOSE        = 0
endif

ifeq ($(ENABLE_VERBOSE),1)
  Q                     =
else
  Q                     = @
endif
```
Calling `make V=0` or `make V=1` with the above fragment will enable or disable verbose output.


## Architecture Setup
This meta rules defines the compiler prefix and flags that must be used when building for a specified architecture. This section must appear before any meta recipe for the architecture!
The first parameter of the ```BEGIN_DEFINE_ARCH``` is the architecture name; in this example it is ```MY_ARCH```. The second parameter is the build output directory, where all objects, libraries, and binaries are created; in this example it is ```build/my_arch```.
```Makefile
$(call BEGIN_DEFINE_ARCH,  MY_ARCH,  build/my_arch)
  PREFIX        :=  # Compiler prefix
  ASF           :=  # Assembler flags
  CF            :=  # C Flags
  CXXF          :=  # C++ Flags
  LF            :=  # Linker flags
  LL            :=  # Linker last flags
$(call END_DEFINE_ARCH)
```
- The ASF, CF, CXXF, LF, and LL flags are global flags applied to all meta recipes for the given architecture. These may be appended later with ```BEGIN_APPEND_ARCH_FLAGS``` and ```END_APPEND_ARCH_FLAGS```

Below is an example for defining a host (X86) build and ARM build architecture:
```Makefile
$(call BEGIN_DEFINE_ARCH,  ARM_CM4,   build/arm_cm4)
  PREFIX        := arm-none-eabi-
  ASF           := -mcpu=cortex-m4 -mthumb -DCORE_M4
  CF            := -Os -g3 -Wall -mcpu=cortex-m4 -mthumb -DCORE_M4 \
                   -std=c99
  CXXF          := -Os -g3 -Wall -mcpu=cortex-m4 -mthumb -DCORE_M4 \
                   -std=c++14 -fno-exceptions -fno-rtti
$(call END_DEFINE_ARCH)

$(call BEGIN_DEFINE_ARCH,  HOST,      build/host)
  CF            := -O0 -g3 -Wall -std=c99
  CXXF          := -O0 -g3 -Wall -std=c++14
$(call END_DEFINE_ARCH)
```

#### Appending Architecture Flags
Using this section will append flags for all recipes in the given architecture. This section may appear at any time during the build, since architecture flags are not applied until the build steps are executed.
```Makefile
$(call BEGIN_APPEND_ARCH_FLAGS,  MY_ARCH)
  ASF           :=  # Assembler flags
  CF            :=  # C Flags
  CXXF          :=  # C++ Flags
  LF            :=  # Linker flags
  LL            :=  # Linker last flags
$(call END_APPEND_ARCH_FLAGS)
```


## Building Artifacts
A build for a specific architecture can be created using the ```BEGIN_ARCH_BUILD``` and ```END_ARCH_BUILD``` calls. The ```BEGIN_ARCH_BUILD``` call takes one parameter, the architecture that is being built for.
```Makefile
$(call BEGIN_ARCH_BUILD, ARM_CM4)

  # ... Meta build constructs

$(call END_ARCH_BUILD)
```
The architecture must be defined before using this construct.

A universal build will build for all available architectures. This is intended for building libraries that are platform independent. Also, the universal build can be used for building executables with a few caveats. See the [Usage Tips](#usage-tips) section for information on that.
All the same constructs that can be used in the architecture specific build can be used in the universal build.
```Makefile
$(call BEGIN_UNIVERSAL_BUILD)

  # ... Meta build constructs

$(call END_UNIVERSAL_BUILD)
```
All architectures must be defined before using this construct

#### Adding Includes
Include paths can be added inside of the meta build constructs with ```ADD_AS_INCLUDE```, ```ADD_C_INCLUDE```, and ```ADD_CXX_INCLUDE```
- ```ADD_AS_INCLUDE``` will append a list of include paths onto the assembler build flags
- ```ADD_C_INCLUDE``` will append a list of include paths onto the C build flags
- ```ADD_CXX_INCLUDE``` will append a list of include paths onto the C++ build flags

All of the above constructs take a list of paths as their only argument. The include paths added with these constructs are exportable, see the [Exporting Build Dependencies](#exporting-build-dependencies) and [Importing Build Dependencies](#importing-build-dependencies) sections for more info on that.

Currently, C include paths are treated as a subset of C++ include paths. If a path is added using the ```ADD_C_INCLUDE```, it will be visible to C++ code as well. However, include paths added with ```ADD_CXX_INCLUDE``` will not be visible to C code, for obvious reasons.

```Makefile
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_C_INCLUDE, include/path other/include/path)
  $(call ADD_CXX_INCLUDE, include/cxx/path)
  # ... #
$(call END_UNIVERSAL_BUILD)
```

#### Building Source
Source files can be built with a single call to ```BUILD_SOURCE```. This construct will take a list of source files as its only parameter. Currently, the following types of files are compatible:
- .c for C source
- .cpp or .cc for C++ source
- .S for Assembly files

```Makefile
MY_SOURCE_PATH      := my/src/path
MY_SOURCE_FILES     := $(find $(MY_SOURCE_PATH) -name "*.c") \
                       $(find $(MY_SOURCE_PATH) -name "*.S")

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_C_INCLUDE, my/include/path)
  $(call BUILD_SOURCE, $(MY_SOURCE_FILES))
  # ... #
$(call END_UNIVERSAL_BUILD)
```

#### Build Flags
There are several constructs for adding build flags the the meta build constructs.
- ```ADD_ASF_FLAG``` will append to the assembler build flags
- ```ADD_CF_FLAG``` will append to the C build flags
- ```ADD_CXXF_FLAG``` will append to the C++ build flags
- ```ADD_LF_FLAG``` will append the first linker flags
- ```ADD_LL_FLAG``` will append the last linker flags

All of the above constructs take a list of flags as their first parameter. The LL and LF flags are only used for linking steps. The CF and CXXF flags are used both for linking and source build steps.

Flags added with the above constructs are _exportable_ flags. Hidden flags are supported as well by defining the following variables within the build construct.
- ASF for hidden assembler build flags
- CF for hidden C build flags
- CXXF for hidden C++ build flags
- LF for hidden first linker flags
- LL for hidden last linker flags

The above variables must be defined as a [simply expanded variable](https://www.gnu.org/software/make/manual/html_node/Flavors.html), i.e. use the ```:=``` notation instead of the ```=``` notation.

```Makefile
$(call BEGIN_ARCH_BUILD, ARM_CM0)
  $(call ADD_C_INCLUDE,     my/include/path)
  $(call ADD_CF_FLAG,       -DARM_CM0)
  $(call BUILD_SOURCE,      $(MY_SOURCE_FILES))

  # Hidden flags for changing the linking behavior
  CF := -Ildscripts
  LF := -nostdlib -T myexec.ld
  LL := -lgcc
  $(call CXX_LINK,          myexec.elf)
$(call END_ARCH_BUILD)
```

#### Building a Static Library
Static libraries are created with the ```MAKE_LIBRARY``` call. This call takes a single parameter for the library base-name to build. Internally, every ```BUILD_SOURCE``` call appends a list of generated objects for the build construct. When then ```MAKE_LIBRARY``` call is made, it will create a static library out of all those objects.
```Makefile
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE, include)
  $(call BUILD_SOURCE, foo.cpp bar.cpp)
  $(call BUILD_SOURCE, newFeature.cpp)
  $(call MAKE_LIBRARY, myCode)
  $(call EXPORT_SHALLOW_DEPS, myCode)
$(call END_UNIVERSAL_BUILD)
```
The above example will take all of take the object files generated in both of ```BUILD_SOURCE``` calls, and create a static library name `libmyCode.a`. Note that the ```MAKE_LIBRARY``` call used the libraries *base-name*, not its full name. That is due to the way that linking rules need to be generated.

Note that if a ```BUILD_SOURCE``` call is made after the ```MAKE_LIBRARY``` call, the objects generated in that step will not make it into the proceeding library call.

Making a static library and using the ```EXPORT_SHALLOW_DEPS``` call is the key to the automatic dependency system. See [Importing and Exporting Build Dependencies](#importing-and-exporting-build-dependencies) section for details on how this works.

#### Building an Executable (Linking)
Linking an executable is done with the ```CXX_LINK``` and ```CC_LINK``` calls.
- If an executable is only being built with objects generated from C code, then the ```CC_LINK``` call can be used
- If an executable is being built from C++ generated objects, or contains a mix of C and C++ objects, the the ```CXX_LINK``` call should be used

Both calls take the output executable name as their first parameter.
```Makefile
MY_SRC := foo.cpp bar.cpp main.cpp

$(call BEGIN_ARCH_BUILD, ARM_CM4)
  $(call ADD_CXX_INCLUDE,     $(d)/include)
  $(call BUILD_SOURCE,        $(MY_SRC))
  $(call CXX_LINK,            myprogram.elf)
  $(call APPEND_ALL_TARGET_VAR)
$(call END_ARCH_BUILD)
```

The ```APPEND_ALL_TARGET_VAR``` call will add the output executable to the ```ALL_TARGETS``` variable, causing it to be a high-level build target. See [Adding Artifacts to the All Target List](#adding-artifacts-to-the-all-target-list).

#### Importing and Exporting Build Construct Dependencies
This was the initial raison d'etre for the metaMake project. These constructs allow for small pieces of code to be built into small libraries and pulled into other build constructs with minimal effort.
```Makefile
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,       libfoo/include)
  $(call BUILD_SOURCE,          foo_1.cpp foo_2.cpp)
  $(call MAKE_LIBRARY,          foo)
  $(call EXPORT_SHALLOW_DEPS,   libfoo)
$(call END_UNIVERSAL_BUILD)

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,       libbar/include)
  $(call BUILD_SOURCE,          bar_1.cpp bar_2.cpp)
  $(call MAKE_LIBRARY,          bar)
  $(call EXPORT_SHALLOW_DEPS,   libbar)
$(call END_UNIVERSAL_BUILD)

$(call BEGIN_ARCH_BUILD,        ARM_CM4)
  $(call IMPORT_DEPS,           libbar libfoo)
  $(call ADD_CXX_INCLUDE,       application/include)
  $(call BUILD_SOURCE,          main.cpp)
  $(call CXX_LINK,              application.elf)
  $(call APPEND_ALL_TARGET_VAR)
$(call END_ARCH_BUILD)
```
In the above example, there are two libraries that are being built; ```libfoo.a``` and ```libbar.a```. There is an executable named ```application.elf``` being built for the ARM_CM4 architecture that depends on ```libfoo.a``` and ```libbar.a```. With the ```IMPORT_DEPS``` call, the application build construct gains the appropriate include paths and linking steps required to build against the libraries.

- The ```EXPORT_SHALLOW_DEPS``` call take a human friendly dependency name as its first parameter. This exports *only the dependencies for the immediate build construct*. This will not export a recursive list of dependencies, see the [Shallow Dependency Limitations](#shallow-dependency-limitations) section for details.
- This ```IMPORT_DEPS``` call takes a list of human friendly dependency names as its first parameter. It is not required that a dependency is exported before it is imported, only that it is present after all build constructs are parsed.

#### Adding Artifacts to the All Target List
The ```ALL_TARGETS``` variable can be appended with the output of the last build construct rule by using the ```APPEND_ALL_TARGET_VAR``` call. This call does not take any parameters.

- If this call is made after a ```CC_LINK``` or ```CXX_LINK``` call, it will append the output executable name to the ```ALL_TARGETS``` variable.
- If this call is made after a ```MAKE_LIBRARY``` call, then that output library will be appended to the ```ALL_TARGETS``` variable
- If this call is made after a ```BUILD_SOURCE``` call, then all the objects generated by that call will be appended to the ```ALL_TARGETS``` variable.

It is normally a good idea to only have "top-level" targets added to the ```ALL_TARGETS``` variable, and let `make` figure out the required objects to build from there. 

#### Adding Artifacts to the Clean Target List
The ```CLEAN_TARGETS``` variable contains a list of phony targets that should be called to clean all build artifacts. A clean rule is automatically generated per architecture that is defined, and appended to the ```CLEAN_TARGETS``` variable. 

#### Custom Steps for Targets
These calls are normally not needed in a build system, but are available for tweaking build construct behavior.

The ```APPEND_TARGET_TO_VAR``` call has the same behavior as the ```APPEND_ALL_TARGET_VAR```, but takes a variable name as its first parameter. This variable is appended with the name of the output target in the previous build construct command. 
```Makefile
OUTPUT_ELF_NAME         := 

$(call BEGIN_ARCH_BUILD,        ARM_CM4)
  $(call ADD_CXX_INCLUDE,       application/include)
  $(call BUILD_SOURCE,          main.cpp foo.cpp bar.cpp)
  $(call CXX_LINK,              application.elf)
  $(call APPEND_TARGET_TO_VAR,  OUTPUT_ELF_NAME)
$(call END_ARCH_BUILD)

$(OUTPUT_ELF_NAME:%.elf=%.hex): $(OUTPUT_ELF_NAME)
	$(call GET_ARCH_PREFIX, ARM_CM4)objcopy -O ihex $< $@
```
This example gets the complete filename of the linking step output, and uses it to generate a hex file using the objcopy tool.

Custom build dependencies can be added with the ```ADD_CUSTOM_BUILD_DEP``` call. The first parameter of this call takes a list of real or phony target names (not to be confused with the human friendly dependency names used in the other build constructs). Build dependencies will block any ```BUILD_SOURCE``` calls from running until the build dependency has been satisfied. A build dependency is special in that it is the ONLY dependency information that is exported recursively. Most of the time this is used to block the building of source until headers are moved into pace. Use this with caution.

Similar to the ```ADD_CUSTOM_BUILD_DEP``` call, ```ADD_CUSTOM_LINK_DEP``` will add custom dependencies to ```CC_LINK``` and ```CXX_LINK``` output targets. Use this with caution, but it allows object files to be custom inserted into the linking steps.


## Other Tools

#### Finding Source Files
The ```FIND_SOURCE_IN_DIR``` call can be used to recursively find source in a directory. This call takes a directory as its first parameter. It will search for the following types of files:
- .c for C source
- .cpp and .cc for C++ source
- .s or .S for Assembly source

It is recommended to use a simply expanded variable for this call, else it will cause additional overhead (use ```:=``` instead of ```=```)
```Makefile
MY_SOURCE := $(call FIND_SOURCE_IN_DIR, my/source)
```

#### Getting the Architecture Prefix
It can sometimes be useful to get at the compiler prefix used by the meta build constructs when writing custom recipes. The ```GET_ARCH_PREFIX``` call takes an architecture as its first parameter, and returns the compiler prefix.
```Makefile
application.hex: application.elf
	$(call GET_ARCH_PREFIX, ARM_CM4)objcopy -O ihex $< $@
```


## Usage Tips

#### Mixing Universal Builds with Architecture Specific Builds
Universal builds may be mixed with architecture specific builds, with a few caveats. Under the hood, the meta make fragment tracks universal builds using the exported dependency names. When the end of the universal build step is reached, the build rule is expanded for all known architectures. To mix universal builds and architecture specific builds, it is recommended that the architecture specific build be defined first.
```Makefile
MY_SRC = src/foo.cpp src/bar.cpp

$(call BEGIN_ARCH_BUILD, ARM_CM4)
  $(call ADD_CXX_INCLUDE,     $(d)/include)
  $(call ADD_CXXF_FLAG,       -DSPECIAL_ARM_CM4_BUILD_FLAG)
  $(call BUILD_SOURCE,        $(MY_SRC))
  $(call MAKE_LIBRARY,        myLib)
  $(call EXPORT_SHALLOW_DEPS, myLib)
$(call END_ARCH_BUILD)

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,     $(d)/include)
  $(call BUILD_SOURCE,        $(MY_SRC))
  $(call MAKE_LIBRARY,        myLib)
  $(call EXPORT_SHALLOW_DEPS, myLib)
$(call END_UNIVERSAL_BUILD)
```

This can be useful as well for unit testing code which expects to build against platform specific code. In most cases, it is fine to expose just the headers to the code under test to get it to compile.
```Makefile
$(call BEGIN_ARCH_BUILD, ARM_CM4)
  $(call ADD_C_INCLUDE,       $(d)/include)
  $(call BUILD_SOURCE,        $(STM32F4_DRIVERS_SRC))
  $(call MAKE_LIBRARY,        stm32f4_drivers)
  $(call EXPORT_SHALLOW_DEPS, stm32f4_drivers)
$(call END_ARCH_BUILD)

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_C_INCLUDE,       $(d)/include)
  $(call EXPORT_SHALLOW_DEPS, stm32f4_drivers)
$(call END_UNIVERSAL_BUILD)
```
The above fragment only builds for `ARM_CM4`, and only exposes its headers for any other architecture builds.


#### Building for All Architectures
Under the hood, the universal build system is generating a build step string. Once the universal build step is ended, the build string is evaluated for all known architectures. By appending the output targets to the ALL_TARGETS variable every time the build rule is evaluated for an architecture, a target can be build for all architectures defined in the build system.
```Makefile
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_C_INCLUDE,         $(d)/include)
  $(call BUILD_SOURCE,          $(SOURCE_$(d)))
  $(call CC_LINK,               myExecutable.elf)
  $(call APPEND_ALL_TARGET_VAR)

  # See the list of bugs, all universal build rules MUST export a dependency
  $(call EXPORT_SHALLOW_DEPS,   myExecutable.elf)
$(call END_UNIVERSAL_BUILD)
```


#### Release and Debug Builds
Release and debug builds can be generated by defining multiple architectures.
```Makefile
$(call BEGIN_DEFINE_ARCH, HOST_RELEASE, build/host/release)
  PREFIX        :=
  CF            := -O3
$(call END_DEFINE_ARCH)

$(call BEGIN_DEFINE_ARCH, HOST_DEBUG, build/host/debug)
  PREFIX        :=
  CF            := -O0 -g3
$(call END_DEFINE_ARCH)
```


#### Building a Library and an Executable
Sometimes it is useful to build a code fragment as both a library and an executable. In this example the library only source is built first, then a library created. After the library is created, the executable only source is built and an executable is linked (containing both the library objects and executable objects).
```Makefile
INCLUDE_DIR        := include
LIB_SOURCE         := src/foo.cpp src/bar.cpp
EXEC_SOURCE        := src/main.cpp
LIB_NAME           := mylib
EXEC_NAME          := myexec.elf

$(call BEGIN_ARCH_BUILD, ARM_CM4)
  $(call ADD_CXX_INCLUDE,     $(INCLUDE_DIR))
  $(call BUILD_SOURCE,        $(LIB_SOURCE))
  $(call MAKE_LIBRARY,        $(LIB_NAME))
  $(call EXPORT_SHALLOW_DEPS, $(LIB_NAME))

  LF               := -T ldscripts/myexec.ld
  $(call BUILD_SOURCE,        $(EXEC_SOURCE))
  $(call CXX_LINK,            $(EXEC_NAME))
$(call END_ARCH_BUILD)
```

#### Linking an Externally Linked Library
There is no built-in meta rule to do this, but thats what you get for wanting to use some other build system. However, it is not difficult to do.
```Makefile
EXTERNAL_LIB_FOLDER       := plebeian_code/extlib
EXTERNAL_LIB_HEADERS      := $(EXTERNAL_LIB_FOLDER)/include
EXTERNAL_LIB_FILE         := $(EXTERNAL_LIB_FOLDER)/build/libextlib.a

$(EXTERNAL_LIB_FILE):
	cd $(EXTERNAL_LIB_FOLDER) && $(MAKE)

$(call BEGIN_ARCH_BUILD, HOST)
  $(call ADD_CXX_INCLUDE,     $(EXTERNAL_LIB_HEADERS))
  $(call ADD_CUSTOM_LINK_DEP, $(EXTERNAL_LIB_FILE))
  $(call ADD_LF_FLAG,         -L$(strip $(dir $(EXTERNAL_LIB_FILE))))
  $(call ADD_LL_FLAG,         -l$(strip $(EXTERNAL_LIB_FILE)))
  $(call EXPORT_SHALLOW_DEPS,  extlib)
$(call END_ARCH_BUILD)
```
The ```ADD_CUSTOM_LINK_DEP``` will cause recipes that import ````extlib``` to depend on the external library build recipe completing before trying to link against it. The rest is manually adding in the linker flags.

## Internals
- [ ] TODO: Write docs for internal variables
- [ ] TODO: Write docs for internal rules
- [ ] TODO: Write docs for describing how the build constructs work

#### Version Information
Version information for this project can be found in the variables ```METAMAKE_MAJOR_VERSION``` and ```METAMAKE_MINOR_VERSION```. The major version will increment every time backwards compatibility in the metaMake API is broken. The minor number should increment between behavior changes within the API.

## Work in Progress
Things that are still in development
- [ ] Examples
- [ ] Documentation
- [ ] Cleanup the variable names in the meta-rules
- [ ] Add debug information to the meta rules
- [ ] Parameter sanity checks on all call and eval meta rules
- [ ] Add settings to disable pretty messages in the meta rules


## Bugs and Limitations

#### Universal Build Rule Limitation
Currently, the universal build rules must **NOT** be used for anything that does not export dependencies, else the build rule will not get expanded. This is currently a limitation that allows for universal builds to be mixed with architecture specific builds. This behavior may change in the future.

#### Shallow Dependency Limitations
Currently, there is only shallow dependency exporting, which is mostly due to recursive dependency resolution being a very complex problem to solve using Makefile meta rules.
```Makefile
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,       mylib_1/include)
  $(call BUILD_SOURCE,          $(MY_LIB_1_SRC))
  $(call MAKE_LIBRARY,          mylib_1)
  $(call EXPORT_SHALLOW_DEPS,   mylib_1)
$(call END_UNIVERSAL_BUILD)

$(call BEGIN_UNIVERSAL_BUILD)
  $(call IMPORT_DEPS,           mylib_1)
  $(call ADD_CXX_INCLUDE,       mylib_2/include)
  $(call BUILD_SOURCE,          $(MY_LIB_2_SRC))
  $(call MAKE_LIBRARY,          mylib_2)
  $(call EXPORT_SHALLOW_DEPS,   mylib_2)
$(call END_UNIVERSAL_BUILD)

$(call BEGIN_ARCH_BUILD,        HOST)
  $(call IMPORT_DEPS,           mylib_2)
  $(call ADD_CXX_INCLUDE,       application/include)
  $(call BUILD_SOURCE,          main.cpp)
  $(call CXX_LINK,              application)
$(call END_ARCH_BUILD)
```
In the above example, `application` will fail to build, since application is only importing dependencies for `mylib_2`, when it really depends on `mylib_2` and then on `mylib_1`.

The correct work around to the above problem is for application to have the following import line instead:
```Makefile
  # ... #
  $(call IMPORT_DEPS, 			mylib_2 mylib_1)
  # ... #
```
Note that since `mylib_2` and `mylib_1` are both static libraries, *their linking order actually matters*. If you are not familiar with this problem, there are many great resources on the net that describe linking order issues involved with static libraries.

This gets even more difficult to solve if two libraries end up depending on each other (directly or indirectly). My recommendation is to design your build constructs in layers, where each layer can only depend on constructs in layers below it, not on constructs in the same layer or above. Better yet, try to keep libraries self contained, then this problem goes away completely.

If you do run into a problem with circular dependencies, and reorganizing the libraries is not an option, then a quick-fix solution would be to just import the dependencies multiple times until the issue goes away.
```Makefile
  # Last resort fix, don't do this!!!
  # ... #
  $(call IMPORT_DEPS, 			mylib_2 mylib_1 mylib_2 mylib_1)
  # ... #
```

#### Exporting Dependencies Multiple Times
Currently, it is not recommended to export dependencies more than once from a build rule. It will work, but probably not the way you want. For example:
```Makefile
MINIMAL_SRC     := foo.cpp bar.cpp
FEATURE_Y_SRC   := newFeature.cpp

$(call BEGIN_UNIVERSAL_BUILD)
  # Build minimal library features
  $(call ADD_CXX_INCLUDE,     include/minimal)
  $(call BUILD_SOURCE,        $(MINIMAL_SRC))
  $(call MAKE_LIBRARY,        mylib_minimal)
  $(call EXPORT_SHALLOW_DEPS, mylib_minimal)

  # Build in extra features, inheriting all objects generated in
  # the previous build step
  # Don't do this!
  $(call ADD_CXX_INCLUDE,     include/newFeature)
  $(call BUILD_SOURCE,        $(FEATURE_Y_SRC))
  $(call MAKE_LIBRARY,        mylib_full)
  $(call EXPORT_SHALLOW_DEPS, mylib_full)
$(call END_UNIVERSAL_BUILD)
```
The `mylib_full` will contain the same objects as `mylib_minimal`, plus the new feature objects. However, this will create a very inefficient linking step, where anyone importing `mylib_full` as a dependency will also get the linking step for `mylib_minimal`. This behavior is not sane, and will probably change in the future.

#### Building Source Multiple Times for the Same Architecture
There is currently nothing in place to stop a build rule being generated multiple times for the same object file. If you do this, you're going to have a bad time.
```Makefile
MY_SRC := foo.cpp bar.cpp

$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,     include)
  $(call BUILD_SOURCE,        $(MY_SRC))
  $(call MAKE_LIBRARY,        mylib_1)
$(call END_UNIVERSAL_BUILD)

# Don't do this!
$(call BEGIN_UNIVERSAL_BUILD)
  $(call ADD_CXX_INCLUDE,     include)
  $(call ADD_CXXF_FLAG,       -DENABLE_COOL_FEATURE)
  $(call BUILD_SOURCE,        $(MY_SRC))
  $(call MAKE_LIBRARY,        mylib_2)
$(call END_UNIVERSAL_BUILD)
```

## License
MIT license for all files.

