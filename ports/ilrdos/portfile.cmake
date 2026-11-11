# Biblioteca header-only: só precisa do build release.
set(VCPKG_BUILD_TYPE release)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO V0rtexLinux/ILrDOS
    REF "v${VERSION}"
    SHA512 4ef141b960426652f291aac30c0556d4a587b94af65ceb9f93944634e24323ebe6bec93d7f318249872453dbd779e05c4bbac5d3712e9cc391f57c752b865621
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DILRDOS_BUILD_DAEMON=OFF
        -DILRDOS_WITH_OPENCV=OFF
        -DILRDOS_WITH_ALSA=OFF
        -DILRDOS_WITH_VOSK=OFF
        -DILRDOS_INSTALL=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/ilrdos)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/doc" "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
