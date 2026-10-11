/-
奇数軌道を持つ置換の符号付き和の相殺から、有限集合と不動点のない対合を残す。
二点除去による帰納法は具体版と同じであり、和の零性を仮定に受け取らない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 可換加法モノイドは有限和・一項の取り出し・結合則に使う。
負号と右加法逆元則は、符号が逆になる二項の和を消す箇所にだけ使う。
乗法・体・順序・置換・軌道・行列は要求しない。
対合性は二点を除いた集合の閉性、不動点の不在は二点目の取り出しに必要である。 -/
theorem involution_neg_sum_zero
    {D M : Type*} [Fintype D] [AddCommMonoid M] [Neg M]
    (hAddNeg : ∀ x : M, x + -x = 0)
    (F : D → D) (hF : Function.Involutive F) (hfixed : ∀ σ, F σ ≠ σ)
    (w : D → M) (hneg : ∀ σ, w (F σ) = -w σ) :
    ∑ σ : D, w σ = 0 := by
  classical
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
        _ = 0 := hAddNeg (w σ)
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

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
