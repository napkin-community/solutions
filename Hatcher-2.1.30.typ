#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/commute:0.3.0": arr, commutative-diagram, node

#plain_box(title: "AT-2.1.30")[
  In each of the following commutative diagrams assume that all maps but one are isomorphisms. Show that the remaining map must be an isomorphism as well.
]

#solution(users.finalchild)[
  Two trivial properties of isomorphisms in a category:
  Inverse of an isomorphism is an isomorphism. Finite composition of isomorphisms is also an isomorphism.

  From the commutative diagrams, each map can be represented as a composition of other isomorphisms or inverses of other isomorphisms. Thus, the map is an isomorphism. #sym.qed
]
