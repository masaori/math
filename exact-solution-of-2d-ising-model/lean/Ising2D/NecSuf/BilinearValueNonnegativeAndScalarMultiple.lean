/-
# 必要十分版: 成分が非負なら双線型値 `x^⊤Py` は非負、ベクトルを `c` 倍すると `w^⊤Pw` は `cc` 倍

人手証明のラベル: **`real_bilinear_value_with_nonnegative_entries_is_nonnegative`**・**`real_bilinear_value_of_scalar_multiple_vector`**
（正本 `structured-latex/content/011_max_eigenvalue.ts`）。
具体版は `Ising2D.real_bilinear_value_with_nonnegative_entries_is_nonnegative`・`Ising2D.real_bilinear_value_of_scalar_multiple_vector`
（`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple.lean`）で、
導出は同じフォルダの `ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultipleFromNecSuf.lean` に置く。

## 手順（具体版の `calc` と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| `def_real_bilinear_value`（最初と最後の段） | `dotProduct_mulVec_eq_double_sum'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`） |
| 非負の実数の積は非負（`mul_nonneg` を 2 回） | 仮定 `hmul` を 2 回 |
| `finite_sum_of_nonnegative_reals_is_at_least_each_term`（各 `p` と外側の和） | `finite_sum_ge_term'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`） |
| 仮定 `w_k = c u_k`、結合則 4 回、可換則 1 回 | 仮定 `hw`、`mul_assoc`、仮定 `hc` |
| `finite_sum_of_real_scalar_multiples` を 4 回 | `finite_sum_mul_left'`（同上） |
| 最後の結合則 `c(c(u^⊤Pu)) = (cc)(u^⊤Pu)` | `mul_assoc` |

## この主張に本質的に効いている構造

* 非負性の主張: `≤` の反射律・推移律と、両辺に同じ元を足しても `≤` が保たれること（`finite_sum_ge_term'`）、
  非負の元どうしの積が非負であること（明示の仮定 `hmul`）だけ。積の非負性は主張そのものに要るので外せない。
  加法の逆元・乗法の単位元・可換性・反対称律・全順序は使わない。添字の型が空でないこと `[Nonempty n]` は、人手が `k → 1` と
  項を一つ選ぶ段のために要る（人手の `n ≥ 1`）。
* 実数倍の主張: 乗法の結合則と、`c` が各 `u_kP_kl` と可換であること（明示の仮定 `hc`。人手の可換則の段 `s c = c s`（`s → u_kP_kl`）で使う元だけに限った）、
  左分配則（`finite_sum_mul_left'`）と `c·0 = 0`。乗法の可換性一般・単位元・加法の逆元・順序は使わない。
  `hc` を外すと人手の可換則の段が書けず、`w^⊤Pw` と `(cc)(u^⊤Pu)` は一般に一致しない（非可換な環で `c` が `u_kP_kl` と可換でない場合）。
* 乗法の結合則は、実数倍の主張では人手の 4 か所の段そのものに要る。非負性の主張では、mathlib の `x ⬝ᵥ P *ᵥ y`（`Σ_k x_k (Σ_l P_kl y_l)`）を
  人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く段（`dotProduct_mulVec_eq_double_sum'`）だけで使う。結合的でない係数では人手の和と mathlib の値が別物になるので、
  具体版と同じ手順を保つ限り外せない。
* どちらも、主張の文の `P *ᵥ y` そのものが mathlib で `NonUnitalNonAssocSemiring`（左右の分配則と `0·a = a·0 = 0`）を要求する。
  以上から、係数は非単位的な半環 `R` に置く。
* 非負性の主張の `[AddRightMono R]` は、加法が可換なので `AddLeftMono` から出る（mathlib の instance）。既存の `finite_sum_ge_term_fin'` の
  仮定の並びに合わせて残している。
-/
import Ising2D.NecSuf.BilinearValueAtMostValueAtAbsoluteVector
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [NonUnitalSemiring R]
variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_with_nonnegative_entries_is_nonnegative` の必要十分版**（具体版と同じ並び）。 -/
theorem bilinear_value_with_nonnegative_entries_is_nonnegative' [Preorder R] [AddLeftMono R] [AddRightMono R]
    (hmul : ∀ s t : R, 0 ≤ s → 0 ≤ t → 0 ≤ s * t) [Nonempty n] (P : Matrix n n R)
    (hP : ∀ k l, 0 ≤ P k l) (x y : n → R) (hx : ∀ k, 0 ≤ x k) (hy : ∀ l, 0 ≤ y l) :
    x ⬝ᵥ P *ᵥ y ≥ 0 := by
  have hterm : ∀ k l, x k * P k l * y l ≥ 0 := fun k l =>
    have h1 : x k * P k l ≥ 0 := hmul _ _ (hx k) (hP k l)
    hmul _ _ h1 (hy l)
  let i₀ : n := Classical.arbitrary n
  have hrow : ∀ k, ∑ l, x k * P k l * y l ≥ 0 := fun k =>
    calc ∑ l, x k * P k l * y l
        ≥ x k * P k i₀ * y i₀ := finite_sum_ge_term' _ (hterm k) i₀
      _ ≥ 0 := hterm k i₀
  calc x ⬝ᵥ P *ᵥ y
      = ∑ k, ∑ l, x k * P k l * y l := dotProduct_mulVec_eq_double_sum' x y P
    _ ≥ ∑ l, x i₀ * P i₀ l * y l := finite_sum_ge_term' _ hrow i₀
    _ ≥ 0 := hrow i₀

/-- **人手 `real_bilinear_value_of_scalar_multiple_vector` の必要十分版**（具体版の 13 段と同じ並び）。 -/
theorem bilinear_value_of_scalar_multiple_vector' (P : Matrix n n R) (c : R) (u : n → R)
    (hc : ∀ k l, u k * P k l * c = c * (u k * P k l)) (w : n → R) (hw : ∀ k, w k = c * u k) :
    w ⬝ᵥ P *ᵥ w = c * c * (u ⬝ᵥ P *ᵥ u) :=
  calc w ⬝ᵥ P *ᵥ w
      = ∑ k, ∑ l, w k * P k l * w l := dotProduct_mulVec_eq_double_sum' w w P
    _ = ∑ k, ∑ l, c * u k * P k l * (c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by rw [hw k, hw l]
    _ = ∑ k, ∑ l, c * (u k * P k l) * (c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc c (u k) (P k l)]
    _ = ∑ k, ∑ l, c * (u k * P k l * (c * u l)) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc c (u k * P k l) (c * u l)
    _ = ∑ k, ∑ l, c * (u k * P k l * c * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc (u k * P k l) c (u l)]
    _ = ∑ k, ∑ l, c * (c * (u k * P k l) * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hc k l]
    _ = ∑ k, ∑ l, c * (c * (u k * P k l * u l)) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_assoc c (u k * P k l) (u l)]
    _ = ∑ k, c * ∑ l, c * (u k * P k l * u l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_mul_left' c (mul_zero c) (fun l => c * (u k * P k l * u l))
    _ = ∑ k, c * (c * ∑ l, u k * P k l * u l) :=
        Finset.sum_congr rfl fun k _ => by
          rw [finite_sum_mul_left' c (mul_zero c) (fun l => u k * P k l * u l)]
    _ = c * ∑ k, c * ∑ l, u k * P k l * u l :=
        finite_sum_mul_left' c (mul_zero c) (fun k => c * ∑ l, u k * P k l * u l)
    _ = c * (c * ∑ k, ∑ l, u k * P k l * u l) := by
        rw [finite_sum_mul_left' c (mul_zero c) (fun k => ∑ l, u k * P k l * u l)]
    _ = c * (c * (u ⬝ᵥ P *ᵥ u)) := by rw [dotProduct_mulVec_eq_double_sum' u u P]
    _ = c * c * (u ⬝ᵥ P *ᵥ u) := (mul_assoc c c _).symm

end Ising2D.NecSuf
