import Ising2DLambda.FisherZero.PositiveRationalInPositiveCone
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 自然数 `c` を ℕ → ℚ → Qbar の二つの包含で送り、`Q_s` の元へ持ち上げ、
    右から `xi` を掛けた積。 -/
noncomputable def quadraticNatMulElement (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s) :
    QuadraticFieldElement s :=
  quadraticMulElement s hs (positiveRationalElement s (c : ℚ)) xi

/-- 上の積は `Qbar` の通常の積と同じ元である（本文の「c·ξ は Qbar の乗法」）。 -/
theorem quadraticNatMulElement_coe (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s) :
    (quadraticNatMulElement s hs c xi : Qbar) =
      algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) := by
  simp only [quadraticNatMulElement, quadraticMulElement, positiveRationalElement]

/-- 本文の零の積・零の表示・所属の移し替え・正の場合の六行。 -/
theorem quadraticNatMulValue_spec (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) ∈ quadraticFieldSet s ∧
      (c = 0 → algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  by_cases hc : c = 0
  · have hzero : algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) = 0 := by
      calc
        algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) =
            algebraMap ℚ Qbar ((0 : ℕ) : ℚ) * (xi : Qbar) :=
          congrArg (fun n : ℕ => algebraMap ℚ Qbar (n : ℚ) * (xi : Qbar)) hc
        _ = algebraMap ℚ Qbar (0 : ℚ) * (xi : Qbar) :=
          congrArg (fun q : ℚ => algebraMap ℚ Qbar q * (xi : Qbar)) Nat.cast_zero
        _ = (0 : Qbar) * (xi : Qbar) :=
          congrArg (fun z : Qbar => z * (xi : Qbar)) (map_zero (algebraMap ℚ Qbar))
        _ = 0 := zero_mul _
    have hrep : (0 : Qbar) = algebraMap ℚ Qbar 0 + algebraMap ℚ Qbar 0 * s := by
      calc
        (0 : Qbar) = 0 + 0 := (add_zero 0).symm
        _ = 0 + (0 : Qbar) * s := congrArg (fun z : Qbar => 0 + z) (zero_mul s).symm
        _ = algebraMap ℚ Qbar 0 + (0 : Qbar) * s :=
          congrArg (fun z : Qbar => z + (0 : Qbar) * s) (map_zero (algebraMap ℚ Qbar)).symm
        _ = algebraMap ℚ Qbar 0 + algebraMap ℚ Qbar 0 * s :=
          congrArg (fun z : Qbar => algebraMap ℚ Qbar 0 + z * s)
            (map_zero (algebraMap ℚ Qbar)).symm
    have hzmem : (0 : Qbar) ∈ quadraticFieldSet s := ⟨0, 0, hrep⟩
    have hmem : algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) ∈ quadraticFieldSet s := by
      rw [hzero]
      exact hzmem
    refine ⟨hmem, fun _ => hzero, ?_⟩
    intro hpositive
    omega
  · have hcpos : 1 ≤ c := Nat.one_le_iff_ne_zero.mpr hc
    have hnat : 0 < c := lt_of_lt_of_le Nat.zero_lt_one hcpos
    have hq : (0 : ℚ) < (c : ℚ) := Nat.cast_pos.mpr hnat
    have hcoefS : algebraMap ℚ Qbar (c : ℚ) ∈ quadraticFieldSet s :=
      positiveRational_mem_quadraticFieldSet s (c : ℚ)
    have hcoefP : positiveRationalElement s (c : ℚ) ∈ quadraticPositiveCone s :=
      positiveRational_mem_positiveCone s hs (c : ℚ) hq
    have hmem : algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) ∈ quadraticFieldSet s :=
      quadraticMul_mem s hs ⟨algebraMap ℚ Qbar (c : ℚ), hcoefS⟩ xi
    have hpos : quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s :=
      quadraticPositiveCone_mul_mem s hs (positiveRationalElement s (c : ℚ)) xi hcoefP hxi
    exact ⟨hmem, fun h => (hc h).elim, fun _ => hpos⟩

/-- 既存の積の型へ、値を与える定義の橋で戻す。 -/
theorem quadraticNatMulElement_zero_or_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    (c = 0 → (quadraticNatMulElement s hs c xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  have h := quadraticNatMulValue_spec s hs c xi hxi
  refine ⟨?_, h.2.2⟩
  intro hc
  calc
    (quadraticNatMulElement s hs c xi : Qbar) =
        algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) := quadraticNatMulElement_coe s hs c xi
    _ = 0 := h.2.1 hc

end Ising2DLambda.FisherZero
