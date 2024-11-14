# coding=utf-8
import shutil
import os
import sys
import argparse

SCRIPT_PATH = os.path.split(os.path.realpath(__file__))[0]
BUILD_DIR_PATH = SCRIPT_PATH + "/../build"


def clear():
    if os.path.exists(BUILD_DIR_PATH):
        shutil.rmtree(BUILD_DIR_PATH)


def get_project_path():
    project_path = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
    return project_path


def gene_proto_buf_source_file(out_dir):
    protoc_path = get_project_path() + "/script/bin/protoc"
    if sys.platform.startswith("win"):
        protoc_path = get_project_path() + "/script/bin/protoc.exe"

    build_cmd = "{0} -I={1}/logger/proto --cpp_out={2} {1}/logger/proto/*.proto".format(
        protoc_path, get_project_path(), out_dir
    )
    ret = os.system(build_cmd)
    if ret != 0:
        print("!!!generate pb source file fail")
        return False
    return True


def build_windows(platform="x64", config="Release", args=None):
    platform_dir = "%s/%s-%s" % (BUILD_DIR_PATH, platform, config)
    os.makedirs(platform_dir, exist_ok=True)
    gene_proto_buf_source_file(platform_dir)
    os.chdir(platform_dir)

    build_cmd = (
        'cmake ../.. -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=%s -DCMAKE_GENERATOR_PLATFORM=%s -DCMAKE_SYSTEM_NAME=Windows -T v143'
        % (config, platform)
    )

    if args.test:
        build_cmd += " -DBUILD_STL_TEST=ON"

    print("build cmd:" + build_cmd)
    ret = os.system(build_cmd)
    if ret != 0:
        print("!!!!!!!!!!!!!!!!!!build fail")
        return False

    build_cmd = "cmake --build . --config %s --parallel 8" % (config)
    ret = os.system(build_cmd)
    if ret != 0:
        print("build fail!!!!!!!!!!!!!!!!!!!!")
        return False
    return True


def main():
    # clear()
    os.makedirs(BUILD_DIR_PATH, exist_ok=True)
    parser = argparse.ArgumentParser(description="build windows")
    parser.add_argument(
        "--test", action="store_true", default=False, help="run unittest"
    )
    args = parser.parse_args()

    if not build_windows(platform="x64", config="Debug", args=args):
        exit(1)


if __name__ == "__main__":
    main()
