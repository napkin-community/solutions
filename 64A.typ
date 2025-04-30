#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "Problem 64A")[
  Show that a space $X$ is Hausdorff if and only if the diagonal ${(x, x) | x in X}$ is closed in the product space $X times X$.
]

#solution(users.ranolp)[
  Let the diagonal be $D$, and let $D^C = (X times X) without D$.

  == $X$ is Hausdorff $==>$ diagonal is closed in the $X times X$


  For any $(p, q) in D^C$, we know $p != q$ so we can use Hausdorff.

  Let the open-neighborhoods of $p, q$ be $U_((p, q)), V_((p, q))$ where $U_((p, q)) inter V_((p, q)) = emptyset$.

  #grid(columns: 2, column-gutter: 0.75em, row-gutter: 1em)[
    *Claim.*
  ][
    $D_C = limits(union.big)_((p,q) in D^C) U_((p, q)) times V_((p, q))$
  ][
    *Proof.*
  ][
    Since $U_((p, q)) inter V_((p, q)) = emptyset$, There is no $z$ such that $(z, z) in U_((p, q)) times V_((p, q))$.

    In other words, it doesn't contain any elements from $D$.

    Also, we know $(p, q) in U_((p, q)) times V_((p, q))$, the union must contain every $(p, q) in D^C$.

    So the union is exactly $D^C$. $square$
  ]

  By *Definition 64.3.1*, $U_((p, q)) times V_((p, q))$ is open in $X times X$.

  Also (possibly infinitely many) open sets' union is open.

  Hence $D^C$ is open and $D$ is closed. $square$

  == $X$ is Hausdorff $<==$ diagonal is closed in the $X times X$

  For any $(x, y) in D^C$ there exists an open-neighborhood for $(x, y)$ called $U times V$.

  #grid(columns: 2, column-gutter: 0.75em, row-gutter: 1em)[
    *Claim.*
  ][
    $U inter V = emptyset$
  ][
    *Proof.*
  ][
    Proof by contradiction.

    Suppose $U inter V != nothing$, we can pick an element $z in U inter V$.

    In other words, $(z, z) in U times V subset.eq D^C$.

    Contradiction. $square$
  ]

  For any $x != y$, We found disjoint open-neighborhoods for them.

  Hence $X$ is Hausdorff. $square$

  == Referneces


  #plain_box(title: "Definition 64.3.1")[
    Given topological spaces $X$ and $Y$, the #glossary[product topology] on $X times Y$ is the space whose

    - Points are pairs $(x, y)$ with $x in X, y in Y$, and
    - Topology is given as follows: the _basis_ of the topology for $X times Y$ is $U times V$, for $U subset.eq X$ open and $V subset.eq Y$ open.
  ]

]
