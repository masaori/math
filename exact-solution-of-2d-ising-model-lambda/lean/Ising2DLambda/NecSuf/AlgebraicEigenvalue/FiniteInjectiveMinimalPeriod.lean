import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationAdd
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationInjective
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 本文と同じ衝突・三等号・単射性。逆写像・全射性・点の順序は使わない。
有限性を除いた自然数の後者写像や、単射性を除いた二点の定値写像では正の帰還がない点を持つ。 -/
theorem finiteInjective_positive_return {J : Type*} [Fintype J]
    (f : J → J) (hf : Function.Injective f) (i : J) :
    ∃ n : ℕ, 0 < n ∧ f^[n] i = i := by
  classical
  let v : Fin (Fintype.card J + 1) → J := fun k => f^[k.val] i
  have hnot : ¬ Function.Injective v := by
    intro hinj
    have hcard := Fintype.card_le_of_injective v hinj
    simp only [Fintype.card_fin] at hcard
    omega
  obtain ⟨a, b, hab, hne⟩ := Function.not_injective_iff.mp hnot
  have hneval : a.val ≠ b.val := fun h => hne (Fin.ext h)
  have hordered : ∃ r s : ℕ, r < s ∧ f^[s] i = f^[r] i := by
    rcases lt_or_gt_of_ne hneval with hlt | hgt
    · exact ⟨a.val, b.val, hlt, hab.symm⟩
    · exact ⟨b.val, a.val, hgt, hab⟩
  obtain ⟨r, s, hrs, hcollision⟩ := hordered
  let d : ℕ := s - r
  have hd : 0 < d := Nat.sub_pos_of_lt hrs
  have hsum : r + d = s := Nat.add_sub_of_le (Nat.le_of_lt hrs)
  have hcancel : f^[r] (f^[d] i) = f^[r] i := by
    calc
      f^[r] (f^[d] i) = f^[r + d] i := (iterate_add_necSuf f r d i).symm
      _ = f^[s] i := congrArg (fun k : ℕ => f^[k] i) hsum
      _ = f^[r] i := hcollision
  have hreturn : f^[d] i = i := iterate_injective_necSuf f hf r hcancel
  exact ⟨d, hd, hreturn⟩

/-- 正の帰還時刻の最小元。 -/
noncomputable def finiteInjectiveMinimalPeriod {J : Type*} [Fintype J]
    (f : J → J) (hf : Function.Injective f) (i : J) : ℕ :=
  open Classical in Nat.find (finiteInjective_positive_return f hf i)

/-- 本文と同じく、自然数の整列性で正値性・帰還・最小性を得る。 -/
theorem finiteInjectiveMinimalPeriod_spec {J : Type*} [Fintype J]
    (f : J → J) (hf : Function.Injective f) (i : J) :
    0 < finiteInjectiveMinimalPeriod f hf i ∧
    f^[finiteInjectiveMinimalPeriod f hf i] i = i ∧
    ∀ n : ℕ, 0 < n → f^[n] i = i → finiteInjectiveMinimalPeriod f hf i ≤ n := by
  classical
  have hspec := Nat.find_spec (finiteInjective_positive_return f hf i)
  exact ⟨hspec.1, hspec.2, fun _ hn heq =>
    Nat.find_min' (finiteInjective_positive_return f hf i) ⟨hn, heq⟩⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
