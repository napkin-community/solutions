#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "HoTT 3.12")[
  Show that if $"LEM"$ holds, then for all $A : 𝒰$ we have $‖(‖A‖→A)‖$.
]

#solution(users.finalchild)[
  By $"LEM"$, $‖A‖+¬‖A‖$. Casework.

  On case $‖A‖$, by recursion principle of $‖A‖$, it suffices to assume $a:A$ and prove with $|⋅ ↦ a|:‖‖A‖→A‖$.

  On case $¬‖A‖$, $‖A‖$ contradicts the assumption, thus $‖A‖→A$ by explosion. It follows that ‖‖A‖→A‖.
]
