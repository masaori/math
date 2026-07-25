#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("Lie Groups, Lie Algebras, and Representations Proposition 3.35")[
  // $forall X in frak(g), forall Y in cal(G)$
  $forall X, Y in M(n, CC)$

  $
  e^(op("ad")_X)(Y)
  &= sum_(n=0)^(infinity) (1/n!) overbrace(
      #$[X, [X, dots.c , [X, Y] dots.c ]$,
      n "times"
    )\
  &= Y + [X, Y] + 1/2 [X, [X, Y]] + 1/6 [X, [X, [X, Y]]] + dots
  $

  ただし、$overbrace(
    #$[X, [X, dots.c , [X, Y] dots.c ]$,
    0 "times"
  )
  =
  Y$
  とする。

  #note[
    この定理は "Lie Groups, Lie Algebras, and Representations"（Brian Hall）Proposition 3.35 の参考記述であり、このリポジトリでは未証明である。証明の根拠として使用することは禁止する。
  ]
]<brianhall_exc14>
