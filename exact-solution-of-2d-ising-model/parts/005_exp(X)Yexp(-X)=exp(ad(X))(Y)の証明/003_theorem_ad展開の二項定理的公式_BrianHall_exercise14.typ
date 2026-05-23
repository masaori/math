#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("Lie Groups, Lie Algebras, and Representations excise 14")[
  $K := bb(R)$もしくは$bb(C)$, $d in bold(Z)_(gt.eq)$

  $X, Y in M(K, d)$について、

  $
    overbrace(
      #$[X, [X, dots.c , [X, Y] dots.c ]$,
      m "times"
    )
    =
    sum_(k=0)^m binom(m, k) X^k Y(-X)^(m-k)
  $
  #proof[
    TODO:
    帰納法で行ける
  ]

  #note[
    この定理は "Lie Groups, Lie Algebras, and Representations"（Brian Hall）Exercise 14 の参考記述であり、このリポジトリでは未証明である。証明の根拠として使用することは禁止する。
  ]
]
