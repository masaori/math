#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim("行列ノルムの劣乗法性")[
  $K := RR$ または $K := CC$、$n in ZZ_(>= 1)$、$A, B in "Mat"(n, K)$ について、

  $
    ||A B|| <= ||A|| dot.op ||B||
  $

  #proof[
    TODO
  ]
]<matrix_norm_submultiplicativity>

#claim("行列乗算の連続性")[
  $K := RR$ または $K := CC$、$n in ZZ_(>= 1)$、$A_N, A, B in "Mat"(n, K)$、$||A_N - A|| -> 0$ のとき、

  $
    ||A_N B - A B|| -> 0
  $

  #proof[
    $
      ||A_N B - A B||
      &=
      ||(A_N - A) B||
      \
      &<=
      ||A_N - A|| dot.op ||B||
      quad (because #ref(<matrix_norm_submultiplicativity>))
      \
      &->
      0
    $
  ]
]<matrix_multiplication_continuity>
