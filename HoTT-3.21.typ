#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let isProp = "isProp"
#let isequiv = "isequiv"
#let rec = "rec"
#let id = "id"
#let refl = "refl"

#plain_box(title: "HoTT 3.21")[
  Prove that $isProp(P)≃(P≃‖P‖)$.
]

#solution(users.finalchild)[
  Note that both $isProp(P)$ and $P≃‖P‖$ are mere propositions.
  The latter is derived from equivalence being a dependent product of a function and its $isequiv$, both of which being mere propositions:
  $ isProp (P→‖P‖) $
  $ "Given" f:P→‖P‖, " " isProp (isequiv f) $

  Thus it suffices to show $isProp(P)↔(P≃‖P‖)$. Both sides being mere propositions automatically proves inverseness.

  Right direction is Lemma 3.9.1.

  Left direction: Given $e:P≃‖P‖$ and $p_1,p_2:P$, $p_1=e^(-1) thin (e thin p_1) = e^(-1) thin (e thin p_2)=p_2$.
]
