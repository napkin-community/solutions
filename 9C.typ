#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set math.mat(delim: "[")

#plain_box(title: [Problem 9C])[
  #set math.mat(row-gap: 0pt, column-gap: 4pt)
  Let's say a _magic square_ is a $3 times 3$ matrix of real numbers where the sum of all diagonals, columns, and rows is equal, such as #box(baseline: 35%)[#scale(80%, reflow: true)[$mat(8, 1, 6; 3, 5, 7; 4, 9, 2)$]]. Find the dimension of the set of margin squares, as a real vector space under addition.
]

#solution(users.ranolp)[
  #blue_box("Theorem 9.7.7", subtitle: "Rank-nullity theorem")[
    Let $V$ and $W$ be finite-dimensional vector spaces. If $T : V -> W$, then

    $
      dim V = dim ker T + dim im T
    $
  ]

  Let's say the vector space as $V$, consider following linear map

  $T = mat(a_(i j)) |-> a_(0 0) + a_(0 1) + a_(0 2) : V -> RR$

  Since we know it's $V$ is finite-dimensional because $V subset.eq RR^9$, we can apply rank-nullity theorem.

  $dim V = dim ker T + + dim im T = dim ker T + dim RR = dim ker T + 1$

  Now we need to find dimension of $ker T$, which is the dimension of _magic square_ with sum 0.
  Consider another linear map $Q$

  $Q = mat(a_(i j)) |-> a_(0 0) : V -> RR$

  $dim ker T = dim ker Q + dim im Q = dim ker Q + dim RR = dim ker Q + 1$

  And then we have following matrix.

  $
    mat(0, x, -x; y, z, -y-z; -y, -x-z, x+y+z)
  $

  Since we know $0 + z + (x + y + z) = 0$, $x = -y -2z$. Substitute $x$ and simplify.

  $
    mat(0, -y-2z, y+2z; y, z, -y-z; -y, y+z, -z)
  $

  Since we know $(-y) + z + (y + 2z) = 0$, $3z = 0$, Substitute $z$ and simplify.

  $
    mat(0, -y, y; y, 0, -y; -y, y, 0)
  $

  Use rank-nulllity theorem again! Now consider following linear map

  $R : mat(a_(i j)) |-> a_(0 2) : ker Q -> RR$

  $dim ker Q = dim ker R + dim im R = dim ker R + dim RR = dim ker R + 1$.

  $y = 0$ for $ker R$. So $ker R = {mat(0, 0, 0; 0, 0, 0; 0, 0, 0)}$, which is zero-dimensional.

  Thus, $dim V = dim ker R + dim im R + dim im Q + dim im T = 0 + 1 + 1 + 1 = 3$.
]
