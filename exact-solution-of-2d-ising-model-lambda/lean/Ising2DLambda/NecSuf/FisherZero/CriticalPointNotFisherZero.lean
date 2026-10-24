/-
主張「臨界点は Fisher 零点でない」の必要十分版。

同じ手順に必要なのは、評価値と正錐の元の値の一致、その元の表示が正条件を満たすこと、
値が零なら表示が零表示になること、正条件の三分岐、零の狭義順序の非反射性、および
零点集合への所属が評価値の零性を意味することだけである。
体・多項式・有理数・代数的数・全順序は要求しない。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 表示仕様と零点集合の定義を使って零表示へ移り、具体版と同じ三分岐で矛盾する。
`hcases` は各正条件で実際に使う一つの条件だけ、`hirrefl` は零での非反射性だけでよい。 -/
theorem represented_positive_value_not_mem_zeroSet_necSuf
    {Q K A X : Type} [LT A]
    (coeQ : Q → K) (zeroK : K) (rep : Q → A × A) (positive : A × A → Prop)
    (zeroA : A) (point : X) (xi : Q) (valueK : K) (zeroSet : Set X)
    (hvalue : valueK = coeQ xi)
    (hpositive : positive (rep xi))
    (hzero_rep : coeQ xi = zeroK → rep xi = (zeroA, zeroA))
    (hcases : ∀ ab, positive ab →
      ab ≠ (zeroA, zeroA) ∨ zeroA < ab.1 ∨ ab.1 < zeroA)
    (hirrefl : ¬ zeroA < zeroA)
    (hmem : point ∈ zeroSet → valueK = zeroK) :
    point ∉ zeroSet := by
  intro hpoint
  have hzero : valueK = zeroK := hmem hpoint
  have hxi0 : coeQ xi = zeroK := by
    calc
      coeQ xi = valueK := hvalue.symm
      _ = zeroK := hzero
  have hrep : rep xi = (zeroA, zeroA) := hzero_rep hxi0
  have hzeroPositive : positive (zeroA, zeroA) := by
    rw [← hrep]
    exact hpositive
  rcases hcases (zeroA, zeroA) hzeroPositive with hne | hlt | hlt
  · exact hne rfl
  · exact hirrefl hlt
  · exact hirrefl hlt

end Ising2DLambda.NecSuf.FisherZero
