#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let imagP = $sum_((x: A)) P(x)$

#plain_box(title: "HoTT 3.20")[
  Prove Lemma #text(fill: rgb("#007300"))[3.11.9(ii)]: if $A$ is contractible with center $a$, then #imagP is equivalent to $P(a)$.
]

#solution(users.kiwiyou)[
  #let pr = math.sans("pr")
  #let refl = math.sans("refl")

  #let isContr = math.sans("isContr")
  $ (a, pi): isContr(A) equiv sum_((a: A)) product_((x: A)) (a = x). $
  Thus $pi(x) : a = x$ for each $x : A$.

  Use $pi(x)$ to transport $P(x)$ into $P(a)$:

  #let transport = math.sans("transport")
  $
    pi(x)^(-1)_* defeq transport^P (pi(x)^(-1), -) : P(x) -> P(a)
  $

  Define
  $
    f : (imagP) -> P(a) \
    f(z) defeq pi(pr_1(z))^(-1)_*(pr_2(z))
  $
  and
  $
    g : P(a) -> imagP \
    g(y) defeq (a, y).
  $

  == 1. Homotopy $g compose f ~ id$
  #let lift = math.sans("lift")
  #plain_box(title: "Lemma 2.3.2", subtitle: "Path lifting property")[
    Let $P : A -> cal(U)$ be a type family over $A$ and assume we have $u : P(x)$ for some $x : A$. Then for any $p : x = y$, we have $lift(u, p) : (x, u) = (y, p_*(u))$ in $sum_((x:A)) P(x)$, such that $pr_1(lift(u, p)) = p$.
  ]

  Let $z : imagP$. Apply path lifting to
  $
    u defeq pr_2(z) : P(pr_1(z)),
    quad
    p defeq pi(pr_1(z))^(-1) : pr_1(z) = a.
  $
  Then
  $
    lift(pr_2(z), pi(pr_1(z))^(-1))
    :
    (pr_1(z), pr_2(z))
    =
    (a, pi(pr_1(z))^(-1)_*(pr_2(z))).
  $
  Taking inverse and unfolding $f, g$ gives
  $
    g(f(z)) & equiv (a, pi(pr_1(z))^(-1)_*(pr_2(z))) && quad #[(#{ sym.beta }-reduction)] \
    & = (pr_1(z), pr_2(z)) && quad #[(path lifting)] \
    & = z. && quad #[(Corollary 2.7.3.)]
  $
  Hence $g compose f$ is homotopic to the identity on $imagP$.

  == 2. Homotopy $f compose g ~ id$

  Let $y : P(a)$. We compute
  $
    f(g(y))
    equiv f((a, y))
    equiv pi(a)^(-1)_*(y).
  $

  #let transportconst = math.sans("transportconst")
  #plain_box(title: "Lemma 2.3.5")[
    If $P : A -> cal(U)$ is defined by $P(x) defeq B$ for a fixed $B : cal(U)$,
    then for any $x, y : A$ and $p : x = y$ and $b : B$ we have a path
    $ transportconst^B_p (b) : transport^P (p, b) = b. $
  ]

  Applying *Lemma 2.3.5* to
  $
    B defeq P(a) : cal(U),
    quad
    p defeq pi(a)^(-1) : a = a,
    quad
    b defeq y : P(a).
  $
  Then
  $
    transportconst^(P(a))_(pi(a)^(-1)) (y) : pi(a)^(-1)_* (y) = y.
  $

  $f(g(y)) = y$ is inhabited, so $f compose g$ is homotopic to the identity on
  $P(a)$.

  The two homotopies show that $g$ is a quasi-inverse of $f$, hence
  $
    (imagP) tilde.eq P(a).
  $

  #sym.qed
]
