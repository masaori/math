#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition("2次元ising模型の分配関数")[
  $Z: RR_(>0) times RR_(>0) -> RR_(>0)$を以下のように定める。

  $frak(S) := "Map"({ 1, dots, M} times { 1, dots, N }, { -1, 1 })$として、

  $
  Z(J, J^(prime))
  :=
  sum_(
    s in frak(S)
  ) (
    exp^((
      sum_(
        i &in {1, ..., M} \
        j &in {1, ..., N}
      )
      (
        J s(i, j)s(i+1, j) + J' s(i, j)s(i, j+1)
      )
    ))
  )
  $

  #note[

    $s$は、格子の状態(スピンの配置)を表している

    $frak(S)$は、全ての状態の集合といえる
  ]
]
