/-
章「Kac--Ward 行列式の置換展開」の
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

/-- 置換項の成分積は、固定辺の因子と軌道ごとの重みの積である。 -/
theorem kacWardEntryProduct_orbit_factorization
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ =
      (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) *
        ∏ O ∈ movedEdgeOrbitSet σ,
          ((-Polynomial.X : QbarPoly) ^ O.card *
            ∏ e ∈ O, Polynomial.C (M e (σ e))) := by
  classical
  -- 固定辺と動く辺に分け、動く辺を互いに素な軌道へ分ける。
  obtain ⟨_, hdisjoint, hcover⟩ := movedEdgeOrbitSet_partition σ
  have hsplit :
      (∏ e : ι, kacWardPolynomialMatrix M e (σ e)) =
        (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) *
          ∏ O ∈ movedEdgeOrbitSet σ,
            ∏ e ∈ O, kacWardPolynomialMatrix M e (σ e) := by
    rw [← Finset.prod_filter_mul_prod_filter_not univ (fun e => σ e = e)
      (fun e => kacWardPolynomialMatrix M e (σ e))]
    congr 1
    rw [← Finset.prod_biUnion]
    · change (∏ e ∈ movedEdgeSet σ, kacWardPolynomialMatrix M e (σ e)) =
        ∏ e ∈ (movedEdgeOrbitSet σ).biUnion id, kacWardPolynomialMatrix M e (σ e)
      rw [hcover]
    · intro O₁ hO₁ O₂ hO₂ hne
      exact hdisjoint O₁ hO₁ O₂ hO₂ hne
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
    simp [kacWardPolynomialMatrix, Ne.symm hmoved, neg_mul]
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
