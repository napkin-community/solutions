#import "template/napkin.typ": *
#import "template/napkin-users.typ": *

#plain_box(title: "AT-2.1.2")[
  Show that the #sym.Delta\-complex obtained from $Delta^3$ by performing the order-preserving
  edge identifications $[v_0, v_1] tilde [v_1, v_3]$ and $[v_0, v_2] tilde [v_2, v_3]$ deformation retracts
  onto a Klein bottle. Also, find other pairs of identifications of edges that produce
  #sym.Delta\-complexes deformation retracting onto a torus, a 2-sphere, and $RR"P"^2$.
]

#solution(users.simnalamburt)[
  #figure(
    caption: [Deformation retract onto a Klein bottle],
    {
      import "@preview/cetz:0.4.1"
      let typst-grid = grid
      import cetz.draw: *
      let shades = (50%, 80%).map(light => luma(light).transparentize(50%))
      let canvas = cetz.canvas.with(length: 2cm)
      let violet = oklch(70%, 0.2286, 304.24deg)
      let mark = mark.with(symbol: ">", stroke: 0pt, anchor: "center")
      let (
        back-face,
        back-line,
        back-label,
        front-face,
        front-line,
        front-label,
      ) = range(0, 6)
      let merge-path = merge-path.with(close: true, stroke: none, fill: white)
      let white-back = pts => on-layer(back-face, {
        merge-path({
          for w in pts.windows(2) {
            line(..w)
          }
        })
      })
      typst-grid(
        align: center + horizon,
        columns: (1fr,) * 3,
        canvas({
          set-style(stroke: (cap: "round"))
          ortho({
            let (v0, v1, v2, v3) = ((x: 0), (z: 1), (x: 1), (y: 1))
            on-layer(back-label, {
              content((rel: (-0.1, 0.18), to: v0), $v_0$, anchor: "south-east")
            })
            on-layer(front-label, {
              content((rel: (-0.05, 0), to: v1), $v_1$, anchor: "east")
              content((rel: (0.05, 0.05), to: v2), $v_2$, anchor: "west")
              content((rel: (0, 0.25), to: v3), $v_3$, anchor: "south")
            })
            set-style(stroke: (paint: red), mark: (fill: red))
            on-layer(back-line, {
              line(v0, v1, stroke: (dash: "dashed"))
              mark((v0, 50%, v1), v1)
            })
            on-layer(front-line, {
              line(v1, v3)
              mark((v1, 50%, v3), v3)
            })
            set-style(stroke: (paint: blue), mark: (fill: blue))
            on-layer(back-line, {
              line(v0, v2, stroke: (dash: "dashed"))
              mark((v0, 50%, v2), v2)
            })
            on-layer(front-line, {
              line(v2, v3)
              mark((v2, 50%, v3), v3)
            })
            set-style(stroke: (paint: black), mark: (fill: black))
            on-layer(back-line, {
              line(v0, v3, stroke: (dash: "dashed"))
            })
            on-layer(front-line, {
              line(v1, v2, stroke: (paint: violet))
            })
            on-layer(back-face, {
              white-back((v0, v1, v3, v2))
              merge-path(
                {
                  line(v0, v1)
                  line(v1, v2)
                },
                fill: shades.at(0),
              )
            })
            on-layer(front-face, {
              merge-path(
                {
                  line(v3, v1)
                  line(v1, v2)
                },
                fill: shades.at(1),
              )
            })
          })
        }),
        canvas({
          let (v0, v1, v2, v3) = ((x: 0), (z: 1), (x: 1), (y: 1))
          let fold = (rel: (x: 0.2, z: 0.2), to: (v0, 50%, v3))

          on-layer(back-label, {
            content((rel: (-0.05, 0), to: v0), $v_0$, anchor: "south-east")
          })
          on-layer(front-label, {
            content((rel: (-0.05, 0), to: v1), $v_1$, anchor: "south-east")
            content((rel: (0.05, 0), to: v2), $v_2$, anchor: "south-west")
            content((rel: (-0.05, 0), to: v3), $v_3$, anchor: "south-east")
          })

          set-style(stroke: (cap: "round"))
          on-layer(front-line, {
            set-style(stroke: (paint: red), mark: (fill: red))
            line(v0, v1)
            mark((v0, 50%, v1), v1)
            line(v1, v3)
            mark((v1, 50%, v3), v3)

            set-style(stroke: (paint: blue), mark: (fill: blue))
            line(v0, v2)
            mark((v0, 50%, v2), v2)
            line(v2, v3)
            mark((v2, 50%, v3), v3)

            line(v1, fold, stroke: (paint: violet))
            line(fold, v2, stroke: (paint: violet))
            line(v3, fold, stroke: (paint: gray))
            line(v0, fold, stroke: (paint: gray))
          })
          on-layer(back-line, {
            line(v0, v3, stroke: (paint: black, dash: "dashed"))
          })
          white-back((v0, v1, v3, v2))
          on-layer(front-face, {
            merge-path(
              {
                line(v0, v1)
                line(v1, fold)
                line(fold, v2)
              },
              fill: shades.at(0),
            )
            merge-path(
              {
                line(v3, v1)
                line(v1, fold)
                line(fold, v2)
              },
              fill: shades.at(1),
            )
          })
        }),
        canvas({
          let (v0, v1, v2, v3) = (
            (0, -0.5),
            (-calc.sqrt(0.75), 0),
            (calc.sqrt(0.75), 0),
            (0, 0.5),
          )
          on-layer(front-label, {
            content(v0, $v_0$, anchor: "north")
            content((rel: (-0.05, 0), to: v1), $v_1$, anchor: "east")
            content((rel: (0.05, 0), to: v2), $v_2$, anchor: "west")
            content((rel: (0, 0.05), to: v3), $v_3$, anchor: "south")
          })
          set-style(stroke: (cap: "round"))
          on-layer(front-line, {
            set-style(stroke: (paint: red), mark: (fill: red))
            line(v0, v1)
            mark((v0, 50%, v1), v1)
            line(v1, v3)
            mark((v1, 50%, v3), v3)

            set-style(stroke: (paint: blue), mark: (fill: blue))
            line(v0, v2)
            mark((v0, 50%, v2), v2)
            line(v2, v3)
            mark((v2, 50%, v3), v3)

            set-style(stroke: (paint: black), mark: (fill: black))
            line(v0, v3)
          })
          white-back((v0, v1, v3, v2))
        }),
      )

      let triple = {
        let (v0, v1, v2, v3) = (
          (-0.5, -0.5),
          (-0.5, 0.5),
          (0.5, -0.5),
          (0.5, 0.5),
        )
        let v0-piece = () => {
          line(v0, v1, stroke: (paint: red))
          mark((v0, 50%, v1), v1, fill: red)
          line(v0, v2, stroke: (paint: blue))
          mark((v0, 50%, v2), v2, fill: blue)
          line(v1, v2, stroke: (paint: green))
          mark((v1, 50%, v2), v2, fill: green)
        }
        let v1-piece = () => {
          line(v1, v3, stroke: (paint: red))
          mark((v1, 50%, v3), v3, fill: red)
          line(v2, v3, stroke: (paint: blue))
          mark((v2, 50%, v3), v3, fill: blue)
          line(v1, v2, stroke: (paint: green))
          mark((v1, 50%, v2), v2, fill: green)
        }

        (
          canvas({
            on-layer(front-label, {
              content(v0, $v_0$, anchor: "north-east")
              content(v1, $v_1$, anchor: "south-east")
              content(v2, $v_2$, anchor: "north-west")
              content(v3, $v_3$, anchor: "south-west")
            })
            set-style(stroke: (cap: "round"))
            on-layer(front-line, {
              v0-piece()
              v1-piece()
            })
            white-back((v0, v1, v3, v2))
          }),
          canvas({
            set-style(stroke: (cap: "round"))
            on-layer(front-line, {
              v0-piece()
              white-back((v0, v1, v2))
              set-origin((0.1, 0.1))
              v1-piece()
              white-back((v1, v3, v2))
            })
          }),
          canvas({
            set-style(stroke: (cap: "round"))
            on-layer(front-line, {
              v0-piece()
              white-back((v0, v1, v2))
              set-transform((
                (0, 1, 0, -1.1),
                (-1, 0, 0, 0),
                (0, 0, 1, 0),
                (0, 0, 0, 1),
              ))
              v1-piece()
              white-back((v1, v3, v2))
            })
          }),
        )
      }
      typst-grid(
        align: center + horizon,
        columns: (1fr,) * 4,
        ..triple,
        canvas({
          let (bl, br, tl, tr) = (
            (-0.5, -0.5),
            (0.5, -0.5),
            (-0.5, 0.5),
            (0.5, 0.5),
          )
          set-style(stroke: (cap: "round"))
          on-layer(front-line, {
            set-style(stroke: (paint: green), mark: (fill: green))
            line(tl, bl)
            mark((tl, 50%, bl), bl)
            line(br, tr)
            mark((br, 50%, tr), tr)

            set-style(stroke: (paint: blue), mark: (fill: blue))
            line(tl, tr)
            mark((tl, 50%, tr), tr)
            line(bl, br)
            mark((bl, 50%, br), br)

            set-style(stroke: (paint: red), mark: (fill: red))
            line(bl, tr)
            mark((bl, 50%, tr), tr)
          })
          white-back((bl, tl, tr, br))
        }),
      )
    },
  )
]

