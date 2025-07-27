#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.11")[
  Show that if $A$ is a retract of $X$ then the map $H_n (A)→H_n (X)$ induced by the inclusion $A$ ⊂ $X$ is injective.
]

#solution(users.finalchild)[
  The retract is the left inverse of the inclusion. By functoriality, the map induced by the retract is the left inverse of the map induced by the inclusion. Thus, the map induced by the inclusion is injective.
  #h(1fr) #sym.qed
]
