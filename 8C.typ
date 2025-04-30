#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(
  title: [Problem 8C],
  subtitle: [The cofinite topology is quasicompact only],
)[
  We let $X$ be an infinite set and equip it with the #glossary[cofinite topology]: the open sets are the empty set and
  complements of finite sets. This makes $X$ into a topological space. Show that $X$ is quasicompact but not Hausdorff.
]

#solution(users.ranolp)[
  #enum[
    For any open cover ${U_alpha}$, fix a non-empty open set $S in {U_alpha}$. \
    Due to cofinite topology, $S^C = X without S$ is finite. \
    Let's say $|S^C| = n$ and $S^C = { a_1, a_2, dots, a_(n-1), a_n }$. \
    For each $1 <= i <= n$, we pick $U_i in {U_alpha}$ containing $a_i$. \
    the set ${ S, U_1, U_2, dots, U_n }$ is finite subcover for ${ U_alpha }$. \
    We found finite subcover for all open covers. \
    Hence $X$ is quasicompact. $square$
  ][

    For any $p, q in X$ where $p != q$ and any open neighborhood of $p$ and $q$ called $U$ and $V$. \
    If $U inter V = empty$ then $V subset.eq X without U$. \
    However, due to cofinite topology, $V$ must be infinite, which cannot be a subset or equal to finite set $X without U$. \
    Thus $U inter V != empty$. \
    Hence $X$ is not Hausdorff. $square$
  ]

  == References

  #include "8.3.1.typ"
  #include "8.3.2.typ"
  #include "7.3.1.typ"
]
