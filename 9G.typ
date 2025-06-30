#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set math.mat(delim: "[")

#plain_box(title: [Problem 9G], subtitle: [TSTST 2014])[
  Let $P(x)$ and $Q(x)$ be arbitrary polynomials with real coefficients, and let $d$ be the degree of $P(x)$. Assume that $P(x)$ is not the zero polynomial.. Prove that there exist polynomials $A(x)$ and $B(x)$ such that.

  #enum(numbering: "(i)")[
    Both $A$ and $B$ have degree at most $d slash 2$,
  ][
    At most one of $A$ and $B$ is the zero polynomial,
  ][
    $P$ divdes $A + Q dot B$
  ]
]

#solution(users.ranolp)[
  Powered by Gemini™

  #blue_box("Theorem 9.7.7", subtitle: "Rank-nullity theorem")[
    Let $V$ and $W$ be finite-dimensional vector spaces. If $T : V -> W$, then

    $
      dim V = dim ker T + dim im T
    $
  ]

  At most $k$-degree polynomial vector space is isomorphic to $RR^(k+1)$.

  Consider $V = RR^(plus.circle (floor(d slash 2))+1) times RR^(plus.circle (floor(d slash 2)+1))$, $W = RR^(plus.circle d)$, and a linear map

  $T = (A, B) |-> (A + Q dot B) mod P : V -> W$

  By rank-nullity theorem

  $
                       dim V & = dim ker T + dim im T \
    2 (floor(d slash 2) + 1) & = dim ker T + dim im T
  $

  In other words, $dim ker T = 2 (floor(d slash 2) + 1) - dim im T$.

  In this case, $im T subset.eq RR^(plus.circle d)$ so $dim im T <= d$.  For evaluating $dim ker T$, choose the maximal value $d$.

  Let's case work to evaluate $dim ker T$,

  #list[
    *$d$ is even*: $dim ker T >= d + 2 - d = 2$
  ][
    *$d$ is odd*: $dim ker T >= (d - 1) + 2 - d = 1$
  ]

  Thus, $dim ker T >= 1$.

  Since $ker T$ is non-trivial, there exists non-zero $(A, B) in V$.

  In other words, there exist non-zero $A$ or non-zero $B$.
]
