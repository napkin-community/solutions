#import "@preview/tidy:0.4.2"
#import "napkin.typ"
#import "napkin-users.typ": users

#let docs = tidy.parse-module(
  read("napkin.typ"),
  name: "napkin",
  scope: (
    napkin: napkin,
    users: users,
  ),
  preamble: "#import napkin: *\n",
)
#tidy.show-module(docs, style: tidy.styles.default)
