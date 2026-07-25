#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition(none)[
  有限次元線型空間 $V$ 

  $exp : "End"(V) -> "End"(V)$を以下のように定める。

  線型写像 $X in "End"(V)$ について、
  $
  exp(X) := sum_(n=0)^(infinity) (1/n!) overbrace(X compose X compose dots compose X, n "times")
  $
]
