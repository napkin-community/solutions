#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#chili(2)#plain_box(title: [Problem 65C], subtitle: [RMM 2013])[
  Let $n ≥ 2$ be a positive integer. A stone is placed at
  each vertex of a regular 2$n$-gon. A move consists of selecting an edge of the 2$n$-gon and
  swapping the two stones at the endpoints of the edge. Prove that if a sequence of moves
  swaps every pair of stones exactly once, then there is some edge never used in any move.
]

#solution(users.finalchild)[
  Assume a sequence of moves that swaps every pair of stones exactly once.\
  Fix a stone $O$. Every other stone should swap with $O$ either clockwise or counterclockwise.\

  \

  Claim: the order of the stones is in the following form (clockwise):

  $ - A_x - dots - A_1 - O - B_1 - dots - B_y - $

  where $A_i$ swaps with $O$ clockwise and $B_i$ swaps with $O$ counterclockwise. $x$, $y$ can be zero.\
  Proof: Assuming a counterexample leads to a violation of the rule on the sequence.

  \

  Let $A_0 = B_0 = O$ for convenience.\
  Claim: The edge between $B_y$ and $A_x$ is never used.\
  Proof:\
  The movement of $O$ is limited by the number of $A_i$s and $B_i$s, so crossing the edge is impossible.\
  Assume the edge is first used by some two stones other than $O$. Every combination of $A_i$ and $B_i$ leads to a violation of the rule on the sequence. #sym.qed
]
