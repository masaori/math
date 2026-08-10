/-
章「固有値の代数性」の主張「代数的数を成分とする行列の冪は右から掛けても得られる」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_matrix_pow_succ_right`）に対応する。人手証明は k についての帰納法で、
出発点が 5 段・一歩が 4 段の鎖である。

  人手証明                                        このファイル
  出発点の第 1 段（冪の定義）                     qbarMatrixPow の展開（rfl）
  出発点の第 2 段（冪の定義。A^0 = I）            qbarMatrixPow の展開（rfl）
  出発点の第 3 段（A I = A）                      qbarMatrix_mul_qbarIdentityMatrix
  出発点の第 4 段（A = I A）                      qbarIdentityMatrix_mul（左右は別の等式）
  出発点の第 5 段（冪の定義へ戻す）               qbarMatrixPow の折りたたみ（rfl）
  一歩の第 1 段（冪の定義）                       qbarMatrixPow の展開（rfl）
  一歩の第 2 段（帰納法の仮定）                   ih
  一歩の第 3 段（結合則）                         qbarMatrixProduct_assoc
  一歩の第 4 段（冪の定義へ戻す）                 qbarMatrixPow の折りたたみ（rfl）

mathlib の `pow_succ`（モノイドの冪）へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionPow
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityMatrixUnit

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の本体（`claim_qbar_matrix_pow_succ_right`）。`A^{k+1} = A^k A`。
冪は `A^0 = I`、`A^{k+1} = A A^k`（左から掛ける）と定めてあるので、これは定義ではない。 -/
theorem qbarMatrixPow_succ_right (A : QbarRowMatrix L) :
    ∀ k : ℕ, qbarMatrixPow L A (k + 1) = qbarRowMatrixProduct L (qbarMatrixPow L A k) A := by
  intro k
  induction k with
  | zero =>
      calc qbarMatrixPow L A (0 + 1)
          = qbarRowMatrixProduct L A (qbarMatrixPow L A 0) := rfl
          -- 出発点の第 1 段。冪の定義。
        _ = qbarRowMatrixProduct L A (qbarIdentityMatrix L) := rfl
          -- 出発点の第 2 段。冪の定義（A^0 = I）。
        _ = A := qbarMatrix_mul_qbarIdentityMatrix L A
          -- 出発点の第 3 段。単位行列を右から掛ける。
        _ = qbarRowMatrixProduct L (qbarIdentityMatrix L) A :=
            (qbarIdentityMatrix_mul L A).symm
          -- 出発点の第 4 段。単位行列を左から掛ける（右の等式からは出ない別の等式である）。
        _ = qbarRowMatrixProduct L (qbarMatrixPow L A 0) A := rfl
          -- 出発点の第 5 段。冪の定義へ戻す。
  | succ k ih =>
      calc qbarMatrixPow L A (k + 1 + 1)
          = qbarRowMatrixProduct L A (qbarMatrixPow L A (k + 1)) := rfl
          -- 一歩の第 1 段。冪の定義。
        _ = qbarRowMatrixProduct L A (qbarRowMatrixProduct L (qbarMatrixPow L A k) A) := by
            rw [ih]
          -- 一歩の第 2 段。帰納法の仮定。
        _ = qbarRowMatrixProduct L (qbarRowMatrixProduct L A (qbarMatrixPow L A k)) A :=
            (qbarMatrixProduct_assoc L A (qbarMatrixPow L A k) A).symm
          -- 一歩の第 3 段。積の結合則。
        _ = qbarRowMatrixProduct L (qbarMatrixPow L A (k + 1)) A := rfl
          -- 一歩の第 4 段。冪の定義へ戻す。

end Ising2DLambda.AlgebraicEigenvalue
