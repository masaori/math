/- 整数行列式と、転倒数の符号を使う行指定の置換展開。

符号・転倒数は本文の定義 `def_permutation_sign` をそのまま書いた具体版の定義を使う。
符号の性質は具体版の補題だけを引く: 二乗が 1（`finiteOrderedSign_mul_self`）、乗法性
（`finiteOrderedSign_comp`）、互換の符号（`KacWard.finiteTransposition_sign`）。必要十分版の定理は引かない。
mathlib の `Matrix.det` と `Equiv.Perm.sign` は、本文の行列式の定義との対応（定義どうしの橋渡し）にだけ使う。 -/
import Ising2DLambda.IntegerMatrix.Basic
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSet
import Ising2DLambda.KacWard.TranspositionSignFiniteOrderedSet
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.IntegerMatrix

open scoped BigOperators
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign

/-- 恒等置換は転倒を持たないので、符号は `(-1)^0 = 1`。 -/
private theorem inversionSign_one {ι : Type*} [Fintype ι] [LinearOrder ι] :
    finiteOrderedSign (1 : Equiv.Perm ι) = 1 := by
  have hcount : finiteOrderedInversionCount (1 : Equiv.Perm ι) = 0 := by
    unfold finiteOrderedInversionCount
    rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    intro p hp hrev
    have hlt : p.1 < p.2 := finiteOrdered_mem_orderedPairs.mp hp
    exact lt_asymm hlt (by simpa using hrev)
  rw [finiteOrderedSign, hcount, pow_zero]

/-- 転倒数で定めた人手証明の符号を、行列式ライブラリの符号へ結ぶ準同型。 -/
private noncomputable def inversionSignHom {ι : Type*} [Fintype ι] [LinearOrder ι] :
    Equiv.Perm ι →* ℤˣ where
  toFun σ := {
    val := finiteOrderedSign σ
    inv := finiteOrderedSign σ
    val_inv := finiteOrderedSign_mul_self σ
    inv_val := finiteOrderedSign_mul_self σ
  }
  map_one' := by
    apply Units.ext
    exact inversionSign_one
  map_mul' := by
    intro σ τ
    apply Units.ext
    exact finiteOrderedSign_comp σ τ

/-- 転倒数の偶奇で定めた符号は、行列式ライブラリの置換符号と一致する。 -/
theorem inversionSignIndependent_eq_mathlibSign {ι : Type*} [Fintype ι] [LinearOrder ι]
    (σ : Equiv.Perm ι) :
    finiteOrderedSign σ = (Equiv.Perm.sign σ : ℤ) := by
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
        simpa [inversionSignHom, hu] using KacWard.finiteTransposition_sign hab
    · haveI : Subsingleton ι := not_nontrivial_iff_subsingleton.mp h
      ext τ
      have hτ : τ = 1 := Subsingleton.elim _ _
      subst τ
      simpa [inversionSignHom] using (inversionSign_one (ι := ι))
  have hvalue := DFunLike.congr_fun hhom σ
  exact congrArg Units.val hvalue

/-- 本文の定義どおり、転倒数の符号による行指定の有限和。 -/
noncomputable def determinant {ι : Type*} [Fintype ι] [LinearOrder ι]
    (A : Square ι) : ℤ :=
  ∑ σ : Equiv.Perm ι, finiteOrderedSign σ * ∏ i, A i (σ i)

/-- 本文の定義の展開。 -/
theorem determinant_eq_independentSignedPermutationSum {ι : Type*} [Fintype ι] [LinearOrder ι]
    (A : Square ι) :
    determinant A = ∑ σ : Equiv.Perm ι,
      finiteOrderedSign σ * ∏ i, A i (σ i) := rfl

/-- mathlib の列指定展開を転置で行指定へ直し、転倒数の符号へ結ぶ。 -/
theorem determinant_eq_mathlib {ι : Type*} [Fintype ι] [LinearOrder ι]
    (A : Square ι) : determinant A = Matrix.det A := by
  classical
  calc
    determinant A = ∑ σ : Equiv.Perm ι,
        finiteOrderedSign σ * ∏ i, A i (σ i) := rfl
    _ = ∑ σ : Equiv.Perm ι, (Equiv.Perm.sign σ : ℤ) * ∏ i, A i (σ i) := by
      simp only [inversionSignIndependent_eq_mathlibSign]
    _ = ∑ σ : Equiv.Perm ι, (Equiv.Perm.sign σ : ℤ) * ∏ i, A.transpose (σ i) i := by
      simp only [Matrix.transpose_apply]
    _ = Matrix.det A.transpose := (Matrix.det_apply' _).symm
    _ = Matrix.det A := Matrix.det_transpose A

end Ising2DLambda.IntegerMatrix
