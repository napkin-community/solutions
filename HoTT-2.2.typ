#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let sp = " "
#let refl = "refl"
#let ind = "ind"

#plain_box(title: [HoTT-2.2])[
  Show that the three equalities of proofs constructed in the previous exercise form a commutative triangle. In other words, if the three definitions of concatenation are denoted by $(p sp ▪_1 sp q)$, $(p sp ▪_2 sp q)$, and $(p sp ▪_3 sp q)$, then the concatenated equality
  $ (p sp ▪_1 sp q) = (p sp ▪_2 sp q) = (p sp ▪_3 sp q) $
  is equal to the equality $(p sp ▪_1 sp q)=(p sp ▪_3 sp q)$.
]

#solution(users.finalchild)[
  $ e_12 sp x sp y sp p sp z sp q : (p sp ▪_1 sp q) = (p sp ▪_2 sp q) $
  $ e_23 sp x sp y sp p sp z sp q : (p sp ▪_2 sp q) = (p sp ▪_3 sp q) $
  $ e_13 sp x sp y sp p sp z sp q : (p sp ▪_1 sp q) = (p sp ▪_3 sp q) $

  Goal: for all $x$, $y$, $p$, $z$, $q$,
  $
    (e_12 sp x sp y sp p sp z sp q) sp ▪ sp (e_23 sp x sp y sp p sp z sp q) = e_13 sp x sp y sp p sp z sp q
  $

  By induction on $p$ and $q$, the goal becomes
  $
    (e_12 sp x sp x sp refl_x sp x sp refl_x) sp ▪ sp (e_23 sp x sp x sp refl_x sp x sp refl_x) = e_13 sp x sp x sp refl_x sp x sp refl_x
  $
  which is
  $ refl_refl_x sp ▪ sp refl_refl_x = refl_refl_x $
  which is true, judgementally.


]
