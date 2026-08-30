/-
章「トーラス上の Kac--Ward 行列式」の
「置換項は固定辺の因子と軌道ごとの重みの積である」の具体版。
人手証明と同じ順で、固定辺と動く辺への分割、軌道族への分割、
動く辺の因子の -x 倍への書き換え、(-x) の括り出しを行う。
-/
import Ising2DLambda.KacWard.MovedOrbitPartition
import Ising2DLambda.KacWard.DeterminantTermNonzero
import Ising2DLambda.NecSuf.KacWard.TermOrbitWeightFactorization

namespace Ising2DLambda.KacWard

open Finset Polynomial
open Ising2DLambda.AlgebraicEigenvalue

variable {ι : Type} [Fintype ι] [DecidableEq ι]

private lemma iterLeft_eq_iterate (σ : Equiv.Perm ι) (n : ℕ) (e : ι) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft (⇑σ) n e = (⇑σ)^[n] e := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft,
      Function.iterate_succ_apply']
    rw [ih]

private lemma perm_iterLeft_return (σ : Equiv.Perm ι) (e : ι) :
    ∃ k, 1 ≤ k ∧ Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft (⇑σ) k e = e := by
  obtain ⟨k, hk, hreturn⟩ := permutation_power_return σ e
  exact ⟨k, hk, (iterLeft_eq_iterate σ k e).trans hreturn⟩

/-- 置換項の成分積は、固定辺の因子と軌道ごとの重みの積である。 -/
theorem kacWardEntryProduct_orbit_factorization
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ =
      (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) *
        ∏ O ∈ movedEdgeOrbitSet σ,
          ((-Polynomial.X : QbarPoly) ^ O.card *
            ∏ e ∈ O, Polynomial.C (M e (σ e))) := by
  classical
  -- 人手証明の第二〜第四の等号: 固定辺と軌道族への分割（必要十分版へ委ねる）。
  have hsplit := Ising2DLambda.NecSuf.KacWard.prod_fixed_orbit_factorization
    (⇑σ) σ.injective (perm_iterLeft_return σ)
    (fun e => kacWardPolynomialMatrix M e (σ e))
  have hfamily :
      Ising2DLambda.NecSuf.KacWard.movedOrbitSet (⇑σ) = movedEdgeOrbitSet σ := rfl
  rw [hfamily] at hsplit
  rw [kacWardDeterminantEntryProduct, hsplit]
  congr 1
  -- 人手証明の第五・第六の等号: 各軌道の中で因子を -x 倍へ書き換え、(-x) を括り出す。
  refine Finset.prod_congr rfl ?_
  intro O hO
  obtain ⟨-, -, hcover⟩ := movedEdgeOrbitSet_partition σ
  have hOsub : O ⊆ movedEdgeSet σ := by
    intro e he
    rw [← hcover]
    exact mem_biUnion.mpr ⟨O, hO, he⟩
  have hfactor : ∀ e ∈ O,
      kacWardPolynomialMatrix M e (σ e) =
        (-Polynomial.X : QbarPoly) * Polynomial.C (M e (σ e)) := by
    intro e he
    have hmoved : σ e ≠ e := mem_movedEdgeSet.mp (hOsub he)
    simp [kacWardPolynomialMatrix, Matrix.one_apply, Ne.symm hmoved, neg_mul]
  calc ∏ e ∈ O, kacWardPolynomialMatrix M e (σ e)
      = ∏ e ∈ O, ((-Polynomial.X : QbarPoly) * Polynomial.C (M e (σ e))) :=
        Finset.prod_congr rfl hfactor
    _ = (∏ _e ∈ O, (-Polynomial.X : QbarPoly)) * ∏ e ∈ O, Polynomial.C (M e (σ e)) :=
        Finset.prod_mul_distrib
    _ = (-Polynomial.X : QbarPoly) ^ O.card * ∏ e ∈ O, Polynomial.C (M e (σ e)) := by
        rw [Finset.prod_const]

/-- 導出版: 同じ分解を必要十分版から得たことの明示。 -/
theorem kacWardEntryProduct_orbit_factorization_from_necSuf
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ =
      (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) *
        ∏ O ∈ movedEdgeOrbitSet σ,
          ((-Polynomial.X : QbarPoly) ^ O.card *
            ∏ e ∈ O, Polynomial.C (M e (σ e))) :=
  kacWardEntryProduct_orbit_factorization M σ

end Ising2DLambda.KacWard
