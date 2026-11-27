/- 整数行列式と、転倒数の符号を使う行指定の置換展開。

符号・転倒数は本文の定義 `def_permutation_sign` をそのまま書いた具体版の定義を使う。
mathlib の `Matrix.det` と `Equiv.Perm.sign` は、本文の行列式の定義との対応（定義どうしの橋渡し）にだけ使う。
橋渡しは mathlib の符号の定義と転倒の対の対応だけで示し、本文の符号の性質の主張は引かない。 -/
import Ising2DLambda.IntegerMatrix.Basic
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSet
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.Fintype.Sort
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

namespace Ising2DLambda.IntegerMatrix

open scoped BigOperators
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign
open Finset

/-- `Fin n` の上では、mathlib の転倒の積 `signAux` が置換符号に一致する。 -/
private theorem signAux_eq_sign {n : ℕ} (g : Equiv.Perm (Fin n)) :
    Equiv.Perm.signAux g = Equiv.Perm.sign g := by
  by_cases h : Nontrivial (Fin n)
  · have hs : Function.Surjective
        (MonoidHom.mk' (Equiv.Perm.signAux (n := n)) Equiv.Perm.signAux_mul) := by
      intro u
      rcases Int.units_eq_one_or u with hu | hu
      · exact ⟨1, by simp [hu]⟩
      · obtain ⟨x, y, hxy⟩ := exists_pair_ne (Fin n)
        exact ⟨Equiv.swap x y, by simp [Equiv.Perm.signAux_swap hxy, hu]⟩
    exact DFunLike.congr_fun (Equiv.Perm.eq_sign_of_surjective_hom hs) g
  · haveI : Subsingleton (Fin n) := not_nontrivial_iff_subsingleton.mp h
    have hg : g = 1 := Subsingleton.elim _ _
    subst hg
    simp

/-- 転倒数の偶奇で定めた符号は、行列式ライブラリの置換符号と一致する（定義どうしの橋渡し）。
`ι` を順序同型で `Fin n` へ移し、mathlib の符号の定義（`Fin n` 上の転倒の積 `signAux`）と
転倒の対を一対一に対応させる。本文の符号の性質の主張は引かない。 -/
theorem inversionSignIndependent_eq_mathlibSign {ι : Type*} [Fintype ι] [LinearOrder ι]
    (σ : Equiv.Perm ι) :
    finiteOrderedSign σ = (Equiv.Perm.sign σ : ℤ) := by
  classical
  let e : ι ≃o Fin (Fintype.card ι) := (monoEquivOfFin ι rfl).symm
  let g : Equiv.Perm (Fin (Fintype.card ι)) := (e.toEquiv.symm.trans σ).trans e.toEquiv
  have hg (i : ι) : g (e i) = e (σ i) := by
    simp [g]
  have hcard : finiteOrderedInversionCount σ =
      ((Equiv.Perm.finPairsLT (Fintype.card ι)).filter fun x => g x.1 ≤ g x.2).card := by
    unfold finiteOrderedInversionCount
    refine card_nbij' (fun p => (⟨e p.2, e p.1⟩ : Σ _ : Fin (Fintype.card ι), Fin (Fintype.card ι)))
      (fun x => (e.symm x.2, e.symm x.1)) ?_ ?_ ?_ ?_
    · intro p hp
      simp only [finiteOrderedPairs, coe_filter, mem_filter, mem_univ, true_and, Set.mem_setOf_eq] at hp ⊢
      refine ⟨Equiv.Perm.mem_finPairsLT.mpr (e.lt_iff_lt.mpr hp.1), ?_⟩
      rw [hg, hg]
      exact e.le_iff_le.mpr hp.2.le
    · intro x hx
      simp only [finiteOrderedPairs, coe_filter, mem_filter, mem_univ, true_and, Set.mem_setOf_eq] at hx ⊢
      have hlt : x.2 < x.1 := Equiv.Perm.mem_finPairsLT.mp hx.1
      refine ⟨e.symm.lt_iff_lt.mpr hlt, ?_⟩
      have hle : e (σ (e.symm x.1)) ≤ e (σ (e.symm x.2)) := by
        rw [← hg, ← hg, OrderIso.apply_symm_apply, OrderIso.apply_symm_apply]
        exact hx.2
      have hne : σ (e.symm x.1) ≠ σ (e.symm x.2) := fun h =>
        (ne_of_lt hlt).symm (e.symm.injective (σ.injective h))
      exact lt_of_le_of_ne (e.le_iff_le.mp hle) hne
    · intro p _
      simp
    · intro x _
      simp
  calc
    finiteOrderedSign σ = (-1) ^ finiteOrderedInversionCount σ := rfl
    _ = (-1) ^ ((Equiv.Perm.finPairsLT (Fintype.card ι)).filter
          fun x => g x.1 ≤ g x.2).card := by rw [hcard]
    _ = ((Equiv.Perm.signAux g : ℤˣ) : ℤ) := by
      unfold Equiv.Perm.signAux
      rw [Units.coe_prod]
      simp only [apply_ite Units.val, Units.val_neg, Units.val_one]
      rw [prod_ite, prod_const, prod_const_one, mul_one]
    _ = ((Equiv.Perm.sign g : ℤˣ) : ℤ) := by rw [signAux_eq_sign]
    _ = (Equiv.Perm.sign σ : ℤ) := by rw [Equiv.Perm.sign_symm_trans_trans]

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
