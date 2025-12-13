#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let sp = " "
#let refl = "refl"

#plain_box(title: [HoTT-2.6])[
  Prove that if $p : x = y$, then the function $(p sp ▪ sp –) : (y=z) -> (x=z)$ is an equivalence.
]


#solution(users.finalchild)[
  We have a quasi-inverse given by $(r: x=z) ↦ p^(-1) sp ▪ sp r$.\
  We prove the properties needed:

  $
    ((r: x=z) ↦ p^(-1) sp ▪ sp r)∘((q:y=z) ↦ p sp ▪ sp q)\
    ≡ ((q:y=z) ↦ p^(-1) sp ▪ sp (p sp ▪ sp q))\
    ~ id_(y=z)
  $

  $
    ((q:y=z) ↦ p sp ▪ sp q)∘((r: x=z) ↦ p^(-1) sp ▪ sp r)\
    ≡ ((r:x=z) ↦ p sp ▪ sp (p^(-1) sp ▪ sp r))\
    ~ id_(x=z)
  $
]
