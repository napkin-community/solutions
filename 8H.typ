#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#chili(1)
#plain_box(title: [Problem 8H])[
  Let $M = (M, d)$ be a bounded metric space. Suppose that whenever $d'$ is another metric on $M$ for which $(M, d)$ and $(M, d')$ are homeomorphic (i.e. have the same open sets), then $d'$ is also bounded. Prove that $M$ is compact.
]

#solution(users.kiwiyou)[
  Prove the contrapositive: if $M$ is not compact, then there exists a metric $d'$ on $M$ such that $(M, d)$ and $(M, d')$ are homeomorphic, but $d'$ is not bounded.

  If $M$ is not compact, there exists a sequence $(x_n)$ in $M$ without a convergent subsequence.

  #plain_box(title: [Definition 8.1.2])[
    A metric space $M$ is #glossary[sequentially compact] if every sequence has a subsequence which converges.
  ]

  Define $f(x) = inf_n (d(x, x_n) + 1/n)$.

  Since subsequence of $(x_n)$ never converges, $f(x) > 0$ for all $x in M$.

  $
    x = x_n & => f(x) = 1 / n
    \ x != x_n & => exists epsilon > 0 "s.t." forall n: d(x, x_n) >= epsilon
  $

  Define $d'(x, y) = d(x, y) + |1/f(x) - 1/f(y)|$. Now show that $d'$ is a metric.

  #plain_box(title: [Definition 2.1.1])[
    A #glossary[metric space] is a pair $(M, d)$ consisting of a set of points $M$ and a #glossary[metric] $d : M times M arrow RR_(>=0)$. The distance function must obey:

    - For any $x, y in M$, we have $d(x, y) = d(y, x)$; i.e. $d$ is symmetric.

    - The function $d$ must be #glossary[positive definite] which means that $d(x, y) >= 0$ with equality if and only if $x = y$.

    - The function $d$ should satisfy the #glossary[triangle inequality]: for all $x, y, z in M$,
    $ d(x, z) + d(z, y) >= d(x, y). $
  ]

  - $d'$ is trivially symmetric and positive definite.

  - $d'(x, y)$ follows the triangle inequality.
  $
    d'(x, y) + d'(y, z) & = d(x, y) + d(y, z) + abs(1 / f(x) - 1 / f(y)) + abs(1 / f(y) - 1 / f(z))
    \ & >= d(x, z) + abs(1 / f(x) - 1 / f(z))
    \ & = d'(x, z)
  $

  Therefore, $d'$ is a metric.

  #black_note[Exercise][
    Show that $(M, d)$ and $(M, d')$ are homeomorphic by identity map.
  ]

  For all $x in M$, $n in NN$, $d(x, x_n) >= n$, so $(M, d')$ is not bounded.

  #qed
]
