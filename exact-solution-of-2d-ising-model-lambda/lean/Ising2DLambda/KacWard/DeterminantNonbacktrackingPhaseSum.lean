/-
章「トーラス上の Kac--Ward 行列式」の
「行列式は非後退置換の位相表示の和である」
（`claim_kac_ward_determinant_nonbacktracking_phase_sum`）の具体版。

人手証明と同じく、行列式を置換項の有限和へ開き、許された後続辺条件を
満たさない置換項を零にし、残った各項へ軌道ごとの位相・ねじれ表示を代入する。
-/
import Ising2DLambda.KacWard.TermOrbitPhaseTwist
import Ising2DLambda.NecSuf.KacWard.DeterminantNonbacktrackingPhaseSum

namespace Ising2DLambda.KacWard

open Finset Polynomial Matrix
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

private theorem linearOrder_trichotomous {ι : Type} [LinearOrder ι] :
    Trichotomous (fun x y : ι => x < y) := by
  intro a b
  rcases lt_trichotomy a b with hab | hab | hab
  · exact Or.inl ⟨hab, ne_of_lt hab, not_lt_of_ge (le_of_lt hab)⟩
  · exact Or.inr (Or.inl ⟨by simp [hab], hab, by simp [hab]⟩)
  · exact Or.inr (Or.inr ⟨not_lt_of_ge (le_of_lt hab), ne_of_gt hab, hab⟩)

/-- 転倒数で定めた人手証明の符号を、行列式ライブラリの符号へ結ぶ準同型。 -/
private noncomputable def inversionSignHom {ι : Type} [Fintype ι] [LinearOrder ι] :
    Equiv.Perm ι →* ℤˣ where
  toFun σ := {
    val := sign (fun x y : ι => x < y) σ
    inv := sign (fun x y : ι => x < y) σ
    val_inv := sign_mul_self (fun x y : ι => x < y) σ
    inv_val := sign_mul_self (fun x y : ι => x < y) σ
  }
  map_one' := by
    apply Units.ext
    exact sign_one (fun x y : ι => x < y) linearOrder_trichotomous
  map_mul' := by
    intro σ τ
    apply Units.ext
    exact sign_comp (fun x y : ι => x < y) linearOrder_trichotomous σ τ

/-- 転倒数の偶奇で定めた符号は、行列式ライブラリの置換符号と一致する。 -/
theorem inversionSign_eq_mathlibSign {ι : Type} [Fintype ι] [LinearOrder ι]
    (σ : Equiv.Perm ι) :
    sign (fun x y : ι => x < y) σ = (Equiv.Perm.sign σ : ℤ) := by
  classical
  have hhom : inversionSignHom (ι := ι) = Equiv.Perm.sign := by
    by_cases h : Nontrivial ι
    · letI : Nontrivial ι := h
      apply Equiv.Perm.eq_sign_of_surjective_hom
      intro u
      rcases Int.units_eq_one_or u with hu | hu
      · refine ⟨1, ?_⟩
        apply Units.ext
        simpa [hu, inversionSignHom] using
          (sign_one (fun x y : ι => x < y) linearOrder_trichotomous)
      · obtain ⟨a, b, hab⟩ := exists_pair_ne ι
        refine ⟨transpositionPerm a b, ?_⟩
        apply Units.ext
        simp [inversionSignHom, sign_transposition, hab, hu]
    · haveI : Subsingleton ι := not_nontrivial_iff_subsingleton.mp h
      ext τ
      have hτ : τ = 1 := Subsingleton.elim _ _
      subst τ
      simpa [inversionSignHom] using
        (sign_one (fun x y : ι => x < y) linearOrder_trichotomous)
  have hvalue := DFunLike.congr_fun hhom σ
  exact congrArg Units.val hvalue

/-- `det(I-XM)` は人手証明で定めた符号付き置換項の有限和である。 -/
theorem kacWardDeterminant_eq_signedPermutationSum {ι : Type} [Fintype ι]
    [LinearOrder ι] (M : Matrix ι ι Qbar) :
    kacWardDeterminant M =
      ∑ σ : Equiv.Perm ι, kacWardSignedPermutationTerm M σ := by
  classical
  rw [kacWardDeterminant, ← Matrix.det_transpose]
  simp [Matrix.det_apply', kacWardSignedPermutationTerm,
    kacWardDeterminantEntryProduct, Matrix.transpose_apply,
    inversionSign_eq_mathlibSign]

/-- 固定点であるか、許された後続へ移る置換の有限集合。 -/
noncomputable def nonbacktrackingPermutations {ι : Type} [Fintype ι]
    (allowed : ι → ι → Prop) : Finset (Equiv.Perm ι) := by
  classical
  exact Finset.univ.filter fun σ => ∀ i, σ i ≠ i → allowed i (σ i)

/-- 行列式の置換展開から不許可の項を消し、各非後退項の位相表示を代入する。 -/
theorem kacWardDeterminant_nonbacktracking_phase_sum {ι : Type} [Fintype ι]
    [LinearOrder ι]
    (a b : Bool) (horizontal vertical : ι → Bool)
    (M : Matrix ι ι Qbar) (allowed : ι → ι → Prop)
    (turns : Finset ι → List Turn) (closing : Finset ι → Turn) {z : Qbar}
    (hdiag : ∀ e, M e e = 0)
    (hsupport : ∀ i j, M i j ≠ 0 ↔ allowed i j)
    (horbitPhase : ∀ σ ∈ nonbacktrackingPermutations allowed,
      ∀ O ∈ movedEdgeOrbitSet σ,
        (∏ e ∈ O, M e (σ e)) =
          (boolSign (Bool.xor (a && parity horizontal O.toList)
              (b && parity vertical O.toList)) : Qbar) *
            z ^ (((turns O).map turnValue).sum + turnValue (closing O))) :
    kacWardDeterminant M =
      ∑ σ ∈ nonbacktrackingPermutations allowed,
        ∏ O ∈ movedEdgeOrbitSet σ,
          (-(Polynomial.X ^ O.card) * Polynomial.C
            ((boolSign (Bool.xor (a && parity horizontal O.toList)
                (b && parity vertical O.toList)) : Qbar) *
              z ^ (((turns O).map turnValue).sum + turnValue (closing O)))) := by
  classical
  rw [kacWardDeterminant_eq_signedPermutationSum]
  apply restrictedSum_replace_necSuf
  · intro σ hσ
    have hbad : ∃ i, σ i ≠ i ∧ ¬allowed i (σ i) := by
      simpa [nonbacktrackingPermutations] using hσ
    obtain ⟨i, hi, hnotAllowed⟩ := hbad
    have hMzero : M i (σ i) = 0 := by
      exact not_ne_iff.mp (fun hne => hnotAllowed ((hsupport i (σ i)).mp hne))
    have hentryZero : kacWardDeterminantEntryProduct M σ = 0 := by
      apply not_ne_iff.mp
      intro hne
      have hMnonzero := (kacWardDeterminantEntryProduct_ne_zero_iff M σ).mp hne i hi
      exact hMnonzero hMzero
    simp [kacWardSignedPermutationTerm, hentryZero]
  · intro σ hσ
    exact kacWardSignedPermutationTerm_orbit_phase_twist
      a b horizontal vertical M σ turns closing hdiag (horbitPhase σ hσ)

end Ising2DLambda.KacWard
