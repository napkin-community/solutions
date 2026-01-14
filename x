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
    if ! which -s sha256sum; then
      echo "Error: Please install 'sha256sum'"
      exit 1
    fi
    if sha256sum --quiet -c - 2>/dev/null <<'EOF'
036711d5e63acdae3ce121c4a6707f0c535bc3dfd126d1546633683f8be06bd2  fonts/HakgyoansimBareonbatangB.otf
206ac90bb89d91d98815485930091766123c27bc7d07d9bf3f27427d2b34100f  fonts/HakgyoansimBareonbatangR.otf
14e6328a5383d2b927c47051093ce0aff60deea07e6df71b8b99ee8d9c2ff8f2  fonts/lmmono10-italic.otf
22deb6d3be3ffcb40b33f0e010afb256c677d97c2a2bdee1f5740cdc97751558  fonts/lmmono10-regular.otf
b826e490fa671f254840abe88afea0975b606f57fb4a8b93f53787c26d8ac319  fonts/lmmono12-regular.otf
17319490d20f24e192bd7e7999484b95111a4654ac2620e7aa215591142ae997  fonts/lmmono8-regular.otf
cdd53c7dc01a1d25f21eaf7cae44bfb8a9665e4cbd60e5f8da14287aca819bb9  fonts/lmmono9-regular.otf
6bb7315ab000361195457b6c5efc75ed4bc24d278c6026d0aa8e0e4847394384  fonts/lmmonocaps10-oblique.otf
9fb93a8f39f8e55682d09edb93c4c07d976c13bb92253b875b5b6a19e9af9e0a  fonts/lmmonocaps10-regular.otf
2f4ae1bd30d4203a1c74c61d61dddbd5e2c2d5a7001d456b1b98e08b7c47ffb9  fonts/lmmonolt10-bold.otf
a739b6deaafe0b9e8ae1eec9db1f425c52e1f6f483ca8e07e359bdd118310bba  fonts/lmmonolt10-boldoblique.otf
f19451a27c178d48b99921e72ff6acf568f670bf58c71c6dd506b1f96a2d9c9e  fonts/lmmonolt10-oblique.otf
176f2e3745e3d97eb7b96b25be919ed0e198f491dc363ad28971be1d5707ace7  fonts/lmmonolt10-regular.otf
2af9fab2c4d4c7a98aaebb9d66ffe1b55b3319e48c5d84add7ef27c2890747d2  fonts/lmmonoltcond10-oblique.otf
fd2e0afd73a6029887d222f1e379f9e977ed57f9471d48ba44fb42c52a650274  fonts/lmmonoltcond10-regular.otf
7306b49832153fb387be1c741962a72d36127a2176f855d11c9903e6a15bfaca  fonts/lmmonoprop10-oblique.otf
59036dd0b599f3e90c41dc4b063849bb36ba29058f94d386718fb9ce523d8657  fonts/lmmonoprop10-regular.otf
c30d83cb4cdd879ea251243590e135e012e5d43e889a0d0990d196b1083715d2  fonts/lmmonoproplt10-bold.otf
4d1193e06d6042695f8caf9cde48785867bee8de8460a7a9c99504074d280f57  fonts/lmmonoproplt10-boldoblique.otf
2d57934e1ae5f71cbcbed7b7ea6fa597f9212ebfd8d0cc91e9fabbb9622cab7f  fonts/lmmonoproplt10-oblique.otf
dedec8ee86f7448949cb695ace72f2e0de3ccc380ff92dfbc6c45c20209e3349  fonts/lmmonoproplt10-regular.otf
4b4a3e600db7f6ec434f8b48b31f22e12faced90e1681c93eeba5e23a6e55fde  fonts/lmmonoslant10-regular.otf
102fe06c430a8b681b2bf6876b7cd967ae4d47b4b6b41d915eb7913b726d9fb1  fonts/lmroman10-bold.otf
c37a28eed7a6e03f792b98b5e5f637b2fcda378bb4855f99284f1a88fe35f124  fonts/lmroman10-bolditalic.otf
c1fce25075567bb8dbf2151658c3b442690041db17a2d49fc9e55905ea5b7169  fonts/lmroman10-italic.otf
1aa18cfefa58132c52ce5de70db1fd1154201c19cd2b2cdaffba4906a33e6852  fonts/lmroman10-regular.otf
28c8782ac2b6486958b5dc7610ada7800c53546ff7f36bc65909a876e1cd338e  fonts/lmroman12-bold.otf
ada6b3f451238784e5a5ea75d43efa1eb4329cd75ce65bf047ed2f31b7b5e2f3  fonts/lmroman12-italic.otf
e6be218ae83e61aa8a29990d3cdc401c678c1962188cb9a4a8b6359e4f5e5870  fonts/lmroman12-regular.otf
ed048c80fb4b67663b80899b89fe5fba17d7442e1286d61fd08fe5689c6b7c3c  fonts/lmroman17-regular.otf
6326fb955d07bedcc8f73684e6b6bfa76706d38f3a85bd89c0659504ace366a1  fonts/lmroman5-bold.otf
954bd9c376597c7043e7b616430163e0158155edf7434fd70082cf8460c08533  fonts/lmroman5-regular.otf
f1ebd52916182bfc2e3f9d4b5ba847ad6acc6c7761354c0dc052fb01ec14f73c  fonts/lmroman6-bold.otf
501396c437f76c260b8724265b8495f318a640ee5a4674852ecbb20daf256696  fonts/lmroman6-regular.otf
063ea9e378b4fca4fd59771cf522faa21eb7c8516c89464745c79725b384fb9a  fonts/lmroman7-bold.otf
19d20f2bb00fbffe5d3d66e9b6a54f0108289068029e9d88649d981d53613ddf  fonts/lmroman7-italic.otf
48c4b46ab255eec96588fb992fba1ed6102e53d051da480738a61cc6cdb328c3  fonts/lmroman7-regular.otf
04d4f633c3da31a169f4c54a7fe8c7e63925b39d030381f8d3eab955f16be7b2  fonts/lmroman8-bold.otf
fb0536b5c3eee5b5622cd827ceb410e6514e36512ebdc51d2cf98a96c06d44e8  fonts/lmroman8-italic.otf
f73015c3827596586faa380c398501caf9b5bcbb6f40b46af6a51277ca97c9fc  fonts/lmroman8-regular.otf
f72feac9ea12eb858d8093d6c0ee710a6c25f59b61278c88ec41c0a680838415  fonts/lmroman9-bold.otf
2106cffcdc9f9cb411d7c3441e34d77a168b998a58b40e727ab5b815437d1975  fonts/lmroman9-italic.otf
8ab7b017fc67ea0e30cbf9e7ebd940010442ea67b40cf65f87d73f3ca11b0e6f  fonts/lmroman9-regular.otf
603e6bb88c206f3252d2ca1a061d0faf252dd6c87501f2efa32ce2f70793b1ad  fonts/lmromancaps10-oblique.otf
1ab40332a969892c7ed6cb010193b5276ccef1da6798bcbd1a465fee23d29334  fonts/lmromancaps10-regular.otf
430d9237cfeb1b7ef25a36002adac0524a11a07f4a31b16ce5a0eb3330163217  fonts/lmromandemi10-oblique.otf
63b6f9528e6117c5b0c0b1992517696ae09d05e7ca3711df0e0409d9db6df32c  fonts/lmromandemi10-regular.otf
5f7b9361353271246ac66a2681399052cc261a943c8a03c754ee212fdfb4a64c  fonts/lmromandunh10-oblique.otf
6c298b3680cc111c6e20eb2489bab9637ac316a686740fc1f8396230215e1161  fonts/lmromandunh10-regular.otf
5f6689646a5e88b402d2e60085c813fca3a4d60707b0383c65cb023107a8bddc  fonts/lmromanslant10-bold.otf
056ad4d08d2eb58d6b7fd0ac5de3f1fb799f2bb0c16b66c7e6b5bc5b6aef6481  fonts/lmromanslant10-regular.otf
25f2ecfb860f2e45e6ebe69d11bc6305f5bfbef8f13476638ba291f47d1f130c  fonts/lmromanslant12-regular.otf
4f30eda1d4674a1f4eea513b3baf85e3ba3fb17b2e4cf09bf627aee91dc0a4cc  fonts/lmromanslant17-regular.otf
a88ecd1a6b4d5aa1c9d537b98d0de8e19d63b292918fabf0cc36158ed770ca63  fonts/lmromanslant8-regular.otf
7441aee0c9dfbca16118fc7fe339c2e6c79ecc966a51ac1f76860351b6a8f02e  fonts/lmromanslant9-regular.otf
21bbbe167e824b93a956327bcc1efda99c1bb472e761834da40cef33cab46194  fonts/lmromanunsl10-regular.otf
a597b710326c1a8a2c7238d808e5d38711638a72a32383478db4829d63afd687  fonts/lmsans10-bold.otf
e45673d84754a94f2f053bd4c15950b4b320144fbb622c630a26fd7b68cfabc5  fonts/lmsans10-boldoblique.otf
1b38b36efc21f9d3f34edf6a13f9d71f59c41f824e790f5d3ee5ba5b4936f377  fonts/lmsans10-oblique.otf
d431b786b9b603662718e79cfe9b441f47a8b0b3e854dde89d5acb3ed7cfd682  fonts/lmsans10-regular.otf
1f138e6203f7092f9a01f6193ed97d971b5045b99969f3a62c7e43a7faabc1c0  fonts/lmsans12-oblique.otf
f87ebdea035a96e8787e2c663cfcc78ce73205d37800eafe7948278e2cc7666a  fonts/lmsans12-regular.otf
0f6a4450c5fc9afd3650f24ad9003684fff3252691bbf2a33be94b383db8a77c  fonts/lmsans17-oblique.otf
f6c395a436e4fa7e88bbf1445e64b9c78ce4effba3668b13cc433077fc71a984  fonts/lmsans17-regular.otf
7f4227513bfd47b7077bedd125caa4c0a223a2cdad17a1470145cdea83353c88  fonts/lmsans8-oblique.otf
04f0d25ca474494cb707e752170f6c22cdcb8ae2b5fb80872143e18d5cc463f8  fonts/lmsans8-regular.otf
ac0535d7d4a8eb1b531c5faeb9060a4b9bac397d72cf54191ef53eea6f66b617  fonts/lmsans9-oblique.otf
80ef596460b7b402621780f7cd73a348efedc4cd2c6deca37da58f07ee61b85d  fonts/lmsans9-regular.otf
f98ed7d9cc5e10fd5c8e01f6ea708fddff5bbbf6f4503998c92b3c1f26d68d33  fonts/lmsansdemicond10-oblique.otf
3a8cc8f72acaf6d4cc9200a838e5e118bf6f265233aa078e105559f6db6c2948  fonts/lmsansdemicond10-regular.otf
44cd928f556c68c3a6ce5938f6968c3da7b3d9d14d3c8add54005f0cc5e39a53  fonts/lmsansquot8-bold.otf
0cac0a6909c1cb33df8d3aeda2817ef2671d7f466cc352d826551bf92ca5f877  fonts/lmsansquot8-boldoblique.otf
d858d237a69d432ca0ff67b930dabf5a60bfde69ca39bc555fab78ecbb5f4e4d  fonts/lmsansquot8-oblique.otf
5da041def6d17825bb9b2d1d4fef66099a1e871005c08fc8f0d29976a923f4c9  fonts/lmsansquot8-regular.otf
EOF
    then
      echo -e "✅ \x1b[1;92mFonts are already prepared!\x1b[0m"
      exit 0
    else
      echo "Preparing fonts ..."
    fi

    # Check if dependencies are installed
    if ! which -s curl tar xz; then
      echo "Error: Please install 'curl', 'tar', and 'xz'"
      exit 1
    fi

    mkdir -p ./fonts
    # Download then verify tarball
    if [[ ! -f ./fonts/fonts.tar.xz ]]; then
      curl -o ./fonts/fonts.tar.xz 'https://i.hyeon.me/@napkin-community/solutions/fonts.tar.xz'
    fi
    sha256sum --quiet -c - <<< 'b60e1b8fa55eb413e0ab7890b982cc784043c76ff22ebe7f1e4d318bd560195f fonts/fonts.tar.xz'
    # Untar
    tar -xf fonts/fonts.tar.xz -C fonts

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
    if ! command -v typst >/dev/null; then
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
        COPY=wl-copy
      elif command -v xcopy >/dev/null; then
        COPY=xcopy
      else
        echo "Error: Please install 'xcopy', or 'wl-copy' to copy the image to clipboard"
        exit 1
      fi
      <<< "${SVG}" magick svg:- png:- | "${COPY}"
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
