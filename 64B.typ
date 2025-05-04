#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "Problem 64B")[
  Realize the following spaces as CW complexes:

  (a) Möbius strip.

  (b) $ℝ$.

  (c) $ℝ^n$.
]

#solution(users.simnalamburt)[
  (a)

  $X^0 = {e_a^0, e_b^0}$

  $X^1 = {e_c^1, e_d^1}$ where
  $∂e_c^1 = {e_a^0, e_b^0}$,
  $∂e_d^1 = {e_a^0, e_b^0}$

  $X^2 = {e_e^2}$ where
  $∂e_e^2 = {e_c^1, e_d^1}$

  (b)

  $X^0 = {..., e_(-2)^0, e_(-1)^0, e_0^0, e_1^0, e_2^0, ...}$

  $X^1 = {..., e_([-2, -1])^1, e_([-1, 0])^1, e_([0, 1])^1, e_([1, 2])^1, ...}$ where
  $∂e_([n, n+1])^1 = {e_n^0, e_(n+1)^0}$,

  (c)

  // TODO
  TBD
]
