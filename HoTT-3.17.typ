#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.17")[
  Show that the rules for the propositional truncation given in §3.7 are sufficient to
  imply the following induction principle: for any type family $B : ‖A‖ → 𝒰$ such that each $B(x)$
  is a mere proposition, if for every $a : A$ we have $B(|a|)$, then for every $x : ‖A‖$ we have $B(x)$.
]

#solution(users.finalchild)[
  We are given $h: Π_(a:A) B(|a|)$.

  Let $h' defeq (a:A)↦(|a|, h(a)) : A→Σ_(y:‖A‖) B(y)$. Note that $Σ_(y:‖A‖) B(y)$ is a mere proposition.

  Given $x:‖A‖$, by the recursion principle on $x:‖A‖$ with $h'$, $Σ_(y:‖A‖) B(y)$. Destruct it to $(y, i)$.

  Since $x=y$, transport $i$ to prove $B(x)$.
]
