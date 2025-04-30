#import "template/napkin.typ": *

#black_note("Definition 8.3.1")[
  An open cover of a topological space $X$ is a collection of open sets ${U_alpha}$ (possibly infinite or uncountable)
  which _cover_ it: every point in $X$ lies in at least one of the $U_alpha$, so that
  $
    X = union.big U_alpha
  $
  Such a cover is called an #glossary[open cover].

  #par(
    first-line-indent: 1em,
  )[A #glossary[subcover] is exactly what it sounds like: it takes only some of the $U_alpha$, while ensuring that $X$ remains
    covered.]
]
