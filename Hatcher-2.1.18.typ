#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "AT-2.1.18")[
  Show that for the subspace $ℚ ⊂ ℝ$, the relative homology group $H_1(ℝ, ℚ)$ is
  free abelian and find a basis.
]

#let Ker = "Ker"
#let Im = "Im"
#let Let = "let"
#let where = "where"

#let note(param, size: 1em) = {
  $&&#h(25pt)#text(size, rgb("#777"))[ ⋯\u{2009}(#param)]$
}

#solution(users.simnalamburt)[
  $A ⊂ X$ 를 만족하는 아무 두 위상공간 $(A, X)$에 대해, 아래 체인이 long exact
  sequence임을 Hatcher 115p 에서 증명했다.

  $
    ⋯ → H_n (A) → H_n (X) → H_n (X, A) → H_(n-1)(A) → H_(n-1)(X) → ⋯ → H_0(X, A) → 0
  $

  이 체인에 $n := 1, A := ℚ, X := ℝ$ 를 대입하면 다음과 같다.

  $
    ⋯ → H_1(ℚ) → H_1(ℝ) → H_1(ℝ, ℚ) → H_0(ℚ) → H_0(ℝ) → H_0(ℝ, ℚ) → 0
  $

  $ℝ$은 contractible 하므로 $H_1(ℝ) = 0, H_0(ℝ) = ℤ$ 이다. 따라서 위 체인은 다음과
  같다.

  $
    ⋯ → H_1(ℚ) → 0 → H_1(ℝ, ℚ) → H_0(ℚ) → ℤ → H_0(ℝ, ℚ) → 0
  $

  그리고 아래의 사실들에 의해,

  - $ℚ$는 0차원 동형사상으로 이루어진 무한개의 점으로 이루어져 있다.
  - path-connected인 standard n-simplex $Δ^n$를 totally-disconnected인 $ℚ$로
    연속사상하는 것은 상수사상밖에 없다.
  - singular n-simplex in $ℚ$의 정의는, standard n-simplex $Δ^n$를 $ℚ$로 보내는
    연속사상이다.
  - $C_n (ℚ)$는 singular n-simplices in $ℚ$의 집합을 기저로 갖의 free abelian
    group이다.

  아래가 성립한다:

  $
    & C_0(ℚ) = [c] \
    & C_1(ℚ) = [c, c] \
    & C_2(ℚ) = [c, c, c] \
    \
    & ∂_1 : C_1(ℚ) → C_0(ℚ) \
    & ∂_1([c, c]) = [c] - [c] = 0 #note[zero map] \
    & Ker ∂_1 = C_1(ℚ) \
    & Im ∂_1 = 0 \
    \
    & ∂_2 : C_2(ℚ) → C_1(ℚ) \
    & ∂_2([c, c, c]) = [c, c] - [c, c] + [c, c] = [c, c] #note[constant map] \
    & Im ∂_2 = C_1(ℚ) \
    \
    & H_1(ℚ) = Ker ∂_1 / Im ∂_2 = C_1(ℚ) / C_1(ℚ) = 0 #note[trivial group] \
    & H_0(ℚ) ≅ ⨁_(q∈ℚ) ℤ ⋅ [q] #note(size: 0.8em)[0th homology group counts path-connected components] \
  $

  이를 체인에 대입하면 다음과 같다.

  $
    ⋯ → 0 → 0 → H_1(ℝ, ℚ) → ⨁_(q∈ℚ) ℤ ⋅ [q] → ℤ → H_0(ℝ, ℚ) → 0
  $

  여기서, 아래가 성립한다:
  $
    & Let ∂ : H_1(ℝ, ℚ) → ⨁_(q∈ℚ) ℤ ⋅ [q] \
    & Let i^* : ⨁_(q∈ℚ) ℤ ⋅ [q] → ℤ \
    & i^* = λ ∑_(q∈F) n_q ⋅ [q]. ∑_(q∈F) n_q #note[induced by the inclusion $i : ℚ ↪ ℝ$] \
    \
    & Ker ∂ = Im (0 → H_1(ℝ, ℚ)) = 0 #note[exactness, zero map] \
    & Im ∂ = (H_1(ℝ, ℚ))/(Ker ∂) = H_1(ℝ, ℚ) #note[first isomorphism theorem] \
    & Im ∂ = Ker i^* #note[exactness] \
  $

  따라서, 아래가 성립한다:
  $
    H_1(ℝ, ℚ) &≅ Ker i^* \
    &= {∑_(q∈F) n_q ⋅ [q] ∈ ⨁_(q∈ℚ) ℤ ⋅ [q] mid(|) ∑_(q∈F) n_q = 0} #note[definition of kernel] \
    &⊂ {∑_(q∈F) n_q ⋅ [q] ∈ ⨁_(q∈ℚ) ℤ ⋅ [q]} \
    &= ⨁_(q∈ℚ) ℤ ⋅ [q] #note[this is abelian group] \
  $

  $H_1(ℝ, ℚ)$는 abelian group의 subgroup이므로, $H_1(ℝ, ℚ)$도 abelian이다.

  그리고, 아래 집합을 보면:
  $
    B := { [q] - [q_0] | q ∈ ℚ \\ {q_0} } #note[for a fixed $q_0 ∈ ℚ$]
  $
  $B$를 span하여 생성되는 부분군이 $H_1(ℝ, ℚ)$ 전체가 됨을 알 수 있다:
  $
    & ∑_(q∈F\\q_0) n_q ⋅ ([q] - [q_0]) \
    =& ∑_(q∈F\\q_0) n_q ⋅ [q] - (∑_(q∈F\\q_0) n_q) ⋅ [q_0] \
    =& ∑_(q∈F\\q_0) n_q ⋅ [q] + n_(q_0) ⋅ [q_0] && where Let n_(q_0) := - ∑_(q∈F\\q_0) n_q \
    =& ∑_(q∈F) n_q ⋅ [q] && where ∑_(q∈F) n_q = 0 \
  $
  $B$는 선형독립이다. $B$에서 서로 다른 m개의 원소를 뽑아 선형결합하면:
  $
      & k_1([q_1] - [q_0]) + k_2([q_2] - [q_0]) + ⋯ + k_m([q_m] - [q_0]) \
    = & (k_1[q_1] + k_2[q_2] + ⋯ + k_m [q_m]) - (k_1 + k_2 + ⋯ + k_m)[q_0] \
  $
  인데, 위 식이 $0$이 되는 유일한 방법은 $k_1 = k_2 = ⋯ = k_m = 0$이기 때문이다.

  따라서 $B$는 $H_1(ℝ, ℚ)$의 기저다. Free abelian group의 정의는 기저를 갖는
  abelian group이므로, $H_1(ℝ, ℚ)$는 free abelian group이다.
]
