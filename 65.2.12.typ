#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#black_note[Exercise 65.2.12][
  Let $X$ be a path-connected space.
  Prove that $X$ is #glossary[simply connected] if and only if $pi_1 (X)$ is the trivial group.
  (One direction is easy; the other is a little trickier.)
]

#solution(users.kiwiyou)[
  == $X$ is simply connected $==>$ $pi_1 (X)$ is the trivial group

  By definition of simply connected space, every loop $gamma$ is (path) homotopic to the "do-nothing" loop at $gamma(0)$, which is the identity element of $pi_1 (X)$.

  #plain_box(title: [Definition 7.7.4])[
    A space $X$ is #glossary[simply connected] if it's path-connected and for any points $p$ and $q$,
    all paths from $p$ to $q$ are homotopic.
  ]

  Since all elements of $pi_1 (X)$ are homotopic to the identity element, $pi_1 (X)$ is the trivial group. #h(1fr) #sym.qed

  #brown_box(subtitle: "Trivial group")[Example 1.1.17][
    The #glossary[trivial group], often denoted $0$ or $1$, is the group with only an identity element.
    I will use the notation ${1}$.
  ]


  == $X$ is simply connected $<==$ $pi_1 (X)$ is the trivial group

  Let $p, q in X$.

  For all path $a, b$ both from $p$ to $q$, note that $b ast.op overline(a) in pi_1 (X)$, which is the trivial group.

  $
    b
    tilde.eq b ast.op 1
    tilde.eq b ast.op (overline(a) ast.op a)
    tilde.eq (b ast.op overline(a)) ast.op a
    tilde.eq 1 ast.op a
    tilde.eq a
  $

  Therefore, $X$ is simply connected. #h(1fr) #sym.qed
]
