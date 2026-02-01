#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let ind = $"ind"$
#let refl = $"refl"$
#let isSet = $"isSet"$
#let ap = $"ap"$
#let eq(content) = $attach(=, br: content)$

#plain_box(title: [HoTT-3.1])[
  Prove that if $A tilde.eq B$ and $A$ is a set, then so is $B$.
]

#solution(users.ranolp)[

  As the problem said, we have:

  - $e : A tilde.eq B$
  - $f : isSet(A)$

  And we need to check inhabitant of $g : isSet(B)$, which is by definition:

  $
    g : product_((x, y: B)) product_((p, q: x= y)) (p = q)
  $

  and we'll define this function as follows:

  Let $h = ap_(e^(-1))$

  $
    g(x,y,p,q) defeq (ap_h)^(-1)(f(e^(-1)(x), e^(-1)(y), h(p), h(q)))
  $

  by *Lemma 3.3.5.* $isSet(B)$ is mere proposition \
  and because of inhabitant of $g : isSet(B)$, \
  $isSet(B) tilde.eq bold(1)$. #h(1fr) #sym.qed
]
