#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "AT-2.1.12")[
  Show that chain homotopy of chain maps is an equivalence relation.
]

#solution(users.kiwiyou)[
  Given two chain maps $f_sharp, g_sharp : C_n (X) -> C_n (Y)$,
  let's say $f_sharp tilde g_sharp$ if there exists a chain homotopy $P : C_n (X) -> C_(n+1) (Y)$.

  We want to show that $tilde$ is an equivalence relation.

  == 1. Reflexivity

  $
    f_sharp - f_sharp & = 0 \
                      & = partial (0) + 0 \
                      & = partial bold(0) + bold(0) partial \
  $
  #h(1fr) #sym.qed

  == 2. Symmetry

  $
    f_sharp tilde g_sharp & ==> exists P : partial P + P partial = g_sharp - f_sharp \
    & ==> exists P : partial (-P) + (-P) partial = f_sharp - g_sharp \
    & ==> g_sharp tilde f_sharp
  $
  #h(1fr) #sym.qed

  == 3. Transitivity

  Let's introduce another chain map $h_sharp : C_n (X) -> C_(n+1) (Y)$.

  $
    f_sharp ~ g_sharp and g_sharp tilde h_sharp &==> exists P, Q : partial P + P partial = g_sharp - f_sharp and partial Q + Q partial = h_sharp - g_sharp \
    &==> exists P, Q : partial (P + Q) + (P + Q) partial = h_sharp - f_sharp \
    &==> f_sharp tilde h_sharp
  $
  #h(1fr) #sym.qed
]
