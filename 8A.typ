#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 8A])[
  Show that the closed interval $[0, 1]$ and open interval $(0, 1)$ are not homeomorphic.
]

#solution(users.kiwiyou)[
  Suppose $[0, 1]$ and $(0, 1)$ are homeomorphic.

  There exists a homeomorphism $f: [0, 1] arrow (0, 1)$ which preserves open sets.

  #plain_box(title: [Definition 7.2.2])[
    A #glossary[homeomorphism] of topological spaces $(X, tau_X)$ and $(Y, tau_Y)$ is a bijection $f : X arrow Y$ which induces a bijection from $tau_X$ to $tau_Y$: i.e. the bijection preserves open sets.
  ]

  Since $(0, 1)$ is not compact, there exists an open cover ${U_alpha}$ of $(0, 1)$ without a finite subcover.

  #plain_box(title: [Definition 8.3.2])[
    A topological space $X$ is #glossary[quasicompact] if _every_ open cover has a finite subcover. It is #glossary[compact] if it is also Hausdorff.
  ]

  Since $f$ is a homeomorphism, ${f^("pre")(U_alpha)}$ is an open cover of $[0, 1]$, which is compact, so there exists a finite subcover of ${f^("pre")(U_alpha)}$, namely ${V_n}^(N)_(n=1)$, which covers $[0, 1]$.

  Since $f$ is a homeomorphism, ${f^("img")(V_n)}^N_(n=1)$ is a finite subcover of ${U_alpha}$ which covers $(0, 1)$.

  This is a contradiction, so $[0, 1]$ and $(0, 1)$ cannot be homeomorphic. #h(1fr) #sym.qed
]
