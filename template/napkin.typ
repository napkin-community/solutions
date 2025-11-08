/// Daggered problem.
///
/// ```example
/// #latexize[#daggered]
/// ```
///
/// -> content
#let daggered = super(text(sym.dagger, font: "New Computer Modern Math"))

/// Starred problem.
///
/// ```example
/// #latexize[#starred]
/// ```
///
/// -> content
#let starred = super(text(sym.star, font: "New Computer Modern Math"))

/// Coproduct.
///
/// ```example
/// #coproduct
/// ```
///
/// -> content
#let coproduct = scale(sym.Pi, y: -100%)

/// Definitionally Equal to.
///
/// ```example
/// #defeq
/// ```
///
/// -> str
#let defeq = math.class("relation")[
  #text(":", baseline: -0.03em)
  #h(0%)
  #sym.equiv
]

/// Glossary.
///
/// #example(```
/// #latexize[
///   (Later on, we will know that $L$ is the #glossary[Hilbert class field] of $K$.)
/// ]
/// ```, dir: ttb)
///
/// -> content
#let glossary(
  /// Content of the glossary.
  /// -> content
  content,
) = text(fill: rgb("00f"))[*#content*]

/// LaTeXize the content.
///
/// #example(```
/// #latexize[
///   In high school, linear algebra is often really unsatisfying.
/// ]
/// ```, dir: ttb)
///
/// -> content
#let latexize(
  /// Content to LaTeXize.
  /// -> content
  content,
) = [
  #set text(
    font: ("New Computer Modern", "Hakgyoansim Bareonbatang"),
    size: 11pt,
  )
  #show math.equation: set text(font: "New Computer Modern Math", features: (
    "cv01",
  ))
  #set par(spacing: 0.8em, justify: true)
  #content
]

#let titlize(title, subtitle) = if subtitle != none {
  [*#title* (#subtitle)]
} else {
  [*#title*]
}


#let titlize_dot(title, subtitle) = if subtitle != none {
  [*#title* (#subtitle)*.*]
} else {
  [*#title.*]
}

/// Brown box. Used for examples.
///
/// #example(```
/// #brown_box(subtitle: [Multiplication mod $p$])[Example 1.1.9][
///   Let $p$ be a prime. Consider the _nonzero residues modulo $p$_,
///   which we denote by $(Z slash p Z)^(times)$. Then $((Z slash p Z)^(times), times)$ is a group.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let brown_box(
  /// Title of the box.
  /// -> content
  title,
  /// Content of the box.
  /// -> content
  content,
  /// Subtitle of the box.
  /// -> content | none
  subtitle: none,
) = block(
  width: 100%,
  stroke: 1pt + rgb("9e3c0e"),
  fill: rgb("fff9f8"),
  radius: 0.5em,
  inset: 1em,
  latexize[
    #text(fill: rgb("9e3c0e"), titlize(title, subtitle))

    #content
  ],
)

/// A note with black left strip. Used for questions and exercises.
///
/// #example(```
/// #black_note(subtitle: [Unimportant])[Exercise 53.3.3][
///   Show that if $alpha$ is an algebraic number,
///   then $bb(Q)(alpha) tilde.equiv bb(Q)[alpha]$.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let black_note(
  /// Title of the note.
  /// -> content
  title,
  /// Content of the note.
  /// -> content
  content,
  /// Subtitle of the note.
  /// -> content | none
  subtitle: none,
) = block(
  width: 100%,
  stroke: (
    left: 3pt + black,
  ),
  fill: rgb("fafafa"),
  inset: (
    left: 1em,
    right: 1em,
    y: 1em,
  ),
  latexize[
    #titlize_dot(title, subtitle)
    #content
  ],
)

/// A note with green left strip. Used for remarks.
///
/// Requires Latin Modern Sans font.
///
/// #example(```
/// #green_note(subtitle: [For Euclidean geometers])[Remark 64.6.5][
///   You may recognize that while $RR PP^2$ is  the setting for projective geometry,
///   inversion about a circle is done in $CC PP^1$ instead. When one does an inversion sending
///   generalized circles to generalized circles, there is only one point at infinity:
///   this is why we work in $CC PP^n$.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let green_note(
  /// Title of the note.
  /// -> content
  title,
  /// Content of the note.
  /// -> content
  content,
  /// Subtitle of the note.
  /// -> content | none
  subtitle: none,
) = block(
  width: 100%,
  stroke: (
    left: 3pt + rgb("008000"),
  ),
  fill: rgb("f2f9f5"),
  inset: (
    left: 3pt + 1em,
    right: 1em,
    y: 1em,
  ),
  latexize[
    #text(fill: rgb("008000"), font: "Latin Modern Sans")[#titlize(
        title,
        subtitle,
      ) #sym.dash.em]
    #content
  ],
)

/// Green box. Used for results of remarks.
///
/// #example(```
/// #green_box[
///   $CC PP^n$ consists of one cell in each _even_ dimension.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let green_box(
  /// Content of the box.
  /// -> content
  content,
) = block(
  width: 100%,
  stroke: 1pt + rgb("00b200"),
  inset: (x: 1em, y: 0.65em),
  latexize[
    #text(fill: rgb("008000"), [*#content*])
  ],
)

/// Blue box. Used for theorems, lemmas, corollaries, and propositions.
///
/// Requires Latin Modern Sans font.
///
/// #example(```
/// #blue_box(subtitle: [Cantor's diagonal argument])[Lemma 89.2.1][
///   For _any_ set $X$, it’s impossible to construct an injective map
///   $iota : P(X) arrow.r.hook X$.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let blue_box(
  /// Title of the box.
  /// -> content
  title,
  /// Content of the box.
  /// -> content
  content,
  /// Subtitle of the box.
  /// -> content | none
  subtitle: none,
) = block(
  width: 100%,
  stroke: 1pt + rgb("0000ff"),
  fill: rgb("f3fbfb"),
  radius: 0.5em,
  inset: 1em,
  latexize[
    #text(fill: rgb("006896"), font: "Latin Modern Sans", titlize(
      title,
      subtitle,
    ))

    #content
  ],
)

/// Plain box. Used for definitions, problems, and simple quotes.
///
/// #example(```
/// #plain_box[
///   _Proof._ Dead easy with Laurent series.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// #example(```
/// #plain_box(title: [Problem 32B#dagger], subtitle: [Rouché's theorem])[
///   Let $f, g : U arrow bb(C)$ be holomorphic functions, where $U$ contains the unit disk.
///   Suppose that $|f(z)| > |g(z)|$ for all $z$ on the unit circle.
///   Prove that $f$ and $f + g$ have the same number of zeros
///   which lie strictly inside the unit circle (counting multiplicities).
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let plain_box(
  /// Content of the box.
  /// -> content
  content,
  /// Title of the box.
  /// -> content | none
  title: none,
  /// Subtitle of the box.
  /// -> content | none
  subtitle: none,
) = block(
  width: 100%,
  stroke: 1pt + black,
  inset: (x: 1em, y: 0.65em),
  latexize(if title == none { content } else {
    [#titlize_dot(title, subtitle) #content]
  }),
)

/// Chili.
///
/// #example(```
/// #chili(3)
/// #plain_box(title: [Problem 29E])[
///   Let $f : R → R$ be smooth.
///   Suppose that for every point $p$, the Taylor series of
///   $f$ at $p$ has positive radius of convergence.
///   Prove that there exists at least one point at which $f$ is analytic.
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let chili(
  /// Number of chili peppers. Maximum 3.
  /// -> int
  count,
) = place(dx: -65pt, dy: 8pt, box(width: 60pt, align(right, stack(
  dir: rtl,
  ..(image("chili.png", height: 15pt),) * count,
))))

/// Cite other.
///
/// #example(```
/// #latexize[#respect[Le14]]
/// ```)
///
/// -> content
#let respect(who) = [\[#text(fill: rgb("339900"), size: 0.8em, who)\]]

// == Belows are napkin-community/solutions only components ==

/// The solution box
///
/// #example(```
/// #solution(users.ranolp)[
///   It's trivial
/// ]
/// ```, dir: ttb, scale-preview: 100%)
///
/// -> content
#let solution(
  /// The user who try to propose a solution
  /// -> dictionary
  by,
  /// Content of the box.
  /// -> content
  content,
  subtitle: none,
) = block(
  width: 100%,
  fill: rgb("#fbf8ff"),
  inset: 1em,
  latexize[
    #text(fill: rgb("#450e9e"))[
      #titlize([Solution], subtitle)
      #if subtitle != none {
        linebreak()
      } else {}
      _by_ #box(baseline: 20%, radius: 2pt, clip: true)[#image(by.avatar.source, format: by.avatar.format, height: 1.2em)] #if by.name != by.login {
        [#by.name (#by.login)]
      } else { [#by.name] }
    ]

    #line(length: 100%, stroke: 0.5pt + gray)

    #content
  ],
)

#let skip-from-build() = [ #metadata(true) <skip-from-build>]
