#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

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
  를 만족하는데, 편의상 $f$를 $⟨g, h⟩$로 표기하겠다.

  그리고 이제 아래의 아름다운 그림을 보라:

  #image("./67C.png")
]
