import Ising2DLambda.AlgebraicEigenvalue.FiniteMapIterateAdd
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationIterateInjective
import Mathlib.Data.Fintype.Card

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 有限個の反復値の衝突を、加法則と単射性で始点への正の帰還へ変える。 -/
theorem finitePermutation_positive_return {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    ∃ n : ℕ, 0 < n ∧ finiteMapIterate σ n i = i := by
  classical
  let v : Fin (Fintype.card J + 1) → J := fun k => finiteMapIterate σ k.val i
  have hnot : ¬ Function.Injective v := by
    intro hinj
    have hcard := Fintype.card_le_of_injective v hinj
    simp only [Fintype.card_fin] at hcard
    omega
  obtain ⟨a, b, hab, hne⟩ := Function.not_injective_iff.mp hnot
  have hneval : a.val ≠ b.val := fun h => hne (Fin.ext h)
  have hordered : ∃ r s : ℕ, r < s ∧
      finiteMapIterate σ s i = finiteMapIterate σ r i := by
    rcases lt_or_gt_of_ne hneval with hlt | hgt
    · exact ⟨a.val, b.val, hlt, hab.symm⟩
    · exact ⟨b.val, a.val, hgt, hab⟩
  obtain ⟨r, s, hrs, hcollision⟩ := hordered
  let d : ℕ := s - r
  have hd : 0 < d := Nat.sub_pos_of_lt hrs
  have hsum : r + d = s := Nat.add_sub_of_le (Nat.le_of_lt hrs)
  have hcancel : finiteMapIterate σ r (finiteMapIterate σ d i) =
      finiteMapIterate σ r i := by
    calc
      finiteMapIterate σ r (finiteMapIterate σ d i) =
          finiteMapIterate σ (r + d) i := (finiteMapIterate_add σ r d i).symm
      _ = finiteMapIterate σ s i :=
        congrArg (fun k : ℕ => finiteMapIterate σ k i) hsum
      _ = finiteMapIterate σ r i := hcollision
  have hreturn : finiteMapIterate σ d i = i :=
    finitePermutationIterate_injective σ r hcancel
  exact ⟨d, hd, hreturn⟩

/-- 正の帰還時刻の集合の最小元。空集合上では始点を取れず、空の関数になる。 -/
noncomputable def finitePermutationMinimalPeriod {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) : ℕ :=
  open Classical in Nat.find (finitePermutation_positive_return σ i)

/-- 自然数の整列性から得られる正値性・帰還・最小性。 -/
theorem finitePermutationMinimalPeriod_spec {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    0 < finitePermutationMinimalPeriod σ i ∧
    finiteMapIterate σ (finitePermutationMinimalPeriod σ i) i = i ∧
    ∀ n : ℕ, 0 < n → finiteMapIterate σ n i = i →
      finitePermutationMinimalPeriod σ i ≤ n := by
  classical
  have hspec := Nat.find_spec (finitePermutation_positive_return σ i)
  exact ⟨hspec.1, hspec.2, fun _ hn heq =>
    Nat.find_min' (finitePermutation_positive_return σ i) ⟨hn, heq⟩⟩

end Ising2DLambda.AlgebraicEigenvalue
