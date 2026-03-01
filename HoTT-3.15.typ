#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set quote(block: true)
#set enum(numbering: "(i)")
#let PropU = $"Prop"_cal(U)$
#let rec = $"rec"_T(A)$
#let isProp = "isProp"
#let funext = "funext"
#let lemma = "lemma"

#plain_box(title: [HoTT-3.15])[
  + Show that for any $A : cal(U)$, the type

    $
      product_(P: PropU) lr(((A -> P) -> P), size: #150%)
    $

    has the same recursion principle as $||A||$, at least relative to
    propositions in $cal(U)$, _with_ the same judgmental computation rule.

  + The type considered in the previous part does not lie in the same universe
    $cal(U)$, and its recursion principle only applies to propositions in
    $cal(U)$. Show that if we assume propositional resizing, we can define a
    type that does lie in the same universe $cal(U)$ and satisfies the same
    recursion principle as $||A||$, albeit with only a propositional
    computation rule. Thus, we can also define the propositional truncation in
    this case.
]

#solution(users.simnalamburt)[
  + 문제에 주어진 타입을 $T(A)$로 명명한다.
    $
      T(A) defeq product_(P: PropU) lr(((A -> P) -> P), size: #150%)
    $

    임의의 $a : A$ 를 $T(A)$로 보내는 함수 $η$를 아래와 같이 정의한다.
    $
         η & : A -> T(A) \
      η(a) & defeq lambda (P: PropU). lambda (f: A→P). f(a)
    $

    이제 임의의 mere proposition $P : PropU$와 함수 $f : A -> P$ 에
    대해, $T(A)$를 $P$로 보내는 함수 $rec(P, f)$를 정의할 수 있다.
    $
         rec(P, f) & : T(A) -> P \
      rec(P, f)(z) & defeq z(P)(f)
    $

    이때, 모든 $a : A$ 에 대해 아래가 성립한다.
    $
            & rec(P, f)(η(a)) \
      equiv & η(a)(P)(f)      & " … (β-reduction)" \
      equiv & f(a)            & " … (β-reduction)"
    $

    \

    이때, $||A||$의 recursion principle은 교재 117p와 같이 아래와 같이
    정의되어있다.

    #quote(attribution: [HoTT p.117])[
      If $B$ is a mere proposition and we have $f : A → B$, \
      then there is an induced $g : ||A|| → B$ such that $g(|a|) ≡ f(a)$ for
      all $a : A$.
    ]

    따라서 임의의 $P : PropU$와 $f : A -> P$에 대해
    $
              g & : ||A|| -> P \
      rec(P, f) & : T(A) -> P \
    $
    가 존재하고, 모든 $a : A$에 대해
    $
               g(|a|) & equiv f(a) \
      rec(P, f)(η(a)) & equiv f(a)
    $
    가 성립하는것이다.
    $
      |-| : A -> ||A||
    $
    를
    $
      η : A -> T(A)
    $
    로 바꾼 것과 정확히 같은 형태이며, 계산 규칙도 judgmental equality로 같다.

    \

  + 먼저 (i)의 $T(A)$가 mere proposition임을 증명하겠다.

    - $P : PropU$가 존재할 경우, $PropU$의 정의에 의해 $π_2(P) : isProp(P)$가
      존재한다.

      $
             P & : PropU ≡ {A : cal(U) | isProp(A)} ≡ sum_(A : cal(U)) isProp(A) \
        π_2(P) & : isProp(P)
      $

    - $P$가 mere proposition이면, $((A → P) → P)$도 mere proposition이다.

      $
        lemma &: isProp(P) -> isProp((A → P) → P) \
        lemma(h_P) &defeq λ(f, g : (A → P) → P). funext(λ(a : (A → P)). h_P(f(a), g(a)))
      $

      #text(size: 0.6em)[
        타입체크:

        $
          h_P &: isProp(P) ≡ product_(x, y : P) (x = y) \
          a &: A → P \
          f, g &: (A → P) → P \
          f(a), g(a) &: P \
          h_P(f(a), g(a)) &: (f(a) = g(a)) \
          λ(a : (A → P)). h_P(f(a), g(a)) &: product_(a : (A → P)) (f(a) = g(a)) \
          funext(λ(a : (A → P)). h_P(f(a), g(a))) &: (f = g) \
          lemma(h_P) ≡ λ(f, g : (A → P) → P). funext(λ(a : (A → P)). h_P(f(a), g(a))) &: product_(f, g : (A → P) → P) (f = g) defeq isProp((A → P) → P)
        $
      ]

    - 이때, $h_(T(A)) : isProp(T(A))$를 찾을 수 있다.

      $
        h_(T(A)) & : isProp(T(A)) \
        h_(T(A)) & defeq λ(f, g : T(A)). funext(λ(P : PropU). lemma(π_2(P))(f(P), g(P)))
      $

      #text(size: 0.6em)[
        타입체크:

        $
          P &: PropU \
          f, g &: T(A) ≡ product_(P: PropU) ((A → P) → P) \
          f(P), g(P) &: (A → P) → P \
          \
          lemma &: isProp(P) -> isProp((A → P) → P) \
          π_2(P) &: isProp(P) \
          lemma(π_2(P)) &: isProp((A → P) → P) ≡ product_(x, y : (A → P) → P) (x = y) \
          lemma(π_2(P))(f(P), g(P)) &: (f(P) = g(P)) \
          λ(P : PropU). lemma(π_2(P))(f(P), g(P)) &: product_(P : PropU) (f(P) = g(P)) \
          funext(λ(P : PropU). lemma(π_2(P))(f(P), g(P))) &: (f = g) \
          h_(T(A)) ≡ λ(f, g : T(A)). funext(λ(P : PropU). lemma(π_2(P))(f(P), g(P))) &: product_(f, g : T(A)) (f = g) defeq isProp(T(A))
        $
      ]

    따라서, $T(A)$는 mere proposition이다.

    \

    $T(A) ≡ product_(P: PropU) ((A → P) → P)$ 이므로, $P : PropU$에 의해 $T(A)$는
    $cal(U)$보다 한단계 더 큰 universe인 $cal(U^+)$에 속한다. 하지만 $T(A)$가
    mere proposition이므로, propositional resizing axiom을 가정하면 $T(A)$와
    동치인 타입 $T'(A)$를 $cal(U)$ 안에서 잡을 수 있다.

    $
       T(A) & : cal(U^+) \
      T'(A) & : cal(U) \
          e & : T'(A) ≃ T(A)
    $

    이제 $T(A)$의 $η, rec(P, f)$를, $T'(A)$의 $η', rec'(P, f)$로 옮기겠다.

    $
                 η' & : A -> T'(A) \
              η'(a) & defeq e^(-1)(η(a)) \
                    \
         rec'(P, f) & : T'(A) -> P \
      rec'(P, f)(z) & defeq e(z)(P)(f)
    $

    그러면 $a : A$ 에 대해 아래가 성립한다.
    $
      rec'(P, f)(η'(a))
      ≡ rec'(P, f)(e^(-1)(η(a))) & " … (β-reduction)" \
         ≡ e(e^(-1)(η(a)))(P)(f) & " … (β-reduction)" \
                    = η(a)(P)(f) & " … (equivalence)" \
                          ≡ f(a) & " … (β-reduction)" \
    $
    이때, path $e(e^(-1)(x)) = x$ 로 인해, 전체가 judgemental이 아닌 propositional equality이다.

    즉 $T'(A) : cal(U)$ 는 $||A||$와 비교했을때 계산 규칙이 propositional하게
    같은 recursion principle을 가진다.
]
