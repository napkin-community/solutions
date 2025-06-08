#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [#respect[Le14] 5.2.25])[
  A map $m: A -> B$ is #glossary[regular monic] if there exist an object $C$ and maps $B arrows C$ of which $m$ is an equalizer.
  A map $m: A -> B$ is #glossary[split monic] if there exists a map $e: B -> A$ such that $e m = 1_A$.

  #set enum(numbering: "(a)")
  1. Show that split monic #sym.arrow.double.long regular monic #sym.arrow.double.long monic.
  2. In $sans("Ab")$, show that all monics are regular but not all monics are split.
  3. In $sans("Top")$, describe the regular monics, and find a monic that is not regular.
]

#solution(users.kiwiyou)[
  === (a) Split Monic #sym.arrow.double.long Regular monic

  Let map $m: A -> B$ be a split monic, i.e. $e compose m = 1_A$ for some $e: B -> A$.

  We will show that $m$ is an equalizer of $m compose e : B -> B$ and $1_B : B -> B$.

  For some object $O$, suppose a map $f: O -> B$ such that $(m compose e) compose f = 1_B compose f$.

  Let $u = e compose f$.
  We need to show this $u$ is the only map that satisfies $m compose u = f$.

  If there exists a map $v: O -> A$ such that $m compose v = f$, then

  $
    u = e compose f = e compose (m compose v) = (e compose m) compose v = 1_A compose v = v.
  $

  Therefore, $u$ is the only map that satisfies $m compose u = f$. #h(1fr) #sym.qed

  === (a) Regular Monic #sym.arrow.double.long Monic

  Let $m: A -> B$ be a regular monic, i.e. $m$ is an equalizer for some $C$, $f: B -> C$ and $g: B -> C$.

  To show that $m$ is monic, suppose maps $h_1: O -> A$ and $h_2: O -> A$ both satisfies $m compose h_1 = m compose h_2$ for some object $O$.
  We need to show that $h_1 = h_2$.

  Note that $m compose h_1 = m compose h_2$ is a map from $O$ to $C$.

  Since $m$ is an equalizer, there exists a unique map $h: O -> A$ such that $f compose m compose h = g compose m compose h$.

  Therefore $h_1 = h_2 = h$. #h(1fr) #sym.qed

  === (b) In $sans("Ab")$, show that all monics are regular.

  In $sans("Ab")$, monic = injective homomorphism.

  Let $m: A -> B$ be a monic. Since $m^("img")(A)$ is a normal subgroup of $B$, we have $C = B slash m^("img")(A)$.

  Let $f: B -> C$ be the quotient, and $g: B -> C$ be the trivial homomorphism.

  Then for all $h: D -> B$ such that $f compose h = g compose h = 1_C$, $u = m^(-1) compose h$ is the unique homomorphism that satisfies $m compose u = h$.

  Since $m$ is an equalizer, $m$ is regular monic. #h(1fr) #sym.qed

  === (b) In $sans("Ab")$, show that not all monics are split.

  Define $m: ZZ -> ZZ$ as $m(n) = 2n$. This homomorphism is injective, thus monic.

  Suppose $m$ is split monic, i.e. $e compose m = 1$ for some homomorphism $e: ZZ -> ZZ$. This contradicts because:

  $ 1 = (e compose m)(1) = e(2) = e(1) + e(1). $

  Therefore, $m$ is not split monic. #h(1fr) #sym.qed
]
