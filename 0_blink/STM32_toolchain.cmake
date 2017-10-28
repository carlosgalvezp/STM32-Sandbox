INCLUDE(CMakeForceCompiler)

SET(CMAKE_SYSTEM_NAME Linux)

# Specify the cross compiler
CMAKE_FORCE_C_COMPILER(arm-none-eabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-none-eabi-g++ GNU)

# Specify the objcopy command
SET(CMAKE_OBJCOPY_CMD arm-none-eabi-objcopy)
