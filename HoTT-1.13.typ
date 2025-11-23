#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let universe = math.cal("U")
#let never = math.bold("0")
#let inl = math.sans("inl")
#let inr = math.sans("inr")

#plain_box(title: "HoTT 1.13")[
  Using propositions-as-types, derive the double negation of the principle of excluded middle, i.e. prove _not (not (P or not P))_.
]

#solution(users.kiwiyou)[
  We need to find a witness of the type _not (not (P or not P))_.

  #let LEM = $sans("LEM")$

  $ not not LEM : product_(P: universe) ((P + (P -> never)) -> never) -> never $
  $
    not not LEM defeq lambda P. space (square : ((P + (P -> never)) -> never) -> never)
  $

  Our first hole must get a function of type $(P + (P -> never)) -> never$ and derive a contradiction.

  $ not not LEM defeq lambda P. space lambda f. space (square : never) $

  We must use $f$ to derive a contradiction as we cannot prove a contradiction directly.
  Note that $f$ derives a contradiction from a witness of either $P$ or $P -> never$.
  $P$ is not inhabited yet, so we can try constructing a function of type $P -> never$.

  $
    not not LEM defeq lambda P. space lambda f. space f(inr(square : P -> never))
  $

  Our hole now must receive a witness of $P$ and derive a contradiction.
  This time $f$ can receive a witness of $P$.

  $
    not not LEM defeq lambda P. space lambda f. space f(inr(lambda p. f(inl(p))))
  $

  #sym.qed
]
