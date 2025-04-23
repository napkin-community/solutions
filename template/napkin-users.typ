#let users = (
  "ranolp": {
    let metadata = json("../users/ranolp.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
)