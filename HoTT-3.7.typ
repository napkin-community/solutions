#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.7")[
  More generally, show that if $A$ and $B$ are mere propositions and $not(A times B)$, then
  $A + B$ is also a mere proposition.
]

#solution(users.kiwiyou)[
  #let isProp = math.sans("isProp")
  #let sumisProp = math.sans("sum-isProp")
  We need:
  $ sumisProp : isProp(A) -> isProp(B) -> not(A times B) -> isProp(A + B) $

  Let $h_A : isProp(A)$, $h_B : isProp(B)$, $h_not : not(A times B)$.
  Let $sumisProp(h_A, h_B, h_not) defeq f$.
  We define $f$ by cases on its arguments:
  $ f : product_(x, y: A + B) x = y $
  #let inl = math.sans("inl")
  #let inr = math.sans("inr")
  #let ind = math.sans("ind")
  #let ap = math.sans("ap")
  #let never = math.bold("0")
  $
    f(inl(a), inl(a')) & defeq ap_inl (h_A (a, a')) \
    f(inr(b), inr(b')) & defeq ap_inr (h_B (b, b')) \
     f(inl(a), inr(b)) & defeq ind_never (h_not (a, b)) \
     f(inr(b), inl(a)) & defeq ind_never (h_not (a, b))
  $

  #sym.qed
]
