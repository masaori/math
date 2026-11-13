/-
# 行列の二重の有限和は和の順序を入れ替えても等しい（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_finite_double_sum_of_matrices_interchange`、ラベル **`finite_double_sum_of_matrices_interchange`**）

**必要十分版**: `Ising2D/NecSuf/FiniteDoubleSumOfMatricesInterchange.lean` の `NecSuf.finite_double_sum_of_matrices_interchange'`。
具体版をその系として導くのは、同じフォルダの `ClaimFiniteDoubleSumOfMatricesInterchangeFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 成分の鎖の 5 行（`finite_sum_of_matrices_entrywise` → それを各 `a` へ → ℂ の有限和の順序交換 → `finite_sum_of_matrices_entrywise` を各 `b` へ右辺から左辺へ → `finite_sum_of_matrices_entrywise` を右辺から左辺へ） | `finite_double_sum_of_matrices_interchange_apply` の `calc` の 5 段 |
| 「全ての成分が一致し、主張を得る」 | `finite_double_sum_of_matrices_interchange`（`Matrix.ext`） |

- 人手の `a ∈ {1, …, r}`・`b ∈ {1, …, s}` は Lean の有限型 `κ`・`ι` の元、`X_{a,b}` は `X a b : Matrix α β ℂ` である。
  人手の証明は番号の帰納法を使わず成分の鎖だけなので、添字は有限型のまま受ける（`κ := Fin r`・`ι := Fin s` で人手の主張そのもの、
  `κ := Fin M → Fin 4` で Step 6 の多重添字の和に当たる）。人手の `r, s ≥ 1` は証明で使わないので仮定に置かない。
  行と列の添字は `ClaimFiniteSumOfMatricesWithSingleNonzeroTerm.lean` と同じく任意の型 `α`・`β` で受ける。
- `finite_sum_of_matrices_entrywise` は mathlib の `Matrix.sum_apply`。
- 3 段目「ℂ の加法の結合法則・交換法則による有限和の順序交換（`complex_numbers_form_a_field`）」は、本文に ℂ の二重和の主張が無く、
  人手がこの 1 行で結合法則・交換法則から順序交換を引いているので、Lean も 1 段で mathlib の `Finset.sum_comm` を当てる
  （`Finset.sum_comm` が使うのは加法の結合法則・交換法則だけである。人手が名前だけで引き本文に主張が無い有限和の順序交換に
  `Finset.sum_comm` を引くのは、`ClaimTransposePreservesMatrixNormAndLimits.lean`・`ClaimCongruencePreservesPositiveDefinite.lean`・
  `ClaimMomentLogConvexity.lean` と同じ扱いである。実数の版 `finite_double_sum_of_real_numbers_interchange` は本文に主張があるので帰納法で書いてある）。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2D

open Matrix

/-- **`finite_double_sum_of_matrices_interchange`** の成分の鎖:
`(Σ_a Σ_b X_{a,b})_{ik} = (Σ_b Σ_a X_{a,b})_{ik}`。 -/
theorem finite_double_sum_of_matrices_interchange_apply {κ ι α β : Type*} [Fintype κ] [Fintype ι]
    (X : κ → ι → Matrix α β ℂ) (i : α) (k : β) :
    (∑ a, ∑ b, X a b) i k = (∑ b, ∑ a, X a b) i k :=
  calc (∑ a, ∑ b, X a b) i k
      = ∑ a, (∑ b, X a b) i k := Matrix.sum_apply i k Finset.univ _                 -- `finite_sum_of_matrices_entrywise`
    _ = ∑ a, ∑ b, X a b i k :=
        Finset.sum_congr rfl fun a _ => Matrix.sum_apply i k Finset.univ (X a)        -- `finite_sum_of_matrices_entrywise` を各 `a` へ同時適用
    _ = ∑ b, ∑ a, X a b i k := Finset.sum_comm                                      -- ℂ の加法の結合法則・交換法則による有限和の順序交換
    _ = ∑ b, (∑ a, X a b) i k :=
        Finset.sum_congr rfl fun b _ =>
          (Matrix.sum_apply i k Finset.univ (fun a => X a b)).symm                    -- `finite_sum_of_matrices_entrywise` を右辺から左辺へ、各 `b` へ同時適用
    _ = (∑ b, ∑ a, X a b) i k := (Matrix.sum_apply i k Finset.univ _).symm          -- `finite_sum_of_matrices_entrywise` を右辺から左辺へ

/-- **人手 `finite_double_sum_of_matrices_interchange`**: `Σ_a Σ_b X_{a,b} = Σ_b Σ_a X_{a,b}`。 -/
theorem finite_double_sum_of_matrices_interchange {κ ι α β : Type*} [Fintype κ] [Fintype ι]
    (X : κ → ι → Matrix α β ℂ) :
    ∑ a, ∑ b, X a b = ∑ b, ∑ a, X a b :=
  Matrix.ext (finite_double_sum_of_matrices_interchange_apply X)                    -- 全ての成分が一致する

end Ising2D
