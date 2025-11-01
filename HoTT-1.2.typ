#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [HoTT-1.2])[
  Derive the recursion principle for products $"rec"_(A times B)$ using only the projections, and verify that the definitional equalities are valid. Do the same for $Sigma$-types.
]

#let pr1 = $"pr"_1$
#let pr2 = $"pr"_2$
#let recP = $"rec"_(A times B)$
#let recDP = $"rec"_(Sigma_(x : A) B(x))$
#let def = $:equiv$

#solution(users.ranolp)[
  The exercise makes us define the recursor based on the projection of (maybe dependent) pair types.

  #enum[
    *$recP$*

    We have projections

    - $pr1 : A times B -> A$
    - $pr2 : A times B -> B$

    with the following defining equations

    - $pr1((a, b)) def a$
    - $pr2((a, b)) def b$

    Anyway, our goal is to define

    $recP : limits(Pi)_(C : cal(U)) (A -> B -> C) -> A times B -> C$

    and the definition is

    $recP(C, g, (a, b)) def g(pr1((a, b)))(pr2((a, b)))$

    We can verify that the recursor above has the desired property by doing $beta$-reduction on #pr1 and #pr2.

    After the reduction, we get $g(a)(b)$, correctly Church-encoding the product. #h(1fr) #sym.qed
  ][
    *$recDP$*

    We have projections

    - $pr1 : (limits(Sigma)_(x:A) B(x)) -> A$
    - $pr2 : limits(Pi)_(p:Sigma_((x:A)) B(x)) -> B(pr1(p))$

    with the following defining equations

    - $pr1((a, b)) def a$
    - $pr2((a, b)) def b$

    #plain_box(
      title: [Lemma 1],
      subtitle: [$pr2((a, b)) def b$ is correct definition #sym.dash.em taken from the textbook],
    )[

      We can define $pr2$ as above because:

      #line(length: 100%, stroke: 0.5pt + gray)

      Given type family $C : (Sigma_((x:A)) B(x)) -> cal(U)$

      for some $g : limits(Pi)_(a:A) med limits(Pi)_(b:B(a)) C((a, b))$

      we can derive function $f : limits(Pi)_(p : Sigma_((x:A)) B(x)) -> C(p)$

      with the following definition

      $f((a, b)) :equiv g(a)(b)$

      #line(length: 100%, stroke: 0.5pt + gray)

      If we take $C(p) = B(pr1(p))$ then the $f$ has type

      $f : limits(Pi)_(p : Sigma_((x:A)) B(x)) -> B(pr1(p))$

      which has the desired type and semantics for $pr2$
    ]

    So again we have two projection functions: $pr1$ and $pr2$.

    Anyway, our goal is to define

    $recDP : limits(Pi)_((C:cal(U))) (Pi_((x:A)) B(x) -> C) -> (Sigma_((x:A)) B(x)) -> C$

    and its definition is

    $recDP(C, g, (a, b)) def g(pr1((a, b)))(pr2((a, b)))$

    Let's verify that the definition concludes with the property we desired once more:

    By $beta$-reducing on $pr1$ and $pr2$, we get $recDP(C, g, (a, b)) def g(a)(b)$,

    and it correctly Church-encodes the dependently-typed product. #h(1fr) #sym.qed
  ]

  As shown above, the recursor can be defined with the projection functions of (maybe dependent) tuples.
]
