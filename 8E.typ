#import "template/napkin.typ": *

#plain_box(title: [Problem 8E])[
  redacted
]

Consider any sequence in $X times Y$ called $(z_n)$.

Let $(x_(i_n))$ be the converging subsequence of $(z_n)$ projected to $X$. Let $x$ be the converging value.

Let $(y_(j_n))$ be the converging subsequence of $(z_(i_n))$ projected to $Y$. Let $y$ be the converging value.

Then $forall epsilon in RR^+$,

$exists n_1 in NN. " " forall n >= n_1. " " d(x_(j_n), x) < epsilon/2$

$exists n_2 in NN. " " forall n >= n_2. " " d(y_(j_n), y) < epsilon/2$

$forall n >= max(n_1, n_2). " " d(z_(j_n), (x,y)) < epsilon$

Thus $z_(j_n) -> (x,y)$. #sym.qed
