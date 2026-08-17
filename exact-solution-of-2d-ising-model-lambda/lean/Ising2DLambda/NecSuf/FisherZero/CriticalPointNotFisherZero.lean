/-
主張「臨界点は Fisher 零点でない」の必要十分版。

同じ手順に必要なのは、評価値と正錐の元の値の一致、その元の表示が正条件を満たすこと、
値が零なら表示が零表示になること、零表示が正条件を満たさないこと、および
零点集合への所属が評価値の零性を意味することだけである。
体・多項式・有理数・代数的数・順序は要求しない（正条件は抽象的な述語のまま扱う）。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 表示が正条件を満たす値は、零点集合へ属さない。

    仮定はそれぞれ具体版の次のステップが使う性質である:
    `hvalue` は評価値の取り出し、`hpositive` は正錐への所属、
    `hzero_rep` は零元の表示の特徴づけ、`hzero_not_positive` は
    零表示が三条件を破ること、`hmem` は零点集合の定義。 -/
theorem represented_positive_value_not_mem_zeroSet_necSuf
    {Q K R X : Type}
    (coeQ : Q → K) (zeroK : K) (rep : Q → R) (positive : R → Prop) (zeroRep : R)
    (point : X) (xi : Q) (valueK : K) (zeroSet : Set X)
    (hvalue : valueK = coeQ xi)
    (hpositive : positive (rep xi))
    (hzero_rep : coeQ xi = zeroK → rep xi = zeroRep)
    (hzero_not_positive : ¬ positive zeroRep)
    (hmem : point ∈ zeroSet → valueK = zeroK) :
    point ∉ zeroSet := by
  intro hpoint
  apply hzero_not_positive
  have hxi0 : coeQ xi = zeroK := by
    rw [← hvalue]
    exact hmem hpoint
  rw [← hzero_rep hxi0]
  exact hpositive

end Ising2DLambda.NecSuf.FisherZero
