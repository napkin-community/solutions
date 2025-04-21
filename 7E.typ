#import "template/napkin.typ": *

#plain_box(title: [Problem 7E])[
  Let $X$ be a topological space. The _connected component_ of a point $p in X$ is the union of all subspaces $S subset.eq X$ which are connected and contain $p$.

  (a) Does the connected component of a point have to be itself connected?

  (b) Does the connected component of a point have to be an open subset of $X$?
]

(a) Yes.

Let $C$ be the connected component of $p$.

Assume $C = (A sect C) union.sq (B sect C)$ where $A sect C$ and $B sect C$ are nonempty and $A$ and $B$ are open in $X$.

Without loss of generality, assume $p in B$.

Take some connected subspace $S subset.eq X$ such that $A sect S != nothing$.

Then $S = (A sect S) union.sq (B sect S)$, and both $A sect S$ and $B sect S$ are nonempty and open in $S$.

This is contradiction, so $C$ is connected.

(b) No.

The connected components of $p in bb(Q)$ is not an open subset of $bb(Q)$.

#qed
