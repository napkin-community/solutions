#import "template/napkin.typ": *
#import "template/napkin-users.typ": *


#plain_box(title: "AT-2.1.13")[
  Verify that $f tilde.equiv g$ implies $f_* = g_*$ for induced homomorphisms of reduced homology groups.
]

#solution(users.xtalclr)[
  We first parse the problem.

  - The maps $f, g : X -> Y$ are continuous maps from topological space $X$ to $Y$.
  - That $f tilde.equiv g$ means that there is a homotopy $H : I times X -> Y$ from $f$ to $g$
    - so that $H$ is continuous, and $H(0, -) = f$, and $H(1, -) = g$

  - The maps $f_*, g_* : tilde(H)_n (X) -> tilde(H)_n(Y)$ are induced homomorphisms of _reduced_ homology groups (p113).
    - We will call them $tilde(f)_*, tilde(g)_*$ instead to be explicit that we are talking about _reduced_ homology.
    - Side note: the maps $f_\#, g_\#$ are induced homomorphisms on chains (p110).

  Recall that even for _non-reduced_ homology groups, showing $f_* = g_*$ was a nontrivial task (Theorem 2.10). The proof constructed the prism operator $P : C_n (X) -> C_(n+1)(Y)$ so that it satisfies the relation
  $ partial P = g_\# - f_\# - P partial $
  on every dimension $n$. Here we consider $g_\#, f_\#$ be on dimension $n$. Consequently, the $P$ on left-hand side is $P : C_n (X) -> C_(n+1)(Y)$ and the right-hand side is $P : C_(n-1)(X) -> C_n(Y)$.

  Our job now is to modify the prism operator and the equation above for reduced cohomology. Call the corresponding homomorphisms on _reduced_ chains $tilde(f)_\#, tilde(g)_\#$ to avoid confusion.

  1. The only difference with $f_\#, g_\#$ and $tilde(f)_\#, tilde(g)_\#$ is that, at dimension $-1$, we have $tilde(f)_\#, tilde(g)_\# : ZZ -> ZZ$ instead of $f_\#, g_\# : 0 -> 0$.
  2. So define $tilde(P) : tilde(C)_n (X) -> tilde(C)_(n+1)(Y)$ the same as $P$ for dimension $n != -1, -2$ (you don't have any difference in domain and range). For $n=-2$, you don't have a choice but set $tilde(P)$ to zero as $tilde(C)_(-2)(X) = 0$. We will postpone deciding $tilde(P)$ for dimension $n=-1$.
  3. By 2 only, the equation $partial tilde(P) = tilde(g)_\# - tilde(f)_\# - tilde(P) partial$ is already satisfied for $n != 0, -1$ as it does not have any difference with original $partial P = g_\# - f_\# - P partial$.
  4. For $n=0$, we have $partial tilde(P) = partial P = g_\# - f_\# - P partial = tilde(g)_\# - tilde(f)_\# - P partial$ that we need to match with $tilde(g)_\# - tilde(f)_\# - tilde(P) partial$. What we get is that $P partial = tilde(P) partial$ for dimension zero. As $P : C_(-1)(X) -> C_0(Y)$ should be a zero map (as $C_(-1)(X) = 0$) a natural guess is to set $tilde(P) : C_(-1)(X) -> C_0(Y)$ to be the zero map too. Let us do so, and this clears up proving the equation for $n=0$.
  5. It remains to show $partial tilde(P) = tilde(g)_\# - tilde(f)_\# - tilde(P) partial$ for $n=-1$. The left-hand side is a zero map by definition (see 4 above). $tilde(f)_\#, tilde(g)_\# : ZZ -> ZZ$ are identity maps so they cancel out. It remains to verify $tilde(P) partial = 0$ but recall that, in step 2 above, we set $tilde(P) : tilde(C)_(-2)(X) -> tilde(C)_(-1)(X)$ to be zero. So this equation is verified.

  With all this, we defined the prism operator $tilde(P) : tilde(C)_n (X) -> tilde(C)_(n+1)(Y)$ for reduced homology and verified the equation $partial tilde(P) = tilde(g)_\# - tilde(f)_\# - tilde(P) partial$. So there is a chain homotopy between $tilde(f)_\#$ and $tilde(g)_\#$, and thus $tilde(f)_* = tilde(g)_*$ (Proposition 2.12, that chain-homotopic chain maps induce the same homomorphisms on homology).

  _Note._ Why bother with $tilde(P)$ when you can do the casework using $H_n (X) = tilde(H)_n (X)$ for $n != 0$ and $H_0(X) tilde.equiv tilde(H)_0(X) plus.circle ZZ$ for nonempty $X$? My line of thought was that (i) the proof above would be safe in terms of naturality (I have to admit I don't know exactly what I am talking about) but I fear that such 'exceptional' casework might lead to some faliure in preserving naturality, and that (ii) the casework would be quite messy considering cases of $X$ or $Y$ being empty or not too. Feel free to prove me wrong and come up with a cleaner proof instead.
]
