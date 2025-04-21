#import "template/napkin.typ": *

#black_note[Question 8.4.3][
  Give another proof using sequential definitions of continuity and compactness. (This is even easier.)
]

#blue_box(subtitle: [Sequential continuity])[Theorem 2.3.3][
  A function $f: M arrow.r N$ of metric spaces is continuous at a point $p in M$ if and only if the following property holds: if $x_1, x_2, ...$ is a sequence in $M$ converging to $p$, then the sequence $f (x_1), f (x_2), ...$ in $N$ converges to $f(p)$.
]

For all sequence ${y_n}$ in $Y$, $x_n = f^("pre")(y_n)$ is a sequence in $X$.

Since $X$ is compact, there exists a convergent subsequence ${x_(gamma_k)}$ in $X$.

#plain_box(title: [Definition 8.1.2])[
  A metric space $M$ is sequentially compact if every sequence has a subsequence which converges.
]

Since $f$ is continuous, $f^("img")(x_(gamma_k)) = y_(gamma_k)$ is a convergent subsequence in $Y$.

Therefore, $f^("img")(X)$ is compact.

#qed
