#import "@preview/tidy:0.4.2"
#import "napkin-solve-utilities.typ"
#import "napkin-challengers.typ": challengers

#let docs = tidy.parse-module(
  read("napkin-solve-utilities.typ"),
  name: "napkin-solve-utilities",
  scope: (napkin-solve-utilities: napkin-solve-utilities, challengers: challengers),
  preamble: "#import napkin-solve-utilities: *\n",
)
#tidy.show-module(docs, style: tidy.styles.default)
