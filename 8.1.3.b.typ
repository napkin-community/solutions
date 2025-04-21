#import "template/napkin.typ": *

#brown_box(subtitle: [Non-examples of compact metric spaces])[Example 8.1.3][
  (b) More generally, if a space is not bounded it cannot be compact. (You can prove this if you want.)
]

Let $X$ be an unbounded metric space. Suppose $X$ is compact.

There exists a sequence ${x_n}$ such that $d(x_n, x_1) > n - 1$. (unbounded)

For all $epsilon > 0$, $n >= epsilon + 1 => epsilon < d(x_1, x_n) <= d(x_1, x) + d(x, x_n)$.

Since $d(x, x_n) >= d(x_1, x_n) - d(x_1, x) > epsilon$, ${x_n}$ does not converge to $x$.

For all subsequence ${x_(gamma_n)}$, $d(x_1, x_(gamma_n)) > n - 1$, so ${x_(gamma_n)}$ does not converge to $x$.

This is contradiction, so $X$ is not compact.

#qed
