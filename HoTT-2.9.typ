#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let split = "split"
#let join = "join"
#let rec = "rec"
#let ind = "ind"
#let inl = "inl"
#let inr = "inr"

#plain_box(title: [HoTT-2.9])[
  Prove that coproducts have the expected universal property,
  $ (A + B -> X) ≃ (A -> X) × (B -> X). $
  Can you generalize this to an equivalence involving dependent functions?
]

#solution(users.simnalamburt)[
  먼저 *비의존 함수(non-dependent function)* 버전을 증명하자.

  두 함수 $split$ (forward, $->$)와 $join$ (backward, $<-$)을 다음과 같이 정의한다.

  $
           split & : (A + B -> X) -> (A -> X) × (B -> X) \
        split(h) & :≡ (h ∘ inl, h ∘ inr) \
            join & : (A -> X) × (B -> X) -> (A + B -> X) \
    join((g, h)) & :≡ rec_(A+B) (X, g, h)
  $

  이제 두 함수가 서로 역함수(inverse)임을 보이자.

  1. *$split ∘ join tilde id$*: 임의의 $x$ 에 대하여, by induction on $x$, $(g, h) ≡ x$

    $
      split(join((g, h))) & ≡ (join((g, h)) ∘ inl, join((g, h)) ∘ inr) \
                          & ≡ (λ a. g(a), λ b. h(b)) \
                          & ≡ (g, h) quad ("by η-conversion")
    $

    So, $split(join((g, h))) = (g, h)$.

  2. *$join ∘ split tilde id$*:
    임의의 $f: A + B -> X$ 에 대하여, 모든 $x: A+B$ 에서 $join(split(f))(x) = f(x)$ 임을 $x$ 에 대한 귀납법으로 보인다.
    - $x ≡ inl(a)$ 일 때: $join(split(f))(inl(a)) ≡ (f ∘ inl)(a) ≡ f(inl(a))$
    - $x ≡ inr(b)$ 일 때: $join(split(f))(inr(b)) ≡ (f ∘ inr)(b) ≡ f(inr(b))$
    점별로(pointwise) 같으므로, 함수 외연성(function extensionality)에 의해 $join(split(f)) = f$ 이다.

  \

  다음으로, 이를 *의존 함수(dependent function)* 버전으로 일반화하자.

  임의의 Type family $P : A + B -> cal(U)$ 에 대하여 다음이 성립한다.

  $
    (Π_(x:A+B) P(x)) ≃ (Π_(a:A) P(inl(a))) × (Π_(b:B) P(inr(b)))
  $

  증명 구조는 위와 완전히 동일하다.

  $
      split_(Π) (h) & :≡ (λ a. h(inl(a)), λ b. h(inr(b))) \
    join_(Π) (g, h) & :≡ ind_(A+B) (λ x.X, g, h)
  $

  1. $split_(Π) (join_(Π) (g, h))$ 는 정의에 따라 $(g, h)$ 로 계산된다(definitionally equal).
  2. $join_(Π) (split_(Π) (f))$ 는 $x$ 가 $inl(a)$ 일 때와 $inr(b)$ 일 때 모두 $f(x)$ 와 같으므로, 함수 외연성에 의해 $f$ 와 같다.
]
