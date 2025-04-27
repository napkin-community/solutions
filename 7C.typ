#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 7C], subtitle: [Hausdorff implies $T_1$ axiom])[
  Let $X$ be a Hausdorff topological space. Prove that for any point $p in X$ the set ${p}$ is closed.
]

#solution(users.kiwiyou)[
  For every $q != p$, there exists two open neighbourhoods $U$ of $p$ and $V$ of $q$ s.t. $U sect V = empty$.

  #plain_box(title: [Definition 7.3.1], subtitle: [Hausdorff])[
    A topological space $X$ is #glossary[Hausdorff] if for any two distinct points $p, q in X$, there exists two open neighbourhoods $U$ of $p$ and $V$ of $q$ such that $ U sect V = empty. $
  ]

  Let $ Y = union.big_attach(q in X without {p}) V. $

  Since $Y$ is union of open neighbourhoods of $p$, $Y$ is open.

  #plain_box[
    - Arbitrary unions (possibly infinite) of open sets are also open in $cal(T)$.
  ]

  Since $Y = X without {p}$ is open, ${p}$ is closed. #qed

  #plain_box(title: [Definition 7.2.4])[
    In a general topological space $X$, we say that $S subset.eq X$ is #glossary[closed] in $X$ if the complement $X without S$ is open in $X$.
  ]
]
