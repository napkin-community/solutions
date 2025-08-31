#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/commute:0.3.0": arr, commutative-diagram, node


#plain_box(title: "AT-2.1.31")[
  Using the notation of the five-lemma, give an example where the maps $alpha$, $beta$, $delta$, and $epsilon$ are zero but $gamma$ is nonzero. This can be done with short exact sequences in which all the groups are either $ZZ$ or $0$.
]

#solution(users.finalchild)[
  #align(center)[
    #commutative-diagram(
      node((0, 0), $0$, "A1"),
      node((0, 1), $0$, "A2"),
      node((0, 2), $ZZ$, "A3"),
      node((0, 3), $ZZ$, "A4"),
      node((0, 4), $0$, "A5"),

      node((1, 0), $0$, "B1"),
      node((1, 1), $ZZ$, "B2"),
      node((1, 2), $ZZ$, "B3"),
      node((1, 3), $0$, "B4"),
      node((1, 4), $0$, "B5"),

      arr("A1", "A2", $0$),
      arr("A2", "A3", $0$),
      arr("A3", "A4", $id$),
      arr("A4", "A5", $0$),

      arr("B1", "B2", $0$, label-pos: right),
      arr("B2", "B3", $id$, label-pos: right),
      arr("B3", "B4", $0$, label-pos: right),
      arr("B4", "B5", $0$, label-pos: right),

      arr("A1", "B1", $0$),
      arr("A2", "B2", $0$),
      arr("A3", "B3", $id$),
      arr("A4", "B4", $0$),
      arr("A5", "B5", $0$),
    )
  ]
]
