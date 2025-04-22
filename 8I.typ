#import "template/napkin.typ": *

#plain_box(title: [Problem 8I])[
  In this problem a "circle" refers to the boundary of a disk with _nonzero_ radius.

  (a) Is it possible to partition the plane $RR^2$ into disjoint circles?

  (b) From the plane $RR^2$ we delete two distinct points $p$ and $q$.
      Is it possible to partition the remaining points into disjoint circles?
]

(a) No.

Suppose $RR^2 = union.plus.big_(C in cal(C)) C$ where $cal(C)$ is a family of circles in $RR^2$.

*Claim.*
  Let $C_0 in cal(C)$ be a circle whose radius is $r_0$.
  Then for all $n in NN$, there is a circle $C in cal(C)$ with radius $r$ such that $r <= (1/2)^n r_0$.

_Proof._ Use induction on $n$.
- *Case:* n = 0.
  $C_0$ satisfies $r_0 <= (1/2)^0 r_0$.
- *Case:* n = k + 1.
  Suppose there is $C in cal(C)$ such that $r <= (1/2)^k r_0$ by induction hypothesis.
  Then there is a circle $C' in cal(C)$ containing the center of $C$. Let $r'$ be the radius of $C'$.
  Since $C'$ must be contained in the inside of $C$, $2r' < r$. Thus $r' <= (1/2)^(k+1) r_0$.

From the claim we proved above, we can choose a sequence of circles ${C_n in cal(C)}$ with radius $r_n$ and center $O_n$ such that $r_n <= (1/2)^n r_0$ by the axiom of countable choice.
Then $O_n$ is a cauchy sequence: Let $epsilon > 0$.
We can choose $N$ such that $(1/2)^(N-1) r_0 < epsilon$.
Then for every $m,n >= N$, $|O_m - O_n| < 2r_N <= (1/2)^(N-1) r_0 < epsilon$ since $O_m, O_n$ are contained in the inside of $C_N$.
Thus $O_n -> O$ for some $O$. Let $C in cal(C)$ be the circle containing $O$ and $r$ be the radius of $C$.
Then $C$ must be contained in the inside of $C_n$ for all $n in N$, implies that $r < r_n <= (1/2)^n r_0$ for all $n$.
But this is a contradiction since the radius of a circle must be positive. #sym.qed
