/- 整数行列式と、転倒数の符号を使う行指定の置換展開。

符号・転倒数は本文の定義 `def_permutation_sign` をそのまま書いた定義（`sign`・`inversionCount`）を使う。
符号の性質は具体版の補題だけを引く: 二乗が 1（`finiteOrderedSign_mul_self`）、乗法性
（`finiteOrderedSign_comp`）、互換の符号（`KacWard.finiteTransposition_sign`）。必要十分版の定理は引かない。
mathlib の `Matrix.det` と `Equiv.Perm.sign` は、本文の行列式の定義との対応（定義どうしの橋渡し）にだけ使う。 -/
import Ising2DLambda.IntegerMatrix.Basic
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSet
import Ising2DLambda.KacWard.TranspositionSignFiniteOrderedSet
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.IntegerMatrix

open scoped BigOperators
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign inversionCount orderedPairs)

/-- 恒等置換は転倒を持たないので、符号は `(-1)^0 = 1`。 -/
private theorem inversionSign_one {ι : Type*} [Fintype ι] [LinearOrder ι] :
    sign (fun x y : ι => x < y) (1 : Equiv.Perm ι) = 1 := by
  have hcount : inversionCount (fun x y : ι => x < y) (1 : Equiv.Perm ι) = 0 := by
    unfold inversionCount
    rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    intro p hp hrev
    have hlt : p.1 < p.2 := AlgebraicEigenvalue.finiteOrdered_mem_orderedPairs.mp hp
    exact lt_asymm hlt (by simpa using hrev)
  rw [sign, hcount, pow_zero]

/-- 転倒数で定めた人手証明の符号を、行列式ライブラリの符号へ結ぶ準同型。 -/
private noncomputable def inversionSignHom {ι : Type*} [Fintype ι] [LinearOrder ι] :
    Equiv.Perm ι →* ℤˣ where
  toFun σ := {
    val := sign (fun x y : ι => x < y) σ
    inv := sign (fun x y : ι => x < y) σ
    val_inv := AlgebraicEigenvalue.finiteOrderedSign_mul_self σ
    inv_val := AlgebraicEigenvalue.finiteOrderedSign_mul_self σ
  }
  map_one' := by
    apply Units.ext
    exact inversionSign_one
  map_mul' := by
    intro σ τ
    apply Units.ext
    exact AlgebraicEigenvalue.finiteOrderedSign_comp σ τ

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
        simpa [hu, inversionSignHom] using (inversionSign_one (ι := ι))
      · obtain ⟨a, b, hab⟩ := exists_pair_ne ι
        refine ⟨KacWard.finiteTranspositionPerm a b, ?_⟩
        apply Units.ext
        simp [inversionSignHom, KacWard.finiteTransposition_sign hab, hu]
    · haveI : Subsingleton ι := not_nontrivial_iff_subsingleton.mp h
      ext τ
      have hτ : τ = 1 := Subsingleton.elim _ _
      subst τ
      simpa [inversionSignHom] using (inversionSign_one (ι := ι))
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
