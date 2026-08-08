/-
章「固有値の代数性」の「シフト行列」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_shift_matrix`）と主張 2 件・定理 1 件
（`claim_shift_matrix_left` / `claim_shift_matrix_right` /
`theorem_shift_matrix_commutes`）に対応する。

  人手証明                                  このファイル
  U（シフト行列）                            shiftMatrix L
  (UA)_{τ,τ''} = A_{S(τ),τ''}               shiftMatrix_mul_apply
  τ'' = S(τ') ⟺ S'(τ'') = τ' の準備          rowShift_eq_iff
  (AU)_{τ,τ''} = A_{τ,S'(τ'')}              mul_shiftMatrix_apply
  UT = TU                                    shiftMatrix_transferMatrix_comm

人手証明が和を「τ' = S(τ) の項と、それ以外の項」へ分けてから、単位元・零元で
片方を落とす形で書いていることは、ここでも同じである。`Finset.sum_eq_single` は
まさにその形（1 点だけ残し、他の項が零であることを見る）なので引いている。
数え上げや行列の一般論（mathlib の `Matrix.mul` や置換行列 `Equiv.Perm.permMatrix`）へは
丸投げしていない。行列は人手証明の定義（`RowMatrix` = 2 変数の写像）のままである。

住処: 人手証明のこれらのブロックは ℤ（成分が ℤ[x]）を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、成分は `Polynomial ℤ`）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigShift
import Ising2DLambda.AlgebraicEigenvalue.Determinant

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `U_{τ,τ'} = κ(1) (τ' = S(τ))、κ(0) (それ以外)`。 -/
noncomputable def shiftMatrix : RowMatrix L :=
  fun τ τ' => if τ' = rowShift L τ then constPoly 1 else constPoly 0

variable {L}

/-- 人手証明の主張「シフト行列を左から掛けると行の添字がシフトされる」。

証明は人手証明どおり。和を `τ' = S(τ)` の項とそれ以外へ分け、
`κ(0)` が零元であることで残りを落とし、`κ(1)` が単位元であることで結論する。 -/
theorem shiftMatrix_mul_apply (A : RowMatrix L) (τ τ'' : RowConfig L) :
    rowMatrixProduct L (shiftMatrix L) A τ τ'' = A (rowShift L τ) τ'' := by
  classical
  show (∑ τ' : RowConfig L, shiftMatrix L τ τ' * A τ' τ'') = A (rowShift L τ) τ''
  rw [Finset.sum_eq_single (rowShift L τ)]
  · -- τ' = S(τ) の項。κ(1) は単位元。
    rw [shiftMatrix, if_pos rfl, constPoly_one, one_mul]
  · -- τ' ≠ S(τ) の項は κ(0) を掛けたものなので零元。
    intro τ' _ hτ'
    rw [shiftMatrix, if_neg hτ', constPoly_zero, zero_mul]
  · intro h
    exact absurd (mem_univ _) h

/-- 人手証明が `(AU)` の計算の前に置く同値 `τ'' = S(τ') ⟺ S'(τ'') = τ'`。

`S` が全単射であること（`rowShiftEquiv`）だけから出る。 -/
theorem rowShift_eq_iff (τ' τ'' : RowConfig L) :
    τ'' = rowShift L τ' ↔ (rowShiftEquiv L).symm τ'' = τ' := by
  constructor
  · intro h
    rw [h]
    exact (rowShiftEquiv L).symm_apply_apply τ'
  · intro h
    rw [← h]
    exact ((rowShiftEquiv L).apply_symm_apply τ'').symm

/-- 人手証明の主張「シフト行列を右から掛けると列の添字が逆向きにシフトされる」。 -/
theorem mul_shiftMatrix_apply (A : RowMatrix L) (τ τ'' : RowConfig L) :
    rowMatrixProduct L A (shiftMatrix L) τ τ'' = A τ ((rowShiftEquiv L).symm τ'') := by
  classical
  show (∑ τ' : RowConfig L, A τ τ' * shiftMatrix L τ' τ'')
    = A τ ((rowShiftEquiv L).symm τ'')
  rw [Finset.sum_eq_single ((rowShiftEquiv L).symm τ'')]
  · -- τ' = S'(τ'') の項。上の同値より U の成分は κ(1)。
    rw [shiftMatrix, if_pos ((rowShift_eq_iff _ τ'').mpr rfl), constPoly_one, mul_one]
  · -- τ' ≠ S'(τ'') の項は、上の同値より U の成分が κ(0) なので零元。
    intro τ' _ hτ'
    have : ¬ (τ'' = rowShift L τ') := fun h => hτ' (((rowShift_eq_iff τ' τ'').mp h).symm)
    rw [shiftMatrix, if_neg this, constPoly_zero, mul_zero]
  · intro h
    exact absurd (mem_univ _) h

variable (L)

/-- 人手証明の定理「シフト行列と転送行列は可換である」。

証明は人手証明どおり 4 つの等号（左から掛ける主張・`S ∘ S' = id`・
転送行列のシフト不変性・右から掛ける主張）である。 -/
theorem shiftMatrix_transferMatrix_comm :
    rowMatrixProduct L (shiftMatrix L) (transferMatrix L)
      = rowMatrixProduct L (transferMatrix L) (shiftMatrix L) := by
  funext τ τ''
  rw [shiftMatrix_mul_apply, mul_shiftMatrix_apply]
  -- T_{S(τ),τ''} = T_{S(τ),S(S'(τ''))} = T_{τ,S'(τ'')}
  conv_lhs => rw [show τ'' = rowShift L ((rowShiftEquiv L).symm τ'') from
    ((rowShiftEquiv L).apply_symm_apply τ'').symm]
  exact transferMatrix_rowShift τ ((rowShiftEquiv L).symm τ'')

end Ising2DLambda.AlgebraicEigenvalue
