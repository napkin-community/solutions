#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 64C#daggered])[
  Show that a finite CW complex is compact.
]

#solution(users.finalchild)[
  Every $k$-cell is compact.

  *Claim.* Finite disjoint union of quasicompact spaces is quasicompact.\
  Consider an open cover ${U_alpha}$ of $A union.plus B$. We denote the included indices of the finite subcovers of the projected subcovers by $Beta_A$ and $Beta_B$. There exists a finite subcover of ${U_alpha}$: ${U_alpha | alpha in Beta_A union Beta_B }$.

  *Claim.* A quotient space of a quasicompact space is quasicompact.\
  Consider an open cover ${U_alpha}$ of $X slash ~$. Then, let $V_alpha = {x | [x] in U_alpha}$, and ${V_alpha}$ is an open cover of $X$. Let $Beta$ the included indices of the finite subcover. Then ${U_alpha | alpha in Beta}$ is the finite subcover of ${U_alpha}$.

  *Claim.* CW complex is Hausdorff.\
  Use mathematical induction. Only consider the case of making $X^k$ from $X^(k-1)$\
  Each point of $X^k$ corresponds to either a point of $X^(k-1)$ (we'll call it A class) or an inner point of an $e_alpha^k$ (we'll call it B class).\
  Consider two distinct points of $X^k$, $a$ and $b$.\
  If $a in X^(k-1)$ and $b in "inner" e_alpha^k$ (or vice versa), we can take $X^(k-1)$ and $"inner" e_alpha^k$ as the disjoint neighborhoods. Similarly, it is easy to take disjoint neighborhoods if one or more of $a$ and $b$ are of class B.\
  If both $a$ and $b$ is of class A, since we assume $X^(k-1)$ is Hausdorff, we have disjoint open neighborhoods $S_a$ and $S_b$. Because the attaching map is continuous, the preimage of the equiv relation gives two distinct open neighborhoods in $X^k$.

  Thus, a finite CW complex is compact. #sym.qed
]
