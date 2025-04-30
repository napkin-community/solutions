#set page(height: auto)

#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#chili(1)
#plain_box(
  title: [Problem 8F#dagger],
  subtitle: [Bolzano-Weierstraß theorem for general metric spaces],
)[
  Prove that a metric space $M$ is sequentially compact if and only if it is complete and totally bounded.
]

#solution(users.ranolp)[
  == sequentially compact $arrow.double.r$ complete and totally bounded

  #list(spacing: 2em)[
    Given a Cauchy sequence $(x_n)$, because $M$ is sequentially compact, \
    there exists a subsequence of $(x_n)$ called $(x_n_k)$
    which converges to $x$.

    #grid(columns: 2, column-gutter: 0.75em, row-gutter: 1em)[
      *Claim.*
    ][$(x_n) -> x$][*Proof.*][
      For any $epsilon > 0$:

      $
        exists N_1& "such that"& forall n, m &>= N_1,&" " d(x_n, x_m) < epsilon / 2 \
        exists K & "such that"& forall k &>= K, &" " d(x_n_k, x) < epsilon / 2
      $

      Let's choose $N = max { N_1, n_K }$, then for any $n >= N$, pick a $k >= K$ with #box[$n_k >= n$]. \
      Because of triangle inequality:
      $
        d(x_n, x) <= d(x_n, x_(n_k)) + d(x_(n_k), x) < epsilon / 2 + epsilon / 2 = epsilon
      $

      Hence $(x_n) -> x$ $square$
    ]

    Thus, any Cauchy sequence in $M$ converges.

    Hence $M$ is complete $square$
  ][
    If a metric space is sequentially compact, it is also compact (*Theorem 8.3.5.*). And we know that compact space is
    totally bounded (*Proposition 8.4.1*).

    Hence $M$ is totally bounded $square$
  ]

  == sequentially compact $arrow.double.l$ complete and totally bounded

  Given sequence $(x_n)$, we need to show that there exists a subsequence of $(x_n)$ which converges.

  #line(length: 100%, stroke: 0.25pt)

  Since $M$ is totally bounded, we can cover whole space with finitely many $epsilon$-balls. \

  For any $k in NN$ and any sequence $(y_n)$ by _Infinite Pigeonhole Principle_, \
  we can pick a #box[$1 / k$-ball] called $A_k$ containing infinitely many terms in $(y_n)$ \
  because $1 / k$-balls are finitely many.

  Let's call the subsequence of $(y_n)$ contained by $A_k$ as $(y^((k))_n)$

  #line(length: 100%, stroke: 0.25pt)

  Let's define a subsequence $(x_n_(Gamma k))$ with $Gamma k < Gamma (k+1)$ inductively for any $k in NN$, \
  - $(x_n_(Gamma 1)) = (x^((1))_n)$
  - $(x_n_(Gamma (k+1))) = (x^((k))_n_(Gamma k))$

  #line(length: 100%, stroke: 0.25pt)

  Now let's define a subsequence $(x_n_k)$ which is Cauchy. \
  Inductively pick $n_1 < n_2 < dots.c$ with $x_n_k in (x_n_(Gamma k))$. \

  If $j, k >= N$ then $x_n_j, x_n_k in A_N$ so $d(x_n_j, x_n_k) < "diameter"(A_N) <= 2 / N$.

  Thus, for $epsilon > 0$, we can pick $N > 2 / epsilon$ to meet $d(x_n_j, x_n_k) < epsilon$

  #line(length: 100%, stroke: 0.25pt)

  We have shown that any sequence has a Cauchy subsequence, which converges in a complete space.

  Hence, $M$ is sequentially compact $square$

  == References
  #include "8.1.2.typ"
  #include "8.3.5.typ"
  #include "8.4.1.typ"
]
