#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let refl = "refl"
#let transport = "transport"

#plain_box(title: [HoTT-2.3])[
  Give a fourth, different, proof of Lemma 2.1.2, and prove that it is equal to the others.

  \

  #titlize_dot("Lemma 2.1.2", none)
  For every type $A$ and every $x, y, z : A$, there is a function
  $ (x = y) -> (y = z) -> (x = z) $
]

#solution(users.simnalamburt)[
  $x, y, z : A$ 이고 $p : x = y$, $q : y = z$ 라 하자.
  Type family $P : A -> cal(U)$ 를 $P(w) equiv (x = w)$ 로 정의하면, $p : P(y)$ 가 된다.
  이제 `transport`를 이용한 네 번째 경로 연결(concatenation)을 다음과 같이 정의하자.

  $
    & p dot_4 q : x = z \
    & p dot_4 q :≡ transport^P (q, p)
  $

  이제 이 정의가 기존의 경로 연결 $p dot q$ 와 같음을 보여야 한다. 즉, 다음을 증명해야 한다.

  $ p dot_4 q = p dot q $

  $q$ 에 대한 경로 귀납(path induction)을 사용하자. $z$ 를 $y$ 로, $q$ 를 $refl_y$ 로 가정하면 충분하다.

  1. **좌변**: `transport`의 정의에 의해, 경로가 $refl$ 일 때 `transport`
    함수는 항등 함수(identity function)와 정의상 같다(definitionally equal).
    $ p dot_4 refl_y equiv "transport"^P (refl_y, p) equiv p $

  2. **우변**: 기존 경로 연결의 우측 단위 법칙(right unit law)에 의해 다음이
    성립한다.
    $ p dot refl_y = p $

  따라서 $q equiv refl_y$ 일 때 $p = p$ 가 되어 등식이 성립하므로, path
  induction에 의해 모든 $q$ 에 대해 $p dot_4 q = p dot q$ 이다.
]
