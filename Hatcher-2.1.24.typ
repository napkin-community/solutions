#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "AT-2.1.24")[
  Show that each $n$-simplex in the barycentric subdivision $Δ^n$ is defined by
  $n$ inequalities $t_(i_0) ≤ t_(i_1) ≤ ⋯ ≤ t_(i_n)$ in its barycentric
  coordinates, where $(i_0, i_1, ⋯, i_n)$ is a permutation of $(0, 1, ⋯, n)$.
]

#let Ker = "Ker"
#let Im = "Im"
#let Let = "let"
#let where = "where"

#let note(param, size: 1em) = {
  $&&#h(25pt)#text(size, rgb("#777"))[ ⋯\u{2009}(#param)]$
}

#solution(users.simnalamburt)[
  $Δ^n$ 안의 한 점의 barycentric coordinates를 $(t_0, t_1, ..., t_n)$라 하자. 이들은 아래를
  만족한다.

  $
    t_i ≥ 0 quad (i = 0, 1, ..., n) wide ∑_i t_i = 1
  $


  $(0, 1, ..., n)$의 순열중 임의로 하나를 골라 $(i_0, i_1, ..., i_n)$라 할 때,
  $R$을 아래와 같이 정의하겠다:

  $
    R := { (t_0, t_1, ..., t_n) ∈ Δ^n | t_(i_0) ≤ t_(i_1) ≤ ... ≤ t_(i_n) }
  $

  $R$이 문제의 "$n$ inequalities $t_(i_0) ≤ t_(i_1) ≤ ⋯ ≤ t_(i_n)$ in its
  barycentric coordinates, where $(i_0, i_1, ⋯, i_n)$ is a permutation of $(0,
    1, ⋯, n)$"에 해당한다. 우리의 목표는 $R$이 "each $n$-simplex in the
  barycentric subdivision $Δ^n$"임을 보이는 것이다.

  점 $p_m$을 아래와 같이 정의하자:

  $
    & p_m ∈ Δ^n quad (0 ≤ m ≤ n) \
    & (p_m)_(i_j) := inline(paren.l underbrace(0\, 0\, ...\, 0, m)\, underbrace(1/(n-m+1)\, 1/(n-m+1)\, ...\, 1/(n-m+1), n-m+1) paren.r) \
  $

  $p_m$은 면 $[i_m, ..., i_n]$의 barycenter이다.

  이때 아래의 부등식 체인이 성립하는데,

  $
    Δ^n = [i_0, i_1, ..., i_n] ⊃ [i_1, ..., i_n] ⊃ ... ⊃ [i_m, ..., i_n] ⊃ ... ⊃ [i_n]
  $

  위 체인의 각 면의 barycenter는 각각 $p_0, p_1, ..., p_m, ..., p_n$이다.
  따라서, $Δ^n$의 barycentric subdivision의 $n$-simplex 중 현재 순열
  $(i_0, i_1, ..., i_n)$에 대응하는 것은 $[p_0, p_1, ..., p_n]$이다.
  이 simplex를 $σ := [p_0, p_1, ..., p_n]$라 하자.

  이제 우리의 목표는 $R = σ$임을 보이는 것이다.

  == i) $σ ⊂ R$
  $p_m$의 정의상, $p_m$은 $p_m ∈ Δ^n, (p_m)_(i_0) ≤ (p_m)_(i_1) ≤ ... ≤ (p_m)_(i_n)$을 만족한다.

  $
       & 0 ≤ 0 ≤ ... ≤ 0 ≤ 1/(n-m+1) ≤ 1/(n-m+1) ≤ ... ≤ 1/(n-m+1) \
    => & (p_m)_(i_0) ≤ (p_m)_(i_1) ≤ ... ≤ (p_m)_(i_n)
  $

  $[p_0, p_1, ..., p_n]$안의 임의의 점 $q$는 $p_0, p_1, ..., p_n$의 convex
  combination이므로, $q$ 역시 $q ∈ Δ^n, (q)_(i_0) ≤ ... ≤ (q)_(i_n)$을
  만족한다. 즉, $q ∈ R$이다. 따라서, $[p_0, p_1, ..., p_n] ⊂ R$이고, $σ ⊂ R$이다.

  == ii) $σ ⊃ R$

  임의의 $t = (t_0, t_1, ..., t_n) ∈ R$에 대하여,

  $
    & a_0 := (n+1)t_(i_0) \
    & a_m := (n-m+1)(t_(i_m)-t_(i_(m-1))) quad (1 ≤ m ≤ n)
  $

  로 두자. $t ∈ R$이므로
  $t_(i_0) ≤ t_(i_1) ≤ ... ≤ t_(i_n)$이고, 따라서 각 $a_m ≥ 0$이다.

  또한,
  $
    sum_(m=0)^n a_m & = (n+1)t_(i_0) + sum_(m=1)^n (n-m+1)(t_(i_m)-t_(i_(m-1))) \
                    & = sum_(j=0)^n t_(i_j) \
                    & = sum_(k=0)^n t_k = 1
  $

  이므로 $(a_0, ..., a_n)$은 barycentric coordinates이다.

  이제 $u := sum_(m=0)^n a_m p_m$라 두면, $p_m$의 정의에 의해
  $m > j$이면 $(p_m)_(i_j) = 0$, $m ≤ j$이면 $(p_m)_(i_j) = 1/(n-m+1)$이다.
  따라서 각 $j = 0, 1, ..., n$에 대해
  $
    u_(i_j) & = sum_(m=0)^j a_m/(n-m+1) \
            & = t_(i_0) + sum_(m=1)^j (t_(i_m)-t_(i_(m-1))) \
            & = t_(i_j)
  $

  이다. 따라서 $u$와 $t$는 모든 barycentric coordinate가 같으므로 $u = t$이다.
  즉,
  $t = sum_(m=0)^n a_m p_m ∈ [p_0, p_1, ..., p_n] ⊂ σ$.

  임의의 $t ∈ R$에 대해 $t ∈ σ$이므로 $R ⊂ σ$이다.

  결론적으로 $σ ⊂ R$와 $R ⊂ σ$가 모두 성립하므로 $R = σ$.
]
