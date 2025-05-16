#import "template/napkin.typ": *

#plain_box(title: [Exercise 66.1.3 (On requiring surjectivity of $p$)])[
  Let $p : E -> B$ be satisfying this definition, except that $p$ need not be surjective.
  If $B$ is connected and $E$ is nonempty, then $p$ is surjective.
]

_Proof._
Let $p : E -> B$ be a continuous map such that every point $b in B$ has an open neighborhood $U$ of $b$ which is evenly covered by $p$.
We claim that $p(E)$ and $B without p(E)$ are both open.
- Let $x in p(E)$. Then there is an open neighborhood $U$ of $x$ which is evenly covered by $p$. That is,
  $
    p^(-1)(U) = union.plus.big_(alpha in I) V_alpha "for some" (V_alpha)_(alpha in I) \
    p|_(V_alpha) : V_alpha -> U "is a homeomorphism for all" alpha in I
  $
  Since $x in p(E)$, there is $y in p^(-1)(x) subset.eq p^(-1)(U)$, which implies that there is $alpha_0 in I$ such that $y in V_(alpha_0)$.
  Then $p|_(V_(alpha_0)) : V_(alpha_0) -> U$ is a homeomorphism. Then $U = p(V_(alpha_0)) subset.eq p(E)$. Thus $p(E)$ is open.
- Let $y in B without p(E)$. Then there is an open neighborhood $U$ of $y$ which is evenly covered by $p$.
  Suppose $x in p(E)$ for some $x in U$. Then $U subset.eq p(E)$ by the same argument of the above.
  But then $y in U subset.eq p(E)$, hence contradiction.
  Thus $x in.not p(E)$ for all $x in U$. That is, $U subset.eq B without p(E)$.
  Thus $B without p(E)$ is open.
Now suppose that $B$ is connected and $E$ is nonempty. Then $p(E)$ is nonempty.
If $B without p(E)$ is also nonempty, $p(E)$ and $B without p(E)$ separates $B$ into two disjoint nonempty open sets, which is contradiction.
Hence $B without p(E)$ must be empty. i.e. $p$ is surjective.
