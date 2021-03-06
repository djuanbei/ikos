###############################################################################
#
# Find LLVM headers and libraries.
#
# Author: Maxime Arthaud
#
# Contact: ikos@lists.nasa.gov
#
# Notices:
#
# Copyright (c) 2018 United States Government as represented by the
# Administrator of the National Aeronautics and Space Administration.
# All Rights Reserved.
#
# Disclaimers:
#
# No Warranty: THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF
# ANY KIND, EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED
# TO, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL CONFORM TO SPECIFICATIONS,
# ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
# OR FREEDOM FROM INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE
# ERROR FREE, OR ANY WARRANTY THAT DOCUMENTATION, IF PROVIDED, WILL CONFORM TO
# THE SUBJECT SOFTWARE. THIS AGREEMENT DOES NOT, IN ANY MANNER, CONSTITUTE AN
# ENDORSEMENT BY GOVERNMENT AGENCY OR ANY PRIOR RECIPIENT OF ANY RESULTS,
# RESULTING DESIGNS, HARDWARE, SOFTWARE PRODUCTS OR ANY OTHER APPLICATIONS
# RESULTING FROM USE OF THE SUBJECT SOFTWARE.  FURTHER, GOVERNMENT AGENCY
# DISCLAIMS ALL WARRANTIES AND LIABILITIES REGARDING THIRD-PARTY SOFTWARE,
# IF PRESENT IN THE ORIGINAL SOFTWARE, AND DISTRIBUTES IT "AS IS."
#
# Waiver and Indemnity:  RECIPIENT AGREES TO WAIVE ANY AND ALL CLAIMS AGAINST
# THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL
# AS ANY PRIOR RECIPIENT.  IF RECIPIENT'S USE OF THE SUBJECT SOFTWARE RESULTS
# IN ANY LIABILITIES, DEMANDS, DAMAGES, EXPENSES OR LOSSES ARISING FROM SUCH
# USE, INCLUDING ANY DAMAGES FROM PRODUCTS BASED ON, OR RESULTING FROM,
# RECIPIENT'S USE OF THE SUBJECT SOFTWARE, RECIPIENT SHALL INDEMNIFY AND HOLD
# HARMLESS THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS,
# AS WELL AS ANY PRIOR RECIPIENT, TO THE EXTENT PERMITTED BY LAW.
# RECIPIENT'S SOLE REMEDY FOR ANY SUCH MATTER SHALL BE THE IMMEDIATE,
# UNILATERAL TERMINATION OF THIS AGREEMENT.
#
###############################################################################

if (NOT LLVM_FOUND)
  find_program(LLVM_CONFIG_EXECUTABLE CACHE NAMES llvm-config DOC "Path to llvm-config binary")

  if (LLVM_CONFIG_EXECUTABLE)
    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --version
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_VERSION
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --prefix
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_ROOT
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --includedir
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --bindir
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_TOOLS_BINARY_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --libdir
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_LIBRARY_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --cppflags
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_CPPFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --cxxflags
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_CXXFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --ldflags
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_LDFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --obj-root
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_OBJ_ROOT
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --libs core bitreader asmparser analysis
      RESULT_VARIABLE HAD_ERROR
      OUTPUT_VARIABLE LLVM_MODULE_LIBS
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (HAD_ERROR)
      message(FATAL_ERROR "llvm-config failed with status: ${HAD_ERROR}")
    endif()

    execute_process(
      COMMAND ${LLVM_CONFIG_EXECUTABLE} --cmakedir
      OUTPUT_VARIABLE LLVM_CMAKE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif()

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(LLVM
    REQUIRED_VARS
      LLVM_ROOT
      LLVM_INCLUDE_DIR
      LLVM_TOOLS_BINARY_DIR
      LLVM_LIBRARY_DIR
      LLVM_CPPFLAGS
      LLVM_CXXFLAGS
      LLVM_LDFLAGS
      LLVM_OBJ_ROOT
      LLVM_MODULE_LIBS
      LLVM_VERSION
    VERSION_VAR
      LLVM_VERSION
    FAIL_MESSAGE
      "Could NOT find LLVM. Please provide -DLLVM_CONFIG_EXECUTABLE=/path/to/llvm-config")
endif()
