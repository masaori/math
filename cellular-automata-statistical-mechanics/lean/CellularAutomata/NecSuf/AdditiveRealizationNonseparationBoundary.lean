/-
正本: content/finite-word-real-normalization-boundary.ts の必要十分版。

具体版から次の不要な構造を取り除く。

* 定値零写像の加法性には、始域と終域の加法モノイドだけを要る。
* 異なる二元を識別しないことには、始域の異なる二元と終域の零だけを要る。

有限台、整数係数、素数、正の有限個数、復元写像、実数体、順序、
単射性、一般語族の極限、位相的エントロピー、複素数体は一般定理では使わない。
-/
import CellularAutomata.AdditiveRealizationNonseparationBoundary
import CellularAutomata.NecSuf.FiniteWordRealNormalizationBoundary
import Mathlib

namespace CellularAutomata.NecSuf.AdditiveRealizationNonseparationBoundary

open CellularAutomata.PrimeLogarithm
open CellularAutomata.FiniteWordRealNormalizationBoundary
open CellularAutomata.AdditiveRealizationNonseparationBoundary
open CellularAutomata.NecSuf.FiniteWordRealNormalizationBoundary

/-! ## 定値零写像に必要な構造 -/

/-- 任意の始域から零を持つ終域への定値零写像。 -/
def zeroMap {Source Target : Type} [Zero Target] : Source → Target := fun _ => 0

/-- 加法モノイド間の定値零写像は零と加法を保つ。 -/
theorem zeroMap_isZeroAdditive
    {Source Target : Type} [AddMonoid Source] [AddMonoid Target] :
    IsZeroAdditiveMap (zeroMap : Source → Target) := by
  constructor
  · rfl
  · intro left right
    change 0 = 0 + 0
    exact (zero_add 0).symm

/-! ## 定値零写像の非分離性に必要な構造 -/

/-- 始域の異なる二元は、定値零写像の下で同じ零へ移る。 -/
theorem zeroMap_needNotDistinguish
    {Source Target : Type} [Zero Target]
    (left right : Source) (hdistinct : left ≠ right) :
    left ≠ right ∧
      (zeroMap left : Target) = zeroMap right ∧
      (zeroMap right : Target) = 0 := by
  constructor
  · exact hdistinct
  · constructor <;> rfl

/-! ## 具体版の導出 -/

/-- 具体版の零実数実現は、一般の定値零写像である。 -/
theorem zeroRealization_eq_zeroMap :
    zeroRealization = (zeroMap : LogVector → ℝ) := by
  rfl

/-- 具体版の零実数実現の加法性は、加法モノイド間の一般定理から得られる。 -/
theorem zeroRealization_isAdditive_of_necSuf :
    IsAdditiveRealization zeroRealization := by
  rw [zeroRealization_eq_zeroMap]
  exact zeroMap_isZeroAdditive

/-- 具体版の識別力反例は、定値零写像の一般の非分離性から得られる。 -/
theorem additiveRealization_needNotDistinguishCounts_of_necSuf :
    logarithm (positiveNat 1 (by decide)) ≠
        logarithm (positiveNat 2 (by decide)) ∧
      zeroRealization (logarithm (positiveNat 1 (by decide))) =
          zeroRealization (logarithm (positiveNat 2 (by decide))) ∧
      zeroRealization (logarithm (positiveNat 2 (by decide))) = 0 := by
  simpa [zeroRealization_eq_zeroMap] using
    (zeroMap_needNotDistinguish
      (Target := ℝ)
      (logarithm (positiveNat 1 (by decide)))
      (logarithm (positiveNat 2 (by decide)))
      logarithm_one_ne_logarithm_two)

end CellularAutomata.NecSuf.AdditiveRealizationNonseparationBoundary
