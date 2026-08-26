/-
人手証明「有理点 2 分の 1 では点数乗表示は末尾で成り立たない」
（ラベル `claim_eventual_power_form_at_one_half_is_impossible`）の Lean 具体版。

回文性から 2 の辺数乗を掛けた 2 分の 1 での値が 2 での値に等しいことを示す。
辺数が 2 以上なら点数乗表示の仮定から 2 での値は 4 で割れるが、破れ数 0 と 1 の
多重度から同じ値は法 4 で 2 となるので矛盾する。

住処は自然数、有理数、有限和だけである。箱の大きさの極限、上限、下限、積分、
微分、無限和、級数、指数関数、実対数は使わない。
-/
import Ising3DCut.LimitQuantity.EventualPowerFormAtTwoImpossible
import Ising3DCut.LimitQuantity.NullModelEvalNeInv
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepOne
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantSpecialized

namespace Ising3DCut.LimitQuantity

open Finset NullModel Polynomial

/-- 有理点 2 分の 1 での有限箱値。 -/
noncomputable def partitionValueAtOneHalfRat (L : ℕ) : ℚ :=
  (polyOfMultiplicity (Fintype.card (Edge L)) (multiplicity L)).eval (1 / 2)

/-- 重複度多項式の 2 での値は、自然数として定義した有限箱値の有理数への像である。 -/
theorem polyOfMultiplicity_eval_two_eq_partitionValueAtTwoNat (L : ℕ) :
    (polyOfMultiplicity (Fintype.card (Edge L)) (multiplicity L)).eval 2 =
      (partitionValueAtTwoNat L : ℚ) := by
  simp [polyOfMultiplicity, partitionValueAtTwoNat, eval_finsetSum]

/-- 人手証明の最初の四行。回文性による有限和の添字変更を反転多項式の評価として行う。 -/
theorem two_pow_edge_mul_partitionValueAtOneHalf_eq_partitionValueAtTwo (L : ℕ) :
    (2 : ℚ) ^ Fintype.card (Edge L) * partitionValueAtOneHalfRat L =
      (partitionValueAtTwoNat L : ℚ) := by
  have hpal := reflect_nullModel_poly_eq L
  have hdeg := natDegree_polyOfMultiplicity_le
    (Fintype.card (Edge L)) (multiplicity L)
  have h := eval_eq_pow_mul_eval_inv_of_reflect_eq hpal hdeg
    (q := (2 : ℚ)) (by norm_num)
  rw [show (1 / (2 : ℚ)) = 1 / 2 by norm_num,
    polyOfMultiplicity_eval_two_eq_partitionValueAtTwoNat] at h
  exact h.symm

/-- 一辺が 2 以上の自由境界箱には相異なる二辺がある。 -/
theorem two_le_card_edge {L : ℕ} (hL : 2 ≤ L) : 2 ≤ Fintype.card (Edge L) := by
  let e : Edge L := ⟨zeroSite (by omega), 0, by simp [zeroSite]; omega⟩
  obtain ⟨f₁, f₂, f₃, p, q, hf₁, hf₂, hf₃, hchain⟩ :=
    alternate_three_edges_exists hL e
  let injection : Bool → Edge L := fun b => if b then e else f₁
  have hinj : Function.Injective injection := by
    intro a b hab
    cases a <;> cases b <;> simp_all [injection]
  exact (Fintype.card_le_of_injective injection hinj :
    Fintype.card Bool ≤ Fintype.card (Edge L))

/-- `claim_eventual_power_form_at_one_half_is_impossible` の具体版。 -/
theorem eventual_power_form_at_one_half_is_impossible :
    ¬ ∃ L₀ c : ℕ, 0 < L₀ ∧ 0 < c ∧
      ∀ L, L₀ ≤ L → partitionValueAtOneHalfRat L =
        (c ^ Fintype.card (Site L) : ℕ) := by
  rintro ⟨L₀, c, hL₀, hc, hpower⟩
  let L := max L₀ 2
  have hL₀L : L₀ ≤ L := le_max_left _ _
  have hL2 : 2 ≤ L := le_max_right _ _
  have hedge : 2 ≤ Fintype.card (Edge L) := two_le_card_edge hL2
  have hscaled := two_pow_edge_mul_partitionValueAtOneHalf_eq_partitionValueAtTwo L
  rw [hpower L hL₀L] at hscaled
  have hscaledNat :
      2 ^ Fintype.card (Edge L) * c ^ Fintype.card (Site L) =
        partitionValueAtTwoNat L := by
    exact_mod_cast hscaled
  have hfour : 4 ∣ partitionValueAtTwoNat L := by
    rw [← hscaledNat]
    exact Dvd.dvd.mul_right (pow_dvd_pow 2 hedge) _
  have hmod := partitionValueAtTwoNat_mod_four hL2
  rw [Nat.dvd_iff_mod_eq_zero.mp hfour] at hmod
  norm_num at hmod

end Ising3DCut.LimitQuantity
