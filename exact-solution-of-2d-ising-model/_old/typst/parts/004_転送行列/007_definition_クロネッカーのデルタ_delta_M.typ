#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$delta^M_((mu, nu))$])[
  $$
  $
  delta_(P) :=
  cases(
    1 & quad P "is True",
    0 & quad P "is False"
  )
  $
]

TODO: ↑こんな感じの定義の方が読みやすく汎用性も高そうなので置き換えたい

#definition([$delta^M_((mu, nu))$])[
  $$
  $
  delta^M_((mu, nu)) :=
  cases(
    1 & (mu equiv nu mod M),
    0 & (mu equiv.not nu mod M)
  )
  $
]
