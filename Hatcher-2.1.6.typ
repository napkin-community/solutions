#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.6")[
  Compute the simplicial homology groups of the $Delta$-complex obtained from $n+1$ 2-simplices $Delta_0^2, dots.h.c, Delta_n^2$ by identifying all three edges of $Delta_0^2$ to a single edge, and for $i > 0$ identifying the edges $[v_0, v_1]$ and $[v_1, v_2]$ of $Delta_i^2$ to a single edge and the edge $[v_0, v_2]$ to the edge $[v_0, v_1]$ of $Delta_(i-1)^2$.
]

#solution(users.xtalclr)[
  Call the space $X$. Call the 2-simplex generators $f_0, ..., f_n$. Call the edge $[v_0, v_1]$ of $Delta_i^2$ as $e_i$. Identifying all the edges as told, we can see that $e_0, ..., e_n$ are all the representators of the identifications done on the edges (that is, every edge is identified with exactly one of $e_0, ..., e_n$). So they form the 1-simplex generators of $X$. The space $X$ has only one 0-simplex: all points of $Delta_0^2$ are identified, then $v_0$ of $Delta_i^2$ is identified with $v_0$ of $Delta_(i-1)^2$, then $[v_0, v_1] = [v_1, v_2]$ on $Delta_i^2$.

  With all this, we now have a complete understanding of the chain maps. Under $partial$, each generator maps as follows.

  - $f_0$ maps to $e_0 - e_0 + e_0 = e_0$
  - For $i > 0$, $f_i$ maps to $[v_0, v_1] - [v_0, v_2] + [v_1, v_2] = 2e_i - e_(i-1)$.
  - All edges map to zero as we have only one point.

  Now we compute the homology.

  - $partial$ on $C_2(X)$ is injective and we have $H_2(X) = 0$.
  - The homology $H_1(X)$ is $plus.big_i ZZ e_i$ factored out by the image of $partial : C_2(X) -> C_1(X)$. This identifies $e_0 = 0$ and $2e_i = e_(i-1)$. So we have $H_1(X) tilde.equiv ZZ \/ 2^n ZZ$. See the proof below.
    - Define the map $ZZ -> H_1(X)$ by setting $z |-> z e_n$. The map is surjective: repeatedly use $e_(i-1) = 2e_i$ to push any element of $H_1(X)$ to the form $z e_n$. The kernel of the map contains $2^n$ so now we have the map $ZZ \/ 2^n ZZ -> H_1(X)$. The inverse $H_1(X) -> ZZ \/ 2^n ZZ$ is $e_i |-> 2^(n-i)$ (it is routine to check that the maps are well-defined inverse of each other; track the generators).
  - We have $H_0(X) tilde.equiv ZZ$ as $X$ is nonzero and connected. $H_n(X) = 0$ for all $n >= 3$ by dimensionality.
]
