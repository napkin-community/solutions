#import "template/napkin.typ": *

#plain_box(title: [Problem 8I])[
  In this problem a "circle" refers to the boundary of a disk with _nonzero_ radius.

  (a) Is it possible to partition the plane $RR^2$ into disjoint circles?

  (b) From the plane $RR^2$ we delete two distinct points $p$ and $q$.
  Is it possible to partition the remaining points into disjoint circles?
]

*Lemma.*
Suppose an open disk $D subset.eq RR^2$ is partitioned into disjoint circles.
That is, $D = union.plus.big_(C in cal(C)) C$ where $cal(C)$ is a family of circles in $D$.
Then there is a sequence of circles ${C_n in cal(C)}$ with radius $r_n$ such that $r_n <= (1 / 2)^n r_0$.

_Proof._
Let $C_0 in cal(C)$ be a circle whose radius is $r_0$.
By using the axiom of countable choice, it is enough to show that for all $n in NN$, there is a circle $C in cal(C)$ with radius $r$ such that $r <= (1 / 2)^n r_0$. We will prove this by induction on $n$.
- *Case:* n = 0. $C_0$ satisfies $r_0 <= (1 / 2)^0 r_0$.
- *Case:* n = k + 1. Suppose there is $C in cal(C)$ such that $r <= (1 / 2)^k r_0$ by induction hypothesis. Then there is a circle $C' in cal(C)$ containing the center of $C$. Let $r'$ be the radius of $C'$. Since $C'$ must be contained in the inside of $C$, $2r' < r$. Thus $r' <= (1 / 2)^(k+1) r_0$. #sym.qed

(a) No.

Suppose $RR^2 = union.plus.big_(C in cal(C)) C$ where $cal(C)$ is a family of circles in $RR^2$.
Choose a circle $C in cal(C)$ and let $D$ be the inside of $C$. Then $D = union.plus.big_(C in cal(C)_D) C$ where $cal(C)_D = { C in cal(C) | C subset.eq D }$.
From the above lemma, there is a sequence of circles ${C_n in cal(C)_D}$ with radius $r_n$ and center $O_n$ such that $r_n <= (1 / 2)^n r_0$.
Then $O_n$ is a cauchy sequence in $RR^2$: Let $epsilon > 0$.
We can choose $N$ such that $(1 / 2)^(N-1) r_0 < epsilon$.
Then for every $m,n >= N$, $|O_m - O_n| < 2r_N <= (1 / 2)^(N-1) r_0 < epsilon$ since $O_m, O_n$ are contained in the inside of $C_N$.
Thus $O_n -> O$ for some $O in RR^2$. $O$ is contained in the inside of $C_n$ for all $n$.
Let $C in cal(C)$ be the circle containing $O$ and $r$ be the radius of $C$.
Then $C$ must be contained in the inside of $C_n$ for all $n in N$, implies that $r < r_n <= (1 / 2)^n r_0$ for all $n$.
But this is a contradiction since the radius of a circle must be positive. #sym.qed

(b) No.

Suppose $RR^2 without {p,q} = union.plus.big_(C in cal(C)) C$ where $cal(C)$ is a family of circles in $RR^2$.
Let $cal(P)$ and $cal(Q)$ be the subset of $cal(C)$ such that each circle in $cal(P)$ and $cal(Q)$ contains $p$ and $q$ in its inside, respectively.
We can calssify circles in $cal(C)$ into one of $cal(P) inter cal(Q)^complement$, $cal(P)^complement inter cal(Q)$, $cal(P) inter cal(Q)$, and $cal(P)^complement inter cal(Q)^complement$, but $cal(P)^complement inter cal(Q)^complement$ must be empty by the same argument of (a).
Consider a strict partial order $subset.sq$ on $cal(C)$ such that $C_1 subset.sq C_2$ if and only if $C_1$ is contained in the interior of $C_2$.
$cal(P) inter cal(Q)^complement$, $cal(P)^complement inter cal(Q)$, and $cal(P) inter cal(Q)$ are totally ordered by $subset.sq$.
Let $P, Q, R$ be propositions such that
$
  &P &&: cal(P) &&inter cal(Q)^complement &&"is nonempty and has no maximum under" subset.sq \
  &Q &&: cal(P)^complement &&inter cal(Q) &&"is nonempty and has no maximum under" subset.sq \
  &R &&: cal(P) &&inter cal(Q) &&"is nonempty and has no minimum under" subset.sq
$
Let $L$ be the straight line in $RR^2$ containing $p$ and $q$.
$L without {p,q}$ has three connected componenet, namely $L_p, L_(p q), L_q$
where $L_p$ and $L_q$ are half-line starting from $p$ and $q$, respectively,
and $L_(p q)$ is the line segment between $p$ and $q$.

We claim following.
+ $P <-> not Q$. $L_(p q) = X union.plus Y$ where $X = L_(p q) inter union.big (cal(P) inter cal(Q)^complement)$ and $Y = L_(p q) inter union.big (cal(P)^complement inter cal(Q))$. \
  Then $P <-> X "open" <-> Y "closed" <-> not Q$.
+ $P <-> not R$. $L_p = X union.plus Y$ where $X = L_p inter union.big (cal(P) inter cal(Q)^complement)$ and $Y = L_p inter union.big (cal(P) inter cal(Q))$. \
  Then $P <-> X "open" <-> Y "closed" <-> not R$.
+ $Q <-> not R$. $L_q = X union.plus Y$ where $X = L_q inter union.big (cal(P)^complement inter cal(Q))$ and $Y = L_q inter union.big (cal(P) inter cal(Q))$. \
  Then $Q <-> X "open" <-> Y "closed" <-> not R$.

Hence $P <-> not Q <-> R <-> not P$, but this is contradiction. #sym.qed
