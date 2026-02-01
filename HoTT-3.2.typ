#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.2")[
  Prove that if A and B are sets, then so is A + B.
]

#solution(users.kiwiyou)[
  We want to construct:
  #let isSet = math.sans("isSet")
  #let isSetDistr = math.sans("isSetDistr")
  $ isSet_(A + B) : isSet(A) -> isSet(B) -> isSet(A + B) $

  Proof outline:
  #let eq(expr) = math.attach(math.eq, br: expr)
  #let code = math.sans("code")
  1. Using encode-decode method, suggest a type family $code(x, y) tilde.eq (x eq(A + B) y)$
  #let isProp = math.sans("isProp")
  2. Prove $isProp(code(x, y))$
  3. Prove $code(x, y) tilde.eq (x eq(A + B) y)$
  4. Prove $isSet(A + B)$ using univalence and transport

  == 1. Definition of $code(x, y)$

  #let inl = math.sans("inl")
  #let inr = math.sans("inr")
  #let ind = math.sans("ind")
  $x eq(A + B) y$ is hard to handle directly since there are two degenerate cases: $inl = inr$ and $inr = inl$.
  We use $code(x, y)$ to rule them out.

  $ code : product_(x, y : A + B) cal(U) $
  $ code(inl(a), inl(a')) defeq (a eq(A) a') $
  $ code(inr(b), inr(b')) defeq (b eq(B) b') $
  #let null = math.bold("0")
  $ code(inl(a), inr(b')) defeq null $
  $ code(inr(b), inl(a')) defeq null $
  We omit $null$ cases from now on.

  #let encode = math.sans("encode")
  We define $encode$ with path induction on $x$ and $y$.
  $ encode : product_(x, y: A + B) (x = y) -> code(x, y) $
  #let refl = math.sans("refl")
  $ encode(inl(a), inl(a), refl_inl(a)) defeq refl_a $
  $ encode(inr(b), inr(b), refl_inr(b)) defeq refl_b $

  #let decode = math.sans("decode")
  $decode$ needs case analysis.
  $ decode : product_(x, y : A + B) code(x, y) -> (x eq(A + B) y) $
  #let ap = math.sans("ap")
  $ decode(inl(a), inl(a'), c) defeq ap_inl (c) $
  $ decode(inr(b), inr(b'), c) defeq ap_inr (c) $

  == 2. Construction of $isProp(code(x, y))$

  $ isProp(code(x, y)) equiv product_(p, q : code(x, y)) (p = q) $

  The type seems a bit obscure, but case analysis on $x$ and $y$ reveals it is actually simple.

  $
    isProp_code: product_(u: isSet(A)) product_(v: isSet(B)) product_(x, y: A + B) product_(p, q : code(x, y)) (p = q)
  $
  #let summon = math.sans("summon")
  $ isProp_code (u, v, inl(a), inl(a'), p, q) defeq u(a, a', p, q) $
  $ isProp_code (u, v, inr(b), inr(b'), p, q) defeq v(b, b', p, q) $

  == 3. $code(x, y)$ and $(x eq(A + B) y)$ are equivalent

  To use univalence and transport, we need equivalence.

  Forward direction: when $x equiv inl(a)$ and $y equiv inl(a')$, $code(x, y) equiv (a = a')$.
  do a path induction with $a equiv a'$, $c equiv refl_a$:
  $
    encode(x, y, decode(x, y, c))
    &equiv encode(inl(a), inl(a), decode(inl(a), inl(a), refl_a)) \
    &equiv encode(inl(a), inl(a), ap_inl (refl_a)) \
    &equiv encode(inl(a), inl(a), refl_inl(a)) \
    &equiv refl_a \
    &equiv c
  $

  The case $x equiv inr(b)$ and $y equiv inr(b')$ is symmetric.

  Backward direction: path induction with $a = a'$, $p equiv refl_inl(a)$:
  $
    decode(x, y, encode(x, y, p))
    &equiv decode(inl(a), inl(a), encode(inl(a), inl(a), refl_inl(a))) \
    &equiv decode(inl(a), inl(a), refl_a) \
    &equiv ap_inl (refl_a) \
    &equiv refl_inl(a) \
    &equiv p
  $

  == 4. Construction of $isSet(A + B)$

  #let ua = math.sans("ua")
  #let transport = math.sans("transport")
  $
    isSet_(A + B)(u, v, x, y) defeq transport^isProp (ua(summon^(code(x, y) tilde.eq (x = y))))(isProp_code (u, v, x, y))
  $

  Sanity check:

  - $ua(summon^(code(x, y) tilde.eq (x = y)))$ is of type $code(x, y) eq(cal(U)) (x = y)$.
  - $transport^isProp (square: code(x, y) eq(cal(U)) (x = y))$ is of type $isProp(code(x, y)) -> isProp(x = y)$.
  - $isProp_code (u, v, x, y)$ is of type $product_(p, q : code(x, y)) (p = q) equiv isProp(code(x, y))$.
  - $isSet_(A + B)(u, v, x, y)$ is of type $isProp(x = y)$.
  - $isSet_(A + B)(u, v)$ is of type $product_(x, y: A + B) isProp(x = y) equiv isSet(A + B)$.
  #sym.qed
]
