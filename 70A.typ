#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#plain_box(title: [Problem 70A], subtitle: [Four lemma])[
  In an abelian category, consider the commutative diagram

  #diagram(
    node((0, 0), $A$),
    edge("r", $p$, "->"),
    edge("d", $alpha$, "-|>"),
    edge((0, 0), (0, 0.72), $$, "-|>"),
    node((1, 0), $B$),
    edge("r", $q$, "->"),
    edge("d", $beta$, "hook->"),
    node((2, 0), $C$),
    edge("r", $r$, "->"),
    edge("d", $gamma$, "->"),
    node((3, 0), $D$),
    edge("d", $delta$, "hook->"),
    node((0, 1), $A'$),
    edge("r", $p'$, "->"),
    node((1, 1), $B'$),
    edge("r", $q'$, "->"),
    node((2, 1), $C'$),
    edge("r", $r'$, "->"),
    node((3, 1), $D'$),
  )

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
