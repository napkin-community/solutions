#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#brown_box(subtitle: [Non-examples of compact metric spaces])[Example 8.1.3][
  #enum(numbering: "(a)", start: 2)[
    More generally, if a space is not bounded it cannot be compact. (You can prove this if you want.)
  ]
]

#solution(users.kiwiyou)[
  Let $X$ be an unbounded metric space. Suppose $X$ is compact.

  There exists a sequence ${x_n}$ such that $d(x_n, x_1) > n - 1$.

  #plain_box(title: [Definition 6.1.1])[
    A metric space $M$ is #glossary[bounded] if there is a constant $D$ such that $d(p, q) <= D$ for all $p, q in M$.
  ]

  For all $epsilon > 0$, $n >= epsilon + 1 ==> epsilon < d(x_1, x_n) <= d(x_1, x) + d(x, x_n)$.

  #plain_box(title: [Definition 2.1.1])[
    A #glossary[metric space] is a pair $(M, d)$ consisting of a set of points $M$ and a #glossary[metric] $d : M times M arrow RR_(>=0)$. The distance function must obey:

    - For any $x, y in M$, we have $d(x, y) = d(y, x)$; i.e. $d$ is symmetric.

    - The function $d$ must be #glossary[positive definite] which means that $d(x, y) >= 0$ with equality if and only if $x = y$.

    - The function $d$ should satisfy the #glossary[triangle inequality]: for all $x, y, z in M$,
    $ d(x, z) + d(z, y) >= d(x, y). $
  ]

  Since $d(x, x_n) >= d(x_1, x_n) - d(x_1, x) > epsilon$, ${x_n}$ does not converge to $x$.

  For all subsequence ${x_(gamma_n)}$, $d(x_1, x_(gamma_n)) > n - 1$, so ${x_(gamma_n)}$ does not converge to $x$.

  This is contradiction, so $X$ is not compact. #h(1fr) #sym.qed

  #plain_box(title: [Definition 6.1.1])[
    A metric space $M$ is #glossary[sequentially compact] if every sequence has a subsequence which converges.
  ]
]
