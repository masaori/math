/-
人手証明「自由エネルギー密度の下からの評価」の具体版。

全て正の配位の破れボンド数が零であることから分配多項式の値を一で下から評価し、
実対数の単調性を一度だけ使う。最後に正の有理係数を掛ける。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensity

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

/-- `claim_constant_plus_breaks_no_bond`。定数配位では各辺の両端の値が等しい。 -/
theorem allPlusConfig_brokenBondCount_eq_zero (L : ℕ) [NeZero L] :
    brokenBondCount L (allPlusConfig L) = 0 := by
  unfold brokenBondCount
  have hfilter :
      (univ.filter fun e : Edge L =>
        allPlusConfig L (boundary0 L e) ≠ allPlusConfig L (boundary1 L e)) = ∅ := by
    ext e
    simp [allPlusConfig]
  rw [hfilter, card_empty]

/-- `claim_free_energy_density_nonnegative`。人手証明の下からの評価を同じ順序で辿る。 -/
theorem freeEnergyDensity_nonnegative (L : PositiveNatural) (t : StrictlyPositiveReal) :
    0 ≤ freeEnergyDensity L t := by
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  let σplus : Config L.1 := allPlusConfig L.1
  have hσplus : σplus ∈ (univ : Finset (Config L.1)) := mem_univ σplus
  have hbreaks : brokenBondCount L.1 σplus = 0 :=
    allPlusConfig_brokenBondCount_eq_zero L.1
  have hrest : 0 ≤ ∑ σ ∈ (univ : Finset (Config L.1)).erase σplus,
      t.1 ^ brokenBondCount L.1 σ := by
    exact sum_nonneg fun σ _ => (pow_pos_by_induction t.2 _).le
  have hpartition : 1 ≤ Polynomial.aeval t.1 (partitionPolynomial L.1) := by
    rw [eval_partitionPolynomial_real L.1 t.1]
    calc
      1 = t.1 ^ brokenBondCount L.1 σplus := by rw [hbreaks, pow_zero]
      _ ≤ t.1 ^ brokenBondCount L.1 σplus +
          ∑ σ ∈ (univ : Finset (Config L.1)).erase σplus,
            t.1 ^ brokenBondCount L.1 σ := le_add_of_nonneg_right hrest
      _ = ∑ σ : Config L.1, t.1 ^ brokenBondCount L.1 σ := by
        rw [add_comm, sum_erase_add _ _ hσplus]
  have hentropy : 0 ≤ finiteRealFreeEntropy L.1 t := by
    let partitionPositive : StrictlyPositiveReal :=
      ⟨Polynomial.aeval t.1 (partitionPolynomial L.1),
        partitionPolynomial_eval_real_pos L.1 t.2⟩
    have hlog : realLogarithm ⟨1, zero_lt_one⟩ ≤ realLogarithm partitionPositive := by
      rcases hpartition.eq_or_lt with heq | hlt
      · exact le_of_eq (congrArg realLogarithm (Subtype.ext heq))
      · exact (realLogarithm_strictMono ⟨1, zero_lt_one⟩ partitionPositive hlt).le
    calc
      0 = realLogarithm ⟨1, zero_lt_one⟩ := realLogarithm_one.symm
      _ ≤ realLogarithm partitionPositive := hlog
      _ = finiteRealFreeEntropy L.1 t := rfl
  have hcoefficient : 0 ≤ (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ)) := by
    positivity
  calc
    0 = (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ)) * 0 := (mul_zero _).symm
    _ ≤ (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ)) * finiteRealFreeEntropy L.1 t :=
      mul_le_mul_of_nonneg_left hentropy hcoefficient
    _ = freeEnergyDensity L t := rfl

end Ising2DLambda.ThermodynamicLimit
