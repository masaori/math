#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$epsilon$の固有空間])[
  $
    cal(F) := (CC^2)^(times.o M) \
    cal(F)^((plus.minus)) := { f in cal(F) | epsilon f = plus.minus f }
  $

  #note[
    $epsilon^2 = 1$ なので、$epsilon$の固有値は$plus.minus 1$ (?:ちょっと計算いる？)
  ]
]
