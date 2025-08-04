#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#chili(1)
#plain_box(title: [Problem 8H])[
  Let $M = (M, d)$ be a bounded metric space. Suppose that whenever $d'$ is another metric on $M$ for which $(M, d)$ and $(M, d')$ are homeomorphic (i.e. have the same open sets), then $d'$ is also bounded. Prove that $M$ is compact.
]

#solution(users.kiwiyou)[
  Prove the contrapositive: if $M$ is not compact, then there exists a metric $d'$ on $M$ such that $(M, d)$ and $(M, d')$ are homeomorphic, but $d'$ is not bounded.

  = 1. Construction of a new metric

  If $M$ is not compact, there exists a sequence $(x_n)$ in $M$ without a convergent subsequence.

  #plain_box(title: [Definition 8.1.2])[
    A metric space $M$ is #glossary[sequentially compact] if every sequence has a subsequence which converges.
  ]

  Define $f(x) = inf_n (d(x, x_n) + 1 / n)$, then $f(x) > 0$ since subsequence of $(x_n)$ never converges.

  Define $d'(x, y) = d(x, y) + abs(1 / f(x) - 1 / f(y))$, then $d'$ is a metric.

  #plain_box(title: [Definition 2.1.1])[
    A #glossary[metric space] is a pair $(M, d)$ consisting of a set of points $M$ and a #glossary[metric] $d : M times M arrow RR_(>=0)$. The distance function must obey:

    - For any $x, y in M$, we have $d(x, y) = d(y, x)$; i.e. $d$ is symmetric.

    - The function $d$ must be #glossary[positive definite] which means that $d(x, y) >= 0$ with equality if and only if $x = y$.

    - The function $d$ should satisfy the #glossary[triangle inequality]: for all $x, y, z in M$,
    $ d(x, z) + d(z, y) >= d(x, y). $
  ]

  - $d'$ is trivially symmetric and positive definite.

  - $d'(x, y)$ satisfies the triangle inequality.
  $
    d'(x, y) + d'(y, z) & = d(x, y) + d(y, z) + abs(1 / f(x) - 1 / f(y)) + abs(1 / f(y) - 1 / f(z))
    \ & >= d(x, z) + abs((1 / f(x) - 1 / f(y)) + (1 / f(y) - 1 / f(z)))
    \ & >= d(x, z) + abs(1 / f(x) - 1 / f(z))
    \ & = d'(x, z)
  $

  Therefore, $d'$ is a metric.

  = 2. Finding a homeomorphism

  Now show that $(M, d)$ and $(M, d')$ are homeomorphic by identity map $I$.

  First, $f$ is continuous in $(M, d)$.
  $
                    d(y, x_n) & <= d(x, y) + d(x, x_n) \
            d(y, x_n) + 1 / n & <= d(x, y) + d(x, x_n) + 1 / n \
    inf_n (d(y, x_n) + 1 / n) & <= d(x, y) + inf_n (d(x, x_n) + 1 / n) \
                         f(y) & <= d(x, y) + f(x) \
                |f(y) - f(x)| & <= d(x, y) \
  $

  For all $epsilon > 0$,
  $ d(x, y) < epsilon ==> |f(y) - f(x)| <= d(x, y) < epsilon. $

  Now that $abs(1 / f(x) - 1 / f(y))$ is continuous in $(M, d)$, there exists $delta_f$ such that
  $
    d(x, y) < delta_f ==> abs(1 / f(x) - 1 / f(y)) < epsilon.
  $

  Define $delta = min(delta_f, epsilon)$, then
  $
    d(x, y) < delta ==> d(x, y) + abs(1 / f(x) - 1 / f(y)) < epsilon.
  $

  Therefore, $I$ is continuous in $(M, d)$.

  #plain_box(title: [Definition 2.3.1])[
    Let $M = (M, d_M)$ and $N = (N, d_N)$ be metric spaces. A function $f : M -> N$ is #glossary[continuous] at a point $p in M$ if for every $epsilon > 0$ there exists a $delta > 0$ such that $ d_M (x, p) < delta ==> d_N (f (x), f (p)) < epsilon. $ Moreover, the entire function $f$ is continuous if it is continuous at every point $p in M$.
  ]

  And as $d(x, y) <= d'(x, y)$, $I^(-1)$ is also continuous in $(M, d')$.

  Since $I$ is a homeomorphism, so $(M, d)$ and $(M, d')$ are homeomorphic.

  #plain_box(title: [Definition 2.4.1])[
    Let $M$ and $N$ be metric spaces. A function $f : M -> N$ is a #glossary[homeomorphism] if it is a bijection, and both $f : M -> N$ and its inverse $f^(-1) : N -> M$ are continuous. We say $M$ and $N$ are #glossary[homeomorphic].
  ]

  = 3. Unboundedness of $(M, d')$

  Fix a point $p$, then there exists minimum integer $N > 1 / f(p)$.

  For all $n in NN$, since $1 / f(x_n) >= n$,
  $
    d'(p, x_(n+N)) & = d(p, x_(n+N)) + abs(1 / f(p) - 1 / f(x_(n+N))) \
                   & = d(p, x_(n+N)) + 1 / f(x_(n+N)) - 1 / f(p) \
                   & >= n + N - N \
                   & >= n. \
  $

  Therefore, $d'$ is not bounded.

  #plain_box(title: [Definition 6.1.1])[
    A metric space $M$ is #glossary[bounded] if there is a constant $D$ such that $d(p, q) <= D$ for all $p, q in M$.
  ]

  Since the contrapositive is proven, $M$ is compact. #h(1fr) #sym.qed
]
