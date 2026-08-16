/-
「実現写像は有理数倍と可換である」の必要十分版。

具体版が使うのは、(1) 有限台の写像 `μ : P →₀ K` の係数倍 `r • μ` の台が `μ` の台に含まれること
（`r * 0 = 0`。`MulZeroClass K` が担う）、(2) `(r • μ) p = r * μ p`（係数倍の定義）、
(3) 係数を送る写像 `ι : K → R` が乗法を保ち `ι 0 = 0` であること（仮定として受ける）、
(4) `R` の乗法の結合則、(5) `R` の乗法が有限和へ分配すること、だけである。
`R` は `NonUnitalSemiring`（加法の可換モノイド・乗法の半群・分配則）で足り、単位元・逆元・順序・
実対数は使わない。重み `w : P → R`（具体版では `log_ℝ(ι p)`）は任意でよく、その性質は一切使わない。
`K` は `MulZeroClass`（係数倍を定め、`r * 0 = 0` を与える）で足り、加法も体の性質も使わない。
証明手順は具体版と同じ六段（定義・台の包含・係数倍の定義・`ι` の乗法保存・結合則・分配則・定義）。
-/
import Mathlib.Data.Finsupp.SMul
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {P K R : Type*} [MulZeroClass K] [NonUnitalSemiring R]

/-- 実現写像の必要十分版: 台に渡る和 `Σ_{p ∈ supp μ} ι(μ p) · w p`。 -/
noncomputable def realizeWith (ι : K → R) (w : P → R) (μ : P →₀ K) : R :=
  μ.support.sum fun p => ι (μ p) * w p

/-- 係数倍と可換: `realizeWith ι w (r • μ) = ι r * realizeWith ι w μ`。 -/
theorem realizeWith_smul_necSuf (ι : K → R) (hι : ∀ a b : K, ι (a * b) = ι a * ι b)
    (hι0 : ι 0 = 0) (w : P → R) (r : K) (μ : P →₀ K) :
    realizeWith ι w (r • μ) = ι r * realizeWith ι w μ := by
  calc
    realizeWith ι w (r • μ)
        = (r • μ).support.sum fun p => ι ((r • μ) p) * w p := rfl      -- 定義
    _ = μ.support.sum fun p => ι ((r • μ) p) * w p := by
          -- supp(r·μ) ⊂ supp(μ)。台の外の項は (r·μ)(p) = 0 で ι 0 = 0
          apply Finset.sum_subset (Finsupp.support_smul)
          intro p _ hp
          rw [Finsupp.notMem_support_iff.mp hp, hι0, zero_mul]
    _ = μ.support.sum fun p => ι (r * μ p) * w p := by
          -- 係数倍の定義
          apply Finset.sum_congr rfl
          intro p _
          rw [Finsupp.smul_apply, smul_eq_mul]
    _ = μ.support.sum fun p => (ι r * ι (μ p)) * w p := by
          -- ι は乗法を保つ
          apply Finset.sum_congr rfl
          intro p _
          rw [hι]
    _ = μ.support.sum fun p => ι r * (ι (μ p) * w p) := by
          -- 乗法の結合則
          apply Finset.sum_congr rfl
          intro p _
          rw [mul_assoc]
    _ = ι r * μ.support.sum fun p => ι (μ p) * w p :=
          (Finset.mul_sum _ _ _).symm                                   -- 分配則を有限和へ
    _ = ι r * realizeWith ι w μ := rfl                                  -- 定義

end Ising2DLambda.NecSuf.ThermodynamicLimit
