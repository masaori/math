/-
# 成分が非負なら実数の双線型値 `x^⊤Py` は非負、ベクトルを実数倍すると `w^⊤Pw` はその実数どうしの積の倍

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_with_nonnegative_entries_is_nonnegative`（ラベル **`real_bilinear_value_with_nonnegative_entries_is_nonnegative`**）
* `maxeig_claim_real_bilinear_value_of_scalar_multiple_vector`（ラベル **`real_bilinear_value_of_scalar_multiple_vector`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `real_bilinear_value_with_nonnegative_entries_is_nonnegative` の準備の 2 つの不等式 | `hterm` の 2 段（`mul_nonneg` を 2 回） |
| 同じ証明の各 `p` についての 2 行の鎖（行の和の非負性） | `hrow` の `calc` の 2 段 |
| 同じ証明の 3 行の鎖 | 本体の `calc` の 3 段 |
| `real_bilinear_value_of_scalar_multiple_vector` の 13 行の鎖 | `real_bilinear_value_of_scalar_multiple_vector` の `calc` の 13 段 |

- 人手の `x^⊤Py`（`def_real_bilinear_value` の `Σ_kΣ_l (x_kP_kl)y_l`）は Lean の `x ⬝ᵥ P *ᵥ y` で、
  `dotProduct_mulVec_eq_real_bilinear_value`（`RealMatrixBilinearFormAndNorm.lean`）が人手の和の形へ開く。
- 人手の「非負の実数の積は非負」は mathlib の `mul_nonneg`（ℝ の順序の性質そのもの）である。
- 人手の和の添字 `{1, …, n}` は Lean では有限型 `n` である。人手の `n ≥ 1` は `[Nonempty n]` に当たり、
  人手が `k → 1`・`p → 1`・`q → 1` として選ぶ添字 `1` は Lean では `i₀ := Classical.arbitrary n` である。
  `finite_sum_of_nonnegative_reals_is_at_least_each_term`・`finite_sum_of_real_scalar_multiples` は `_fintype` 版を引く。
- 人手は `ℝ^n` の元の実数倍を定めず、`w` を成分の等式 `w_k = c u_k` で与える。Lean も同じく仮定 `hw` に置く
  （引く側で `w := fun k => c * u k` なら `hw := fun _ => rfl`）。
- 人手は引く主張の記号（`a_j`・`k`・`x_j`）とぶつからないよう、ベクトルを `x, y`・`u, w`、準備の添字を `p, q` と書く。
  Lean の束縛変数は `k, l` のままで、人手の「項の非負性」「行の和の非負性」は `hterm`・`hrow` である。

必要十分版は `Ising2D.NecSuf.bilinear_value_with_nonnegative_entries_is_nonnegative'`・`bilinear_value_of_scalar_multiple_vector'`
（`NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean`）である。本ファイルの `calc` と同じ並びで示す。
具体版がその `R → ℝ` の特殊化として得られることは `ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultipleFromNecSuf.lean` に置く。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_with_nonnegative_entries_is_nonnegative`**: `P_kl ≥ 0`・`x_k ≥ 0`・`y_l ≥ 0` なら
`x^⊤Py ≥ 0`（人手の準備の 2 つの不等式、各 `p` の 2 行の鎖、本体の 3 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_with_nonnegative_entries_is_nonnegative [Nonempty n] (P : Matrix n n ℝ)
    (hP : ∀ k l, 0 ≤ P k l) (x y : n → ℝ) (hx : ∀ k, 0 ≤ x k) (hy : ∀ l, 0 ≤ y l) :
    x ⬝ᵥ P *ᵥ y ≥ 0 := by
  -- 準備（項の非負性）: `(x_pP_pq)y_q ≥ 0`（人手の `p, q` は Lean の `k, l`）
  have hterm : ∀ k l, x k * P k l * y l ≥ 0 := fun k l =>
    have h1 : x k * P k l ≥ 0 := mul_nonneg (hx k) (hP k l)                 -- 非負の実数の積は非負（`x_p`, `P_pq`）
    mul_nonneg h1 (hy l)                                                     -- 非負の実数の積は非負（`x_pP_pq`, `y_q`）
  let i₀ : n := Classical.arbitrary n                                        -- 人手の添字 `1`
  -- 行の和の非負性: 各 `p` について `Σ_l (x_pP_pl)y_l ≥ 0`（人手の `p` は Lean の `k`）
  have hrow : ∀ k, ∑ l, x k * P k l * y l ≥ 0 := fun k =>
    calc ∑ l, x k * P k l * y l
        ≥ x k * P k i₀ * y i₀ :=
          finite_sum_of_nonnegative_reals_ge_term_fintype _ (hterm k) i₀     -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`k → 1`）
      _ ≥ 0 := hterm k i₀                                                    -- 項の非負性（`q → 1`）
  calc x ⬝ᵥ P *ᵥ y
      = ∑ k, ∑ l, x k * P k l * y l :=
        dotProduct_mulVec_eq_real_bilinear_value x y P                      -- `def_real_bilinear_value`（`x → x`、`y → y`）
    _ ≥ ∑ l, x i₀ * P i₀ l * y l :=
        finite_sum_of_nonnegative_reals_ge_term_fintype _ hrow i₀           -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`k → 1`）
    _ ≥ 0 := hrow i₀                                                         -- 行の和の非負性（`p → 1`）

/-- **人手 `real_bilinear_value_of_scalar_multiple_vector`**: すべての `k` で `w_k = c u_k` なら
`w^⊤Pw = (cc)(u^⊤Pu)`（人手の 13 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_of_scalar_multiple_vector (P : Matrix n n ℝ) (c : ℝ) (u w : n → ℝ)
    (hw : ∀ k, w k = c * u k) :
    w ⬝ᵥ P *ᵥ w = c * c * (u ⬝ᵥ P *ᵥ u) :=
  calc w ⬝ᵥ P *ᵥ w
      = ∑ k, ∑ l, w k * P k l * w l :=
        dotProduct_mulVec_eq_real_bilinear_value w w P                      -- `def_real_bilinear_value`（`x → w`、`y → w`）
    _ = ∑ k, ∑ l, c * u k * P k l * (c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hw k, hw l]                                                    -- 仮定 `w_k = c u_k` を `w_k` と `w_l` へ同時適用
    _ = ∑ k, ∑ l, c * (u k * P k l) * (c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc c (u k) (P k l)]                                     -- 結合則 `(cu_k)P_kl = c(u_kP_kl)` を各項へ
    _ = ∑ k, ∑ l, c * (u k * P k l * (c * u l)) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc c (u k * P k l) (c * u l)                                -- 結合則 `(cs)t = c(st)` を各項へ
    _ = ∑ k, ∑ l, c * (u k * P k l * c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc (u k * P k l) c (u l)]                               -- 結合則 `s(cu_l) = (sc)u_l` を各項へ
    _ = ∑ k, ∑ l, c * (c * (u k * P k l) * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_comm (u k * P k l) c]                                      -- 可換則 `sc = cs` を各項へ
    _ = ∑ k, ∑ l, c * (c * (u k * P k l * u l)) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc c (u k * P k l) (u l)]                               -- 結合則 `(cs)u_l = c(su_l)` を各項へ
    _ = ∑ k, c * ∑ l, c * (u k * P k l * u l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_of_real_scalar_multiples_fintype c
            (fun l => c * (u k * P k l * u l))                               -- `finite_sum_of_real_scalar_multiples` を各 `k` へ
    _ = ∑ k, c * (c * ∑ l, u k * P k l * u l) :=
        Finset.sum_congr rfl fun k _ => by
          rw [finite_sum_of_real_scalar_multiples_fintype c
            (fun l => u k * P k l * u l)]                                    -- `finite_sum_of_real_scalar_multiples` を各 `k` へ
    _ = c * ∑ k, c * ∑ l, u k * P k l * u l :=
        finite_sum_of_real_scalar_multiples_fintype c
          (fun k => c * ∑ l, u k * P k l * u l)                              -- `finite_sum_of_real_scalar_multiples`
    _ = c * (c * ∑ k, ∑ l, u k * P k l * u l) := by
        rw [finite_sum_of_real_scalar_multiples_fintype c
          (fun k => ∑ l, u k * P k l * u l)]                                 -- `finite_sum_of_real_scalar_multiples`
    _ = c * (c * (u ⬝ᵥ P *ᵥ u)) := by
        rw [dotProduct_mulVec_eq_real_bilinear_value u u P]                  -- `def_real_bilinear_value` を右辺から左辺へ
    _ = c * c * (u ⬝ᵥ P *ᵥ u) := (mul_assoc c c _).symm                     -- 結合則 `c(ct) = (cc)t`（`t → u^⊤Pu`）

end Ising2D
