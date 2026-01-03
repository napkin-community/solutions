#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let pr1 = $"pr"_1$
#let pr2 = $"pr"_2$
#let inl = $"inl"$
#let inr = $"inr"$
#let ap = $"ap"$
#let refl = $"refl"$
#let eq(content) = $attach(=, br: content)$

#plain_box(title: [HoTT-2.8])[
  State and prove an analogue of Theorem 2.6.5 for coproducts
]

#blue_box[Quotation of #(sym.section)2.6][
  $
    "pair"^= : (pr1 (x) = pr1 (y)) times (pr2 (x) = pr2 (y)) -> (x = y)
  $

  #sym.dots.c

  Finally, we consider the functoriality of `ap` under cartesian products. Suppose given types $A, B, A^prime, B^prime$ and functions $g : A -> A^prime$ and $h : B -> B^prime$; then we can define a function $f : A times B -> A^prime times B^prime$ by $f(x) defeq (g (pr1 x), h(pr2 x))$.

  #plain_box(title: [Theorem 2.6.5])[
    _In the above situation, given $x, y : A times B$ and $p : "pr"_1 x = "pr"_1 y$ and $q : "pr"_2 x = "pr"_2 y$, we have_

    $
      f("pair"^=(p, q)) eq(f(x)=f(y)) "pair"^=(g(p), h(q)))
    $
  ]

]

#solution(users.ranolp)[
  The core property of the theorem above is followings are same:
  - apply($A -> A^prime "and" B -> B^prime$) then compose($A^prime "and" B^prime -> A^prime times B^prime$)
  - compose($A "and" B -> A times B$) then apply($A times B -> A^prime times B^prime$).

  Thus, the analogue for coproducts is followings are same:

  - apply($A -> A^prime "or" B -> B^prime$) then compose($A^prime "or" B^prime -> A^prime + B^prime$)
  - compose($A "or" B -> A + B$) then apply($A + B -> A^prime + B^prime$).

  #line(length: 100%)

  Suppose given types $A, B, A^prime, B^prime$ and functions $g : A -> A^prime$ and $h : B -> B^prime$ then we can define a function $f : A + B -> A^prime + B^prime$ by case analysis:

  $
    f(inl(a)) defeq inl(g(a)) \
    f(inr(b)) defeq inr(h(b))
  $

  _In above situation_

  #enum[
    Given $a, a^prime : A$ and $p : a = a^prime$, we have
    $
      ap_f (ap_inl (p)) = ap_inl (ap_g (p))
    $

    Proof. by path induction on $p$,

    $
      ap_f (ap_inl (refl_a)) & = ap_inl (ap_g (refl_a)) \
        ap_f (refl_(inl(a))) & = ap_inl (refl_(g(a))) \
            refl_(inl(g(a))) & = refl_(inl(g(a))) \
    $
  ][
    Given $b, b^prime : B$ and $p : b = b^prime$, we have
    $
      ap_f (ap_inr (p)) = ap_inr (ap_h (p))
    $

    Proof. by path induction on $p$,

    $
      ap_f (ap_inr (refl_b)) & = ap_inr (ap_h (refl_b)) \
        ap_f (refl_(inr(b))) & = ap_inr (refl_(h(b))) \
            refl_(inr(h(b))) & = refl_(inr(h(b))) \
    $
  ]
]
