#let challengers = (
  "ranolp": {
    let metadata = json("./assets/challengers/ranolp/metadata.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
)