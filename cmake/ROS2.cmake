# -------- Find thirdparty library -------- #

# ROS packages
set(ros_dependencies ament_cmake rclcpp rclcpp_components)

foreach(dependency ${ros_dependencies})
  find_package(${dependency} REQUIRED)
endforeach()

# Other packages
find_package(Eigen3 REQUIRED)

set(other_dependencies Eigen3::Eigen)

# ------------- Build library ------------- #
file(GLOB_RECURSE sources CONFIGURE_DEPENDS "src/*.cpp")
add_library(templatelib SHARED ${sources})
target_include_directories(templatelib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)
target_link_libraries(templatelib ${other_dependencies})
ament_target_dependencies(templatelib ${ros_dependencies})

# ------------ Build execuable ----------- #

# ---------------- Install --------------- #

install(DIRECTORY include/
  DESTINATION include
)

install(TARGETS templatelib
  EXPORT templatelibTargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

# Install  directories
install(DIRECTORY launch config
  DESTINATION share/${PROJECT_NAME}
)

# ----------------- Test ----------------- #
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
  add_subdirectory(test)
endif()

ament_package()