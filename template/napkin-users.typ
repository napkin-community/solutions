#let users = (
  "finalchild": {
    let metadata = json("../users/finalchild.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
  "kiwiyou": {
    let metadata = json("../users/kiwiyou.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
  "ranolp": {
    let metadata = json("../users/ranolp.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
  "simnalamburt": {
    let metadata = json("../users/simnalamburt.json")
    let avatar = read(metadata.avatar.path, encoding: none)
    (..metadata, avatar: (source: avatar, format: metadata.avatar.format))
  },
)
