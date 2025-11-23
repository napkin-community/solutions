#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let universe = $cal("U")$
#let contradiction = $bold("0")$
#let tnot(expr) = $#expr -> contradiction$
#let inl = $sans("inl")$
#let inr = $sans("inr")$

#plain_box(title: "HoTT 1.13")[
  Using propositions-as-types, derive the double negation of the principle of excluded middle, i.e. prove _not (not (P or not P))_.
]

#solution(users.kiwiyou)[
  We need to find a witness of the type _not (not (P or not P))_.

  #let DNLEM = $sans("DNLEM")$

  $ DNLEM : product_(P: universe) tnot((tnot((P + (tnot(P)))))) $
  $ DNLEM defeq lambda P. square : tnot((tnot((P + (tnot(P)))))) $

  Our first hole must get a function of type $tnot((P + (tnot(P))))$ and derive a contradiction.

  $ DNLEM defeq lambda P. lambda f. square : contradiction $

  We must use $f$ to derive a contradiction as we cannot prove a contradiction directly.
  Note that $f$ derives a contradiction from a witness of either $P$ or $tnot(P)$.
  $P$ is not inhabited yet, so we can try constructing a function of type $tnot(P)$.

  $ DNLEM defeq lambda P. lambda f. f(inr(square : tnot(P))) $

  Our hole now must receive a witness of $P$ and derive a contradiction.
  This time $f$ can receive a witness of $P$.

  $ DNLEM defeq lambda P. lambda f. f(inr(lambda p. f(inl(p)))) $

  #sym.qed
]
