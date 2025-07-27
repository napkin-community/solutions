#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.4")[
  Compute the simplicial homology groups of the triangular parachute obtained from $Delta^2$ by identifying its three vertices to a single point.
]

#solution(users.finalchild)[
  The complex has one 0-simplex.
  $ H^Delta_0 (X) = ZZ $
  The complex has three 1-simplex, which is all a cycle, where $a+b+c$ forms a boundary.
  $ H^Delta_1 (X) = ZZ^2 $
  The complex has one 2-simplex, which is not a cycle.
  $ H^Delta_2 (X) = 0 $
  The complex has no $n$-simplex where $n>=3$.
  $ H^Delta_n (X) = 0 " " (n>=3) $
]
