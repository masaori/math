#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#let mapDef(f, A, B, a, b, comment) = {
  $
  #grid(
    columns: 6,
    gutter: 5pt,
    $#f$, $:$, $#A$, $->$, $#B$, $#comment$,
    "", "", rotate(-90deg, $in$), "", rotate(-90deg, $in$), "",
    "", "", $#a$, $|->$, $#b$,  ""
  )
  $
}

#definition("自己同型群/内部自己同型群/外部自己同型群")[
  群$G$について、

  $
    "Aut"(G) := { phi | phi: G -> G, phi "は群同型" } \
  $

  $"Aut"(G)$を、群$G$の自己同型群と呼ぶ。

  \

  また、

  $g in G$について、

  #mapDef($phi_g$, $G$, $G$, $h$, $g h g^(-1)$, "")

  と定め、

  #mapDef($phi$, $G$, $"Aut"(G)$, $g$, $phi_g$, "")

  と定める時、

  $"Im"(phi)$を$G$の内部自己同型群と呼び、$"Inn"(G)$と書く。

  \

  また、

  $"Aut"(G)slash"Inn"(G)$を$G$の外部自己同型群と呼び、$"Out"(G)$と書く
]
