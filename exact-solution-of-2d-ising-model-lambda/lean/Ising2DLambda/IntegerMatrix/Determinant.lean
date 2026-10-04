/- 整数行列式と、転倒数の符号を使う行指定の置換展開。 -/
import Ising2DLambda.IntegerMatrix.Basic
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.IntegerMatrix

open scoped BigOperators
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

private theorem linearOrder_trichotomous {ι : Type*} [LinearOrder ι] :
    Trichotomous (fun x y : ι => x < y) := by
  intro a b
  rcases lt_trichotomy a b with hab | hab | hab
  · exact Or.inl ⟨hab, ne_of_lt hab, not_lt_of_ge (le_of_lt hab)⟩
  · exact Or.inr (Or.inl ⟨by simp [hab], hab, by simp [hab]⟩)
  · exact Or.inr (Or.inr ⟨not_lt_of_ge (le_of_lt hab), ne_of_gt hab, hab⟩)

/-- 転倒数で定めた人手証明の符号を、行列式ライブラリの符号へ結ぶ準同型。 -/
private noncomputable def inversionSignHom {ι : Type*} [Fintype ι] [LinearOrder ι] :
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
theorem inversionSign_eq_mathlibSign {ι : Type*} [Fintype ι] [LinearOrder ι]
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

/-- 有限添字の整数行列式。本文の行指定展開との一致は直後の補題で保証する。 -/
noncomputable def determinant {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Square ι) : ℤ := Matrix.det A

/-- mathlib の列指定展開を転置で行指定へ直し、転倒数の符号へ結ぶ。 -/
theorem determinant_eq_signedPermutationSum {ι : Type*} [Fintype ι] [LinearOrder ι]
    (A : Square ι) :
    determinant A = ∑ σ : Equiv.Perm ι,
      sign (fun i j : ι => i < j) σ * ∏ i, A i (σ i) := by
  classical
  calc
    determinant A = Matrix.det A := rfl
    _ = Matrix.det A.transpose := (Matrix.det_transpose A).symm
    _ = ∑ σ : Equiv.Perm ι, (Equiv.Perm.sign σ : ℤ) * ∏ i, A.transpose (σ i) i :=
      Matrix.det_apply' _
    _ = ∑ σ : Equiv.Perm ι, sign (fun i j : ι => i < j) σ * ∏ i, A i (σ i) := by
      simp only [inversionSign_eq_mathlibSign, Matrix.transpose_apply]

end Ising2DLambda.IntegerMatrix
