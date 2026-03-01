#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.14")[
  Show that assuming LEM, the double negation $not not A$ has the same recursion principle as the propositional truncation $||A||$ but with a propositional computation rule rather than a judgmental one. In other words, prove that assuming LEM, if $B$ is a mere proposition and we have $f : A -> B$, then there is an induced $g : not not A -> B$ such that $g(|a|) = f(a)$ for all $a : A$. Deduce that (assuming LEM) we have $not not A tilde.eq ||A||$. Thus, under LEM, the propositional truncation can be defined rather than taken as a separate type former.
]

#solution(users.kiwiyou)[
  #let PropU = $"Prop"_cal(U)$
  #let LEM = math.sans("LEM")
  #let isProp = math.sans("isProp")
  #let qinv = math.sans("qinv")
  #let rec = math.sans("rec")
  #let inl = math.sans("inl")
  #let inr = math.sans("inr")

  Assume
  $
    LEM : product_(P : PropU) (P + not P).
  $

  Fix $B : PropU$ and $f : A -> B$. We must build
  $
    rec_(not not A)(B, f) : not not A -> B.
  $
  So take $g : not not A$ and try to produce an element of $B$.

  What data do we have?

  + $f : A -> B$ only turns an $A$ into a $B$.
  + $g : not not A$ is $((A -> bold(0)) -> bold(0))$; it does not give $A$.
  + We do not have $LEM(A)$, and even with it this route is not needed.

  Therefore we cannot directly manufacture $B$ from $f$ and $g$.
  The only classical handle is to decide $B$ itself:
  $
    LEM(B) : B + not B.
  $
  This is why the eliminator must split on $B + not B$.

  + If $B$ holds, we return it via $id_B$.
  + If $h : not B$, then $h compose f : not A$, so $g(h compose f) : bold(0)$.
    From this contradiction, ex-falso gives an element of $B$.

  Hence the proof line is exactly
  $
    rec_(not not A)(B, f) defeq lambda g.
    rec_(B + not B)(
      B,
      id_B,
      lambda h. rec_(bold(0))(B, g(h compose f)),
      LEM(B)
    ).
  $

  Let
  $
    eta : A -> not not A \
    eta(a) defeq lambda u. u(a).
  $
  Then for each $a : A$ we have a propositional computation rule
  $
    rec_(not not A)(B, f)(eta(a)) = f(a),
  $
  by case analysis on $LEM(B)$: the $inl$ case is from $isProp(B)$, and the $inr$ case
  is absurd.

  Define
  $
    f : not not A -> ||A|| \
    f defeq rec_(not not A)(||A||, |-|),
  $
  and
  $
    g : ||A|| -> not not A \
    g defeq rec_(||A||)(not not A, lambda a. lambda u. u(a)).
  $

  Now $qinv(f)$ is immediate. We need
  $
    product_(x : not not A) (g(f(x)) = x)
    " and "
    product_(y : ||A||) (f(g(y)) = y).
  $
  Since both types are mere propositions,
  $
    isProp(not not A), isProp(||A||)
  $
  we can set
  $
    alpha(x) defeq isProp(not not A)(g(f(x)), x),
  $
  and
  $
    beta(y) defeq isProp(||A||)(f(g(y)), y).
  $
  Hence $qinv(f)$, so
  $
    not not A tilde.eq ||A||.
  $
  Therefore, under LEM, propositional truncation is definable from double
  negation, with only propositional computation.
  #sym.qed
]
