/-
正本: content/finite-word-real-normalization-boundary.ts の必要十分版。

具体版から次の不要な構造を取り除く。

* 自然数倍の保存には、始域と終域の加法モノイドと、零・加法を保つ写像だけを要る。
* 規格化後の一定性には、正の自然数倍を元へ戻す規格化演算だけを要る。

有限二元語、素数、有限台、整数係数、実数体、順序、対数、
一般語族の極限、位相的エントロピー、複素数体は一般定理では使わない。
-/
import CellularAutomata.FiniteWordRealNormalizationBoundary
import Mathlib

namespace CellularAutomata.NecSuf.FiniteWordRealNormalizationBoundary

open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.PrimeLogarithm
open CellularAutomata.FiniteWordRealNormalizationBoundary

/-! ## 零と加法を保つ写像に必要な構造 -/

/-- 二つの加法モノイドの間で零と加法を保つ写像。 -/
def IsZeroAdditiveMap
    {Source Target : Type} [AddMonoid Source] [AddMonoid Target]
    (realize : Source → Target) : Prop :=
  realize 0 = 0 ∧
    ∀ left right : Source, realize (left + right) = realize left + realize right

/-- 零と加法を保つ写像は自然数倍を保つ。 -/
theorem zeroAdditiveMap_naturalMultiple
    {Source Target : Type} [AddMonoid Source] [AddMonoid Target]
    (realize : Source → Target) (hrealize : IsZeroAdditiveMap realize)
    (value : Source) (multiplier : ℕ) :
    realize (multiplier • value) = multiplier • realize value := by
  induction multiplier with
  | zero =>
      simpa using hrealize.1
  | succ multiplier inductionHypothesis =>
      rw [succ_nsmul, hrealize.2, inductionHypothesis, succ_nsmul]

/-! ## 正の自然数倍を戻す規格化に必要な構造 -/

/-- 正の自然数倍を、その正の倍率による規格化で元へ戻せること。 -/
def IsPositiveNaturalNormalizer
    {Target : Type} [AddMonoid Target]
    (normalize : Target → PositiveStage → Target) : Prop :=
  ∀ value : Target, ∀ multiplier : PositiveStage,
    normalize (multiplier.val • value) multiplier = value

/-- 加法写像で移した自然数倍は、正の倍率による規格化で元の像へ戻る。 -/
theorem normalizedZeroAdditiveImage_constant
    {Source Target : Type} [AddMonoid Source] [AddMonoid Target]
    (realize : Source → Target) (hrealize : IsZeroAdditiveMap realize)
    (normalize : Target → PositiveStage → Target)
    (hnormalize : IsPositiveNaturalNormalizer normalize)
    (value : Source) (multiplier : PositiveStage) :
    normalize (realize (multiplier.val • value)) multiplier = realize value := by
  rw [zeroAdditiveMap_naturalMultiple realize hrealize]
  exact hnormalize (realize value) multiplier

/-! ## 具体版の導出 -/

/-- 具体版の加法的実数実現は、零と加法だけを保つ一般写像である。 -/
theorem isZeroAdditiveMap_of_additiveRealization
    (realize : LogVector → ℝ) (hrealize : IsAdditiveRealization realize) :
    IsZeroAdditiveMap realize :=
  hrealize

/-- 具体版の自然数倍保存は、加法モノイド間の一般定理の特殊化である。 -/
theorem additiveRealization_naturalMultiple_of_necSuf
    (realize : LogVector → ℝ) (hrealize : IsAdditiveRealization realize)
    (value : LogVector) (multiplier : ℕ) :
    realize (scale (multiplier : ℤ) value) =
      (multiplier : ℝ) * realize value := by
  have hscale : scale (multiplier : ℤ) value = multiplier • value := by
    ext prime
    simp [scale_apply]
  rw [hscale]
  rw [zeroAdditiveMap_naturalMultiple realize
    (isZeroAdditiveMap_of_additiveRealization realize hrealize)]
  simp

/-- 実数の除算は、正の自然数倍を元へ戻す規格化演算である。 -/
theorem realDivision_isPositiveNaturalNormalizer :
    IsPositiveNaturalNormalizer
      (fun value : ℝ => fun multiplier : PositiveStage =>
        value / (multiplier.val : ℝ)) := by
  intro value multiplier
  have hnonzero : (multiplier.val : ℝ) ≠ 0 := by
    exact_mod_cast multiplier.property.ne'
  rw [nsmul_eq_mul]
  exact mul_div_cancel_left₀ value hnonzero

/-- 全二元語族の具体的な実数規格化値は、一般の加法写像と規格化の定理から一定になる。 -/
theorem fullTwoSymbolWordRealizedDensity_constant_of_necSuf
    (realize : LogVector → ℝ) (hrealize : IsAdditiveRealization realize)
    (length : PositiveStage) :
    finiteWordRealizedDensity realize length =
      realize (logarithm (positiveNat 2 (by decide))) := by
  rw [finiteWordRealizedDensity,
    finiteWordLogarithmicCount_eq_naturalMultiple]
  change
    (fun value : ℝ => fun multiplier : PositiveStage =>
      value / (multiplier.val : ℝ))
      (realize (scale (length.val : ℤ)
        (logarithm (positiveNat 2 (by decide))))) length =
      realize (logarithm (positiveNat 2 (by decide)))
  rw [additiveRealization_naturalMultiple_of_necSuf realize hrealize]
  rw [← nsmul_eq_mul]
  exact realDivision_isPositiveNaturalNormalizer _ length

end CellularAutomata.NecSuf.FiniteWordRealNormalizationBoundary
