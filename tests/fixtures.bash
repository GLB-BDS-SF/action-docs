#!/bin/bash

create_remote_repo(){
    name=$1

    git init $name
}

create_initial_commit(){
    init_readme
    git add README.md
    git commit -sm 'initial commit'
}

get_latest_commit(){
    echo "$(git rev-parse --verify HEAD)"
}

init_readme(){
cat <<EOF > README.md
<!--- BEGIN_ACTION_DOCS --->
<!--- END_ACTION_DOCS --->
EOF
}

update_readme(){
    echo 'fin' >> README.md
}

mkdir -p test
cd test

create_remote_repo remote
REMOTE_PATH="${BATS_TEST_DIRNAME}/tmp/remote"

COMMIT=$(get_latest_commit $REMOTE_PATH)
echo "$COMMIT"

mkdir -p "${BATS_TEST_DIRNAME}/tmp/local" && cd "${BATS_TEST_DIRNAME}/tmp/local"
git init
git remote add origin "$REMOTE_PATH"
git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "$COMMIT":mabranche

git branch -la
git checkout mabranche
echo 'fin' >> README.md
git add README.md
git commit -sm 'update readme'

git push origin HEAD:main
git log --first-parent
##############################

# git checkout -b "test"
# git fetch --unshallow

rm -rf "${BATS_TEST_DIRNAME}/tmp"
