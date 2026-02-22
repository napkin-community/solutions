#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let cdotp = "▪"
#let apd = $"apd"$
#let ap = $"ap"$
#let refl = "refl"
#let eqA = $attach(=, br: A)$
#let eqB = $attach(=, br: B)$

#plain_box(title: [HoTT-2.18])[
  State and prove a version of Lemma 2.4.3 for dependent functions.

  \

  #titlize_dot("Lemma 2.4.3", none)
  Suppose $H : f ∼ g$ is a homotopy between functions $f, g : A → B$ and let
  $p : x eqA y$. Then we have

  $
    H(x) cdotp g(p) = f(p) cdotp H(y)
  $
]

#solution(users.simnalamburt)[
  일단 Lemma 2.4.3의 의존버전을 정의해보자.

  비 의존버전 Lemma 2.4.3에 등장하는 항들의 타입을 모두 나열하면 아래와 같다.

  $
                   A, B & : cal(U) \
                   f, g & : A → B \
                   x, y & : A \
                      p & : x eqA y \
                      H & : f ∼ g \
                        \
                   ap_f & : (x eqA y) → f(x) eqB f(y) \
        f(p) ≡ ap_f (p) & : f(x) eqB f(y) \
                        \
                   ap_g & : (x eqA y) → g(x) eqB g(y) \
        g(p) ≡ ap_g (p) & : g(x) eqB g(y) \
                        \
                   H(x) & : f(x) eqB g(x) \
                   H(y) & : f(y) eqB g(y) \
                        \
    H(x) cdotp ap_g (p) & : f(x) eqB g(y) \
    ap_f (p) cdotp H(y) & : f(x) eqB g(y)
  $

  위를 모두 의존버전으로 옮기면 아래와 같다.

  $
    A &: cal(U) \
    P &: A → cal(U) \
    f, g &: product_(x:A) P(x) \
    x, y &: A \
    p &: x eqA y \
    H &: product_(x:A) (f(x) attach(=, br: P(x)) g(x)) \
    \
    p_* ≡ "transport"^P (p, -) &: P(x) → P(y)
    \
    apd_f &: product_(x,y:A) product_(p : x eqA y) (p_*(f(x)) attach(=, br: P(y)) f(y)) \
    apd_f (p) &: p_*(f(x)) attach(=, br: P(y)) f(y) \
    \
    apd_g &: product_(x,y:A) product_(p : x eqA y) (p_*(g(x)) attach(=, br: P(y)) g(y)) \
    apd_g (p) &: p_*(g(x)) attach(=, br: P(y)) g(y) \
    \
    H(x) &: f(x) attach(=, br: P(x)) g(x) \
    H(y) &: f(y) attach(=, br: P(y)) g(y) \
    \
    p_*(H(x)) ≡ ap_("transport"^P (p, -)) (H(x)) &: p_*(f(x)) attach(=, br: P(y)) p_*(g(x)) \
    \
    p_*(H(x)) cdotp apd_g (p) &: p_*(f(x)) attach(=, br: P(y)) g(y) \
    apd_f (p) cdotp H(y) &: p_*(f(x)) attach(=, br: P(y)) g(y)
  $

  약간 설명을 하자면, 비의존 버전의 Lemma 2.4.3에서 $ap_f (p), ap_g (p)$ 가 하던
  역할은 의존 버전에서는 $apd_f (p), apd_g (p)$ 가 한다. 이때, $H(x) : f(x)
  attach(=, br: P(x)) g(x)$ 는 fiber $P(x)$ 안의 path이므로, fiber $P(y)$ 안의
  path인 $apd_g (p)$ 와 곧바로 합성할 수 없다. 따라서 $p_*$ 를 써서 $H(x)$ 를
  fiber $P(y)$ 안의 path로 먼저 옮긴 뒤 합성해야한다.

  따라서 다음이 의존함수 버전의 Lemma 2.4.3 이다.

  $
    product_(x,y:A) product_(p : x eqA y)
    (
      p_*(H(x)) cdotp apd_g(p) = apd_f(p) cdotp H(y)
    )
  $

  이제 증명하자. $p$ 에 대한 path induction을 사용하면 $p ≡ refl_x$ 인 경우만 보면 충분하다.

  이 경우 $p_*$ 는 항등 함수이고, $apd_f (refl_x) = refl_(f(x))$, $apd_g (refl_x) = refl_(g(x))$ 이다.
  $
    p_*(H(x)) cdotp apd_g (p)
    = H(x) cdotp refl_(g(x))
    = H(x)
  $
  이고,
  $
    apd_f (p) cdotp H(y)
    = apd_f (refl_x) cdotp H(x)
    = refl_(f(x)) cdotp H(x)
    = H(x)
  $
  이므로 양변이 같다.

  따라서 모든 $x,y:A$ 와 $p : x = y$ 에 대해
  $
    p_*(H(x)) cdotp apd_g (p) = apd_f (p) cdotp H(y)
  $
  가 성립한다. #sym.qed
]
