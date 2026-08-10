/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に α := RowConfig L、lt := rowConfigLess L、s := F(O,O) を代入すると、
具体版の 3 主張が出る。代入する仮定は次の 2 つだけである。

  台の対が ≺ で順序づけられていること   ← mem_crossOrderedPairs（F(O,O) の作り方）
  ≺ の非対称性                          ← claim_row_config_order_linear の三分律の一部

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・台が軌道から作られていること・≺ が推移的であること・
三分律の残りの 2 つの結論。

住処: ℕ と ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignValues
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSignValues

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `orbitPermSign` が、必要十分版の `signOn` の特殊化であること。 -/
theorem orbitPermSign_eq_necSuf (O : Finset (RowConfig L)) (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g
      = NecSuf.AlgebraicEigenvalue.signOn (rowConfigLess L) (crossOrderedPairs L O O) g := rfl

/-- 第一の主張を、必要十分版から導いたもの。 -/
theorem orbitPermSign_eq_one_or_neg_one_from_necSuf (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g = 1 ∨ orbitPermSign L O g = -1 := by
  rw [orbitPermSign_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.signOn_eq_or (rowConfigLess L) _ g

/-- 第二の主張を、必要十分版から導いたもの。 -/
theorem orbitPermSign_mul_self_from_necSuf (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g * orbitPermSign L O g = 1 := by
  rw [orbitPermSign_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.signOn_mul_self (rowConfigLess L) _ g

/-- 第三の主張を、必要十分版から導いたもの。渡す仮定は台の順序づけと非対称性の 2 つだけである。 -/
theorem orbitPermSign_id_from_necSuf (O : Finset (RowConfig L)) :
    orbitPermSign L O (fun τ => τ) = 1 := by
  rw [orbitPermSign_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.signOn_id (rowConfigLess L)
    (fun p hp => (mem_crossOrderedPairs.mp hp).2)
    (fun _ _ h => not_rowConfigLess_of_rowConfigLess h)

end Ising2DLambda.AlgebraicEigenvalue
