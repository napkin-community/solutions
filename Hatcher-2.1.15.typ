#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.15")[
  For an exact sequence $A → B → C → D → E$ show that $C = 0$ iff the map $A → B$ is surjective and $D → E$ is injective. Hence for a pair of spaces $(X, A)$, the inclusion $A ↪ X$ induces isomorphisms on all homology groups iff $H_n (X, A) = 0$ for all $n$.
]

#solution(users.finalchild)[
  #enum(numbering: "(a)")[
    For an exact sequence $A → B → C → D → E$ show that $C = 0$ iff the map $A → B$ is surjective and $D → E$ is injective.

    #sym.arrow.double)\
    $"img" (A->B) = "ker" (B->C) = 0$\
    $"ker" (D->E)= "img" (C->D) = 0$

    #sym.arrow.double.l)\
    $"ker" (C->D) = "img" (B->C) = B slash "ker" (B->C) = B slash "img" (A->B) = 0$\
    $"img" (C->D) = "ker" (D->E) = 0$\
    Thus $C = 0$
  ][
    For a pair of spaces $(X, A)$, the inclusion $A ↪ X$ induces isomorphisms on all homology groups iff $H_n (X, A) = 0$ for all $n$.

    #sym.arrow.double)\
    Consider the exact sequence $dots -> H_(n+1) (A) -> H_(n+1) (X) -> H_(n+1) (X,A) -> H_n (A) -> H_n (X) -> dots$\
    Since $H_n (A) -> H_n (X)$ is surjective and injective for all $n$, it follows from (a) that $H_n (X,A) = 0$ for all $n$.

    #sym.arrow.double.l)\
    Consider the exact sequence $dots -> H_(n+1) (A) -> H_(n+1) (X) -> H_(n+1) (X,A) -> H_n (A) -> H_n (X) -> dots$\
    Since for all $n$, $H_n (X,A)=0$, it follows from (a) that for all $n$, $H_n (A) -> H_n (X)$ is surjective and injective, thus an isomorphism.
  ]
]
