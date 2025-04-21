#import "@preview/tidy:0.4.2"
#import "napkin.typ"

#let docs = tidy.parse-module(
  read("napkin.typ"),
  name: "napkin",
  scope: (
    napkin: napkin,
  ),
  preamble: "#import napkin: *\n",
)
#tidy.show-module(docs, style: tidy.styles.default)
