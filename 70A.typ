#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#plain_box(title: [Problem 70A], subtitle: [Four lemma])[
  In an abelian category, consider the commutative diagram

  #diagram(label-sep: 0em, {
    let (a, b, c, d) = ((0, 0), (1, 0), (2, 0), (3, 0))
    let (a_, b_, c_, d_) = ((0, 1), (1, 1), (2, 1), (3, 1))

    node(a, $A$)
    node(b, $B$)
    node(c, $C$)
    node(d, $D$)

    node(a_, $A'$)
    node(b_, $B'$)
    node(c_, $C'$)
    node(d_, $D'$)

    edge(a, b, $p$, "-|>")
    edge(b, c, $q$, "-|>")
    edge(c, d, $r$, "-|>")

    edge(a_, b_, $p'$, "-|>", label-side: right)
    edge(b_, c_, $q'$, "-|>", label-side: right)
    edge(c_, d_, $r'$, "-|>", label-side: right)

    edge(a, a_, $a$, marks: (none, (inherit: "|>", extrude: (0, -8))))
    edge(b, b_, $β$, "hook-|>")
    edge(c, c_, $γ$, "-|>")
    edge(d, d_, $δ$, "hook-|>")
  })

  where the first and second rows are exact. Prove that if $alpha$ is epic, and $beta$ and $delta$ are monic, then $gamma$ is monic.
]

#solution(users.finalchild)[
  By Mitchell's embedding theorem, move the category to a left $R$-module.

  $forall c in C " " (gamma c = 0) " "$\
  Plan: We will prove $exists a in A " " (q p a = c)$\
  Then, by the exact sequence $A ->^p B ->^q C$, $c = q p a = 0$\
  It proves $gamma$ is monic.

  == finding $a$

  $delta r c = r' gamma c = 0$\
  Since $delta$ is monic, $r c = 0$\
  $c in "Ker" r$\
  By the exact sequence $B ->^q C ->^r D$, $exists b in B " " (q b = c)$\
  $q' beta b = gamma q b = gamma c = 0$\
  $beta b in "Ker" q'$\
  By the exact sequence $A' ->^p' B' ->^q' C'$ and epicness of $alpha$, $exists a in A " " (p' alpha a = beta b)$\
  $beta p a = p' alpha a = beta b$\
  Since $beta$ is monic, $p a = b$\
  $c = q b = q p a$ #sym.qed
]
