#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

#set page(height: auto)

#plain_box(title: "Problem 68A")[
  Show that the two definitions of natural transformation (one in terms of $cal(A) times bold(2) -> cal(B)$ and one in terms of arrows $F(A) -->^(alpha_A) G(A)$) are equivalent.
]



#solution(users.ranolp)[
  == Common Condition

  Given two categories $cal(A), cal(B)$ and two functors $F, G : cal(A) -> cal(B)$.

  == Given natural transformation $F(A) -->^(alpha_A) G(A)$

  Our goal is to construct a functor $beta : cal(A) times bold(2) -> cal(B)$ for each $alpha$.

  Since product category is defined as tuple of objects and arrows, we can construct $beta$ by

  $
    "sending tuple of objects" \
    beta((A, 0)) = F(A) wide beta((A, 1)) = G(A) \
    "and sending tuple of morphisms" \
    beta((f, id_0)) = F(f) wide beta((f, id_1)) = G(f) \
    beta((A_1 ->^f A_2, 0->^<= 1)) = alpha_A_2 compose F(f) \
    "to" cal(B)
  $

  Now we need to check the $beta$ is functor.

  #enum[
    *Mapping of Objects*

    Trivially done by $F(A)$ and $G(A)$
  ][
    *Mapping of Morphisms*

    Trivially done by $F(f)$, $G(f)$ and $alpha_A_2 compose F(f)$.

    #diagram(
      node((0, 0), $F(A_1)$),
      edge((0, 0), (1, 0), $F(f)$, "->"),
      edge((0, 0), (0, 1), $alpha_A_1$, "->"),
      node((1, 0), $F(A_2)$),
      edge((1, 0), (1, 1), $alpha_A_2$, "->", label-side: left),
      node((0, 1), $G(A_1)$),
      edge((0, 1), (1, 1), $G(f)$, "->", label-side: right),
      node((1, 1), $G(A_2)$),
    )
  ][
    *Preservation of Identity Morphism*

    In $cal(A) times bold(2)$, identity is either $id_((A, 0)) = (id_A, id_0)$ which will be sent to $F(id_A)$ or $id_((A, 1)) = (id_A, id_1)$ which will be sent to $G(id_A)$. both will preserve identity by functor $F$ and $G$.
  ][
    *Preservation of Composition*

    It's the most unsatisfying part. We will split cases for easier understanding.

    #enum(numbering: "i.")[
      Both sides are $(f, id_0)$ form: Preserved by functor $F$.
    ][
      Both sides are $(f, id_1)$ form: Preserved by functor $G$.
    ][
      The one is $(A_1 ->^f A_2, 0 ->^<= 1)$: Prove case by case.

      #enum(numbering: "a.", spacing: 2em)[
        $beta((A_2 ->^g A_3, id_1)) compose beta((A_1 ->^f A_2, 0 ->^<= 1)) = G(g) compose alpha_A_2 compose F(f)$

        *Abuse of Notation*: let's call the function above as $beta(g) compose beta(f)$ for now.


        #diagram(
          node((0, 0), $A_1$),
          edge((0, 0), (0, 1), $f$, "->"),
          edge((0, 0), (0, 2), $g compose f$, "->", bend: 35deg),
          node((0, 1), $A_2$),
          edge((0, 1), (0, 2), $g$, "->"),
          node((0, 2), $A_3$),

          node((3, 0), $F(A_1)$),
          edge((3, 0), (3, 1), $F(f)$, "->"),
          edge((3, 0), (4, 2), $beta(g) compose beta(f)$, "->", bend: 90deg),
          node((3, 1), $F(A_2)$),
          edge((3, 1), (4, 1), $alpha_A_2$, "->"),
          node((4, 1), $G(A_2)$),
          edge((4, 1), (4, 2), $G(g)$, "->"),
          node((4, 2), $G(A_3)$),
        )

        The diagram above commutes.
      ][
        $(A_1 ->^f A_2, 0 ->^<= 1) compose (A_0 ->^g A_1, id_0) = alpha_A_2 compose F(f) compose F(g)$

        *Abuse of Notation*: let's call the function above as $beta(f) compose beta(g)$ for now.

        #diagram(
          node((0, 0), $A_0$),
          edge((0, 0), (0, 1), $g$, "->"),
          edge((0, 0), (0, 2), $f compose g$, "->", bend: 35deg),
          node((0, 1), $A_1$),
          edge((0, 1), (0, 2), $f$, "->"),
          node((0, 2), $A_2$),

          node((3, 0), $F(A_0)$),
          edge((3, 0), (3, 1), $F(g)$, "->"),
          edge((3, 0), (4, 2), $beta(f) compose beta(g)$, "->", bend: 40deg),
          node((3, 1), $F(A_1)$),
          edge((3, 1), (3, 2), $F(f)$, "->"),
          node((3, 2), $F(A_2)$),
          edge((3, 2), (4, 2), $alpha_A_2$, "->"),
          node((4, 2), $G(A_2)$),
        )

        The diagram above commutes.
      ]
    ]
  ]

  == Given functor $beta : cal(A) times bold(2) -> cal(B)$

  Our goal is to construct a natural transformation $F(A) -->^(alpha_A) G(A)$ from $beta$.

  Consider $A_1 ->^f A_2$, then following diagram commutes.


  #diagram(
    node((0, 0), $(A_1, 0)$),
    edge((0, 0), (1, 0), $(f, id_0)$, "->"),
    edge((0, 0), (0, 1), $(id_A_1, 0 -> 1)$, "->"),
    node((1, 0), $(A_2, 0)$),
    edge((1, 0), (1, 1), $(id_A_2, 0 -> 1)$, "->", label-side: left),
    node((0, 1), $(A_1, 1)$),
    edge((0, 1), (1, 1), $(f, id_1)$, "->", label-side: right),
    node((1, 1), $(A_2, 1)$),

    edge((1, 1), (3, 2), $beta$, "-->"),

    node((3, 2), $F(A_1)$),
    edge((3, 2), (4, 2), $F(f)$, "->"),
    edge((3, 2), (3, 3), $beta((id_A_1, 0 -> 1))$, "->"),
    node((4, 2), $F(A_2)$),
    edge((4, 2), (4, 3), $beta((id_A_2, 0 -> 1))$, "->", label-side: left),
    node((3, 3), $G(A_1)$),
    edge((3, 3), (4, 3), $G(f)$, "->", label-side: right),
    node((4, 3), $G(A_2)$),
  )

  Let's say $alpha_A = beta((id_A, 0 -> 1))$. Then it's the naturally requirement.

  #diagram(
    node((0, 0), $F(A_1)$),
    edge((0, 0), (1, 0), $F(f)$, "->"),
    edge((0, 0), (0, 1), $alpha_A_1$, "->"),
    node((1, 0), $F(A_2)$),
    edge((1, 0), (1, 1), $alpha_A_2$, "->", label-side: left),
    node((0, 1), $G(A_1)$),
    edge((0, 1), (1, 1), $G(f)$, "->", label-side: right),
    node((1, 1), $G(A_2)$),
  )
]
