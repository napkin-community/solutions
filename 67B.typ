#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 67B#daggered])[
  What is the coproduct $X + Y$ in the categories $sans("Set")$, $sans("Vect")_k$, and a poset?
]

#solution(users.kiwiyou)[
  == Coproduct in $sans("Set")$

  Define the coproduct as
  $
    X + Y = X product.co Y \
    iota_X (x) = (x, 0) \
    iota_Y (y) = (y, 1)
  $

  Then for any object $A$ with morphisms $g: X -> A$ and $h: Y -> A$,
  $f: X + Y -> A$ must satisfy
  $
    (f compose iota_X) (x) = f((x, 0)) = g(x) \
    (f compose iota_Y) (y) = f((y, 1)) = h(y)
  $

  This uniquely determines $f$ for all $(x, y) in X + Y$. #h(1fr) #sym.qed

  == Coproduct in $sans("Vect")_k$

  Define the coproduct as
  $
    X + Y = { (bold("x"), bold("y")) | bold("x") in X, bold("y") in Y } \
    k(bold("x"), bold("y")) = (k bold("x"), k bold("y")) \
    (bold("x")_1, bold("y")_1) + (bold("x")_2, bold("y")_2) = (bold("x")_1 + bold("x")_2, bold("y")_1 + bold("y")_2) \
    iota_X (bold("x")) = (bold("x"), bold("0")_Y) \
    iota_Y (bold("y")) = (bold("0")_X, bold("y"))
  $

  Then for any object $A$ with morphisms $g: X -> A$ and $h: Y -> A$,
  $f: X + Y -> A$ must satisfy
  $
    (f compose iota_X) (bold("x")) = f((bold("x"), bold("0")_Y)) = g(bold("x")) \
    (f compose iota_Y) (bold("y")) = f((bold("0")_X, bold("y"))) = h(bold("y"))
  $

  Since $f((bold("x"), bold("y")) = f(bold("x"), bold("0")_Y) + f((bold("0")_X, bold("y"))) = g(bold("x")) + h(bold("y"))$,
  this uniquely determines $f$ for all $(bold("x"), bold("y")) in X + Y$. #h(1fr) #sym.qed

  == Coproduct in a poset

  Define the coproduct as
  $
    X + Y = X or Y
  $
  if it exists.

  Then for any object $A$, $X <= A and Y <= A ==> X + Y <= A$. #h(1fr) #sym.qed
]
