# This script takes care of building your crate and packaging it for release

set -ex

package() {
    local TARGET=$1 \
        src=$(pwd) \
        stage=

    case $TRAVIS_OS_NAME in
        linux)
            stage=$(mktemp -d)
            ;;
        osx)
            stage=$(mktemp -d -t tmp)
            ;;
    esac

    test -f Cargo.lock || cargo generate-lockfile

    cross build --target $TARGET --release

    cp target/$TARGET/release/$CRATE_NAME $stage/

    cd $stage
    tar czf $src/$CRATE_NAME-$TRAVIS_TAG-$TARGET.tar.gz *
    cd $src

    rm -rf $stage
}

release_tag() {
    case $TRAVIS_OS_NAME in
        linux)
            cross build --target $TARGET --release
            cp --force target/$TARGET/release/$CRATE_NAME bin/
            ;;
        osx)
            make release
            ;;
    esac

    git add --force bin/$CRATE_NAME
    git commit --message "Add binary for $TRAVIS_TAG-$TARGET."
    tagname="binary-$TRAVIS_TAG-$TARGET"
    git tag --force "$tagname"
    git push --force https://${GITHUB_TOKEN}@github.com/autozimu/LanguageClient-neovim.git "$tagname"
}

TARGETS=(${TARGETS//:/ })
for TARGET in "${TARGETS[@]}"; do
    release_tag $TARGET
    package $TARGET
done
