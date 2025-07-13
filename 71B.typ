#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/cetz:0.4.0"


#plain_box(title: "Problem 71B", subtitle: "Brouwer fixed point theorem")[
  Use the previous problem to prove that any continuous function $f : D^n -> D^n$ has a fixed point.
]

#solution(users.kiwiyou)[
  Assume that $f$ has no fixed point.
  We can define $F(x)$ as the intersection of $S^(n-1)$ and the ray from $f(x)$ to $x$.
  The intersection is uniquely determined since $x != f(x)$.

  #align(center, cetz.canvas({
    import cetz.draw: *

    let label(body) = box(inset: (x: 0.4em, y: 0.1em), body)

    on-layer(-1, {
      circle((0, 0), radius: 2, name: "D", fill: luma(75%).transparentize(50%))
      content((rel: "D", to: (-1.1, 1.1)), $D^n$)
      content("D.north-east", label($S^(n-1)$), anchor: "base-west")
    })

    set-style(stroke: none, fill: black)
    circle((0.3, 0.7), radius: 0.05, name: "fx")
    circle((-0.2, -0.3), radius: 0.05, name: "x")
    hide({
      line("fx", ("fx", 9, "x"), name: "ray")
    })
    intersections("raycast", "D", "ray")
    circle("raycast.0", radius: 0.05, name: "Fx")

    content("x", label($x$), anchor: "base-west")
    content("fx", label($f(x)$), anchor: "base-west")
    content("Fx", label($F(x)$), anchor: "base-west")

    on-layer(-1, {
      line("fx", "Fx", stroke: red, mark: (end: ">", fill: red, scale: 0.5))
    })
  }))

  If such $f$ exists, the composition $S^(n-1) arrow.hook D^n ->^F S^(n-1)$ is identity map, which is a contradiction.
  #h(1fr) #sym.qed
]
