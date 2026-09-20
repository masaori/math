/-
「反復横断階段は非零の周期並進と交わらない」の必要十分版。

格子・階段・巻き付きから切り離すと、必要なのは点族の座標幅、整数並進による
座標増分、および一回の増分が幅を真に超えることだけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 座標幅より大きい一定量を整数回加える非零並進は、もとの点族と交わらない。 -/
theorem bounded_family_avoids_nonzero_integer_translates_necSuf
    {I X : Type*} (family : I → X) (translate : ℤ → X → X) (coordinate : X → ℤ)
    (width periodStep : ℤ)
    (hwidth : ∀ i j : I, |coordinate (family i) - coordinate (family j)| ≤ width)
    (htranslate : ∀ (z : ℤ) (x : X),
      coordinate (translate z x) = coordinate x + z * periodStep)
    (hperiod : width < periodStep)
    (i j : I) (z : ℤ) (hz : z ≠ 0) : family i ≠ translate z (family j) := by
  intro heq
  have hcoordinate := congrArg coordinate heq
  rw [htranslate] at hcoordinate
  have habsz : 1 ≤ |z| := (Int.one_le_abs hz)
  have hwidthNonneg : 0 ≤ width := by
    simpa using hwidth i i
  have hperiodNonneg : 0 ≤ periodStep := by omega
  have hlower : periodStep ≤ |z| * periodStep := by nlinarith
  have htooLarge : width < |z * periodStep| := by
    rw [abs_mul, abs_of_nonneg hperiodNonneg]
    exact lt_of_lt_of_le hperiod hlower
  have hsame : |coordinate (family i) - coordinate (family j)| = |z * periodStep| := by
    rw [hcoordinate]
    congr 1
    ring
  have hbound := hwidth i j
  rw [hsame] at hbound
  exact (not_lt_of_ge hbound) htooLarge

end Ising2DLambda.NecSuf.KacWard
