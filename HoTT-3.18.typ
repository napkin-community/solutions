#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set quote(block: true)
#set enum(numbering: "(i)")
#let cU = $cal(U)$
#let LEM = "LEM"
#let LDN = "LDN"
#let isProp = "isProp"
#let funext = "funext"

#plain_box(title: [HoTT-3.18])[
  Show that the law of excluded middle (3.4.1) and the law of double negation
  (3.4.2) are logically equivalent

  $
    LEM & defeq product_(A: cU) lr((isProp(A) -> (A + not A)), size: #150%) & " ⋯ (3.4.1)" \
    LDN & defeq product_(A: cU) lr((isProp(A) -> (not not A -> A)), size: #150%) & " ⋯ (3.4.2)"
  $
]

#solution(users.simnalamburt)[
  #let inl = "inl"
  #let inr = "inr"
  #let ap = "ap"
  #let ind = "ind"
  #let rec = "rec"
  #let never = math.bold("0")
  #let lem = "lem"
  #let ldn = "ldn"
  #let toLDN = "toLDN"
  #let toLEM = "toLEM"
  #let isPropNot = "isPropNot"
  #let isPropDec = "isPropDec"
  #let nnem = "nnem"

  + 먼저 $LEM -> LDN$ 을 증명하겠다.

    $lem : LEM$ 을 가정하자. 임의의 $A : cU$, $h_A : isProp(A)$ 에 대해
    $not not A -> A$ 를 만드는 함수 $toLDN(lem)(A)(h_A)$를 아래와 같이
    정의할 수 있다.

    $
                   toLDN & : LEM -> LDN \
      toLDN(lem)(A)(h_A) & defeq lambda (u : not not A).
                           rec_(A + not A)(
                             A,
                             lambda a. a,
                             lambda n. rec_(never)(A, u(n)),
                             lem(A)(h_A)
                           )
    $

    #text(size: 0.6em)[
      타입체크:

      $
        lem &: LEM ≡ product_(X : cU) (isProp(X) -> (X + not X)) \
        A &: cU \
        h_A &: isProp(A) \
        u &: not not A ≡ (not A -> never) \
        lem(A) &: isProp(A) -> (A + not A) \
        lem(A)(h_A) &: A + not A \
        lambda a. a &: A -> A \
        n &: not A ≡ (A -> never) \
        u(n) &: never \
        rec_(never)(A, u(n)) &: A \
        lambda n. rec_(never)(A, u(n)) &: not A -> A \
        rec_(A + not A)(
          A,
          lambda a. a,
          lambda n. rec_(never)(A, u(n)),
          lem(A)(h_A)
        ) &: A \
        lambda (u : not not A).
        rec_(A + not A)(
          A,
          lambda a. a,
          lambda n. rec_(never)(A, u(n)),
          lem(A)(h_A)
        ) &: not not A -> A \
        toLDN(lem)(A)(h_A) &: not not A -> A
      $
    ]

    따라서, $toLDN$ 은 $LEM -> LDN$ 의 witness 이다.

    \

  + 다음으로 $LDN -> LEM$ 을 증명하겠다.

    $ldn : LDN$ 을 가정하자. 임의의 $A : cU$와 $h_A : isProp(A)$에 대해
    $A + not A$를 만들기 위해, 먼저 보조정리 세 개를 구성하겠다.

    - 먼저 $not A$가 mere proposition임을 보이자.

      $
        isPropNot(A) & : isProp(not A) \
        isPropNot(A) & defeq lambda(f, g : not A). funext(lambda a. ind_never(f(a)))
      $

      #text(size: 0.6em)[
        타입체크:

        $
          A &: cU \
          not A &: A -> never \
          f, g &: not A ≡ (A -> never) \
          a &: A \
          f(a) &: never \
          g(a) &: never \
          ind_never(f(a)) &: f(a) = g(a) \
          lambda a. ind_never(f(a)) &: product_(a : A) (f(a) = g(a)) \
          funext(lambda a. ind_never(f(a))) &: f = g \
          lambda(f, g : not A). funext(lambda a. ind_never(f(a))) &: product_(f, g : not A) (f = g) \
          isPropNot(A) &: isProp(not A)
        $
      ]

    - 이제 $A + not A$가 mere proposition임을 보이자.

      $
                              isPropDec & : isProp(A) -> isProp(A + not A) \
        isPropDec(h_A)(inl(a), inl(a')) & defeq ap_inl (h_A(a, a')) \
         isPropDec(h_A)(inl(a), inr(n)) & defeq ind_never (n(a)) \
         isPropDec(h_A)(inr(n), inl(a)) & defeq ind_never (n(a)) \
        isPropDec(h_A)(inr(n), inr(n')) & defeq ap_inr (isPropNot(A)(n, n'))
      $

      #text(size: 0.6em)[
        타입체크:

        $
          h_A &: isProp(A) ≡ product_(x, y : A) (x = y) \
          a, a' &: A \
          n, n' &: not A \
          h_A(a, a') &: a = a' \
          ap_inl(h_A(a, a')) &: inl(a) = inl(a') \
          n(a) &: never \
          ind_never(n(a)) &: inl(a) = inr(n) \
          ind_never(n(a)) &: inr(n) = inl(a) \
          isPropNot(A)(n, n') &: n = n' \
          ap_inr(isPropNot(A)(n, n')) &: inr(n) = inr(n') \
          isPropDec(h_A) &: product_(x, y : A + not A) (x = y) defeq isProp(A + not A)
        $
      ]

      따라서, $A + not A$는 mere proposition이다.

    - 마지막으로 $not not (A + not A)$를 보이자.

      $
        nnem(A) & : not not (A + not A) \
        nnem(A) & defeq lambda k. k(inr(lambda a. k(inl(a))))
      $

      #text(size: 0.6em)[
        타입체크:

        $
          A &: cU \
          A + not A &: cU \
          k &: not (A + not A) ≡ ((A + not A) -> never) \
          a &: A \
          inl(a) &: A + not A \
          k(inl(a)) &: never \
          lambda a. k(inl(a)) &: A -> never ≡ not A \
          inr(lambda a. k(inl(a))) &: A + not A \
          k(inr(lambda a. k(inl(a)))) &: bold(0) ≡ never \
          lambda k. k(inr(lambda a. k(inl(a)))) &: not (A + not A) -> never \
          nnem(A) &: not not (A + not A)
        $
      ]

    이제 위의 세 보조정리를 사용해 $LDN -> LEM$ 의 witness를 직접 정의할 수
    있다.

    $
                   toLEM & : LDN -> LEM \
      toLEM(ldn)(A)(h_A) & defeq ldn(A + not A)(isPropDec(h_A))(nnem(A))
    $

    #text(size: 0.6em)[
      타입체크:

      $
        ldn &: LDN ≡ product_(X : cU) (isProp(X) -> (not not X -> X)) \
        A + not A &: cU \
        isPropDec(h_A) &: isProp(A + not A) \
        nnem(A) &: not not (A + not A) \
        ldn(A + not A) &: isProp(A + not A) -> (not not (A + not A) -> (A + not A)) \
        ldn(A + not A)(isPropDec(h_A)) &: not not (A + not A) -> (A + not A) \
        ldn(A + not A)(isPropDec(h_A))(nnem(A)) &: A + not A \
        toLEM(ldn)(A)(h_A) &: A + not A
      $
    ]

    따라서, $toLEM$ 은 $LDN -> LEM$ 의 witness 이다.

  결론적으로, $toLDN$ 과 $toLEM$ 이 존재하므로 $LEM$ 과 $LDN$ 은 논리적으로
  동치이다. #sym.qed
]
