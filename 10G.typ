#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: [Problem 10G], subtitle: [Differentiation of functions])[
  Let $V$ be the infinite-dimensional real vector space of all infinitely differentiable functions $RR -> RR$.
  Note that $d/(d x): V -> V$ is a linear map (for example it sends $cos x$ to $-sin x$).
  Which real numbers are eigenvalues of this map?
]

#solution(users.kiwiyou)[
  All numbers.

  _Proof._
  For all $k in RR$, consider infinitely differentiable function $f : RR -> RR = x mapsto e^(k x)$, then
  $ (d f)/(d x) = k e^(k x) = k f $
  Therefore, every real number $k$ is eigenvalue. #h(1fr) #sym.qed
]
