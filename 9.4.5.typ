#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#blue_box(subtitle: [Maximality and minimality of bases])[Theorem 9.4.5][
  Let $V$ be a vector space over some field $k$ and take $e_1, ..., e_n in V$. The following are equivalent:
  #set enum(numbering: "(a)")

  1. The $e_i$ form a basis.

  2. The $e_i$ are spanning, but no proper subset is spanning.

  3. The $e_i$ are linearly independent, but adding any other element of $V$ makes them not linearly independent.
]

#solution(users.kiwiyou)[
  #set enum(numbering: "(1)")

  === (a) $==>$ (b)

  By definition of a basis, for all $v in V$, $v = sum_(i=1)^n a_i dot e_i$ for unique $a_i in k$.
  It is clear that ${e_i}$ is spanning.

  Suppose that $S = {e_i}_(i=1)^m$ is spanning for some $m < n$.

  Since $S$ is spanning, there exists $b_i$ such that $e_n = sum_(i=1)^m b_i dot e_i$.

  $e_n$ has two different representations, which is a contradiction.

  Therefore, ${e_i}$ is spanning, but no proper subset is spanning. #h(1fr) #sym.qed

  === (a) $==>$ (c)

  It is clear that ${e_i}$ is linearly independent. Also, every nonzero vector $v in V$ has a unique representation with at least one nonzero coefficient.

  Let $v = sum_(i=1)^n a_i dot e_i$ be the representation of $v$ in ${e_i}$.

  Since $0 = (-1)v_i + sum_(i=1)^n a_i dot e_i$, ${e_i} union {v}$ is not linearly independent. #h(1fr) #sym.qed

  === (b) $==>$ (a)

  Suppose that there exists a vector $v_0 in V$ with two different representations.
  In other words, there exists $a_i, b_i$ such that $v_0 = sum_(i=1)^n a_i dot e_i = sum_(i=1)^n b_i dot e_i$ for some $a_i, b_i in k$ and, without loss of generality, $a_n != b_n$.

  For all $v in V$, let $v = sum_(i=1)^n c_i dot e_i$ be the representation of $v$ in $S$. Then we have:

  $
    v = v + 0 = sum_(i=1)^n c_i dot e_i + (c_n) / (a_n - b_n) sum_(i=1)^n (a_i - b_i) dot e_i = sum_(i=1)^n (c_i + (c_n) / (a_n - b_n) (a_i - b_i)) dot e_i
  $

  Since the coefficient of $e_n$ is always $0$, ${e_i}_(i=1)^(n-1)$ is spanning. This is a contradiction.

  Therefore all vectors have unique representations in $S$. #h(1fr) #sym.qed

  === Bonus: (c) $==>$ (a)

  For all $v in V without {e_i}$, ${e_i} union {v}$ is not linear independent, which means
  there exists $c != 0$ and $a_i$ such that $0 = c dot v + sum_(i=1)^n a_i dot e_i$.

  Then every vector has its representation:

  $ v = sum_(i=1)^n -a_i / c dot e_i $

  If $v$ has two different representations, then $0 = v - v$ has two different representations, which is a contradiction.

  Therefore, every vector has a unique representation. #h(1fr) #sym.qed
]

#green_box[
  Notice the use of division in the proofs (b) $==>$ (a) and (c) $==>$ (a).
  This shows why we need the field instead of a commutative ring.
]
