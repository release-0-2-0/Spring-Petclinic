#!/bin/bash
set -e
shopt -s nullglob

pushd $(dirname "$0") >/dev/null 2>&1
repo_root=`git rev-parse --show-toplevel`
output_dir="$repo_root/.veracode/output/manual"

publishProject() {
    pom_path="$1"

    if [ -d "$output_dir" ]; then
        echo Deleting $output_dir directory
        rm -rf $output_dir
    fi
    mkdir -p $output_dir

    pushd $pom_path >/dev/null 2>&1
        case "$OSTYPE" in
            darwin*)  ./gradlew clean build;
                      ./mvnw clean install;;
            linux*)   ./gradlew clean build;
                      ./mvnw clean install;;
            msys*)    gradlew clean build;
                      mvnw clean install;;
            cygwin*)  gradlew clean build;
                      mvnw clean install;;
        esac
        echo "<<<<<<<<<<<<<< Copying Gradle built artifact >>>>>>>>>>>>>"
        cp build/libs/*.{war,jar,ear} "$output_dir"
        echo "<<<<<<<<<<<<<< Copying Maven built artifact >>>>>>>>>>>>>"
        cp target/*.{war,jar,ear} "$output_dir"
    popd
}

publishProject "$repo_root"
