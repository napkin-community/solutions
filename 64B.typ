#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "Problem 64B")[
  Realize the following spaces as CW complexes:

  (a) Möbius strip.

  (b) $ℝ$.

  (c) $ℝ^n$.
]

#solution(users.simnalamburt)[
  (a) Let's obtain the Möbius strip from the square $[0,1]×[0,1]$ by identifying
  $(1,t) ~ (0,1-t)$ for all $t∈[0,1]$.

  *0-cells.* There are two 0-cells:
  - $e_a^0$: $(0,0) ~ (1,1)$
  - $e_b^0$: $(0,1) ~ (1,0)$

  Hence $X^0 = {e_a^0, e_b^0}$.

  *1-cells.* There are three 1-cells:
  - $e^1$: the bottom edge, from $e_a^0$ to $e_b^0$, $(t,0)$
  - $f^1$: the top edge, from $e_a^0$ to $e_b^0$, $(1-t,1)$
  - $g^1$: the (identified) vertical edge, from $e_b^0$ to $e_a^0$, $(1,t)∼(0,1-t)$

  So $X^1 = {e^1, f^1, g^1}$ where $∂e^1 = {e_a^0, e_b^0}$,
  $∂f^1 = {e_a^0, e_b^0}$, $∂g^1 = {e_b^0, e_a^0}$.

  *2-cell.* Attach one 2-cell $σ^2$ whose boundary goes once around the square.
  Under the identification, the boundary loop is $e · g · f · g$ (note $g$
  appears twice with the same direction, creating the twist). Equivalently,
  attach $σ^2$ via the attaching map $S^1 → X^1$ that traverses the loop
  $e g f g$.

  Thus $X^2 = {σ^2}$ where $∂σ^2 = e · g · f · g$.

  \

  (b)

  $X^0 = {..., e_(-2)^0, e_(-1)^0, e_0^0, e_1^0, e_2^0, ...}$

  $X^1 = {..., e_([-2, -1])^1, e_([-1, 0])^1, e_([0, 1])^1, e_([1, 2])^1, ...}$ where
  $∂e_([n, n+1])^1 = {e_n^0, e_(n+1)^0}$,

  \

  (c)

  // TODO
  TBD
]
