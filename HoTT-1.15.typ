#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let ind = $"ind"$
#let refl = $"refl"$
#let eq(content) = $attach(=, br: content)$

#plain_box(title: [HoTT-1.15])[
  Show that the indiscernibility of identicals follows from path induction.
]

#plain_box[
  #block(width: 100%)[
    *Path induction*:

    $
      ind_(=A) : product_(C:Pi_((x,y:A)) (x eq(A) y) -> cal(U)) (Pi_((x:A)) C(x, x, refl_x)) -> product_((x,y:A)) product_((p:x eq(A) y)) C(x, y, p)
    $

    with equality

    $
      ind_(=A) (C, c, x, x, refl_x) defeq c(x)
    $
  ]
  #block(width: 100%)[
    *Indiscernibility of identicals:* for every family

    $
      C: A -> cal(U)
    $

    there is a function

    $
      f : product_((x,y:A)) product_((p: x eq(A) y)) C(x) -> C(y)
    $

    such that

    $
      f(x, x, refl_x) defeq id_(C(x))
    $

  ]
]


#solution(users.ranolp)[
  #plain_box(title: [Hole Notation ($square : tau$)])[
    To show the reasoning step, we'll present a hole notation, which displays the current goal(s) typed $tau$. The hole may be untyped if it's too obvious or annoying to write explicitly. On the reasoning step, we'll replace hole(s) and may introduce new hole(s).
  ]

  The goal is to construct such $f$. Let's solve step-by-step.

  Given type family $C : A -> cal(U)$,

  #block[

    $
      f defeq & square : product_((x,y:A)) product_((p: x eq(A) y)) C(x) -> C(y) \
      equiv & ind_(=A) (square)(square) : product_((x,y:A)) product_((p: x eq(A) y)) C(x) -> C(y) \
      equiv & ind_(=A) (lambda x. lambda y. lambda p. C(x) -> C(y))(square : Pi_((x:A)) C(x) -> C(x)) \
      equiv & ind_(=A) (lambda x. lambda y. lambda p. C(x) -> C(y))(lambda x. (square : C(x) -> C(x))) \
      equiv & ind_(=A) (lambda x. lambda y. lambda p. C(x) -> C(y))(lambda x. id_(C(x))) \
    $

    Let's verify $f(x, x, refl_x) equiv id_(C(x))$.

    $
      f(x, x, refl_x) equiv & ind_(=A) (lambda x. lambda y. lambda p. C(x) -> C(y))(lambda x. id_(C(x)))(x, x, refl_x) \
      equiv & (lambda x. id_(C(x)))(x) \
      equiv & id_(C(x)) \
    $

    So, the indicernibility of identicals can be derived from the path induction. #h(1fr) $qed$
  ]
]
