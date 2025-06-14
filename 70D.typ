#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#set page(height: auto)

#plain_box(
  title: "Problem 70D",
  subtitle: [An additive category that is not abelian],
)[
  Consider a category, where:

  #set par(first-line-indent: 1em)

  - the objects are pairs of abelian groups $(B, A)$ where $A$ is a subgroup of $B$.
  - the morphisms $(B, A) -> (B prime, A prime)$ are maps $f : B -> B prime$ where $f^"img" (A) subset.eq A prime$.

  (You can think of this similar to the $sans("PairTop")$ category, seen in Chapter 73. We use abelian groups here to make the category additive.)

  This category can be equivalently viewed as the category of short exact sequences #box[$0 -> A -> B -> B slash A -> 0$] of abelian groups.

  Show that the arrow $(X, 0) -> (X, X)$ is monic and epic, but not an isomorphism. #box[Conclude that the category is not abelian].
]



#solution(users.ranolp)[
  Is the arrow $(X, 0) -->^f (X, X) : X -> X$ some group homomprhism? No, "the" only natural map make sense is the $id_X$.

  Experts should not say "natural", "common practice", "obvious", or similar to learners.

  Even in the "naturality", we can think both $id_X$ and the zero map for "the arrow". Thanks to god, it is not "an arrow". If so, since it's abelian, we may think $x |-> 2x$ or similar maps.

  I have no respect for this problem.

  #enum[
    *The arrow $f$ is monic and epic.*

    #list[
      *The arrow $f$ is monic*

      Consider following commutative diagram.

      #diagram(
        node((0, 0), $(B, A)$),
        edge($g$, "-|>", shift: 3pt),
        edge($h$, "-|>", shift: -3pt, label-side: right),
        node((1, 0), $(X, 0)$),
        edge($f$, "-|>"),
        node((2, 0), $(X, X)$),
      )

      $
                 forall b in B                                     \
                  quad f(g(b)) & = f(h(b))                         \
        f(g(b)) + f(h(b))^(-1) & = 0_X                             \
         f(g(b)) +f(h(b)^(-1)) & = 0_X                             \
           f(g(b) + h(b)^(-1)) & = 0_X                             \
              g(b) + h(b)^(-1) & = 0_X "(assume" f "is injective)" \
                          g(b) & = h(b)                            \
      $

      Therefore, $f compose g = f compose h ==> g = h$

      Thus, $f$ is monic. #h(1fr) $square$
    ][
      *The arrow $f$ is epic*

      Consider following commutative diagram


      #diagram(
        node((0, 0), $(X, 0)$),
        edge($f$, "-|>"),
        node((1, 0), $(X, X)$),
        edge($g$, "-|>", shift: 3pt),
        edge($h$, "-|>", shift: -3pt, label-side: right),
        node((2, 0), $(B, A)$),
      )

      $
        forall x in X \
        "Let's say the value of" f(x) "as" y \
        g(f(x)) = h(f(x)) \
        g(y) = h(y) \
      $

      Therefore, $g compose f = h compose f ==> g = h$

      Thus, $f$ is epic. #h(1fr) $square$
    ]
  ][
    *$f$ is not an isomorphism*

    The $f$ is isomorphism if there's a map $(X, X) -->^g (X, 0)$ with following condition

    - $f compose g = id_((X, X))$, and
    - $g compose f = id_((X, 0))$

    By definition, $g^"img" (X) = 0$, which means $(f compose g)(x) = 0$, in other words $f compose g != id_((X, X))$.

    As a consequence, there's no such $g$.

    Thus, $f$ is not an isomorphism #h(1fr) $square$
  ][
    *The category is not abelian*

    By proposition 70.2.6. the category cannot be abelian.

    #blue_box(
      [Proposition 70.2.6],
      subtitle: [Isomorphism $<==>$ monic and epic],
    )[In an abelian category, a map is an isomorphism if and only if it is monic and epic.]
  ]

]
