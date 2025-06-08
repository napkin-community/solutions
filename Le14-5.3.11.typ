#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Le14 5.3.11])[
  It was shown in Example 5.3.4 that the forgetful functor $U: bold("Grp") -> bold("Set")$ creates binary products.
  #set enum(numbering: "(a)")
  #enum.item[
    Using the formula for limits in $bold("Set")$ (Example 5.1.22), prove that, in fact, $U$ creates arbitrary limits.
  ]
  #enum.item[
    Satisfy yourself that the same is true if $bold("Grp")$ is replaced by any other category of algebras such as $bold("Ring")$, $bold("Ab")$, or $bold("Vect")_k$
  ]
]

#solution(users.finalchild)[
  #set enum(numbering: "(a)")
  #enum.item[
    $forall J in bold("Cat") " " forall F : J -> bold("Grp").$

    === A unique cone $(L', phi')$ to $F$ where $U(L')=L$ and $U(phi'_X)=phi_X$ exists.

    Let a cone $(L, phi)$ be the limit of $U compose F$, constructed using Example 5.1.22. This exists since all limits exist in $bold("Set")$.

    Let a cone $(L', phi')$ to $F$ where $U(L')=L$ and $U(phi'_X)=phi_X$. This says $L'$ is just $L$ with a group operation $dot_L'$ and $phi'_X=phi_X$.

    Since $phi_X$ is a group homomorphism, $phi_X (l_1 dot_L' l_2) = phi_X (l_1) dot_(F(X)) phi_X (l_2)$

    Thus, $l_1 dot_(L') l_2 = (phi_X (l_1) dot_(F(X)) phi_X (l_2))_(X in J)$, which is closed in $L$ since for all $f : X -> Y$ in $J$, $U(f)(phi_X (l_1 dot_(L') l_2))=U(f)(phi_X (l_1) dot_(F(X)) phi_X (l_2))=U(f)(phi_X (l_1)) dot_(F(Y)) U(f)(phi_X (l_2))=phi_Y (l_1) dot_(F(Y)) phi_Y (l_2)=phi_Y (l_1 dot_(L') l_2)$ satisfying the condition for inclusion in $L$.)

    Similarly, it can be shown that the inverse is closed in $L'$.

    This makes the unique group $L'$, and it can be verified that $L'$ is a group and each of $phi$ is a morphism in $bold("Grp")$ indeed. Moreover, $(L', phi)$ is a cone in $bold("Grp")$ (trivial since $(L, phi)$ is a cone in $bold("Set")$).

    === $(L', phi')$ is a limit cone.

    Let a cone $(N, psi)$ to $F$. Let $u : N -> L'$ such that $forall X in J " " phi'_X compose u = psi_X$. It immediately follows that $u(n) = (psi_X (n))_(X in J)$

    It can be verified that $u$ is indeed a group homomorphism.\
    $u(n_1 dot_(N) n_2)
    = (psi_X (n_1 dot_(N) n_2))_(X in J)
    = (psi_X (n_1) dot_(F(X)) psi_X (n_2))_(X in J)
    = (phi'_X (u(n_1)) dot_(F(X)) phi'_X (u (n_2)))_(X in J)
    = u(n_1) dot_(L') u(n_2)$.\
    Thus, $u$ is the unique arrow in $bold("Grp")$ factoring $(N, psi)$
  ]
  #enum.item[
    Satisfied myself.
  ]
]
