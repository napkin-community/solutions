#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.20")[
  Show that $tilde(H)_n (X) ≈ tilde(H)_(n+1) (S X)$ for all $n$, where $S X$ is the suspension of $X$. More
  generally, thinking of $S X$ as the union of two cones $C X$ with their bases identified,
  compute the reduced homology groups of the union of any finite number of cones
  $C X$ with their bases identified.
]

#solution(users.kiwiyou)[
  *Theorem.* $forall n : tilde(H)_n (X) ≈ tilde(H)_(n+1) (S X)$

  _Proof._
  Let $S X$ be the union of two cone $C_1 X$ and $C_2 X$ with their bases identified.
  Let their apexes be $p_1$ and $p_2$ respectively.

  $
    tilde(H)_(n+1) (S X) & tilde.eq tilde(H)_(n+1)(S X, C_2 X) & space.quad (because "long exact sequence")\
    & tilde.eq tilde(H)_(n+1)(S X without {p_2}, C_2 X without {p_2}) & space.quad (because "excision") \
    & tilde.eq tilde(H)_(n)(C_2 X without {p_2}) & space.quad (because "long exact sequence") \
    & tilde.eq tilde(H)_(n)(X) & space.quad (because "deformation retract") & space.quad qed.
  $

  More generally, let $U_k X$ be the union of $k$ cones with their bases identified.

  *Theorem.* $forall n, k : tilde(H)_(n)(U_k X) = (tilde(H)_(n-1)(X))^(plus.circle (k-1))$

  _Proof._
  Since $U_k X slash C X tilde.eq (S X)^(or (k-1))$,
  $
    tilde(H)_(n) (U_k X) & tilde.eq tilde(H)_(n)(U_k X slash C X) & space.quad (because "long exact sequence") \
    & tilde.eq (tilde(H)_(n)(S X))^(plus.circle (k-1)) \
    & tilde.eq (tilde(H)_(n-1)(X))^(plus.circle (k-1)) && space.quad qed.
  $
]
