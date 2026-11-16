/-
分散因子の有限積の実対数をモード和へ移す論法の必要十分版。
必要なのは有限添字、正の実数値の因子、平方と有限積の等式、実数の係数だけである。
分散多項式、代数的数、実閉部分体の構造は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog

namespace Ising2DLambda.NecSuf.RealEscape

open Ising2DLambda.ThermodynamicLimit

/-- 平方が正の有限積である実数の絶対値の実対数を、因子ごとの和へ移す。 -/
theorem squareProduct_realLog_sum {α : Type*} [DecidableEq α]
    (S : Finset α) (T : ℝ) (u : α → ℝ) (hu : ∀ i, 0 < u i)
    (hsq : T ^ 2 = ∏ i ∈ S, u i) (c : ℝ) :
    c * Real.log |T| = (c / 2) * ∑ i ∈ S, Real.log (u i) := by
  have hprodpos : 0 < ∏ i ∈ S, u i := Finset.prod_pos fun i _ => hu i
  have hT : T ≠ 0 := by
    intro hzero
    have hsqpos : 0 < T ^ 2 := hsq ▸ hprodpos
    simp [hzero] at hsqpos
  have habs : 0 < |T| := abs_pos.mpr hT
  have hlogabs : Real.log |T| = (1 / 2 : ℝ) * Real.log (T ^ 2) := by
    have hmul := realLog_mul ⟨|T|, habs⟩ ⟨|T|, habs⟩
    have hsquare : |T| * |T| = T ^ 2 := by rw [← pow_two, sq_abs]
    have hlog : Real.log (T ^ 2) = Real.log |T| + Real.log |T| := by
      calc
        Real.log (T ^ 2) = Real.log (|T| * |T|) := congrArg Real.log hsquare.symm
        _ = Real.log |T| + Real.log |T| := hmul
    linarith
  have hlogsum : Real.log (T ^ 2) = ∑ i ∈ S, Real.log (u i) := by
    calc
      Real.log (T ^ 2) = Real.log (∏ i ∈ S, u i) := congrArg Real.log hsq
      _ = ∑ i ∈ S, Real.log (u i) :=
        realLog_prod S (fun i => ⟨u i, hu i⟩)
  rw [hlogabs, hlogsum]
  ring

end Ising2DLambda.NecSuf.RealEscape
