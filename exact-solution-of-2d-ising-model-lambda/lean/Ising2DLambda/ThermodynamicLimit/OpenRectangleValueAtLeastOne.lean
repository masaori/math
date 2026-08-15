/-
人手証明「開境界長方形の全て正の定数配位」「その破れボンド数は零である」
「開境界長方形の値は 1 以上である」の具体版。

`1 = t^0 = t^{b(τ_+)} ≤ t^{b(τ_+)} + Σ_{σ≠τ_+} t^{b(σ)} = Σ_σ t^{b(σ)} = Z^op_{a,b}(t)`
を人手証明と同じ順で辿る。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

variable (a b : ℕ)

/-- `def_open_rectangle_constant_plus_configuration`。全ての頂点に +1 を割り当てる配位 τ_+。 -/
def openAllPlusConfig : OpenConfig a b := fun _ => ⟨1, Or.inl rfl⟩

/-- `claim_open_rectangle_constant_plus_breaks_no_bond`。定数配位では各辺の両端の値が等しい。 -/
theorem openAllPlusConfig_openBrokenBondCount_eq_zero :
    openBrokenBondCount a b (openAllPlusConfig a b) = 0 := by
  unfold openBrokenBondCount openBrokenBondSet
  have hfilter :
      (univ.filter fun e : OpenEdge a b =>
        openAllPlusConfig a b (openBoundary0 a b e) ≠
          openAllPlusConfig a b (openBoundary1 a b e)) = ∅ := by
    ext e
    simp [openAllPlusConfig]
  rw [hfilter, card_empty]

/-- `claim_open_rectangle_value_at_least_one` の具体版。 -/
theorem one_le_openPartitionValue {t : ℝ} (ht : 0 < t) :
    1 ≤ openPartitionValue a b t := by
  let τplus : OpenConfig a b := openAllPlusConfig a b
  have hmem : τplus ∈ (univ : Finset (OpenConfig a b)) := mem_univ τplus
  -- 準備: 各項は正
  have hrest : 0 ≤ ∑ σ ∈ (univ : Finset (OpenConfig a b)).erase τplus,
      t ^ openBrokenBondCount a b σ :=
    sum_nonneg fun σ _ => (pow_pos_by_induction ht _).le
  rw [openPartitionValue_eq_sum]
  calc
    1 = t ^ 0 := (pow_zero t).symm
    _ = t ^ openBrokenBondCount a b τplus := by
      rw [openAllPlusConfig_openBrokenBondCount_eq_zero]
    _ ≤ t ^ openBrokenBondCount a b τplus +
        ∑ σ ∈ (univ : Finset (OpenConfig a b)).erase τplus,
          t ^ openBrokenBondCount a b σ := le_add_of_nonneg_right hrest
    _ = ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ := by
      rw [add_comm, sum_erase_add _ _ hmem]

end Ising2DLambda.ThermodynamicLimit
