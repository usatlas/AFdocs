cmake_minimum_required(VERSION 3.4 FATAL_ERROR)

project(Exam_JetsPlot)

find_package(ROOT)
find_package(AnalysisBase)

message(${ROOT_CXX_FLAGS})

set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )

add_executable(Exam_JetsPlot Exam_JetsPlot.cxx)

target_compile_definitions(Exam_JetsPlot
  PRIVATE ${ROOT_DEFINITIONS}
)

target_include_directories(Exam_JetsPlot
  PRIVATE ${ROOT_INCLUDE_DIRS}
)

target_link_libraries(Exam_JetsPlot
  PRIVATE ${ROOT_LIBRARIES}
  AnalysisBase::xAODEventInfo
  AnalysisBase::xAODRootAccess
  AnalysisBase::xAODJet
)
