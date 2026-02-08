#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let sp = " "
#let refl = "refl"
#let pr = "pr"
#let ap = "ap"
#let comm = "comm"
#let isProp = "isProp"
#let isContr = "isContr"

#plain_box(title: [HoTT-3.5])[
  Show that $isProp(A) ≃ (A → isContr(A))$.
]

#solution(users.finalchild)[
  $ f :equiv (H: isProp A) mapsto (a: A) mapsto (a, (b: A) mapsto H a b) $
  $
    g :equiv (H: A -> isContr A) mapsto (a: A) mapsto (b: A) mapsto (pr_2 (H a) a)^(-1) ▪ (pr_2 (H a) b)
  $

  Prove that $g$ is a quasi-inverse of $f$.

  Since $isProp A$ is a mere proposition, by function extensionality,
  $ g circle.small f = id_(isProp A) $
  Since $isContr A$ is a mere proposition, by function extensionality,
  $ f circle.small g = id_(A -> isContr A) $
]
