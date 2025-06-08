#!/bin/bash
set -euo pipefail; IFS=$'\n\t'

# Change to the directory of the script
cd "${0%/*}"

# Function to display help message and exit
#
# Usage: show_help_then_exit [exit_code]
show_help_then_exit() {
  cat <<EOF
${0} - Napkin Utilities

Usage:
  ${0} [<command>] [<args>]
  ${0} [-h | --help]

  register <github-handle>      Fetch GitHub profile from handle and download
                                the profile to register it to users
  check                         Check whether the typst source file valid
  prepare-fonts                 Prepare fonts for Typst
  capture <filename.typ>        Capture the typst rendered using imagemagick
  -h, --help                    Display this help message
EOF
  exit "${1:-0}"
}

# Parse command line arguments
if (( $# < 1)); then
  show_help_then_exit 1
fi
case "${1}" in
  #
  # Register a user by fetching GitHub profile
  #
  register)
    #
    # Parse ARGV[2]
    #
    if (( $# != 2)); then
      echo "Usage: ${0} register <github-handle>"
      exit 1
    fi
    USERNAME="${2}"

    #
    # Check if dependencies are installed
    #
    if ! which -s curl jq perl; then
      echo "Error: Please install 'curl', 'jq', and 'perl'"
      exit 1
    fi

    #
    # Fetch profile
    #
    echo "Fetching GitHub profile of ${USERNAME} ..."
    PAYLOAD=$(curl "https://api.github.com/users/${USERNAME}")

    #
    # Download the avatar
    #
    curl -o "users/${USERNAME}.avatar" -D "users/${USERNAME}.avatar.headers" "$(jq -r '.avatar_url' <<< "${PAYLOAD}")"
    # Extract the MIME
    AVATAR_MIME=$(perl -ne 'print if s/content-type: image\/([a-z]*)\r$/\1/i' "users/${USERNAME}.avatar.headers")
    rm "users/${USERNAME}.avatar.headers"
    mv "users/${USERNAME}.avatar" "users/${USERNAME}.${AVATAR_MIME}"
    echo "Downloaded 'users/${USERNAME}.${AVATAR_MIME}'"

    #
    # Save JSON
    #
    <<< "{\"a\":${PAYLOAD},\"b\":\"${AVATAR_MIME}\"}" jq '
      {
        login: .a.login,
        name: .a.name,
        avatar: {
          path: "../users/\(.a.login).\(.b)",
          format: .b
        },
        social: {
          github: .a.html_url,
          twitter: (if .a.twitter_username == null then null else "https://twitter.com/\(.a.twitter_username)" end)
        }
      }
    ' > "users/${USERNAME}.json"
    echo "Downloaded 'users/${USERNAME}.json'"

    #
    # Update template/napkin-users.typ
    #
    ls users/*.json |
      perl -ne 'print if s/^users\/([a-z]+)\.json$/\1/' |
      sort |
      perl -e '
use strict;
use warnings;

print "#let users = (\n";
while (my $user = <STDIN>) {
  chomp $user;
  print <<"END";
  "$user": {
    let metadata = json("../users/$user.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },\
END
}
print ")\n";
    ' > template/napkin-users.typ

    echo -e "✅ \x1b[1;92mSuccessfully fetched '${USERNAME}'!\x1b[0m"
    exit 0;;


  #
  # Check whether the typst source file valid
  #
  check)
    # Check if dependencies are installed
    if ! which -s typst find xargs; then
      echo "Error: Please install 'typst', 'find', and 'xargs'"
      exit 1
    fi

    # Fetch dependencies (fletcher, cetz, etc.)
    typst compile --font-path fonts - - > /dev/null <<< '#import "@preview/fletcher:0.5.7"'
    # Parallel build
    find . -maxdepth 1 -name '*.typ' -print0 |
      xargs -0 -P0 -I{} bash -c 'echo "Checking {} ..." && typst compile -f pdf "{}" /dev/null' || {
        echo "Typst source file is invalid."
        exit 1
      }

    echo -e "✅ \x1b[1;92mAll typst source files are valid!\x1b[0m"
    exit 0;;


  #
  # Prepare fonts for Typst
  #
  prepare-fonts)
    # Check if dependencies are installed
    if ! which -s curl b2sum unzip; then
      echo "Error: Please install 'curl', 'b2sum', and 'unzip'"
      exit 1
    fi

    mkdir -p ./fonts
    # Download then verify zips
    if [[ ! -f ./fonts/latin-modern.zip ]]; then
      curl -Lo ./fonts/latin-modern.zip \
        'https://www.gust.org.pl/projects/e-foundry/latin-modern/download/lm2.004otf.zip'
    fi
    if [[ ! -f ./fonts/bareon-batang.zip ]]; then
      curl -Lo ./fonts/bareon-batang.zip \
        --referer 'https://copyright.keris.or.kr/wft/fntDwnldView' \
        -d 'fntGrpId=GFT202301120000000000002&fntFileId=FTF202312080000000000070' \
        'https://copyright.keris.or.kr/cmm/fntDwnldById'
    fi
    b2sum --quiet -c <<'EOF'
87472bdd53899c1dfec8f4b8491fabc7878b1f8c1e72424ae0edf79c7f22fd873f6c3e650d3201dfa4481185dffa5960202919a621fd056947540d215eb20bec fonts/bareon-batang.zip
448233fb23437a08997d8cb6d2600709223ce8dc2fbce949652b47071450a7a0a0915bcfa59bb88b5e52e5fdb6021c93c38891fa05f106fa299a61bd3cbefd5e fonts/latin-modern.zip
EOF
    # Unzip
    unzip -qo ./fonts/latin-modern.zip -d ./fonts
    unzip -qo ./fonts/bareon-batang.zip '*.otf' -d ./fonts

    echo -e "✅ \x1b[1;92mFonts are prepared!\x1b[0m"
    exit 0;;


  #
  # Capture the typst rendered using imagemagick
  #
  capture)
    # Parse ARGV[2]
    if (( $# != 2)); then
      echo "Usage: ${0} capture <filename.typ>"
      exit 1
    fi
    FILENAME="${2}"

    # Check if dependencies are installed
    if ! which -s typst; then
      echo "Error: Please install 'typst'"
      exit 1
    fi

    # Render into SVG
    SVG=$(
      cat - "${FILENAME}" <<< "#set page(margin: (left: 6em, right: 6em, top: 2em, bottom: 2em), height: auto)" |
        typst compile --font-path fonts -f svg - -
    )

    if command -v osascript >/dev/null; then
      # On macOS
      cat <<< "${SVG}" > ./.tmp.svg
      /usr/bin/sips -s format png -o .tmp.png .tmp.svg
      osascript \
        -e 'on run args' \
        -e 'set the clipboard to (read (POSIX file (first item of args)) as picture)' \
        -e 'end' \
        ./.tmp.png
      rm ./.tmp.svg ./.tmp.png
      exit 0
    else
      # On Linux
      if command -v wl-copy >/dev/null; then
        COPY=pbcopy
      elif command -v xcopy >/dev/null; then
        COPY=xcopy
      else
        echo "Error: Please install 'xcopy', or 'wl-copy' to copy the image to clipboard"
        exit 1
      fi
      <<< "${SVG}" | magick svg:- png:- | "${COPY}"
    fi
    exit 0;;


  #
  # Show help message and exit
  #
  -h|--help)
    show_help_then_exit;;


  #
  # Show help message and exit if the command is not recognized
  #
  *)
    show_help_then_exit 1;;
esac
