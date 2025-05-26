#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#set text(font: ("New Computer Modern", "Hakgyoansim Bareonbatang"), size: 11pt)
#show math.equation: set text(font: "New Computer Modern Math", features: (
  "cv01",
))
#set par(spacing: 0.8em, justify: true)

$
  "Napkin:"\
  & H^A : 𝒜 → upright("Set") && H_A : 𝒜^op → upright("Set") \
  & H^A (X) := "Hom"_𝒜 (A, X) && H_A (X) := "Hom"_𝒜 (X, A) \
  & "(covariant Yoneda functor)" && "(contravariant Yoneda functor)" \
  \
  & H^• : 𝒜^op → [𝒜, upright("Set")] && H_• : 𝒜 → [𝒜^op, upright("Set")] \
  & H^• := A ↦ H^A && H_• := A ↦ H_A \
  & "(unnamed)" && "(unnamed)" \
  \
  \
  "Wikipedia:"\
  & h_A = "Hom"(A, -) && h^A = "Hom"(-, A) \
  & "(covariant hom-functor)" && "(contravariant hom-functor)" \
  \
  & h_• : 𝒞^op → upright("Set")^𝒞 && h^• : 𝒞 → upright("Set")^(𝒞^op) \
  & "(unnamed)" && "(unnamed)" \
  \
  \
  "nLab:"\
  & h^c : C → upright("Set") && h_c : C^op → upright("Set") \
  & h^c := "hom"(c, -) && h_c := "Hom"(-, c) \
  & "(hom-functor)" && "(hom-functor)" \
  \
  & Y : C → [C^op, upright("Set")] && C^op → [C, upright("Set")] \
  & "(Yoneda embedding)" && "(jokingly called the contravariant Yoneda embedding)" \
  \
  \
  "1Lab:"\
  & "Hom"[x,-] && "Hom"[-,x] \
  & "(hom-functor)" && "(hom-functor)" \
  \
  & よ: C → [C^op, upright("Sets")] && よ_"cov": C^op → [C, upright("Sets")] \
  & "(Yoneda embedding)" && "(covariant yoneda embedding)" \
$
