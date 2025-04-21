#import "./napkin.typ": *

/// The solution box
///
/// #example(```
/// #solution(challengers.ranolp)[
///   It's trivial
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let solution(
  /// The challenger who try to propose a solution
  /// -> dictionary
  by,
  /// Content of the box.
  /// -> content
  content,
  subtitle: none,
) = box(
  width: 100%,
  fill: rgb("#fbf8ff"),
  inset: 1em,
  latexize[
    #text(
      fill: rgb("#450e9e"),
    )[
      #titlize([Solution], subtitle)
      #if subtitle != none {
        linebreak()
      } else {}
      _by_ #box(baseline: 20%, radius: 2pt, clip: true)[#image(by.avatar.source, format: by.avatar.format, height: 1.2em)] #if by.name != by.login {
        [#by.name (#by.login)]
      } else {
        [#by.name]
      }
    ]

    #line(length: 100%, stroke: 0.5pt + gray)

    #content
  ],
)
