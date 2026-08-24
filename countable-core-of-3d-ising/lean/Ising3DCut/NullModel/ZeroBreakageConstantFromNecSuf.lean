/-
具体版の第三段が必要十分版の特殊化として得られることの明示。

有限型を破れ数 `0` の水準集合、写された先を `Spin`、単射を「原点での値をとる写像」に取る。
単射性は具体版で示した定値性定理から、下界は既存の全上・全下の二配位から与える。

必要十分版の `Fintype.card` と具体版の `multiplicity L 0` が数える集合は
定義がそのまま一致するので、元の個数もそのまま一致する。

住処: `Fin`、`Nat`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.ZeroBreakageConstant
import Ising3DCut.NecSuf.NullModel.ZeroBreakageConstant

namespace Ising3DCut.NullModel

/-- `claim_zero_breakage_multiplicity_is_two` の第三段を必要十分版から導いたもの。 -/
theorem multiplicity_zero_eq_two_from_necSuf {L : ℕ} (hL : 0 < L) :
    multiplicity L 0 = 2 := by
  let valueAtOrigin : LevelSet L 0 → Spin := fun σ => σ.1 (zeroSite hL)
  have hinjective : Function.Injective valueAtOrigin := by
    intro σ τ hvalue
    apply Subtype.ext
    funext a
    have hσzero : brokenCount σ.1 = 0 := (Finset.mem_filter.mp σ.2).2
    have hτzero : brokenCount τ.1 = 0 := (Finset.mem_filter.mp τ.2).2
    rw [eq_zeroSite_value_of_brokenCount_zero hL σ.1 hσzero a,
      eq_zeroSite_value_of_brokenCount_zero hL τ.1 hτzero a]
    exact hvalue
  let spinEquivBool : Spin ≃ Bool := {
    toFun z := if z.1 = 1 then true else false
    invFun b := if b then ⟨1, Or.inl rfl⟩ else ⟨-1, Or.inr rfl⟩
    left_inv z := by
      apply Subtype.ext
      rcases z.2 with hz | hz <;> simp [hz]
    right_inv b := by cases b <;> simp }
  have hspin : Fintype.card Spin = 2 := by
    rw [Fintype.card_congr spinEquivBool]
    rfl
  exact NecSuf.NullModel.card_eq_of_injective_of_le
    valueAtOrigin hinjective 2 hspin (two_le_multiplicity_zero hL)

end Ising3DCut.NullModel
