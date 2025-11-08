#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let rec = math.sans("rec")
#let ind = math.sans("ind")
#let uniq = math.sans("uniq")
#let refl = math.sans("refl")
#let funext = math.sans("funext")
#let identity = math.sans("id")
#let boolean = math.bold("2")
#let fst = $(0_boolean)$
#let snd = $(1_boolean)$

#plain_box(title: "HoTT 1.6")[
  Show that if we define $A times B defeq product_(x : boolean) rec_boolean (cal(U), A, B, x)$, then we can give a definition of $ind_(A times B)$ for which the definitional equalities stated in #(sym.section)1.5 hold propositionally (i.e. using equality types). _(This requires the function extensionality axiom, which is introduced in #(sym.section)2.9.)_
]

#plain_box[
  #block(width: 100%)[
    $
      ind_(A times B): product_(C: A times B -> cal(U)) (product_((x: A)) product_((y: B)) C((x, y))) -> product_(x: A times B) C(x)
    $
    $ ind_(A times B) (C, g, (a, b)) defeq g(a)(b) $
    #place(horizon + right)[(#(sym.section)1.5)]
  ]
  #block(width: 100%)[
    $ funext: (product_(x:A) (f(x) = g(x))) -> (f = g) $
    #place(horizon + right)[(#(sym.section)2.9)]
  ]
]

#solution(users.kiwiyou)[
  From definition of $A times B defeq product_(x: boolean) rec_boolean (cal(U), A, B, x)$, we can natrally try defining our $ind_(A times B)$:

  $
    ind'_(A times B) (C, g, x) defeq g(x fst)(x snd)
  $

  Sadly, $ind'_(A times B)$ has a different type from $ind_(A times B)$ in #(sym.section)1.5:

  $
    ind'_(A times B) : product_(C : A times B -> cal(U)) (product_((x: A)) product_((y: B)) C((x, y))) -> product_(x: A times B) C((x fst, x snd))
  $

  How can we get value of type $product_(x: A times B) C(x)$ from that of type $product_(x: A times B) C((x fst, x snd))$?

  See this lemma, hidden in #(sym.section)2.3:

  #plain_box(title: "Lemma 2.3.1", subtitle: "Transport")[
    Suppose that $P$ is a type family over $A$ and that $p: x attach(=, br: A) y$. Then there is a function $p_* : P(x) -> P(y)$.
  ]

  So if we have $p: (x fst, x snd) = x$, we can transport $C((x fst, x snd))$ into $C(x)$. Let's call this $p$ as $uniq'_(A times B)$.

  $
    uniq'_(A times B) : product_(x: A times B) ((x fst, x snd) = x)
  $

  Since we don't have judgemental equality, it's time for the function extensionality axiom.

  $
    uniq'_(A times B) (x) defeq funext(
      ind_boolean (
        lambda y. ((x fst, x snd)(y) = x(y)),
        refl_(x fst),
        refl_(x snd)
      )
    )
  $

  Verify this by case analysis:

  $
    (lambda y. ((x fst, x snd)(y) = x(y)) fst & equiv ((x fst, x snd) fst = x fst) \
    & equiv ((ind_boolean (rec_boolean (cal(U), A, B), x fst, x snd)) fst = x fst) \
    & equiv (x fst = x fst) \
    & equiv refl_(x fst) \
    (lambda y. ((x fst, x snd)(y) = x(y)) snd & equiv ((x fst, x snd) snd = x snd) \
    & equiv ((ind_boolean (rec_boolean (cal(U), A, B), x fst, x snd)) snd = x snd) \
    & equiv (x snd = x snd) \
    & equiv refl_(x snd)
  $

  Finally, we have $uniq'_(A times B)(x)_* : C((x fst, x snd)) -> C(x)$ to complete $ind'_(A times B)$. This is a new definition:

  $
    ind'_(A times B) : product_(C : A times B -> cal(U)) (product_((x: A)) product_((y: B)) C((x, y))) -> product_(x: A times B) C(x) \
    ind'_(A times B) (C, g, x) defeq uniq'_(A times B)(x)_* (g(x fst)(x snd))
  $

  Remaining question: $ind'_(A times B) = ind_(A times B)$ holds?
]
