/-
人手証明「有理係数の対数順序群の順序は線形順序である」（`claim_rational_log_order_group_linear_order`）の具体版。

四つとも、`λ, μ, ν` の三つに共通の共通分母 `N := N_λ N_μ N_ν`（`claim_common_denominator_multiple` を
二度）を取り、順序の定義を「すべての両方の共通分母で」の形（`rationalLogOrderLE_iff_forall`）で読んで
`Λ` の順序の同じ名前の性質（`claim_log_order_group_linear_order`）へ落とす。反対称律だけは、
`λ_N = μ_N` から `N·λ = ι(λ_N) = ι(μ_N) = N·μ` を経て `N⁻¹` 倍で `λ = μ` へ戻す一段を要する。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: 三元 `λ, μ, ν` には共通の共通分母 `N_λ N_μ N_ν` がある
（`claim_common_denominator_multiple` を各元について一度ずつ）。 -/
theorem commonDenominator_three_exists (l m n : RationalLogOrderGroup) :
    ∃ (N : ℕ) (lN mN nN : LogOrderGroup),
      1 ≤ N ∧ IsCommonDenominator N l lN ∧ IsCommonDenominator N m mN ∧
        IsCommonDenominator N n nN := by
  refine ⟨denominatorProduct l * denominatorProduct m * denominatorProduct n,
    ((denominatorProduct m * denominatorProduct n : ℕ) : ℤ) • commonDenominatorWitness l,
    ((denominatorProduct l * denominatorProduct n : ℕ) : ℤ) • commonDenominatorWitness m,
    ((denominatorProduct l * denominatorProduct m : ℕ) : ℤ) • commonDenominatorWitness n,
    ?_, ?_, ?_, ?_⟩
  · -- N ≥ 1: 1 以上の三数の積
    exact Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero
        (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos l))
          (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos m)))
        (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos n)))
  · -- λ: (N_μ N_ν)·N_λ、ℕ の積の可換性と結合則で N_λ N_μ N_ν
    have h := commonDenominator_mul (denominatorProduct m * denominatorProduct n)
      (denominatorProduct l) l (commonDenominatorWitness l) (commonDenominator_exists l)
    rw [Nat.mul_comm, ← Nat.mul_assoc] at h
    exact h
  · -- μ: (N_λ N_ν)·N_μ
    have h := commonDenominator_mul (denominatorProduct l * denominatorProduct n)
      (denominatorProduct m) m (commonDenominatorWitness m) (commonDenominator_exists m)
    rw [Nat.mul_assoc, Nat.mul_comm (denominatorProduct n), ← Nat.mul_assoc] at h
    exact h
  · -- ν: (N_λ N_μ)·N_ν
    exact commonDenominator_mul (denominatorProduct l * denominatorProduct m)
      (denominatorProduct n) n (commonDenominatorWitness n) (commonDenominator_exists n)

/-- 準備（反対称律で使う）: 同じ `N ≥ 1` の証人が一致すれば元も一致する。
`N·λ = ι(λ_N) = ι(μ_N) = N·μ` を `N⁻¹` 倍で戻す。 -/
theorem eq_of_commonDenominator_witness_eq (N : ℕ) (hN : 1 ≤ N) (l m : RationalLogOrderGroup)
    (w : LogOrderGroup) (hl : IsCommonDenominator N l w) (hm : IsCommonDenominator N m w) :
    l = m := by
  unfold IsCommonDenominator at hl hm
  have hNq : (N : ℚ) ≠ 0 := by exact_mod_cast (Nat.one_le_iff_ne_zero.mp hN)
  calc
    l = ((N : ℚ)⁻¹ * (N : ℚ)) • l := by rw [inv_mul_cancel₀ hNq, one_smul]
    _ = (N : ℚ)⁻¹ • ((N : ℚ) • l) := (smul_smul _ _ _).symm      -- 有理数倍の結合則
    _ = (N : ℚ)⁻¹ • toRational w := by rw [hl]                     -- N は λ の共通分母、証人 w
    _ = (N : ℚ)⁻¹ • ((N : ℚ) • m) := by rw [hm]                    -- N は μ の共通分母、証人 w
    _ = ((N : ℚ)⁻¹ * (N : ℚ)) • m := smul_smul _ _ _              -- 有理数倍の結合則
    _ = m := by rw [inv_mul_cancel₀ hNq, one_smul]

/-- 反射律。 -/
theorem rationalLogOrderLE_refl (l : RationalLogOrderGroup) : rationalLogOrderLE l l :=
  ⟨denominatorProduct l, _, _, denominatorProduct_pos l, commonDenominator_exists l,
    commonDenominator_exists l, logOrderLE_refl _⟩

/-- 推移律。三元の共通の共通分母 `N` で ∀ 形に読み、`Λ` の推移律へ落とす。 -/
theorem rationalLogOrderLE_trans {l m n : RationalLogOrderGroup}
    (h1 : rationalLogOrderLE l m) (h2 : rationalLogOrderLE m n) : rationalLogOrderLE l n := by
  obtain ⟨N, lN, mN, nN, hN, hl, hm, hn⟩ := commonDenominator_three_exists l m n
  have e1 : logOrderLE lN mN := (rationalLogOrderLE_iff_forall l m).mp h1 N lN mN hN hl hm
  have e2 : logOrderLE mN nN := (rationalLogOrderLE_iff_forall m n).mp h2 N mN nN hN hm hn
  exact ⟨N, lN, nN, hN, hl, hn, logOrderLE_trans e1 e2⟩

/-- 反対称律。`Λ` の反対称律で `λ_N = μ_N` を得てから、`N⁻¹` 倍で `Λ_ℚ` の等号へ戻す。 -/
theorem rationalLogOrderLE_antisymm {l m : RationalLogOrderGroup}
    (h1 : rationalLogOrderLE l m) (h2 : rationalLogOrderLE m l) : l = m := by
  obtain ⟨N, lN, mN, _, hN, hl, hm, _⟩ := commonDenominator_three_exists l m m
  have e1 : logOrderLE lN mN := (rationalLogOrderLE_iff_forall l m).mp h1 N lN mN hN hl hm
  have e2 : logOrderLE mN lN := (rationalLogOrderLE_iff_forall m l).mp h2 N mN lN hN hm hl
  have hw : lN = mN := logOrderLE_antisymm e1 e2
  rw [hw] at hl
  exact eq_of_commonDenominator_witness_eq N hN l m mN hl hm

/-- 全順序性。 -/
theorem rationalLogOrderLE_total (l m : RationalLogOrderGroup) :
    rationalLogOrderLE l m ∨ rationalLogOrderLE m l := by
  obtain ⟨N, lN, mN, _, hN, hl, hm, _⟩ := commonDenominator_three_exists l m m
  rcases logOrderLE_total lN mN with h | h
  · exact Or.inl ⟨N, lN, mN, hN, hl, hm, h⟩
  · exact Or.inr ⟨N, mN, lN, hN, hm, hl, h⟩

end Ising2DLambda.ThermodynamicLimit
