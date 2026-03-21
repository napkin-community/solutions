#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let fib = math.sans("fib")
#let refl = math.sans("refl")
#let fst = $sans("pr")_1$
#let fibb = $lr(size: #1em, (b, refl_g(b)))$

#plain_box(title: "HoTT 4.4", subtitle: "The unstable octahedral axiom")[
  Suppose $f : A -> B$ and $g : B -> C$ and $b : B$.
  #enum(numbering: "(i)")[
    Show that there is a natural map $fib_(g compose f) (g(b)) -> fib_g (g(b))$ whose fiber over #fibb is equivalent to $fib_f (b)$.
  ][
    Show that $fib_(g compose f) (c) tilde.eq sum_((w: fib_g (c))) fib_f (fst w)$.
  ]
]

#solution(users.kiwiyou)[
  We solve (ii) first and (i) next.

  Define

  $
    h : fib_(g compose f) (g(b)) -> fib_g (g(b)) \
    h((a, p)) defeq (f(a), p)
  $

  as our desired map.

  *Theorem 1.* $h$ is natural.

  #align(center, diagram(
    cell-size: (4em, 4em),
    $
      fib_(g compose f) (g(b)) edge(fst, ->) edge("d", h, ->, dash: "dashed") & A edge(->) edge("d", f, ->) & C edge("d", id, ->) \
      fib_g (g(b)) edge(fst, ->) & B edge(g, ->) & C \
    $,
  ))

  This square commutes by definition: for $(a, p) : fib_(g compose f) (g(b))$,
  $
    (fst compose h)((a, p)) equiv f(a) equiv (f compose fst)(a, p).
  $
  Applying $g$ to either side gives the same point of $C$, namely $(g compose f)(a)$.

  *Theorem 2.* For every $c : C$,
  $
    fib_(g compose f)(c) tilde.eq sum_((w: fib_g (c))) fib_f (fst w).
  $

  First,

  $
    sum_((w: fib_g (c))) fib_f (fst w)
    &defeq sum_((y, p) : fib_g (c)) fib_f (y) \
    &equiv sum_((y, p) : fib_g (c)) sum_(a : A) (f(a) = y) \
    &equiv sum_(a : A) sum_(y : B) sum_(q : f(a) = y) (g(y) = c).
  $

  Fix $a : A$. Consider the family
  $
    Q_a ((y, q)) defeq (g(y) = c)
  $
  on $(y, q) : sum_(y : B) (f(a) = y)$.

  Note that the base $sum_(y : B) (f(a) = y)$ is contractible with center $(f(a), refl_f(a))$ using the left universal property of identity types.

  #plain_box(title: "Lemma 3.11.9")[
    Let $P : A -> cal(U)$ be a type family.

    (ii) if $A$ is contractible with center $a$, then $sum_((x: A)) P(x)$ is equivalent to $P(a)$.
  ]

  Applying the lemma with
  $
    A defeq sum_(y : B) (f(a) = y), quad a defeq (f(a), refl_f(a)), quad P(x) defeq Q_a (x)
  $
  gives us
  $
    sum_(y : B) sum_(q : f(a) = y) (g(y) = c) & tilde.eq Q_a (f(a), refl_f(a)) \
                                              & equiv (g(f(a)) = c).
  $

  Therefore
  $
    sum_((w: fib_g (c))) fib_f (fst w) & tilde.eq sum_(a : A) (g(f(a)) = c) \
                                       & equiv fib_(g compose f)(c).
  $
  #sym.qed

  *Theorem 3.* $fib_h (fibb) tilde.eq fib_f (b)$.

  Apply *Theorem 2* with $c defeq g(b)$:
  $
    fib_(g compose f)(g(b))
    tilde.eq
    sum_((w: fib_g (g(b)))) fib_f (fst w).
  $

  Under this equivalence, the map $h$ is exactly the first projection
  $
    fst : (sum_((w: fib_g (g(b)))) fib_f (fst w)) -> fib_g (g(b)),
  $
  since both maps send $(a, p)$ to $(f(a), p)$.

  Hence
  $
    fib_h (fibb)
    tilde.eq
    fib_(fst)(fibb).
  $

  #plain_box(title: "Lemma 4.8.1")[
    For any type family $B : A -> cal(U)$, the fiber of $fst : (sum_((x : A)) B(x)) -> A$ over $a : A$ is equivalent to $B(a)$:
    $ fib_fst (a) tilde.eq B(a) $
  ]
  Applying the lemma with
  $ A defeq fib_g (g(b)), quad a defeq fibb, quad B(x) defeq fib_f (fst x) $
  gives us
  $
    fib_fst (fibb) & tilde.eq
                     fib_f (fst(fibb)) \
                   & equiv
                     fib_f (b).
  $
  #sym.qed
]
