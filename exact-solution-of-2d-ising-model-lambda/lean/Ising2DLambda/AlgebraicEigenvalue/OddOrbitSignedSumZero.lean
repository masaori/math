/-
奇数軌道を持つ不動点のない置換の符号付き和の独立具体版。
対合で閉じた有限集合から相異なる二項を除く強い帰納法を、本文と同じ順序で辿る。
値は Polynomial Qbar に固定し、一般の有限相殺定理は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversalNontrivial
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitSkewProductNeg

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

/-- 本文の二点除去、残余集合の閉性、対の相殺、総和の六等号。
対象集合が空の場合も空和を用いるため、添字集合の非空性は仮定しない。 -/
theorem oddOrbit_signed_sum_zero
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j) :
    (∑ σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J},
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) = 0 := by
  classical
  let D := {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}
  let F : D → D := selectedOddOrbitInvolution
  let w : D → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
      ∏ i : J, A i (σ.val i)
  have hF (σ : D) : F (F σ) = σ := selectedOddOrbitInvolution_twice σ
  have hfixed (σ : D) : F σ ≠ σ := selectedOddOrbitInvolution_no_fixed σ
  have hneg (σ : D) : w (F σ) = -w σ :=
    selectedOddOrbit_skew_signed_term_neg A hA σ.val σ.property
  -- 任意の F で閉じた有限部分集合について示し、最後に全体へ適用する。
  have hsum (S : Finset D) (hstable : ∀ σ ∈ S, F σ ∈ S) :
      ∑ σ ∈ S, w σ = 0 := by
    revert hstable
    refine Finset.strongInductionOn S ?_
    intro S ih hstable
    by_cases hS : S = ∅
    · subst S
      exact Finset.sum_empty
    obtain ⟨σ, hσ⟩ := Finset.nonempty_iff_ne_empty.mpr hS
    let τ : D := F σ
    have hτS : τ ∈ S := hstable σ hσ
    have hτσ : τ ≠ σ := hfixed σ
    let R : Finset D := (S.erase σ).erase τ
    have hRerase : R ⊆ S.erase σ := Finset.erase_subset τ (S.erase σ)
    have heraseS : S.erase σ ⊂ S := Finset.erase_ssubset hσ
    have hRsub : R ⊂ S := lt_of_le_of_lt hRerase heraseS
    have _hRcard : R.card < S.card := Finset.card_lt_card hRsub
    have hRstable : ∀ ρ ∈ R, F ρ ∈ R := by
      intro ρ hρ
      obtain ⟨hρτ, hρerase⟩ := Finset.mem_erase.mp hρ
      obtain ⟨hρσ, hρS⟩ := Finset.mem_erase.mp hρerase
      have hFρS : F ρ ∈ S := hstable ρ hρS
      have hFρσ : F ρ ≠ σ := by
        intro heq
        apply hρτ
        calc
          ρ = F (F ρ) := (hF ρ).symm
          _ = F σ := congrArg F heq
          _ = τ := rfl
      have hFρτ : F ρ ≠ τ := by
        intro heq
        apply hρσ
        calc
          ρ = F (F ρ) := (hF ρ).symm
          _ = F τ := congrArg F heq
          _ = F (F σ) := rfl
          _ = σ := hF σ
      exact Finset.mem_erase.mpr ⟨hFρτ,
        Finset.mem_erase.mpr ⟨hFρσ, hFρS⟩⟩
    have hRzero : ∑ ρ ∈ R, w ρ = 0 := ih R hRsub hRstable
    have hpair : w σ + w τ = 0 := by
      calc
        w σ + w τ = w σ + w (F σ) := rfl
        _ = w σ + (-w σ) := congrArg (w σ + ·) (hneg σ)
        _ = 0 := add_neg_cancel _
    have hτerase : τ ∈ S.erase σ := Finset.mem_erase.mpr ⟨hτσ, hτS⟩
    calc
      ∑ ρ ∈ S, w ρ = w σ + ∑ ρ ∈ S.erase σ, w ρ :=
        (Finset.add_sum_erase S w hσ).symm
      _ = w σ + (w τ + ∑ ρ ∈ R, w ρ) :=
        congrArg (w σ + ·) (Finset.add_sum_erase (S.erase σ) w hτerase).symm
      _ = (w σ + w τ) + ∑ ρ ∈ R, w ρ := (add_assoc _ _ _).symm
      _ = 0 + ∑ ρ ∈ R, w ρ := congrArg (· + ∑ ρ ∈ R, w ρ) hpair
      _ = 0 + 0 := congrArg (0 + ·) hRzero
      _ = 0 := zero_add _
  exact hsum univ (fun σ _ => mem_univ (F σ))

end Ising2DLambda.AlgebraicEigenvalue
