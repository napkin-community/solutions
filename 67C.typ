#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node
#let edge = fletcher.edge.with(marks: "-|>")

#plain_box(title: [Problem 67C])[
  In any category $cal(A)$ where all products exist, show that
  $
    (X × Y) × Z ≅ X × (Y × Z)
  $
  where $X, Y, Z$ are arbitrary objects. (Here both sides refer to the objects,
  as in #text(rgb("#800000"))[Abuse of Notation 67.4.2].)
]

#solution(users.simnalamburt)[
  목표: 아래를 만족하는 morphism $f, g$를 찾는것이다.

  $
    f : (X × Y) × Z → X × (Y × Z) \
    g : X × (Y × Z) → (X × Y) × Z \
    g ∘ f = id_((X × Y) × Z) \
    f ∘ g = id_(X × (Y × Z))
  $

  곱의 보편성에 의해, 임의의 C와 $g : C → A, h : C → B$가 주어지면
  $
    f : C → A × B
  $
  라는 유일한 화살표가 존재하여
  $
    π^A ∘ f = g \
    π^B ∘ f = h
  $
  를 만족하는데, 편의상 $f$를 $angle.l g, h angle.r$로 표기하겠다.

  그리고 이제 아래의 아름다운 그림을 보라:

  #align(
    center,
    diagram(
      node((0, 0), $(X times Y) times Z$, name: <XY_Z>),
      node((3, 0), $Y times Z$, name: <YZ>),
      node((2, -3), $X$, name: <X>),
      node((2, -1), $Y$, name: <Y>),
      node((2, 1), $Z$, name: <Z>),
      node((1, -2), $X times Y$, name: <XY>),
      node((4, -2), $X times (Y times Z)$, name: <X_YZ>),
      edge(<XY_Z>, <XY>, label: $p := pi^(X times Y)_(X times Y, Z)$),
      edge(
        <XY_Z>,
        <Z>,
        label: $q := pi^Z_(X times Y, Z)$,
        label-side: right,
        label-sep: 10pt,
      ),
      edge(<YZ>, <Y>, label: $r := pi^Y_(Y, Z)$, label-side: left),
      edge(<YZ>, <Z>, label: $s := pi^Z_(Y, Z)$, label-side: left),
      edge(
        <X_YZ>,
        <X>,
        label: $u := pi^X_(X, Y times Z)$,
        label-side: right,
        label-sep: 10pt,
      ),
      edge(
        <X_YZ>,
        <YZ>,
        label: $v := pi^(Y times Z)_(X, Y times Z)$,
        label-side: left,
      ),
      edge(<XY>, <X>, label: $alpha := pi^X_(X, Y)$),
      edge(<XY>, <Y>, label: $beta := pi^Y_(X, Y)$),
      edge(
        <XY_Z>,
        <YZ>,
        label: text(blue, $angle.l beta compose p, q angle.r$),
        stroke: (paint: blue),
        label-side: right,
      ),
      edge(
        <XY_Z>,
        <X_YZ>,
        label: text(
          blue,
          $f := angle.l alpha compose p, angle.l beta compose p, q angle.r angle.r$,
        ),
        stroke: (paint: blue),
        label-pos: 75%,
        label-angle: 21deg,
        label-sep: 3pt,
        label-side: right,
        bend: -4deg,
      ),
      edge(
        <X_YZ>,
        <XY>,
        label: text(orange, $angle.l u, r compose v angle.r$),
        stroke: (paint: orange),
      ),
      edge(
        <X_YZ>,
        <XY_Z>,
        label: text(
          orange,
          $g := angle.l angle.l u, r compose v angle.r, s compose v angle.r$,
        ),
        stroke: (paint: orange),
        label-pos: 75%,
        label-angle: 21deg,
        label-sep: 3pt,
        bend: -4deg,
      ),
    ),
  )
]
