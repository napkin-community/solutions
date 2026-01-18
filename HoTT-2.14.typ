#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let refl = math.sans("refl")

#plain_box(title: "HoTT 2.14")[
  Suppose we add to type theory the _equality reflection rule_ which says that if there is
  an element $p : x = y$, then in fact $x equiv y$. Prove that for any $p : x = x$, we have $p ≡ refl_x$. (This
  implies that every type is a set in the sense to be introduced in #{ sym.section }3.1; see #{ sym.section }7.2.)
]

#solution(users.kiwiyou)[
  We can have this strange claim under equality reflection rule:
  $
    sans("strange") : product_(x, y: A) product_(q : x = y) q attach(=, br: x = y) refl_x
  $

  Then we can prove this with path induction. We can inhabit $sans("strange")$:
  $ sans("strange")(x, x, refl_x) equiv refl_refl_x $
  $
    sans("strange") defeq sans("ind")_attach(=, br: A) (lambda x, y: A. space lambda q: x = y. space q attach(=, br: x = y) refl_x, lambda x: A. space refl_refl_x)
  $

  So finally, given $p : x = x$, we have $sans("strange")(x, x, p) : p = refl_x$, which is also, by equality reflection rule:
  $ p equiv refl_x $
  #sym.qed
]
