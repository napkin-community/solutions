#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.11")[
  Show that it is not the case that for all $A : cal(U)$ we have $||A|| -> A$. (However, there can be particular types for which $||A|| -> A$. Exercise 3.8 implies that `qinv`($f$) is such.)
]

#let bool = $bold(2)$
#let apd = $"apd"$
#let happly = $"happly"$
#let ua = $"ua"$

#solution(users.ranolp)[
  Given $epsilon : limits(product)_(A:cal(U)) ||A|| -> A$,

  we have $apd$ as follows:
  $
    & "Given" P : A -> cal(U) "and" f : limits(product)_(x:A) P(x) \
    & apd_f : limits(product)_(p : x = y) (p_*(f(x)) = f(y))
  $

  Let's define

  $
    P(A) defeq ||A|| -> A
  $

  so we can use equality $not : bool tilde.eq bool$ to get $ua(not) : bool = bool$:

  $
    p defeq apd_epsilon (ua(not)) : ((ua(not)_*)(epsilon(bool))) = epsilon(bool)
  $

  and $happly$ on it using $star : ||bool||$

  $
    happly(p, star) : ((ua(not)_*)(epsilon(bool)(star))) = epsilon(bool)(star)
  $

  so, WLOG we can assume that $epsilon(bool)(star) = 1_bool$ so

  $
    happly(p, star) : ((ua(not)_*)(1_bool)) = 1_bool
  $

  and since $ua(not)_* = not$, we have:

  $
    happly(p, star) : not(1_bool) = 1_bool
  $

  which is contradiction.
]
