#!/usr/bin/env bats

setup() {
    path=$(pwd)
    DIR_PATH=$(dirname "$path")

    export SRC_BASE_DIR="${DIR_PATH}/src"
    export DEBUG="true"
    
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
   load './fixtures.bash'
}

setup_file() {
    # cd into the directory containing the bats file    
    cd "$BATS_TEST_DIRNAME" || exit 1
}

teardown_file() {
    echo "clean temp dir"
    rm -rf "${BATS_TEST_DIRNAME}/tmp"
}

@test "Should commit README.md" {

    # Test initialization
    create_remote_repo "${BATS_TEST_DIRNAME}/tmp/remote"
    cd "${BATS_TEST_DIRNAME}/tmp/remote"
    create_initial_commit
    COMMIT_SHA=$(get_latest_commit)

    # Test run
    mkdir -p "${BATS_TEST_DIRNAME}/tmp/local"
    GITHUB_WORKSPACE="${BATS_TEST_DIRNAME}/tmp/local"
    GITHUB_HEAD_REF='test-branch'
    INPUT_ACTION_DOCS_WORKING_DIR="${BATS_TEST_DIRNAME}/tmp/"
    cp "${SRC_BASE_DIR}/action.yml" "${BATS_TEST_DIRNAME}/tmp/"
    
    run "${SRC_BASE_DIR}"/docker-entrypoint.sh

        

    # create_remote_repo "${BATS_TEST_DIRNAME}/tmp/local"
    # cd "${BATS_TEST_DIRNAME}/tmp/local"
    # git remote add origin "${BATS_TEST_DIRNAME}/tmp/remote"
    # git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "$COMMIT_SHA":test-branch
    # git checkout test-branch
    # update_readme
    # git add README.md
    # git commit -sm 'update readme'

    # git push origin HEAD:main





}