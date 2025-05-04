#import "template/napkin.typ": *
#import "template/napkin-users.typ": *
#import "@preview/cetz:0.3.4"

#black_note[Exercise 65.2.6][
  Show that for any path $alpha$, $alpha ast.op overline(alpha)$ is homotopic to the "do-nothing" loop at $alpha(0)$. (Draw a picture.)
]

#solution(users.kiwiyou)[
  We can trace back the path $alpha$.

  Define a path homotopy $f_s (t): [0, 1] times [0, 1] -> X$ as:
  $
    f_s (t) = cases(
                              alpha(2t) & space.quad &           (0 <= t <= 1 / 2 s) \
      alpha(s) = overline(alpha)(1 - s) &            & (1 / 2 s <= t <= 1 - 1 / 2 s) \
                overline(alpha)(2t - 1) &            &       (1 - 1 / 2 s <= t <= 1)
    )
  $

  #align(center)[
    #cetz.canvas(background: white, padding: 0.2, {
      import cetz.draw: *

      line((0, 2), (0, -2))
      line((0, 2), (-0.1, 2))
      content((-0.2, 2), anchor: "mid-east")[$t = 0$]
      line((0, 0), (-0.1, 0))
      content((-0.2, 0), anchor: "mid-east")[$display(1 / 2)$]
      line((0, -2), (-0.1, -2))
      content((-0.2, -2), anchor: "mid-east")[$1$]

      rect((0, 2), (12, -2), stroke: none, fill: rgb(0, 0, 0, 0))

      scope({
        set-origin((0.5, 2))
        let graph = {
          bezier-through((0, -0), (1.2, -0.5), (1.8, -1))
          bezier-through((1.8, -1), (0.6, -1.5), (3, -2))
        }
        graph
        set-origin((0, -4))
        scale(y: -100%)
        graph
      })

      scope({
        set-origin((4, 2))
        let graph = {
          bezier-through((0, -0), (1.2, -0.5), (1.8, -1))
          let split = cetz.path-util.bezier.split(
            ..cetz.path-util.bezier.cubic-through-3points(
              (1.8, -1, 0),
              (0.6, -1.5, 0),
              (3, -2, 0),
            ),
            0.8,
          )
          bezier(..split.at(0))
          let (last_x, last_y, ..) = split.at(0).at(1)
          line((last_x, last_y), (last_x, -2))
        }
        graph
        set-origin((0, -4))
        scale(y: -100%)
        graph
      })

      scope({
        set-origin((6.5, 2))
        let graph = {
          bezier-through((0, -0), (1.2, -0.5), (1.8, -1))
          let split = cetz.path-util.bezier.split(
            ..cetz.path-util.bezier.cubic-through-3points(
              (1.8, -1, 0),
              (0.6, -1.5, 0),
              (3, -2, 0),
            ),
            0.2,
          )
          bezier(..split.at(0))
          let (last_x, last_y, ..) = split.at(0).at(1)
          line((last_x, last_y), (last_x, -2))
        }
        graph
        set-origin((0, -4))
        scale(y: -100%)
        graph
      })

      scope({
        set-origin((9, 2))
        let graph = {
          let split = cetz.path-util.bezier.split(
            ..cetz.path-util.bezier.cubic-through-3points(
              (0, -0, 0),
              (1.2, -0.5, 0),
              (1.8, -1, 0),
            ),
            0.5,
          )
          bezier(..split.at(0))
          let (last_x, last_y, ..) = split.at(0).at(1)
          line((last_x, last_y), (last_x, -2))
        }
        graph
        set-origin((0, -4))
        scale(y: -100%)
        graph
      })

      scope({
        set-origin((11.5, 2))
        line((0, 0), (0, -4))
      })

      content((2, -2.5))[$s = 0$]
      line(
        (3, -2.5),
        (10.5, -2.5),
        mark: (end: ">", fill: black),
        stroke: 0.5pt,
      )
      content((11.5, -2.5))[$s = 1$]
    })
  ]

  Since $f_(0) = alpha ast.op overline(alpha)$ and $f_1 = 1$, $alpha ast.op overline(alpha)$ is nulhomotopic. #h(1fr) #sym.qed

  #plain_box(title: [Definition 65.2.2])[
    Denote the trivial do-nothing loop by $1$.
    A loop $gamma$ is nulhomotopic if it is homotopic to $1$; i.e. $gamma tilde.eq 1$.
  ]
]
