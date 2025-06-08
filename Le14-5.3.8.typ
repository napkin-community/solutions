#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#plain_box(title: "Le14 5.3.8")[
  // Taking the limit is a process that receives as its input a diagram in a category $cal(A)$, and produces as its output a new object of $cal(A)$. Later we will see that this process is functorial (Proposition 6.1.4). Here you are asked to prove this in the case of binary products.

  Let $cal(A)$ be a category with binary products. Suppose that we have chosen for each pair $(X, Y)$ of objects a product cone

  $
    X <--^(p^(X,Y)_1) X times Y -->^(p^(X,Y)_2) Y.
  $

  Construct a functor $cal(A) times cal(A) -> cal(A)$ given on objects by $(X, Y) |-> X times Y$.
]



#solution(users.ranolp)[
  Let $F : cal(A) times cal(A) -> cal(A)$ be a functor.

  Given condition, we send objects by $F((X, Y)) = X times Y$.

  And we send morphisms $(X, Y) -->^((f, g)) (Z, W)$ by

  #diagram(
    node((0, 3), $X times Y$),
    edge(
      (0, 3),
      (3, 2),
      $f compose p^(X, Y)_1$,
      "->",
      label-sep: 12pt,
      bend: 70deg,
      label-side: right,
    ),
    edge(
      (0, 3),
      (3, 4),
      $g compose p^(X, Y)_2$,
      "->",
      label-sep: 12pt,
      bend: -74deg,
      label-side: left,
    ),
    edge((0, 3), (1, 2), $p^(X, Y)_1$, "->", label-sep: -4pt),
    edge((0, 3), (2, 3), $exists! F((f, g))$, "-->"),
    node((1, 2), $X$),
    edge((1, 2), (3, 2), $f$, "->", label-sep: 2pt),
    edge((0, 3), (1, 4), $p^(X, Y)_2$, "->", label-sep: 2pt, label-side: right),
    node((1, 4), $Y$),
    edge((1, 4), (3, 4), $g$, "->", label-sep: 2pt, label-side: right),
    node((2, 3), $Z times W$),
    edge((2, 3), (3, 2), $p^(Z, W)_1$, "->", label-sep: -4pt),
    node((3, 2), $Z$),
    edge((2, 3), (3, 4), $p^(Z, W)_2$, "->", label-sep: 2pt, label-side: right),
    node((3, 4), $W$),
  )

  Now all we need to do is to check that $F$ is functor.

  #enum[
    *Preservation of Identity*

    Let's think about $(X, Y) -->^(id_((X,Y))) (X, Y)$. Substitute the diagram above we get

    #diagram(
      node((0, 3), $X times Y$),
      edge(
        (0, 3),
        (3, 2),
        $id_X compose p^(X, Y)_1$,
        "->",
        label-sep: 12pt,
        bend: 70deg,
        label-side: right,
      ),
      edge(
        (0, 3),
        (3, 4),
        $id_Y compose p^(X, Y)_2$,
        "->",
        label-sep: 12pt,
        bend: -74deg,
        label-side: left,
      ),
      edge((0, 3), (1, 2), $p^(X, Y)_1$, "->", label-sep: -4pt),
      edge((0, 3), (2, 3), $exists! F((id_X, id_Y))$, "-->"),
      node((1, 2), $X$),
      edge((1, 2), (3, 2), $id_X$, "->", label-sep: 2pt),
      edge(
        (0, 3),
        (1, 4),
        $p^(X, Y)_2$,
        "->",
        label-sep: 2pt,
        label-side: right,
      ),
      node((1, 4), $Y$),
      edge((1, 4), (3, 4), $id_Y$, "->", label-sep: 2pt, label-side: right),
      node((2, 3), $X times Y$),
      edge((2, 3), (3, 2), $p^(X, Y)_1$, "->", label-sep: -4pt),
      node((3, 2), $X$),
      edge(
        (2, 3),
        (3, 4),
        $p^(X, Y)_2$,
        "->",
        label-sep: 2pt,
        label-side: right,
      ),
      node((3, 4), $Y$),
    )

    Let's place $id_(X times Y)$ on the position of $F((id_X, id_Y))$, then we get the desired properties. And since the morphism is unique, there's no way to construct morphism other than $id_(X times Y)$. Thus the functor $F$ preserves identity.
  ][
    *Preservation of Composition*

    Let's say we have two morphisms $(X, Y) -->^((f_1, g_1)) (Z, W)$ and $(Z, W) -->^((f_2, g_2)) (A, B)$.


    #diagram(
      node((0, 3), $X times Y$),
      edge(
        (0, 3),
        (5, 2),
        $f_2 compose f_1 compose p^(X, Y)_1$,
        "->",
        bend: 68deg,
        label-sep: 12pt,
        label-side: right,
      ),
      edge(
        (0, 3),
        (5, 4),
        $g_2 compose g_1 compose p^(X, Y)_2$,
        "->",
        label-sep: 12pt,
        bend: -75deg,
        label-side: left,
      ),
      edge((0, 3), (1, 2), $p^(X, Y)_1$, "->", label-sep: -4pt),
      edge((0, 3), (2, 3 - .5), $F((f_1, g_1))$, "->", label-angle: 13deg),
      edge(
        (0, 3),
        (4, 3),
        $F((f_2 compose f_1, g_2 compose g_1))$,
        "->",
        bend: -17deg,
        label-pos: 36%,
        label-angle: -4deg,
        label-side: left,
      ),
      node((1, 2), $X$),
      edge((1, 2), (3, 2), $f_1$, "->", label-sep: 2pt),
      edge(
        (0, 3),
        (1, 4),
        $p^(X, Y)_2$,
        "->",
        label-sep: 2pt,
        label-side: right,
      ),
      node((1, 4), $Y$),
      edge((1, 4), (3, 4), $g_1$, "->", label-sep: 2pt, label-side: right),
      node((2, 3 - .5), $Z times W$),
      edge((2, 3 - .5), (4, 3), $F((f_2, g_2))$, "->"),
      edge((2, 3 - .5), (3, 2), $p^(Z, W)_1$, "->", label-sep: -4pt),
      node((3, 2), $Z$),
      edge((3, 2), (5, 2), $f_2$, "->", label-sep: 2pt),
      edge(
        (2, 3 - .5),
        (3, 4),
        $p^(Z, W)_2$,
        "->",
        label-sep: 2pt,
        label-pos: 75%,
        label-side: right,
      ),
      node((3, 4), $W$),
      edge((3, 4), (5, 4), $g_2$, "->", label-sep: 2pt, label-side: right),
      node((4, 3), $A times B$),
      edge((4, 3), (5, 2), $p^(A, B)_1$, "->", label-sep: -4pt),
      node((5, 2), $A$),
      edge(
        (4, 3),
        (5, 4),
        $p^(A, B)_2$,
        "->",
        label-sep: 2pt,
        label-side: right,
      ),
      node((5, 4), $B$),
    )

    Since the morphism $F((f_2 compose f_1, g_2 compose g_1))$ satisfying desired properties is unique so

    $F((f_2 compose f_1, g_2 compose g_1)) = F((f_2, g_2)) compose F((f_1, g_1))$
  ]
]
