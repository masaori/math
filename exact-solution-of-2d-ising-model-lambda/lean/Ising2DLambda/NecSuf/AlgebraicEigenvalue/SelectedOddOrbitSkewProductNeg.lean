/-
奇数個の不変部分集合上の反転による積の符号反転。
再添字付けと積の分割には可換モノイド、負号の積には HasDistribNeg だけを使う。
反対称性は部分集合内の隣接成分だけに要求し、順序・加法・零対角性・不動点不在を要求しない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversal
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Ring.Parity

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J M : Type*} [DecidableEq J] [CommMonoid M] [HasDistribNeg M]

/-- 本文の内部の積の七等号。順置換と逆置換を両逆として再添字付けする。 -/
theorem invariant_subset_reversal_skew_inside_product_neg
    (C : Finset J) (σ : Equiv.Perm J) (hC : ∀ i, σ i ∈ C ↔ i ∈ C)
    (hOdd : Odd C.card) (A : J → J → M)
    (hSkew : ∀ j ∈ C, A (σ j) j = -A j (σ j)) :
    (∏ i ∈ C, A i (invariantPredicateReversal (fun i => i ∈ C) σ hC i)) =
      -(∏ i ∈ C, A i (σ i)) := by
  have hInv (i : J) : σ.symm i ∈ C ↔ i ∈ C := by
    calc
      σ.symm i ∈ C ↔ σ (σ.symm i) ∈ C := (hC (σ.symm i)).symm
      _ ↔ i ∈ C := by rw [σ.apply_symm_apply i]
  have hLeft (i : J) : σ.symm (σ i) = i := σ.symm_apply_apply i
  have hRight (i : J) : σ (σ.symm i) = i := σ.apply_symm_apply i
  calc
    (∏ i ∈ C, A i (invariantPredicateReversal (fun i => i ∈ C) σ hC i)) =
        ∏ i ∈ C, A i (σ.symm i) := by
      refine Finset.prod_congr rfl ?_
      intro i hi
      exact congrArg (A i) (if_pos hi)
    _ = ∏ j ∈ C, A (σ j) (σ.symm (σ j)) := by
      refine Finset.prod_bij' (fun i _ => σ.symm i) (fun j _ => σ j)
        (fun i hi => (hInv i).mpr hi) (fun j hj => (hC j).mpr hj)
        (fun i _ => hRight i) (fun j _ => hLeft j) ?_
      intro i _
      rw [σ.apply_symm_apply i]
    _ = ∏ j ∈ C, A (σ j) j := by
      refine Finset.prod_congr rfl ?_
      intro j _
      exact congrArg (A (σ j)) (σ.symm_apply_apply j)
    _ = ∏ j ∈ C, -A j (σ j) := by
      exact Finset.prod_congr rfl hSkew
    _ = (-1 : M) ^ C.card * (∏ j ∈ C, A j (σ j)) := Finset.prod_neg _
    _ = (-1 : M) * (∏ j ∈ C, A j (σ j)) := by rw [hOdd.neg_one_pow]
    _ = -(∏ j ∈ C, A j (σ j)) := neg_one_mul _

variable [Fintype J]

omit [HasDistribNeg M] in
/-- 本文の外側の積の一等号。反転の外側の枝だけを使う。 -/
theorem invariant_subset_reversal_outside_product
    (C : Finset J) (σ : Equiv.Perm J) (hC : ∀ i, σ i ∈ C ↔ i ∈ C)
    (A : J → J → M) :
    (∏ i ∈ Cᶜ, A i (invariantPredicateReversal (fun i => i ∈ C) σ hC i)) =
      ∏ i ∈ Cᶜ, A i (σ i) := by
  refine Finset.prod_congr rfl ?_
  intro i hi
  exact congrArg (A i) (if_neg (Finset.mem_compl.mp hi))

/-- 本文の全体の積の五等号。内部反転と外側不変を別の行で代入する。 -/
theorem invariant_subset_reversal_skew_product_neg
    (C : Finset J) (σ : Equiv.Perm J) (hC : ∀ i, σ i ∈ C ↔ i ∈ C)
    (hOdd : Odd C.card) (A : J → J → M)
    (hSkew : ∀ j ∈ C, A (σ j) j = -A j (σ j)) :
    (∏ i : J, A i (invariantPredicateReversal (fun i => i ∈ C) σ hC i)) =
      -(∏ i : J, A i (σ i)) := by
  let τ := invariantPredicateReversal (fun i => i ∈ C) σ hC
  calc
    (∏ i : J, A i (τ i)) =
        (∏ i ∈ C, A i (τ i)) * (∏ i ∈ Cᶜ, A i (τ i)) :=
      (Finset.prod_mul_prod_compl C _).symm
    _ = (-(∏ i ∈ C, A i (σ i))) * (∏ i ∈ Cᶜ, A i (τ i)) := by
      rw [invariant_subset_reversal_skew_inside_product_neg C σ hC hOdd A hSkew]
    _ = (-(∏ i ∈ C, A i (σ i))) * (∏ i ∈ Cᶜ, A i (σ i)) := by
      rw [invariant_subset_reversal_outside_product C σ hC A]
    _ = -((∏ i ∈ C, A i (σ i)) * (∏ i ∈ Cᶜ, A i (σ i))) := neg_mul _ _
    _ = -(∏ i : J, A i (σ i)) := congrArg Neg.neg (Finset.prod_mul_prod_compl C _)

/-- 本文の係数の三等号と符号付き項の三等号。
符号には今回の反転に対する不変性だけを要求し、係数写像には保存則を要求しない。 -/
theorem invariant_subset_reversal_skew_signed_term_neg
    {S : Type*}
    (C : Finset J) (σ : Equiv.Perm J) (hC : ∀ i, σ i ∈ C ↔ i ∈ C)
    (hOdd : Odd C.card) (A : J → J → M)
    (hSkew : ∀ j ∈ C, A (σ j) j = -A j (σ j))
    (signValue : Equiv.Perm J → S) (embed : S → M)
    (hSign : signValue (invariantPredicateReversal (fun i => i ∈ C) σ hC) = signValue σ) :
    embed (signValue (invariantPredicateReversal (fun i => i ∈ C) σ hC)) *
        (∏ i : J, A i (invariantPredicateReversal (fun i => i ∈ C) σ hC i)) =
      -(embed (signValue σ) * (∏ i : J, A i (σ i))) := by
  let τ := invariantPredicateReversal (fun i => i ∈ C) σ hC
  let c : Equiv.Perm J → M := fun π => embed (signValue π)
  have hc : c τ = c σ := by
    calc
      c τ = embed (signValue τ) := rfl
      _ = embed (signValue σ) := congrArg embed hSign
      _ = c σ := rfl
  calc
    c τ * (∏ i : J, A i (τ i)) = c σ * (∏ i : J, A i (τ i)) := by rw [hc]
    _ = c σ * (-(∏ i : J, A i (σ i))) := by
      rw [invariant_subset_reversal_skew_product_neg C σ hC hOdd A hSkew]
    _ = -(c σ * (∏ i : J, A i (σ i))) := mul_neg _ _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
