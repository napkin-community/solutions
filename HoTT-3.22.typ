#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let link = text.with(fill: rgb("#007300"))
#let Fin = math.sans("Fin")
#plain_box(title: "HoTT 3.22")[
  As in classical set theory, the finite version of the axiom of choice is a theorem.
  Prove that the axiom of choice (#link[3.8.1]) holds when $X$ is a finite type $Fin(n)$ (as defined in Exercise #link[1.9]).
]

#solution(users.kiwiyou)[
  #let acfin = math.sans("acfin")
  #let AC(X) = {
    $
      (product_(x: #X) norm(sum_(a: A(x)) P(x, a), size: #2em))
      -> norm(sum_(lr((g: product_((x: #X)) A(x)), size: #1em)) product_((x: #X)) P(x, g(x)), size: #2em)
    $
  }
  #plain_box(title: "Theorem", subtitle: "Finite Axiom of Choice")[
    Assume $n: NN$ and type families
    $
      A: Fin(n) -> cal(U) quad "and" quad P: product_(x: Fin(n)) A(x) -> cal(U),
    $
    there exists
    $
      acfin_n (A, P) : sans("AC")(Fin(n)),
    $
    where
    $
      sans("AC")(X) defeq AC(X).
    $
  ]

  We use the following definition of $Fin(n)$:
  #let succ = math.sans("succ")
  $
    Fin(0) defeq bold(0) \
    Fin(succ(n)) defeq Fin(n) + bold(1).
  $

  From this it's natural to prove $acfin_n$ by induction principle of $NN$.
  First unfold the definition of $Fin(0)$.

  $
    acfin_0 (A, P) : AC(Fin(0)) \
    equiv AC(bold(0))
  $

  We can directly construct the $g$ and $product P(x, g(x))$ from $x : bold(0)$.

  #let rec = math.sans("rec")
  $
                                            x & : bold(0) \
                        rec_bold(0) (A(x), x) & : A(x) \
    g_0 defeq lambda x. rec_bold(0) (A(x), x) & : product_((x: bold(0))) A(x)
  $
  $
    x &: bold(0) \
    rec_bold(0) (P(x, g(x)), x) &: P(x, g(x)) \
    h_0 defeq lambda x. rec_bold(0) (P(x, g(x)), x) &: product_((x: bold(0))) P(x, g(x))
  $

  Combine $g_0$ and $h_0$ and truncate finalizes the base case.
  $
    (g_0, h_0) &: sum_(lr((g: product_((x: bold(0))) A(x)), size: #1em)) product_((x: bold(0))) P(x, g(x)) \
    abs((g_0, h_0)) &: norm(sum_(lr((g: product_((x: bold(0))) A(x)), size: #1em)) product_((x: bold(0))) P(x, g(x)), size: #2em) \
    acfin_0 (A, P) defeq lambda f. abs((g_0, h_0)) &: AC(bold(0))
  $

  Next we prove the induction step, deriving $acfin_succ(n)$ from $acfin_n$.
  First we unfold the definition of $Fin(succ(n))$:
  $
    acfin_succ(n) (A, P) : AC(Fin(n) + bold(1)).
  $

  To make use of induction hypothesis $acfin_n$, let
  #let inl = math.sans("inl")
  $
    y : Fin(n) \
    inl(y) : Fin(n) + bold(1) \
    B(y) defeq A(inl(y)) \
    Q(y, B(y)) defeq P(inl(y), B(y)) \
  $
  then
  $
    acfin_n (B, Q) : (product_(y: Fin(n)) norm(sum_(b: B(y)) Q(y, b), size: #2em))
    -> norm(sum_(lr((g: product_((y: Fin(n))) B(y)), size: #1em)) product_((y: Fin(n))) Q(y, g(y)), size: #2em) \
    equiv (product_(y: Fin(n)) norm(sum_(b: A(inl(y))) P(inl(y), b), size: #2em))
    -> norm(sum_(lr((g: product_((y: Fin(n))) A(inl(y))), size: #1em)) product_((y: Fin(n))) P(inl(y), g(y)), size: #2em).
  $

  If we assume hypothesis $f_succ(n)$:
  $
    f_succ(n) &: product_(x: Fin(n) + bold(1)) norm(sum_(a: A(x)) P(x, a), size: #2em) \
    f_succ(n) compose inl &: product_(y: Fin(n)) norm(sum_(a: A(inl(y))) P(inl(y), a), size: #2em) \
    acfin_n (B, Q, f_succ(n) compose inl) &: norm(sum_(lr((g: product_((y: Fin(n))) A(inl(y))), size: #1em)) product_((y: Fin(n))) P(inl(y), g(y)), size: #2em).
  $

  If we have $g_n : product_((y : Fin(n))) A(inl(y))$ and $h_n : product_((y : Fin(n))) P(inl(y), g_n (y))$, we can wrap them to construct $g_succ(n)$ and $h_succ(n)$ partially.
  $
    g_succ(n) (inl(y)) defeq g_n (y) &: A(inl(y)) \
    h_succ(n) (inl(y)) defeq h_n (y) &: P(inl(y), g_n (y)) equiv P(inl(y), g_succ(n) (inl(y)))
  $

  #let inr = math.sans("inr")
  If we also have $a: A(inr(star))$ and $p: P(inr(star), a)$, we can wrap them to complete our $g_succ(n)$ and $h_succ(n)$.
  $
    g_succ(n) (inr(star)) defeq a &: A(inr(star)) \
    h_succ(n) (inr(star)) defeq p &: P(inr(star), a) equiv P(inr(star), g_succ(n) (inr(star)))
  $

  Our previous two dependencies are propositional truncation; and our goal is mere proposition. Applying recursion principle of $norm(-)$ give us a full proof.

  $
    acfin_n (B, Q, f_succ(n) compose inl) &: norm(sum_(lr((g: product_((y: Fin(n))) A(inl(y))), size: #1em)) product_((y: Fin(n))) P(inl(y), g(y)), size: #2em) \
    (g_n, h_n) &: sum_(lr((g: product_((y: Fin(n))) A(inl(y))), size: #1em)) product_((y: Fin(n))) P(inl(y), g(y)) \
    f_succ(n) (inr(star)) &: norm(sum_(a: A(inr(star))) P(inr(star), a), size: #2em) \
    (a, p) &: sum_(a: A(inr(star))) P(inr(star), a) \
    abs((g_succ(n), h_succ(n))) &: norm(sum_(lr((g: product_((x: Fin(succ(n)))) A(x)), size: #1em)) product_((x: Fin(succ(n)))) P(x, g(x)), size: #2em) \
  $
  #sym.qed
]
