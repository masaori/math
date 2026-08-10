/-
章「固有値の代数性」の「固有ベクトルへ行列の冪を作用させると、固有値の冪のスカラー倍に
なること」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_eigenvector_pow`）に対応する。

  人手証明                                      このファイル
  準備の第 1 の等式 1⊙w = w                     qbarVectorSmul_one
  準備の第 2 の等式 (y z)⊙w = y⊙(z⊙w)           qbarVectorSmul_mul
  出発点の第 1 段（冪の定義）                    qbarMatrixPow の展開（rfl）
  出発点の第 2 段（単位行列の作用）              qbarIdentity_action
  出発点の第 3 段（準備の第 1 の等式）           qbarVectorSmul_one
  出発点の第 4 段（z^0 = 1 の約束）              pow_zero
  一歩の第 1 段（冪の定義）                      qbarMatrixPow の展開（rfl）
  一歩の第 2 段（積の作用）                      qbarAction_product
  一歩の第 3 段（帰納法の仮定）                  ih
  一歩の第 4 段（作用がスカラー倍を保つこと）    qbarAction_smul
  一歩の第 5 段（仮定 A·v = z⊙v）                h
  一歩の第 6 段（準備の第 2 の等式）             qbarVectorSmul_mul
  一歩の第 7 段（z^{k+1} = z^k z の約束）        pow_succ

mathlib の固有ベクトルの一般論（`Module.End.HasEigenvector` の類）へは委ねず、
人手証明の帰納法をそのまま書く。`pow_zero` / `pow_succ` は `z^k` の約束
（`def_root_of_unity_set` で置いたもの）そのものである。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionPow
import Ising2DLambda.AlgebraicEigenvalue.QbarActionLinear

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ)

/-- 準備の第 1 の等式。`1 ⊙ v = v`。 -/
theorem qbarVectorSmul_one (v : QbarRowVector L) :
    qbarVectorSmul L 1 v = v := by
  funext τ
  calc qbarVectorSmul L 1 v τ
      = 1 * v τ := rfl
        -- 第 1 段。スカラー倍の定義。
    _ = v τ := one_mul _
        -- 第 2 段。単位元との積。

/-- 準備の第 2 の等式。`(y z) ⊙ v = y ⊙ (z ⊙ v)`。 -/
theorem qbarVectorSmul_mul (y z : Qbar) (v : QbarRowVector L) :
    qbarVectorSmul L (y * z) v = qbarVectorSmul L y (qbarVectorSmul L z v) := by
  funext τ
  calc qbarVectorSmul L (y * z) v τ
      = (y * z) * v τ := rfl
        -- 第 1 段。スカラー倍の定義。
    _ = y * (z * v τ) := mul_assoc _ _ _
        -- 第 2 段。積の結合則。
    _ = y * (qbarVectorSmul L z v τ) := rfl
        -- 第 3 段。スカラー倍の定義。
    _ = qbarVectorSmul L y (qbarVectorSmul L z v) τ := rfl
        -- 第 4 段。スカラー倍の定義。

/-- 人手証明の本体。`A·v = z⊙v` ならば `A^k·v = z^k⊙v`（`claim_qbar_eigenvector_pow`）。
`k` についての帰納法。仮定に使うのは固有ベクトルの 2 条件のうち等式の側だけで、
`v ≠ o_L` は使わない。 -/
theorem qbarAction_pow_smul [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (h : qbarAction L A v = qbarVectorSmul L z v) (k : ℕ) :
    qbarAction L (qbarMatrixPow L A k) v = qbarVectorSmul L (z ^ k) v := by
  induction k with
  | zero =>
      calc qbarAction L (qbarMatrixPow L A 0) v
          = qbarAction L (qbarIdentityMatrix L) v := rfl
            -- 出発点の第 1 段。冪の定義。
        _ = v := qbarIdentity_action L v
            -- 出発点の第 2 段。単位行列の作用は列ベクトルを動かさない。
        _ = qbarVectorSmul L 1 v := (qbarVectorSmul_one L v).symm
            -- 出発点の第 3 段。準備の第 1 の等式。
        _ = qbarVectorSmul L (z ^ 0) v := by rw [pow_zero]
            -- 出発点の第 4 段。z^0 = 1 の約束。
  | succ k ih =>
      calc qbarAction L (qbarMatrixPow L A (k + 1)) v
          = qbarAction L (qbarRowMatrixProduct L A (qbarMatrixPow L A k)) v := rfl
            -- 一歩の第 1 段。冪の定義。
        _ = qbarAction L A (qbarAction L (qbarMatrixPow L A k) v) :=
            qbarAction_product L A (qbarMatrixPow L A k) v
            -- 一歩の第 2 段。行列の積の作用は、作用を 2 度施したものである。
        _ = qbarAction L A (qbarVectorSmul L (z ^ k) v) := by rw [ih]
            -- 一歩の第 3 段。帰納法の仮定。
        _ = qbarVectorSmul L (z ^ k) (qbarAction L A v) :=
            qbarAction_smul L A (z ^ k) v
            -- 一歩の第 4 段。作用は列ベクトルのスカラー倍を保つ。
        _ = qbarVectorSmul L (z ^ k) (qbarVectorSmul L z v) := by rw [h]
            -- 一歩の第 5 段。仮定 A·v = z⊙v。
        _ = qbarVectorSmul L (z ^ k * z) v := (qbarVectorSmul_mul L (z ^ k) z v).symm
            -- 一歩の第 6 段。準備の第 2 の等式。
        _ = qbarVectorSmul L (z ^ (k + 1)) v := by rw [pow_succ]
            -- 一歩の第 7 段。z^{k+1} = z^k z の約束。

end Ising2DLambda.AlgebraicEigenvalue
