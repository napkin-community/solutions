#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 8B])[
  Let $X$ be a topological space with the discrete topology. Under what
  conditions is $X$ compact?
]

#solution(users.simnalamburt)[
  $X$는 이산공간이므로 아래와 $X$를 구성하는 집합은 아래와 같은 꼴이고

  $
    X = {x_1, x_2, dots}
  $

  $X$의 토폴로지는 아래와 같다.

  $
    tau = {nothing, {x_1}, {x_2}, dots, {x_1, x_2}, {x_1, x_3}, dots, {x_1, x_2, x_3}, dots}
  $

  $X$ 가 유한 집합이면, $X$는 항상 compact하다. $X$의 모든 open cover
  ${U_alpha}$는 다음과 같은 꼴의 finite subcover를 갖기때문이다: For each $x_i ∈
  X$, we can select a $V_i$ which satisfies $x_i ∈ V_i ∈ {U_alpha}$. Then,
  ${V_i}$ is a finite subcover of ${U_alpha}$.

  $X$ 가 무한 집합이면, $X$는 compact하지 않다. 아래는 유효한 open cover인데,
  finite subcover를 갖지 않는다.

  $
    {U_alpha} = {{x} : x∈X}
  $

  $square$
]
