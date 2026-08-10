/-
章「固有値の代数性」の主張「シフト行列の固有値は 1 の L 乗根である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_shift_matrix_eigenvalue_root_of_unity`）に対応する。

  人手証明                                          このファイル
  固有値の定義から固有ベクトル v を取る             obtain ⟨v, hv, hne⟩
  第 1 の鎖の第 1 段（評価が冪を保つ）              qbarMatrixEval_pow
  第 1 の鎖の第 2 段（U^L = I）                     shiftMatrix_pow_L
  第 1 の鎖の第 3 段（評価が単位行列を保つ）        qbarMatrixEval_identity
  第 2 の鎖の第 1 段（固有ベクトルの冪の作用）      qbarAction_pow_smul
  第 2 の鎖の第 2 段（第 1 の鎖）                   hMatPow
  第 2 の鎖の第 3 段（単位行列の作用）              qbarIdentity_action
  第 3 の鎖（各点の 9 段）                          hzero の calc
  最後の段（スカラーが 0 であること）               qbarSmul_eq_zero
  結論の 5 段（z^L = 1）                            最後の calc

`rowMatrixPow L A k` が人手証明の `A^{k+1}` を表す（ℤ[x] の側は `A^0` を定めていない）ので、
`U^L` は `rowMatrixPow L (shiftMatrix L) (L - 1)` である。`Qbar` の側の冪は指数がそのままである。

行列式の理論（非自明な核を持つ行列の行列式が零元であること）は経由していない。
使うのは `U^L = I` を評価で運ぶことと、固有ベクトルへ冪を作用させることだけである。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（値は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEvalPow
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenvectorPow
import Ising2DLambda.AlgebraicEigenvalue.QbarSmulEqZero
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixOrder
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 第 1 の鎖（`(Ev_ξ(U))^L = Ev_ξ(U^L) = Ev_ξ(I) = I^Qbar_L`）。 -/
theorem qbarMatrixEval_shiftMatrix_pow_L (ξ : Qbar) :
    qbarMatrixPow L (qbarMatrixEval L ξ (shiftMatrix L)) L = qbarIdentityMatrix L := by
  have hL : L - 1 + 1 = L := Nat.succ_pred_eq_of_pos (Nat.pos_of_ne_zero (NeZero.ne L))
  calc qbarMatrixPow L (qbarMatrixEval L ξ (shiftMatrix L)) L
      = qbarMatrixPow L (qbarMatrixEval L ξ (shiftMatrix L)) (L - 1 + 1) := by rw [hL]
    _ = qbarMatrixEval L ξ (rowMatrixPow L (shiftMatrix L) (L - 1)) :=
        (qbarMatrixEval_pow L ξ (shiftMatrix L) (L - 1)).symm
        -- 第 1 段。成分ごとの評価が行列の冪を保つこと。
    _ = qbarMatrixEval L ξ (identityRowMatrix L) := by rw [shiftMatrix_pow_L L]
        -- 第 2 段。U^L = I。
    _ = qbarIdentityMatrix L := qbarMatrixEval_identity L ξ
        -- 第 3 段。成分ごとの評価が単位行列を単位行列へ写すこと。

/-- 人手証明の本体（`claim_shift_matrix_eigenvalue_root_of_unity`）。
`Ev_ξ(U)` の固有値は 1 の L 乗根である。 -/
theorem shiftMatrix_eigenvalue_rootOfUnity (ξ : Qbar) (z : Qbar)
    (h : IsQbarEigenvalue L (qbarMatrixEval L ξ (shiftMatrix L)) z) :
    z ∈ RootOfUnity L := by
  obtain ⟨v, hv, hne⟩ := h
  -- 第 2 の鎖。z^L ⊙ v = (Ev_ξ(U))^L · v = I^Qbar_L · v = v。
  have hsmul : qbarVectorSmul L (z ^ L) v = v := by
    calc qbarVectorSmul L (z ^ L) v
        = qbarAction L (qbarMatrixPow L (qbarMatrixEval L ξ (shiftMatrix L)) L) v :=
          (qbarAction_pow_smul L (qbarMatrixEval L ξ (shiftMatrix L)) z v hv L).symm
          -- 第 1 段。固有ベクトルへ冪を作用させると固有値の冪のスカラー倍になること。
      _ = qbarAction L (qbarIdentityMatrix L) v := by
          rw [qbarMatrixEval_shiftMatrix_pow_L L ξ]
          -- 第 2 段。第 1 の鎖。
      _ = v := qbarIdentity_action L v
          -- 第 3 段。単位行列の作用は列ベクトルを動かさない。
  -- 第 3 の鎖。各点で (z^L + (-1)) ⊙ v の値が 0 であること。
  have hzero : qbarVectorSmul L (z ^ L + (-1)) v = qbarZeroVector L := by
    funext τ
    calc qbarVectorSmul L (z ^ L + (-1)) v τ
        = (z ^ L + (-1)) * v τ := rfl
          -- 第 1 段。スカラー倍の定義。
      _ = z ^ L * v τ + (-1) * v τ := add_mul _ _ _
          -- 第 2 段。分配則。
      _ = qbarVectorSmul L (z ^ L) v τ + (-1) * v τ := rfl
          -- 第 3 段。スカラー倍の定義。
      _ = v τ + (-1) * v τ := by rw [hsmul]
          -- 第 4 段。第 2 の鎖。
      _ = 1 * v τ + (-1) * v τ := by rw [one_mul]
          -- 第 5 段。1 は積の単位元。
      _ = (1 + (-1)) * v τ := (add_mul _ _ _).symm
          -- 第 6 段。分配則。
      _ = 0 * v τ := by rw [add_neg_cancel]
          -- 第 7 段。-1 は 1 の加法についての逆元。
      _ = 0 := zero_mul _
          -- 第 8 段。零元との積は零元。
      _ = qbarZeroVector L τ := rfl
          -- 第 9 段。零ベクトルの定義。
  -- 最後の段。v ≠ o_L と合わせてスカラーが 0 であることを出す。
  have hz : z ^ L + (-1) = 0 := qbarSmul_eq_zero L (z ^ L + (-1)) v hzero hne
  show z ^ L = 1
  calc z ^ L = z ^ L + 0 := (add_zero _).symm
    _ = z ^ L + ((-1) + 1) := by rw [neg_add_cancel]
    _ = (z ^ L + (-1)) + 1 := (add_assoc _ _ _).symm
    _ = 0 + 1 := by rw [hz]
    _ = 1 := zero_add 1

end Ising2DLambda.AlgebraicEigenvalue
