#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#plain_box(title: [Problem 70B], subtitle: [Five lemma])[
  In an abelian category, consider the commutative diagram

  #diagram(label-sep: 0em, {
    let (a, b, c, d, e) = ((0, 0), (1, 0), (2, 0), (3, 0), (4, 0))
    let (a_, b_, c_, d_, e_) = ((0, 1), (1, 1), (2, 1), (3, 1), (4, 1))

    node(a, $A$)
    node(b, $B$)
    node(c, $C$)
    node(d, $D$)
    node(e, $E$)

    node(a_, $A'$)
    node(b_, $B'$)
    node(c_, $C'$)
    node(d_, $D'$)
    node(e_, $E'$)

    edge(a, b, $p$, "-|>")
    edge(b, c, $q$, "-|>")
    edge(c, d, $r$, "-|>")
    edge(d, e, $s$, "-|>")

    edge(a_, b_, $p'$, "-|>", label-side: right)
    edge(b_, c_, $q'$, "-|>", label-side: right)
    edge(c_, d_, $r'$, "-|>", label-side: right)
    edge(d_, e_, $s'$, "-|>", label-side: right)

    edge(a, a_, $α$, marks: (none, (inherit: "|>", extrude: (0, -8))))
    edge(b, b_, $β$, "-|>")
    edge(b, b_, $≅$, "-|>", label-side: left)
    edge(c, c_, $γ$, "-|>")
    edge(d, d_, $δ$, "-|>")
    edge(d, d_, $≅$, "-|>", label-side: left)
    edge(e, e_, $ε$, "hook-|>")
  })

  where the two rows are exact, $β$ and $δ$ are isomorphism, $α$ is epic, and
  $ε$ is monic. Prove that $γ$ is an isomorphism.
]

#solution(users.simnalamburt)[
  #set par(spacing: 1.25em)

  Mitchell’s embedding theorem에 따라, 주어진 (small) abelian category를 left
  $R$-module의 category로 옮겨주는 full, faithful, exact functor가 존재한다.
  따라서, 주어진 문제를 left $R$-module 로 간주하고 풀겠다. (Object는 module,
  morphism은 module homomorphism에 대응됨)

  $γ$가 isomorphism임을 증명하려면, $γ$가 injective이고 surjective임을
  diagram chasing을 통해 증명하겠다. (공공장소에서 열람하지 말것)

  *1. $γ$가 injective임을 증명*

  $c in C$를 $γ c = 0$을 만족하는 원소라고 하자.

  주어진 commutative diagram에 의해, $δ r c = r' γ c$가 성립하고, $γ c =
  0$이므로, $δ r c = r' 0 = 0$이다.

  $δ$가 isomorphism이므로, injective하다. 따라서 $r c = 0$이다. Kernel의 정의에
  의해, $c in ker r$이다.

  윗 줄이 exact sequence이므로, $im q = ker r$이다. 따라서 $q b = c$ 를 만족하는
  $b in B$가 존재한다.

  주어진 commutative diagram에 의해, $q' β b = γ q b = γ c = 0$가 성립한다.
  Kernel의 정의에 의해, $β b in ker q'$이다.

  아랫 줄이 exact sequence이므로, $im p' = ker q'$이다. 따라서 $p' a' = β b$를
  만족하는 $a' in A'$가 존재한다.

  $α$는 epic이므로, surjective하여, $α a = a'$를 만족하는 $a in A$가 존재한다.

  주어진 commutative diagram에 의해, $β p a = p' α a = p' a' = β b$가 성립한다.

  $β$는 isomorphism이므로, injective하다. 따라서 $p a = b$이다.

  이를 $c$에 대해 표현하면, $c = q b = q p a$가 된다.

  윗 줄이 exact sequence이므로, $im p = ker q$이다. 이는 $q ∘ p = 0$을 의미한다.
  따라서, $c = q p a = 0$이다.

  $γ c = 0$이면 $c = 0$이므로, $γ$는 injective이다.

  *2. $γ$가 surjective임을 증명*

  임의의 원소 $c' in C'$에 대해, $γ c = c'$를 만족하는 $c in C$가 존재함을 보이면 된다.

  $δ$는 isomorphism이므로 surjective하다. 따라서 $δ d = r' c'$를 만족하는 $d in D$가 존재한다.

  주어진 commutative diagram에 의해, $ε s d = s' δ d = s' r' c'$가 성립한다.

  아랫 줄이 exact sequence이므로 $s' ∘ r' = 0$이다. 따라서 $ε s d = 0$이다.

  $ε$는 monic이므로 injective하다. 따라서 $s d = 0$이고, kernel의 정의에 의해 $d in ker s$이다.

  윗 줄이 exact sequence이므로 $im r = ker s$이다. 따라서 $r c_0 = d$를 만족하는 $c_0 in C$가 존재한다.

  주어진 commutative diagram에 의해 $r' γ c_0 = δ r c_0 = δ d = r' c'$이다.

  따라서 $r'(γ c_0 - c')=0$이고, kernel의 정의에 의해 $(γ c_0 - c') in ker r'$이다.

  아랫 줄이 exact sequence이므로 $im q' = ker r'$이다. 따라서 $q' b' = γ c_0 - c'$를 만족하는 $b' in B'$가 존재한다.

  $β$는 isomorphism이므로 surjective하다. 따라서 $β b = b'$를 만족하는 $b in B$가 존재한다.

  주어진 commutative diagram에 의해 $γ q b = q' β b = q' b'$이다.

  따라서 $γ q b = γ c_0 - c'$이고, 이 식을 $c'$에 대해 정리하면 $c' = γ c_0 - γ q b = γ(c_0 - q b)$이다.

  $c = c_0 - q b$라고 하면 $c in C$이므로, 임의의 $c'$에 대해 $γ c = c'$를 만족하는 $c$가 존재한다.

  따라서, $γ$는 surjective이다.

  결론적으로, $γ$는 injective이고 surjective이므로 isomorphism이다. #sym.qed
]
