#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let isContr = $"isContr"$
#let isProp = $"isProp"$
#let funext = $"funext"$
#let snd = $"snd"$
#let happly = $"happly"$

#plain_box(title: [HoTT-3.4])[
  Show that $A$ is a mere proposition if and only if $A -> A$ is contractible.
]

#solution(users.ranolp)[
  #enum[
    *($==>$) $A -> A$ is contractible $->$ $A$ is mere proposition*

    Since there's $e : isContr(A -> A)$, and by definition it is,

    $
      e : sum_(c:A->A) product_(x:A->A) (c=x)
    $

    so we can get $f defeq snd e$


    By definition, $isProp(A) equiv limits(product)_(x,y:A) (x=y)$ and we can define its element.

    #box(inset: (left: 2em))[
      $
        & "answer" : isProp(A) \
        & "answer "x" "y defeq happly((f(lambda \_. x)^(-1) dot f(lambda \_. y)), x)
      $
    ]

    #h(1fr) #sym.qed
  ][
    *($<==$) $A$ is mere proposition $->$ $A -> A$ is contractible*

    Given $f : isProp(A)$ we can construct $"answer"$

    $
      "answer" defeq (id, lambda x. funext(lambda a. f(id(a), x(a))))
    $
    #h(1fr) #sym.qed
  ]
]
