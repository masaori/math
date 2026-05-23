#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$hat(Z)_M^((minus)) = hat(Z)_(-M)^((minus))$、$hat(Y)_M = hat(Y)_(-M)$])[
  $
    hat(Z)_M^((minus)) = hat(Z)_(-M)^((minus)),
    quad
    hat(Y)_M = hat(Y)_(-M)
  $

  #proof[
    $#ref(<def_hatZ_hatY>)$ より、各 $j in {1, dots, M}$ について、

    $
      exp(-sqrt(-1) j dot.op (2 pi M) / M)
      &=
      exp(-2 pi sqrt(-1) j)
      \
      &=
      1
      quad (because exp(-2 pi sqrt(-1) j) = 1)
      \
      &=
      exp(0)
      \
      &=
      exp(-sqrt(-1) j dot.op (2 pi (-M)) / M)
    $

    よって $hat(Z)_M$ と $hat(Z)_(-M)$ の定義における各 $j$ 項の係数 $exp(-sqrt(-1) j (2pi mu)/M)$ が一致する。$hat(Y)$ も同様。
  ]
]<hatZ_hatY_M_periodicity>
