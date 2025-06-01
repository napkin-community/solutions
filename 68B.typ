#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 68B])[
  Let $cal(A)$ be the category of finite sets whose arrows are bijections between sets.
  For $A in cal(A)$,
  let $F(A)$ be the set of _permutations_ of $A$ and
  let $G(A)$ be the set of _orderings_ on $A$.#footnote[A permutation
    is a bijection $A -> A$, and an ordering is a bijection ${1, dots, n} -> A$,
    where $n$ is the size of $A$.]
  #set enum(numbering: "(a)")
  + Extend $F$ and $G$ to functors $cal(A) -> "Set"$.
  + Show that $F(A) tilde.equiv G(A)$ for every $A$, but this isomorphism is _not_ natural.
]

#solution(users.finalchild)[
  #set enum(numbering: "(a)")
  #enum.item[
    $F$ and $G$ act on arrows as follows:

    $F(f) = p mapsto f compose p compose f^(-1)$

    $G(f) = o mapsto f compose o$
  ]
  #enum.item[
    $|F(A)|=|G(A)|$, hence $F(A) tilde.equiv G(A)$.

    Consider $A={0, 1}$, and an arrow $f : A -> A = x mapsto 1 - x$. Let $alpha_A$ be an isomorphism from $F(A)$ to $G(A)$.\
    Since conjugation has no effect on permutations on two-element set, $alpha_A compose F(f)=alpha_A$. On the other hand, $G(f) compose alpha_A = "reverse" compose alpha_A$. The two cannot be equal, thus this isomorphism is not natural.
  ]
]
