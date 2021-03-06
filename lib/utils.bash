#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/flosell/iam-policy-json-to-terraform/"
TOOL_NAME="iam-policy-json-to-terraform"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if iam-policy-json-to-terraform is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

getArch() {
  ARCH=$(uname -m)
  case $ARCH in
  armv*) ARCH="arm" ;;
  aarch64) ARCH="arm64" ;;
  x86) ARCH="386" ;;
  x86_64) ARCH="amd64" ;;
  i686) ARCH="386" ;;
  i386) ARCH="386" ;;
  esac
  echo "$ARCH"
}

echoerr() { printf "%s\n" "$*" >&2; }

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  os=$(uname | tr '[:upper:]' '[:lower:]')
  arch=$(getArch)

  if [ "$os" == "linux" ]; then
    url="$GH_REPO/releases/download/${version}/iam-policy-json-to-terraform_amd64"
  elif [ "$os" == "darwin" ]; then
    if [[ $arch == arm* ]]; then
      url="$GH_REPO/releases/download/${version}/iam-policy-json-to-terraform_darwin_arm"
    else
      url="$GH_REPO/releases/download/${version}/iam-policy-json-to-terraform_darwin"
    fi
  else
    echoerr "No executable available for ${os} and ${arch}."
    exit 1
  fi
  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    # local tool_cmd
    # tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    mkdir "$install_path/bin"
    mv "$install_path/$TOOL_NAME" "$install_path/bin/$TOOL_NAME"
    chmod u+x "$install_path/bin/$TOOL_NAME"
    test -x "$install_path/bin/$TOOL_NAME" || fail "Expected $install_path/bin/$TOOL_NAME to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
