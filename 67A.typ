#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "Problem 67A")[
  In the category $sans("Vect")_k$ of $k$-vector spaces (for a field $k$), what are the initial and terminal objects?
]

#solution(users.ranolp)[
  The arrow of $sans("Vect")_k$ is a Linear Map, which preserves Vector Addition and Scalar Multiplication.

  #grid(columns: 2, gutter: 1em)[*Claim.*][The initial is ${0}$][*Proof.*][
    Suppose there's an arrow $f : {0} -> W$, since it's linear map, it should respect

    $
      f(c bold("v")) = c f (bold("v"))
    $

    Thus, for $c = 0$ and $f(bold("v")) = bold("w")$, $f(0_V) = f(0 bold("v")) = 0 f("v") = 0 bold("w") = 0_W$.

    Because the domain is ${0}$, there is no way to make a linear map other than $f(0_V) = 0_W$.

    Hence, there's only one arrow from ${0}$ to the other spaces. $qed$
  ]

  #grid(columns: 2, gutter: 1em)[*Claim.*][The terminal is ${0}$][*Proof.*][
    Suppose there's an arrow $f : V -> {0}$.
    Since the codomain is ${0}$, The function must be $f(bold("v")) = 0$, which is trivially linear map.

    Hence, there's only one arrow to ${0}$ from the other spaces. $qed$
  ]
]
