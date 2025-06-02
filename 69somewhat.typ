#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

#set page(height: auto)

#plain_box(title: "Problem 69 somewhat")[
  // Taking the limit is a process that receives as its input a diagram in a category $cal(A)$, and produces as its output a new object of $cal(A)$. Later we will see that this process is functorial (Proposition 6.1.4). Here you are asked to prove this in the case of binary products.

  Let $cal(A)$ be a category with binary products. Suppose that we have chosen for each pair $(X, Y)$ of objects a product cone

  $
    X <--^(p^(X,Y)_1) X times Y -->^(p^(X,Y)_2) Y.
  $

  Construct a functor $cal(A) times cal(A) -> cal(A)$ given on objects by $(X, Y) |-> X times Y$.
]



#solution(users.ranolp)[ ]
