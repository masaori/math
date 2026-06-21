#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([交換子と反交換子の関係])[
  $n in ZZ_(>=1)$ とする。$a, b, c in "Mat"(n, CC)$ について、交換子を $[x, y] := x y - y x$、反交換子を $[x, y]_(+) := x y + y x$ と定めるとき、

  $
    [a b, c] = a [b, c]_(+) - [a, c]_(+) b
  $

  が成り立つ。

  #proof[
    右辺を反交換子の定義に従って展開する。

    $
      a [b, c]_(+) - [a, c]_(+) b
      &=
      a (b c + c b) - (a c + c a) b
      quad (because "反交換子の定義")
      \
      &=
      a b c + a c b - a c b - c a b
      quad (because "行列の積の分配法則・結合法則")
      \
      &=
      a b c - c a b
      \
      &=
      (a b) c - c (a b)
      quad (because "行列の積の結合法則")
      \
      &=
      [a b, c]
      quad (because "交換子の定義")
    $

    $qed$
  ]
]<commutator_via_anticommutators>
