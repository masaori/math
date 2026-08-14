/-
主張「正の有理点は Fisher 零点でない」の必要十分版。

同じ手順に必要なのは、内側の値が零でないこと、埋め込み後の評価値との一致、
埋め込みが零元を保つことと単射であること、および零点集合の所属が評価値の零性を
意味することだけである。順序・体・多項式・有理数・代数的数は要求しない。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 非零な内側の値を単射で埋め込んだ評価値は、零点集合へ属さない。 -/
theorem embedded_nonzero_value_not_mem_zeroSet_necSuf
    {Q K X : Type} [Zero Q] [Zero K]
    (embed : Q → K) (point : X) (valueQ : Q) (valueK : K) (zeroSet : Set X)
    (hvalue : valueK = embed valueQ)
    (hvalue_ne : valueQ ≠ 0)
    (hzero : embed 0 = 0)
    (hinjective : Function.Injective embed)
    (hmem : point ∈ zeroSet ↔ valueK = 0) :
    point ∉ zeroSet := by
  have hembed_ne : embed valueQ ≠ 0 := by
    intro heq
    apply hvalue_ne
    apply hinjective
    calc
      embed valueQ = 0 := heq
      _ = embed 0 := hzero.symm
  have hvalueK_ne : valueK ≠ 0 := by
    rw [hvalue]
    exact hembed_ne
  intro hpoint
  exact hvalueK_ne (hmem.mp hpoint)

end Ising2DLambda.NecSuf.FisherZero
