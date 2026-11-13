/-
不変部分集合上の反転による符号保存の具体版。
本文の部分置換の両側逆・二重合成・符号の六等号を独立に辿る。
添字集合と部分集合が空の場合も含み、符号は自前の転倒数による整数値を使う。
符号・転倒数は本文の定義を書いた `sign`・`inversionCount` を使い、乗法性は具体版
`finiteOrderedSign_comp`（`claim_permutation_sign_mul`）を引く。必要十分版の定理は引かない。
-/
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversal
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSet

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign inversionCount)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 部分逆置換を二回合成する表示から、反転の符号保存を得る。 -/
theorem invariantSubsetReversal_sign (C : Finset J) (σ : Equiv.Perm J)
    (hC : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    sign (fun i j : J => i < j) (invariantSubsetReversal C σ hC) =
      sign (fun i j : J => i < j) σ := by
  -- 逆像の所属は、本文と同じ二つの同値で移す。
  have hInv (i : J) : σ.symm i ∈ C ↔ i ∈ C := by
    calc
      (σ.symm i ∈ C) ↔ (σ (σ.symm i) ∈ C) := (hC (σ.symm i)).symm
      _ ↔ i ∈ C := by rw [σ.apply_symm_apply i]
  let p : J → J := fun i => if i ∈ C then σ i else i
  let q₀ : J → J := fun i => if i ∈ C then σ.symm i else i
  -- p(q(i)) = i。内側三等号、外側二等号。
  have hpq (i : J) : p (q₀ i) = i := by
    by_cases hi : i ∈ C
    · have hsi : σ.symm i ∈ C := (hInv i).mpr hi
      calc
        p (q₀ i) = p (σ.symm i) := congrArg p (if_pos hi)
        _ = σ (σ.symm i) := if_pos hsi
        _ = i := σ.apply_symm_apply i
    · calc
        p (q₀ i) = p i := congrArg p (if_neg hi)
        _ = i := if_neg hi
  -- q(p(i)) = i。内側三等号、外側二等号。
  have hqp (i : J) : q₀ (p i) = i := by
    by_cases hi : i ∈ C
    · have hsi : σ i ∈ C := (hC i).mpr hi
      calc
        q₀ (p i) = q₀ (σ i) := congrArg q₀ (if_pos hi)
        _ = σ.symm (σ i) := if_pos hsi
        _ = i := σ.symm_apply_apply i
    · calc
        q₀ (p i) = q₀ i := congrArg q₀ (if_neg hi)
        _ = i := if_neg hi
  let q : Equiv.Perm J :=
    { toFun := q₀, invFun := p, left_inv := hpq, right_inv := hqp }
  -- 二重合成は、内側五等号、外側四等号で反転と一致する。
  have hComposition : q * (q * σ) = invariantSubsetReversal C σ hC := by
    apply Equiv.ext
    intro i
    by_cases hi : i ∈ C
    · have hsi : σ i ∈ C := (hC i).mpr hi
      calc
        (q * (q * σ)) i = q (q (σ i)) := rfl
        _ = q (σ.symm (σ i)) := congrArg q (if_pos hsi)
        _ = q i := congrArg q (σ.symm_apply_apply i)
        _ = σ.symm i := if_pos hi
        _ = invariantSubsetReversal C σ hC i := (if_pos hi).symm
    · have hsi : σ i ∉ C := fun hmem => hi ((hC i).mp hmem)
      calc
        (q * (q * σ)) i = q (q (σ i)) := rfl
        _ = q (σ i) := congrArg q (if_neg hsi)
        _ = σ i := if_neg hsi
        _ = invariantSubsetReversal C σ hC i := (if_neg hi).symm
  -- 本文の二行。一行目は `def_permutation_sign` の (-1) の自然数冪が 1 か -1 であること、
  -- 二行目は二つの場合の整数の積。
  have hValues : sign (fun i j : J => i < j) q = 1 ∨
      sign (fun i j : J => i < j) q = -1 := by
    have he : sign (fun i j : J => i < j) q =
        (-1 : ℤ) ^ inversionCount (fun i j : J => i < j) q := rfl
    rw [he]
    exact neg_one_pow_eq_or ℤ _
  have hSquare : sign (fun i j : J => i < j) q *
      sign (fun i j : J => i < j) q = 1 := by
    rcases hValues with hpos | hneg
    · rw [hpos]
      exact one_mul 1
    · rw [hneg]
      decide
  -- 本文の符号保存の六等号。
  calc
    sign (fun i j : J => i < j) (invariantSubsetReversal C σ hC) =
        sign (fun i j : J => i < j) (q * (q * σ)) :=
      congrArg (sign (fun i j : J => i < j)) hComposition.symm
    _ = sign (fun i j : J => i < j) q *
        sign (fun i j : J => i < j) (q * σ) :=
      finiteOrderedSign_comp q (q * σ)
    _ = sign (fun i j : J => i < j) q *
        (sign (fun i j : J => i < j) q * sign (fun i j : J => i < j) σ) :=
      congrArg (sign (fun i j : J => i < j) q * ·)
        (finiteOrderedSign_comp q σ)
    _ = (sign (fun i j : J => i < j) q * sign (fun i j : J => i < j) q) *
        sign (fun i j : J => i < j) σ := (mul_assoc _ _ _).symm
    _ = 1 * sign (fun i j : J => i < j) σ :=
      congrArg (· * sign (fun i j : J => i < j) σ) hSquare
    _ = sign (fun i j : J => i < j) σ := one_mul _

/-- 選んだ奇数軌道の台の不変性を供給する、本文の二等号。 -/
theorem selectedOddOrbitReversal_sign (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) =
      sign (fun i j : J => i < j) σ := by
  calc
    sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) =
        sign (fun i j : J => i < j)
          (invariantSubsetReversal (selectedOddOrbitFinset σ hσ.2) σ
            (selectedOddOrbitFinset_invariant σ hσ.2)) := rfl
    _ = sign (fun i j : J => i < j) σ :=
      invariantSubsetReversal_sign (selectedOddOrbitFinset σ hσ.2) σ
        (selectedOddOrbitFinset_invariant σ hσ.2)

end Ising2DLambda.AlgebraicEigenvalue
