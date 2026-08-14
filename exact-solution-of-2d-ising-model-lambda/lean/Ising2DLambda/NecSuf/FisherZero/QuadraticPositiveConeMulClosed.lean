/-
「正錐と乗法の両立」の必要十分版。
二次体・有理数・順序をすべて外し、要素の型と乗法、三つの条件述語、
六つの符号場合の積の補題、および転送だけを個別に要求して、
具体版と同じ九通りの場合分けを行う。
-/

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版が使う性質だけを仮定する。順序も環構造も要求しない。 -/
theorem positive_cone_mul_closed_necSuf
    {X : Type} (mul : X -> X -> X) (mem : X -> Prop)
    (C1 C2 C3 : X -> Prop)
    (x y : X)
    (hx : C1 x ∨ C2 x ∨ C3 x)
    (hy : C1 y ∨ C2 y ∨ C3 y)
    (h11 : C1 x -> C1 y -> mem (mul x y))
    (h12 : C1 x -> C2 y -> mem (mul x y))
    (h13 : C1 x -> C3 y -> mem (mul x y))
    (h12' : C1 y -> C2 x -> mem (mul y x))
    (h13' : C1 y -> C3 x -> mem (mul y x))
    (h22 : C2 x -> C2 y -> mem (mul x y))
    (h23 : C2 x -> C3 y -> mem (mul x y))
    (h23' : C2 y -> C3 x -> mem (mul y x))
    (h33 : C3 x -> C3 y -> mem (mul x y))
    (transfer : mem (mul y x) -> mem (mul x y)) :
    mem (mul x y) := by
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
