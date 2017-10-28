SET(CMAKE_SYSTEM_NAME Linux)

# Avoid linking test program, since it requires linker script
SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Specify the cross compiler
SET(CMAKE_C_COMPILER arm-none-eabi-gcc)
SET(CMAKE_CXX_COMPILER arm-none-eabi-g++)

# Specify the objcopy command
SET(CMAKE_OBJCOPY_CMD arm-none-eabi-objcopy)
