/-
「正錐と加法の両立」の必要十分版。
二次体・有理数・順序をすべて外し、要素の型と加法、三つの条件述語、
六つの符号場合の和の補題、および転送だけを個別に要求して、
具体版と同じ九通りの場合分けを行う。
-/

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版が使う性質だけを仮定する。
`X` は要素の型、`add` は加法、`mem` は正錐への所属、
`C₁ C₂ C₃` は表示の三条件である。順序も環構造も要求しない。
六つの補題仮定は本文の六つの符号場合の補題、`transfer` は本文の「転送」
（表示の各成分の加法の可換則による役割の入れ替え）に対応する。 -/
theorem positive_cone_add_closed_necSuf
    {X : Type} (add : X → X → X) (mem : X → Prop)
    (C1 C2 C3 : X → Prop)
    (x y : X)
    (hx : C1 x ∨ C2 x ∨ C3 x)
    (hy : C1 y ∨ C2 y ∨ C3 y)
    (h11 : C1 x → C1 y → mem (add x y))
    (h12 : C1 x → C2 y → mem (add x y))
    (h13 : C1 x → C3 y → mem (add x y))
    (h12' : C1 y → C2 x → mem (add y x))
    (h13' : C1 y → C3 x → mem (add y x))
    (h22 : C2 x → C2 y → mem (add x y))
    (h23 : C2 x → C3 y → mem (add x y))
    (h23' : C2 y → C3 x → mem (add y x))
    (h33 : C3 x → C3 y → mem (add x y))
    (transfer : mem (add y x) → mem (add x y)) :
    mem (add x y) := by
  rcases hx with hx1 | hx2 | hx3
  · rcases hy with hy1 | hy2 | hy3
    · exact h11 hx1 hy1
    · exact h12 hx1 hy2
    · exact h13 hx1 hy3
  · rcases hy with hy1 | hy2 | hy3
    · exact transfer (h12' hy1 hx2)
    · exact h22 hx2 hy2
    · exact h23 hx2 hy3
  · rcases hy with hy1 | hy2 | hy3
    · exact transfer (h13' hy1 hx3)
    · exact transfer (h23' hy2 hx3)
    · exact h33 hx3 hy3

end Ising2DLambda.NecSuf.FisherZero
