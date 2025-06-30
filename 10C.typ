#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set math.mat(delim: "[")

#plain_box(title: [Problem 10C], subtitle: [Switccharoo])[
  Let $V$ be the $CC$-vector space with basis $e_1$ and $e_2$. The map $T : V -> V$ sends $T(e_1) = e_2$ and $T(e_2) = e_1$. Determine the eigenspaces of $T$.
]

#solution(users.ranolp)[
  $forall v in V$, $v$ can be expressed as $a e_1 + b e_2$.

  $
    T(v) & = T(a e_1 + b e_2)    \
         & = a T(e_1) + b T(e_2) \
         & = a e_2 + b e_1
  $

  If $v$ is an eigenvector of $T$, $exists lambda quad lambda (a e_1 + b e_2) = lambda v = T(v) = a e_2 + b e_1$

  Multiplication is distributive, so $lambda a e_1 + lambda b e_2 = a e_2 + b e_1$.

  Since they're basis, they're linear independent, so $lambda a = b$ and $lambda b = a$.

  Thus,  we get $lambda^2 b = b$ and $lambda^2 a = a$. Since it's eigenvector, $a$ and $b$ cannot be both zero.

  Thus if $a != 0$, $lambda^2 a / a = a /a$, so $lambda = plus.minus 1$

  Otherwise $b != 0$, $lambda^2 b / b = b / b$, so $lambda = plus.minus 1$

  The eigenvalue is determined. Let's find eigenspaces.

  #list[
    *For $1$-eigenspace*

    $a e_1 + b e_2 = a e_2 + b e_1$, in other words $a (e_1 + e_2)$ (where $a != 0 in CC$).

    The space is spanned by $e_1 + e_2$
  ][
    *For $-1$-eigenspace*

    $-(a e_1 + b e_2) = a e_2 + b e_1$, in other words $a (e_1 - e_2)$ (where $a != 0 in CC$).

    The space is spanned by $e_1 - e_2$.
  ]
]
