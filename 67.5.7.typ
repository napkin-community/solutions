#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#black_note[Exercise 67.5.7][
  Show that in $bold("Set")$, $bold("Grp")$, $bold("Ab")$, $bold("Vect")_k$, $bold("Top")$, the notions of epic and surjective
  coincide. (For $bold("Set")$, take $A = {0, 1}$.)
]

#solution(users.finalchild)[
  Consider an arrow $f : X -> Y$ in the category. The proof #sym.arrow.l.double direction is almost the same for all concrete categories, so it's only written once.

  == $bold("Set")$

  #sym.arrow.double) $forall y in Y$, consider $g : Y -> {0, 1} = a mapsto 0$ and $h : Y -> {0, 1} = a mapsto (a =? y)$. Since $f$ is epic, $g compose f != h compose f$. Thus, $exists x in X. " " f(x) = y$.  #sym.qed

  #sym.arrow.l.double) $forall A in bold("Set"), forall g : Y -> A, forall y in Y$. Since $f$ is surjective, $exists x in X. f(x) = y$.  $g(y) = (g compose f)(x)$. Thus, $g$ is determined by $g compose f$. #sym.qed

  == $bold("Grp")$

  #sym.arrow.double) Cannot find proof with learnt concepts.

  == $bold("Ab")$

  #sym.arrow.double) Consider $g : Y -> Y slash "Im" f = a mapsto 1 "Im" f$ and $h : Y -> Y slash "Im" f = a mapsto a "Im" f$. Since $f$ is epic and $g compose f = h compose f$, $g = h$. Thus, $"Im" f = Y$. #sym.qed

  == $bold("Vect")_k$

  #sym.arrow.double) Consider $g : Y -> Y slash "Im" f = a mapsto 0 + "Im" f$ and $h : Y -> Y slash "Im" f = a mapsto a + "Im" f$. Since $f$ is epic and $g compose f = h compose f$, $g = h$. Thus, $"Im" f = Y$. #sym.qed

  == $bold("Top")$

  #sym.arrow.double) Consider $g : Y -> Y slash "Im" f = a mapsto ["Im" f]$ and $h : Y -> Y slash "Im" f = a mapsto [a]$. Since $f$ is epic and $g compose f = h compose f$, $g = h$. Thus, $"Im" f = Y$. #sym.qed

]
