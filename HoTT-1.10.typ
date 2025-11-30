#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#let ack = math.op("ack")
#let rec = math.op("rec")
#let suc = math.op("succ")
#let sp = " "

#plain_box(title: "HoTT-1.10")[
  Show that the Ackermann function $ack : ℕ → ℕ → ℕ$ is definable using only $rec_ℕ$ satisfying the following equations:

  $
              ack(0, n) & ≡suc(n) \
         ack(suc(m), 0) & ≡ack(m, 1) \
    ack(suc(m), suc(n)) & ≡ack(m, ack(suc(m), n))
  $
]

#solution(users.finalchild)[
  $
    ack defeq rec_ℕ (ℕ→ℕ,suc, λ(m:ℕ).sp λ(f:ℕ→ℕ).sp rec_ℕ (ℕ,f(1), λ(n:ℕ).sp λ(c:ℕ).sp f(c)))
  $

  Verify the equations:
  $ ack(0) ≡ suc $
  $ ack(suc(m)) ≡ rec_ℕ (ℕ,ack(m, 1), λ(n:ℕ).sp λ(c:ℕ).sp ack(m, c)) $
  Thus
  $ ack(0, n) ≡ suc(n) $
  $ ack(suc(m), 0)≡ack(m, 1) $
  $
    ack(suc(m), suc(n))\
    ≡ (λ(n:ℕ).sp λ(c:ℕ).sp ack(m, c))(n,ack(suc(m), n))\
    ≡ ack(m, ack(suc(m), n))
  $

  Note that we folded some instances of recursive calls implicitly.
]
