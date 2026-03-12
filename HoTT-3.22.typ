#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let Fin = math.sans("Fin")
#let AC = math.sans("AC")
#let acfin = math.sans("acfin")
#let ind = math.sans("ind")
#let rec = math.sans("rec")
#let inl = math.sans("inl")
#let inr = math.sans("inr")

#plain_box(title: "HoTT 3.22")[
  As in classical set theory, the finite version of the axiom of choice is a theorem.
  Prove that the axiom of choice holds when $X$ is a finite type $Fin(n)$.
]

#solution(users.kiwiyou)[
  For a type $X$, let
  $
    AC(X)
    defeq
    (product_(x: X) norm(sum_(a: A(x)) P(x,a), size: #2em))
    ->
    norm(sum_(lr((g : product_((x: X)) A(x)), size: #1em)) product_((x: X)) P(x,g(x)), size: #2em),
  $
  where $A : X -> cal(U)$ and $P : product_(x: X) (A(x) -> cal(U))$.

  We prove by induction on $n : NN$ that for every
  $
    A : Fin(n) -> cal(U)
    quad "and" quad
    P : product_(x: Fin(n)) (A(x) -> cal(U)),
  $
  there is
  $
    acfin_n (A,P) : AC(Fin(n)).
  $

  We use the definition
  $
    Fin(0) defeq bold(0),
    quad
    Fin(n+1) defeq Fin(n) + bold(1).
  $

  == Base Case

  Since $Fin(0) defeq bold(0)$, it suffices to construct an element of $AC(bold(0))$.
  Let
  $
    f : product_(x: bold(0)) norm(sum_(a: A(x)) P(x,a), size: #2em).
  $
  By the induction principle of the empty type, define
  $
    g_0 : product_(x: bold(0)) A(x)
    quad "and" quad
    h_0 : product_(x: bold(0)) P(x,g_0(x)).
  $
  Therefore
  $
    (g_0,h_0) : sum_(lr((g : product_((x: bold(0))) A(x)), size: #1em)) product_((x: bold(0))) P(x,g(x)),
  $
  and hence
  $
    acfin_0 (A,P)(f) defeq abs((g_0,h_0))
  $
  is an element of $AC(bold(0))$.

  == Induction Step

  Assume
  $
    acfin_n :
    product_((A : Fin(n) -> cal(U)))
    product_(lr((P : product_(y: Fin(n)) (A(y) -> cal(U))), size: #1em))
    AC(Fin(n)).
  $
  We must construct $acfin_(n+1)$.

  Let
  $
    A : Fin(n)+bold(1) -> cal(U),
    quad
    P : product_(x: Fin(n)+bold(1)) (A(x) -> cal(U)),
  $
  and suppose
  $
    f : product_(x: Fin(n)+bold(1)) norm(sum_(a: A(x)) P(x,a), size: #2em).
  $
  Define restricted families on $Fin(n)$ by
  $
    B(y) defeq A(inl(y)),
    quad
    Q(y,b) defeq P(inl(y),b).
  $
  Then
  $
    f compose inl : product_(y: Fin(n)) norm(sum_(b: B(y)) Q(y,b), size: #2em),
  $
  so the induction hypothesis yields
  $
    u
    defeq
    acfin_n (B,Q)(f compose inl)
    :
    norm(sum_(lr((g_n : product_(y: Fin(n)) B(y)), size: #1em)) product_((y: Fin(n))) Q(y,g_n (y)), size: #2em).
  $
  Also,
  $
    v
    defeq
    f(inr(star))
    :
    norm(sum_(a: A(inr(star))) P(inr(star),a), size: #2em).
  $

  Let
  $
    T
    defeq
    norm(sum_(lr((g: product_(x: Fin(n)+bold(1)) A(x)), size: #1em)) product_((x: Fin(n)+bold(1))) P(x,g(x)), size: #2em).
  $
  Since $T$ is a propositional truncation, it is a mere proposition. Therefore we may eliminate both $u$ and $v$ into $T$.

  Assume representatives
  $
    (g_n,h_n) : sum_(lr((g_n: product_(y: Fin(n)) B(y)), size: #1em)) product_((y: Fin(n))) Q(y,g_n (y))
  $
  and
  $
    (a,p) : sum_(a: A(inr(star))) P(inr(star),a).
  $
  Define
  $
    g : product_((x: Fin(n)+bold(1))) A(x)
  $
  by coproduct recursion:
  $
    g(inl(y)) defeq g_n (y),
    quad
    g(inr(star)) defeq a.
  $
  Similarly define
  $
    h : product_((x: Fin(n)+bold(1))) P(x,g(x))
  $
  by coproduct recursion:
  $
    h(inl(y)) defeq h_n (y),
    quad
    h(inr(star)) defeq p.
  $
  Then
  $
    (g,h) : sum_(lr((g : product_((x: Fin(n)+bold(1))), A(x)), size: #1em)) product_((x: Fin(n)+bold(1))) P(x,g(x)),
  $
  so
  $
    abs((g,h)) : T.
  $

  Hence, by two applications of the elimination principle for propositional truncation into the mere proposition $T$, we obtain
  $
    acfin_(n+1) (A,P)(f) : T.
  $
  Concretely, we first eliminate $u$, then eliminate $v$, and on representatives $(g_n,h_n)$ and $(a,p)$ we return $abs((g,h)) : T$.

  This completes the induction, and therefore $AC(Fin(n))$ holds for every $n : NN$. #sym.qed
]
