#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.25")[
  Find an explicit, noninductive formula for the barycentric subdivision operator $S : C_n (X) -> C_n (X)$.
]

#solution(users.kiwiyou)[
  *Theorem.*
  $
    S Delta^n = sum_(pi in "Aut"({0, 1, dots, n})) "sgn"(pi)[b^pi_0, b^pi_1, dots, b^pi_n]
  $
  where $b^pi_i$ is the barycenter of $[v_pi(i), v_pi(i+1), dots, v_pi(n)]$ and $v_i$ is the $i$-th vertex of $Delta^n$.

  _Proof._ Use induction. Let $tilde(pi) in "Aut"({0, 1, dots, n + 1} without {i})$.
  $
    S Delta^(n+1) & = sum_(i = 0)^(n+1) (-1)^i [b(Delta^n_i), S Delta^n_i] quad && ("inductive definition") \
    & = sum_(i=0)^(n+1) (-1)^i sum_tilde(pi) "sgn"(tilde(pi))[b(Delta^n_i), b^tilde(pi)_0, b^tilde(pi)_1, dots, b^tilde(pi)_n] quad && ("inductive hypothesis") \
    & = sum_pi "sgn"(pi) [b^pi_0, b^pi_1, dots, b^pi_(n+1)] && ("sign of prepend")
  $

  This explicit formula directly generalizes to general chains by the definition $S sigma = sigma_sharp S Delta^n$.
]
