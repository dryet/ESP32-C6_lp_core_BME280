# Register the component
idf_component_register(SRCS "lp_i2c_main.c"
                       INCLUDE_DIRS "" "lp_core/lp_components/bme280/include"
                       REQUIRES ulp)

#
# ULP support additions to component CMakeLists.txt.
#
# 1. The LP Core app name must be unique (if multiple components use LP Core).
set(ulp_app_name lp_core_${COMPONENT_NAME})
#
# 2. Specify all C files.
#    Files should be placed into a separate directory (in this case, lp_core/),
#    which should not be added to COMPONENT_SRCS.
set(ulp_lp_core_sources "lp_core/main.c" "lp_core/lp_components/bme280/bme280.c")

#
# 3. List all the component source files which include automatically
#    generated LP Core export file, ${ulp_app_name}.h:
set(ulp_exp_dep_srcs "lp_i2c_main.c")

#
# 4. Call function to build ULP binary and embed in project using the argument
#    values above.
ulp_embed_binary(${ulp_app_name} "${ulp_lp_core_sources}" "${ulp_exp_dep_srcs}")
