/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に M := ℤ、α := (RowConfig L → RowConfig L)、sgn := orbitPermSign L O、
w := (fun k => ambientComposite L τ₁ k)、u := -1、n := |O|、e := e(τ₁)、c := rowShift L を
代入すると、具体版の等式が出る。代入する仮定は次の 4 つだけである。

  hw   ← ambientComposite_sign（反復合成の符号が (-1)^k であること）
  hc   ← orbitTranspositionComposite_eq_rowShiftRestriction（Ψ_{|O|-1} = S↾_O）を
         orbitPermSign_congr で符号の等式へ移したもの
  hne  ← card_rowShiftOrbit（|O| = e(τ₁)）
  hpos ← rowShiftMinimalPeriod_pos（e(τ₁) ≥ 1）

このことは、この段そのものが次を使っていないという主張の裏取りになっている。
行配位であること・巡回シフト・軌道・最小周期・互換であること・順序 ≺・
符号が (-1) の冪であること・元が写像であること・型の有限性。

住処: ℕ と ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitShiftRestrictionSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の主張を、必要十分版から導いたもの。 -/
theorem shiftOrbitRestriction_sign_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) :
    orbitPermSign L O (rowShift L) = (-1) ^ (O.card - 1) := by
  classical
  obtain ⟨τ₁, hτ₁⟩ := mem_rowShiftOrbitSet.mp hO
  have hτ₀ : τ₁ ∈ O := hτ₁ ▸ self_mem_rowShiftOrbit τ₁
  have hcard : O.card = rowShiftMinimalPeriod L τ₁ := by
    rw [← hτ₁]; exact card_rowShiftOrbit L τ₁
  have hval : ∀ τ ∈ O, rowShift L τ = ambientComposite L τ₁ (O.card - 1) τ := by
    intro τ hτ
    have h := congrFun (orbitTranspositionComposite_eq_rowShiftRestriction hO hτ₀)
      (⟨τ, hτ⟩ : {τ : RowConfig L // τ ∈ O})
    have h₁ : (orbitTranspositionComposite hO hτ₀ (O.card - 1) ⟨τ, hτ⟩).1
        = rowShift L τ := by
      rw [h]; exact shiftOrbitRestriction_val ⟨O, hO⟩ ⟨τ, hτ⟩
    rw [← h₁]
    exact ambientComposite_val hO hτ₀ (O.card - 1) ⟨τ, hτ⟩
  exact NecSuf.AlgebraicEigenvalue.value_at_top_of_iterated
    (orbitPermSign L O) (fun k => ambientComposite L τ₁ k) (-1)
    O.card (rowShiftMinimalPeriod L τ₁)
    (ambientComposite_sign hO hτ₀) (rowShift L)
    (orbitPermSign_congr hval) hcard (rowShiftMinimalPeriod_pos τ₁)

end Ising2DLambda.AlgebraicEigenvalue
