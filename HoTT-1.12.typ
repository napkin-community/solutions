#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "HoTT-1.12")[
  Using the propositions as types interpretation, derive the following tautologies.

  (i)  If $A$, then (if $B$ then $A$).

  (ii) If $A$, then not (not $A$).

  (iii) If (not $A$ or not $B$), then not $(A$ and $B)$.
]

#solution(users.xtalclr)[
#let F = math.bold("0")
#let U = math.cal("U")
#let inl = math.sans("inl")
#let inr = math.sans("inr")
#let rec = math.sans("rec")
#let defeq = ":" + math.equiv
#let pr1 = $sans("pr")_1$
#let pr2 = $sans("pr")_1$

$sans("I") : A -> (B -> A)$

$sans("I") defeq lambda (a : A).(lambda (b : B). a)$

In words: Assume evidence $a$ of $A$. Then assuming the evidence $b$ of $B$, the statement $A$ is true because $a$ is an evidence of $A$.

$sans("II") : A -> ((A -> #F) -> #F)$

$sans("II") defeq lambda (a : A).(lambda (n : (A -> #F)). n(a))$

In words: Assume evidence $a$ of $A$. Assuming the evidence $n$ of not $A$, we get contradiction by evidence $a$ of $A$ and $n$ of not $A$. So it is impossible that not $A$.

$sans("III") : ((A -> #F) + (B -> #F)) -> (A times B) -> #F$

$sans("III") defeq lambda x. rec_((A -> #F) + (B -> #F))((A times B) -> #F, sans("case_a"), sans("case_b"), x)$ where

$
sans("case_a") : (A -> #F) -> (A times B) -> #F defeq lambda (c : A -> #F). lambda (p : A times B). c(pr1(p))
$

and

$
sans("case_b") : (B -> #F) -> (A times B) -> #F defeq lambda (c : B -> #F). lambda (p : A times B). c(pr2(p)).
$

In words: Assume either not $A$ or not $B$. One of them should be true.

(a) First assume the evidence $c$ of not $A$. Then that both $A$ and $B$ are true is impossible: since the evidence $p$ of both $A$ and $B$ gives the evidence $pr1(p)$ of $A$, we get contradiction by evidence $pr1(p)$ of $A$ and $c$ of not $A$.

(b) Now assume the evidence $c$ of not $B$. Then that both $A$ and $B$ are true is impossible: since the evidence $p$ of both $A$ and $B$ gives the evidence $pr2(p)$ of $B$, we get contradiction by evidence $pr2(p)$ of $B$ and $c$ of not $B$.

So in either case, that both $A$ and $B$ are true is impossible. So it is not that both $A$ and $B$ holds.
]
