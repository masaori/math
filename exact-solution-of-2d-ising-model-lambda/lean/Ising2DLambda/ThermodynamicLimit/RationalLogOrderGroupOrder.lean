/-
人手証明「有理係数の対数順序群の順序」（`def_rational_log_order_group_order`）の具体版。

`λ ≤_{Λ_ℚ} μ` :⟺ `λ` と `μ` の両方の共通分母 `N ≥ 1` で `λ_N ≤_Λ μ_N` となるものが在る。
本文と同じく、この「ある N」の形が「すべての N」の形と一致すること
（→ は `claim_common_denominator_order_independent`、← は `claim_common_common_denominator_exists`）、
および `N_λ N_μ` の証人 `N_μ·λ_{N_λ}`, `N_λ·μ_{N_μ}` の `Λ` での比較一度で決まること（決定可能性）を示す。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.CommonDenominatorMultiple

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_rational_log_order_group_order`。両方の共通分母 `N ≥ 1` で証人が `≤_Λ` を満たすものが在る。 -/
def rationalLogOrderLE (l m : RationalLogOrderGroup) : Prop :=
  ∃ (N : ℕ) (lN mN : LogOrderGroup),
    1 ≤ N ∧ IsCommonDenominator N l lN ∧ IsCommonDenominator N m mN ∧ logOrderLE lN mN

/-- 「ある共通分母で成り立つ」は「すべての共通分母で成り立つ」と言い換えられる。 -/
theorem rationalLogOrderLE_iff_forall (l m : RationalLogOrderGroup) :
    rationalLogOrderLE l m ↔
      ∀ (N : ℕ) (lN mN : LogOrderGroup),
        1 ≤ N → IsCommonDenominator N l lN → IsCommonDenominator N m mN → logOrderLE lN mN := by
  constructor
  · -- → : 独立性（claim_common_denominator_order_independent）
    rintro ⟨N, lN, mN, hN, hl, hm, hle⟩ N' lN' mN' hN' hl' hm'
    exact (commonDenominator_order_independent N N' hN hN' l m lN mN lN' mN' hl hm hl' hm').mp hle
  · -- ← : 共通の共通分母 N_λ N_μ の存在（claim_common_common_denominator_exists）
    intro h
    obtain ⟨hl, hm⟩ := commonCommonDenominator_exists l m
    refine ⟨denominatorProduct l * denominatorProduct m, _, _, ?_, hl, hm, ?_⟩
    · exact Nat.one_le_iff_ne_zero.mpr
        (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos l))
          (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos m)))
    · exact h _ _ _
        (Nat.one_le_iff_ne_zero.mpr
          (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos l))
            (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos m))))
        hl hm

/-- 決定手続き: `N_λ N_μ` の証人 `N_μ·λ_{N_λ}` と `N_λ·μ_{N_μ}` の `Λ` での比較一度で決まる。 -/
theorem rationalLogOrderLE_iff_canonical (l m : RationalLogOrderGroup) :
    rationalLogOrderLE l m ↔
      logOrderLE (((denominatorProduct m : ℤ)) • commonDenominatorWitness l)
        (((denominatorProduct l : ℤ)) • commonDenominatorWitness m) := by
  obtain ⟨hl, hm⟩ := commonCommonDenominator_exists l m
  have hpos : 1 ≤ denominatorProduct l * denominatorProduct m :=
    Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos l))
        (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos m)))
  constructor
  · intro h
    exact (rationalLogOrderLE_iff_forall l m).mp h _ _ _ hpos hl hm
  · intro h
    exact ⟨_, _, _, hpos, hl, hm, h⟩

/-- 判定は `Λ` の順序の判定（二つの有理数の比較）一度に帰着するので決定可能。 -/
noncomputable instance : DecidableRel rationalLogOrderLE := fun l m =>
  decidable_of_iff _ (rationalLogOrderLE_iff_canonical l m).symm

end Ising2DLambda.ThermodynamicLimit
