#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim($sinh"/"cosh"のテイラー展開"$)[
  $
  sinh x &= x + (1/3!) x^3 + (1/5!) x^5 + (1/7!) x^7 + ... \
  &= sum_(
    n >= 0 \
    n "is odd"
  )^infinity
    (1/n!)
    x^n
  \
  cosh x &= 1 + (1/2!) x^2 + (1/4!) x^4 + (1/6!) x^6 + ... \
  &= sum_(
    n >= 1 \
    n "is even"
  )^infinity
    (1/n!)
    x^n
  $
]
