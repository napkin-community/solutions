#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 7E])[
  Let $X$ be a topological space. The _connected component_ of a point $p in X$ is the union of all subspaces $S subset.eq X$ which are connected and contain $p$.

  #enum(numbering: "(a)")[
    Does the connected component of a point have to be itself connected?
  ][
    Does the connected component of a point have to be an open subset of $X$?
  ]
]

#solution(users.finalchild)[
  #set enum(numbering: "(a)")

  1. *Yes.*

    Let $C$ be the connected component of $p$.

    Assume $C = (A inter C) union.sq (B inter C)$ where $A inter C$ and $B inter C$ are nonempty and $A$ and $B$ are open in $X$.

    Without loss of generality, assume $p in B$.

    Take some connected subspace $S subset.eq X$ such that $A inter S != nothing$.

    Then $S = (A inter S) union.sq (B inter S)$, and both $A inter S$ and $B inter S$ are nonempty and open in $S$.

    This is contradiction, so $C$ is connected. #sym.qed

  2. *No.*

    The connected components of $p in bb(Q)$ is not an open subset of $bb(Q)$. #sym.qed
]
