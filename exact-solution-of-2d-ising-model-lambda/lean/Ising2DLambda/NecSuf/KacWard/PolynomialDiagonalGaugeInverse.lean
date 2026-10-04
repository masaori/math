/-
定数多項式への移送の必要十分版。
有限和には有限添字と AddCommMonoid、積の記述には Mul、単位行列には
添字の相等判定と One が要る。写像の零・二項和・一・積の保存を明示して受ける。
分配則、乗法の結合・可換・単位元法則、逆元、体、格子、対角性は使わない。
元の両側逆関係だけを受け、有限和の帰納法、積保存、単位行列保存の順で移す。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarMatrixEval
import Mathlib.Data.Matrix.Mul

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open scoped BigOperators

/-- 本文と同じ有限和の帰納法を使い、既存の積・単位行列保存から両側逆を移す。 -/
theorem mappedMatrices_mul_inverse_necSuf {ι R S : Type*}
    [Fintype ι] [DecidableEq ι]
    [AddCommMonoid R] [Mul R] [One R] [AddCommMonoid S] [Mul S] [One S]
    (φ : R → S) (hzero : φ 0 = 0) (hone : φ 1 = 1)
    (hadd : ∀ a b, φ (a + b) = φ a + φ b)
    (hmul : ∀ a b, φ (a * b) = φ a * φ b)
    (M N : Matrix ι ι R) (hMN : M * N = 1) (hNM : N * M = 1) :
    M.map φ * N.map φ = 1 ∧ N.map φ * M.map φ = 1 := by
  have hsum (a : ι → R) (T : Finset ι) :
      φ (∑ g ∈ T, a g) = ∑ g ∈ T, φ (a g) := by
    induction T using Finset.induction_on with
    | empty =>
        calc
          φ (∑ g ∈ (∅ : Finset ι), a g) = φ 0 := by rw [Finset.sum_empty]
          _ = 0 := hzero
          _ = ∑ g ∈ (∅ : Finset ι), φ (a g) := Finset.sum_empty.symm
    | @insert h T hh ih =>
        calc
          φ (∑ g ∈ insert h T, a g) = φ (a h + ∑ g ∈ T, a g) := by
            rw [Finset.sum_insert hh]
          _ = φ (a h) + φ (∑ g ∈ T, a g) := hadd _ _
          _ = φ (a h) + ∑ g ∈ T, φ (a g) := by rw [ih]
          _ = ∑ g ∈ insert h T, φ (a g) := by rw [Finset.sum_insert hh]
  have hproduct (A B : Matrix ι ι R) (hAB : A * B = 1) : A.map φ * B.map φ = 1 := by
    apply Matrix.ext
    intro i j
    -- 既存補題の逆向きが、本文の積を開いてから有限和を写像の中へ戻す五行に対応する。
    calc
      (A.map φ * B.map φ) i j = φ ((A * B) i j) :=
        (matEval_product_necSuf φ (fun a => hsum a Finset.univ) hmul A B i j).symm
      _ = φ ((1 : Matrix ι ι R) i j) := by rw [hAB]
      _ = (1 : Matrix ι ι S) i j := matEval_identity_necSuf φ hone hzero i j
  constructor
  · exact hproduct M N hMN
  · exact hproduct N M hNM

end Ising2DLambda.NecSuf.KacWard
