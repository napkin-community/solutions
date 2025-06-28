#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 10D])[
  Suppose $T : CC^(plus.circle 2) -> CC^(plus.circle 2)$ is a linear map of $CC$-vector spaces such that $T^2011 = "id"$.
  Must $T$ be diagonalizable?
]

#solution(users.kiwiyou)[
  Yes.

  _Proof._
  $T$ has $2 times 2$ Jordan form, which can contain (1) two $1 times 1$ Jordan blocks, or (2) one $2 times 2$ Jordan block.

  #enum(numbering: "(1)", spacing: 1em)[
    Jordan form is $J = mat(lambda_1, 0; 0, lambda_2)$, which is trivially diagonalizable.
  ][
    Jordan form is $J = mat(lambda, 1; 0, lambda)$, then
    $
      J^2011 = mat(lambda^2011, 2011 lambda^2010; 0, lambda^2011) = I
    $
    Since $2011 lambda^2010 = 0$, $lambda = 0$ but $0 = lambda^2011 = 1$, which is contradiction.
  ]

  Therefore $T$ is diagonalizable. #h(1fr) #sym.qed
]
