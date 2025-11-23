#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let sp = " "

#plain_box(title: "HoTT-1.8")[
  Define multiplication and exponentiation using $"rec"_ℕ$. Verify that $(ℕ, +, 0, ×, 1)$ is a semiring using only $"ind"_ℕ$. You will probably also need to use symmetry and transitivity of equality, Lemmas 2.1.1 and 2.1.2.
]

#solution(users.finalchild)[
  = Definition of multiplication and exponentiation

  Define multiplication and exponentiation as follows. This is just like how we defined add. Note that exponentiate has an extra step that reverses the order of parameters.

  $ "multiply" :≡ "rec"_ℕ (ℕ→ℕ, λ n. 0, λ m. λ g. λ n.n+g(n)) $

  $
    "exponentiate" :≡ λ m.λ n. "rec"_ℕ (ℕ→ℕ, λ m. 1, λ n. λ g. λ m. m × g(m))(n, m)
  $

  \

  = $(ℕ, +, 0, ×, 1)$ is a semiring

  Now we verify that $(ℕ, +, 0, ×, 1)$ is a semiring. Note that $"summon"(T)$ is a notation for summoning a known proof that becomes type $T$ with appropriate arguments.

  == $(ℕ, +, 0)$ is a commutative monoid

  Prove $i+j+k=i+(j+k)$ with induction.

  $ "assoc"_(+):∏_(i,j,k:ℕ)i+j+k=i+(j+k) $

  $
    "assoc"_(+):≡"ind"_ℕ (λ(i:ℕ). ∏_(j,k:ℕ)i+j+k=i+(j+k), "assoc"_(+,0), "assoc"_(+,"s"))
  $

  $ "assoc"_(+,0):∏_(j,k:ℕ) 0+j+k=0+(j+k) $

  $ "assoc"_(+,0)(j,k):≡"refl"_(j+k) $

  $
    "assoc"_(+,"s"):∏_(i:ℕ)(∏_(j,k:ℕ)i+j+k=i+(j+k))→"succ"(i)+j+k="succ"(i)+(j+k)
  $

  $ "assoc"_(+,"s")(h,i,j,k):≡ "ap"_"succ" (h(j,k)) $

  Prove that 0 is the identity of $(ℕ,+)$.

  $ λ i. "refl"_i : ∏_(i:ℕ) 0+i=i $

  $
    "ind"_ℕ (λ(i:ℕ).sp i+0=i, "refl"_0, λ i. λ h. "ap"_("succ") (h)): ∏_(i:ℕ) i+0=i
  $

  Prove $i+j=j+i$ with double induction.

  $ "commut"_(+):∏_(i,j:ℕ) i+j=j+i $

  $
    "commut"_(+):"ind"_ℕ (λ(i:ℕ). ∏_(j:ℕ) i+j=j+i, "commut"_(+,0), "commut"_(+,"s"))
  $

  $ "commut"_(+,0):∏_(j:ℕ) 0+j=j+0 $

  $ "commut"_(+,0)(j):≡"summon"(j+0=j))^(-1) $

  $ "commut"_(+,"s"):∏_(i:ℕ)(∏_(j:ℕ) i+j=j+i)→∏_(j:ℕ)"succ"(i)+j=j+"succ"(i) $

  $
    "commut"_(+,"s")(i,h_1):≡"ind"_ℕ (λ(j:ℕ). "succ"(i)+j=j+"succ"(i), "summon"("succ"(i)+0="succ"(i)), "commut_inner"(i, h_1))
  $

  $
    "commut_inner":∏_(i:ℕ) (∏_(j:ℕ) i+j=j+i) → ∏_(j:ℕ) ("succ"(i)+j=j+"succ"(i)) → "succ"(i)+"succ"(j)="succ"(j)+"succ"(i)
  $

  Prove $"commut_inner"(i, h_1, j, h_2)$ with the composition of three equalities:
  $
      & "succ"(i+"succ"(j)) \
    = & "succ"^2(j+i) #h(1cm) && ("by" h_1) \
    = & "succ"^2(i+j)         && ("by" h_1) \
    = & "succ"(j+"succ"(i))   && ("by" h_2)
  $

  $
    "commut_inner"(i, h_1, j, h_2) :≡ "ap"_"succ" (h_1("succ"(j)))⋅"ap"_("succ"^2)(h_1(j))^(-1)⋅"ap"_"succ" (h_2)
  $

  == Axioms on ×

  Prove that 1 is the identity of $(ℕ,×)$.

  $ λ i. "summon"(i+0=i) : ∏_(i:ℕ) 1×i=i $

  $
    "ind"_ℕ (λ(i:ℕ).sp i×1=i, "refl"_0, λ i. λ h. "ap"_("succ") (h)): ∏_(i:ℕ) i×1=i
  $

  Prove 0 annihilates multiplication.

  $ λ i. "refl"_0: ∏_(i:ℕ) 0×i=0 $

  $ "ind"_ℕ (λ(i:ℕ).sp i×0=0, "refl"_0, λ i. λ h. h): ∏_(i:ℕ) i×0=0 $

  Prove distribution.

  $ "distrbl": ∏_(i,j,k:ℕ) i×(j+k)=i×j+i×k $

  $
    "distrbl":≡"ind"_ℕ (λ(i:ℕ). ∏_(j,k:ℕ) i×(j+k)=i×j+i×k,"distrbl"_0,"distrbl"_"s")
  $

  $ "distrbl"_0 : ∏_(j,k:ℕ) 0×(j+k)=0×j+0×k $

  $ "distrbl"_0 (j,k):≡"refl"_0 $

  $
    "distrbl"_"s" : ∏_(i:ℕ) (∏_(j,k:ℕ) i×(j+k)=i×j+i×k) → ∏_(j,k:ℕ) "succ"(i)×(j+k)="succ"(i)×j+"succ"(i)×k
  $

  Prove $"distrbl"_s (i,h,j,k)$ by the composition of equalities:
  $
      & j+k+i×(j+k) \
    = & j+k+(i×j+i×k)#h(1cm) && ("by" h) \
    = & j+(k+i×j+i×k)        && ("by" "assoc"_+) \
    = & j+(i×j+k+i×k)        && ("by" "commut"_+) \
    = & j+(i×j+(k+i×k))      && ("by" "assoc"_+) \
    = & j+i×j+(k+i×k)        && ("by" "assoc"_+)
  $

  I omit the explicit term for this composition. The components are just $h$, $"commut"_+$ and $"assoc"_+$ wrapped with ap.

  $ "distribr": ∏_(i,j,k:ℕ) (i+j)×k=i×k+j×k $

  $
    "distribr":≡"ind"_ℕ (λ(i:ℕ). ∏_(j,k:ℕ) (i+j)×k=i×k+j×k,"distribr"_0,"distribr"_"s")
  $

  $ "distribr"_0 : ∏_(j,k:ℕ) (0+j)×k=0×k+j×k $

  $ "distribr"_0(j,k):≡"refl"_(j×k) $

  $
    "distribr"_"s" : ∏_(i:ℕ) (∏_(j,k:ℕ) (i+j)×k=i×k+j×k)→ ∏_(j,k:ℕ) ("succ"(i)+j)×k="succ"(i)×k+j×k
  $

  Prove $"distribr"_s (i,h,j,k)$ by the composition of equalities:

  $
      & k+(i+j)×k \
    = & k+(i×k+j×k) #h(1cm) && ("by" h) \
    = & k+i×k+j×k           && ("by" "assoc"_+) \
  $

  Prove $i×j×k=i×(j×k)$ with induction.

  $ "assoc"_(×):∏_(i,j,k:ℕ)i×j×k=i×(j×k) $

  $
    "assoc"_(×):≡"ind"_ℕ (λ(i:ℕ). ∏_(j,k:ℕ)i×j×k=i×(j×k), "assoc"_(×,0), "assoc"_(×,"s"))
  $

  $ "assoc"_(×,0):∏_(j,k:ℕ) 0×j×k=0×(j×k) $

  $ "assoc"_(×,0)(j,k):≡"refl"_0 $

  $
    "assoc"_(×,"s"):∏_(i:ℕ)(∏_(j,k:ℕ)i×j×k=i×(j×k))→"succ"(i)×j×k="succ"(i)×(j×k)
  $

  Prove $"assoc"_(×,"s")(i,h)$ by the composition of equalities:

  $
      & (j+i×j)×k \
    = & j×k+i×j×k #h(1cm) && ("by" "distribr") \
    = & j×k+i×(j×k)       && ("by" h)
  $

  Therefore, $(ℕ, +, 0, ×, 1)$ is a semiring.
]
