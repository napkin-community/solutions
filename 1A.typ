#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "Problem 1A")[
  What is the joke in the following figure? (Source: [#link(<img:snsd>)[#text(fill: color.rgb("339901"))[*Ge*]]].)
]

#align(center)[
  #image("assets/love-proper-isomorphic-subgroup.jpg", width: 40%)
]

#solution(users.ranolp)[
  Let's say "my love for you" as a group called $G$. \
  The picture claims that there exists a proper subgroup $H tilde.equiv G$. \
  If $G$ is finite, any proper subgroup cannot be isomorphic to $G$ itself. \
  Hence $|G| = |"my love for you"| = infinity$
]

// Image Attribution

#import "@preview/citegeist:0.1.0": load-bibliography

#let bib = load-bibliography(read("images.bib"))

== Image Attributions

#grid(columns: 2, column-gutter: 16pt)[
  *[Ge]* <img:snsd>
][
  #set text(font: "New Computer Modern")
  #let fields = bib.at("img:snsd").fields

  #text(features: (smcp: 1))[#fields.author].
  _#(fields.title)_.
  #if fields.note != none {
    [#(fields.note).]
  }
  #if fields.url != none {
    [#text(font: "DejaVu Sans Mono", fill: color.rgb("0000FF"))[#link(fields.url)[#(fields.url)]].]
  }
]
