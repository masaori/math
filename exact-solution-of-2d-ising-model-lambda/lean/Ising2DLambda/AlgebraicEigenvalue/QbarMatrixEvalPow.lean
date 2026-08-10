/-
章「固有値の代数性」の主張「成分ごとの評価は行列の冪を保つ」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_matrix_eval_pow`）に対応する。人手証明は k >= 1 についての帰納法で、
出発点が 4 段・一歩が 4 段の鎖である。

  人手証明                                        このファイル
  出発点の第 1 段（ℤ[x] の冪の定義 A^1 = A）      rowMatrixPow の展開（rfl）
  出発点の第 2 段（Ev(A) = Ev(A) I）              qbarMatrix_mul_qbarIdentityMatrix
  出発点の第 3 段（I = (Ev A)^0）                 qbarMatrixPow の展開（rfl）
  出発点の第 4 段（Qbar の冪の定義へ戻す）        qbarMatrixPow の折りたたみ（rfl）
  一歩の第 1 段（ℤ[x] の冪の定義 A^{k+1}=A^k A）  rowMatrixPow の展開（rfl）
  一歩の第 2 段（評価が積を保つ）                 qbarMatrixEval_product
  一歩の第 3 段（帰納法の仮定）                   ih
  一歩の第 4 段（冪は右から掛けても得られる）     qbarMatrixPow_succ_right

添字のずらしに注意する。`rowMatrixPow L A k` は人手証明の A^{k+1} を表す
（ℤ[x] の側は A^0 を定めていないため。`WeightProduct.lean` の約束）。
`qbarMatrixPow L B k` のほうは指数がそのまま k である。したがって主張は
`qbarMatrixEval L ξ (rowMatrixPow L A k) = qbarMatrixPow L (qbarMatrixEval L ξ A) (k+1)`
という形になる。

mathlib の `map_pow`（モノイド準同型の冪の保存）へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（値は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEval
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixPowSuccRight

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の本体（`claim_qbar_matrix_eval_pow`）。`Ev_ξ(A^k) = (Ev_ξ(A))^k`（k ≥ 1）。
Lean 側では `rowMatrixPow L A k` が人手証明の指数 `k+1` にあたるので、右辺の指数も `k+1` である。 -/
theorem qbarMatrixEval_pow (ξ : Qbar) (A : RowMatrix L) :
    ∀ k : ℕ, qbarMatrixEval L ξ (rowMatrixPow L A k)
      = qbarMatrixPow L (qbarMatrixEval L ξ A) (k + 1) := by
  intro k
  induction k with
  | zero =>
      calc qbarMatrixEval L ξ (rowMatrixPow L A 0)
          = qbarMatrixEval L ξ A := rfl
          -- 出発点の第 1 段。ℤ[x] の冪の定義（A^1 = A）。
        _ = qbarRowMatrixProduct L (qbarMatrixEval L ξ A) (qbarIdentityMatrix L) :=
            (qbarMatrix_mul_qbarIdentityMatrix L (qbarMatrixEval L ξ A)).symm
          -- 出発点の第 2 段。単位行列を右から掛ける。
        _ = qbarRowMatrixProduct L (qbarMatrixEval L ξ A)
              (qbarMatrixPow L (qbarMatrixEval L ξ A) 0) := rfl
          -- 出発点の第 3 段。Qbar の冪の定義（B^0 = I）。
        _ = qbarMatrixPow L (qbarMatrixEval L ξ A) (0 + 1) := rfl
          -- 出発点の第 4 段。Qbar の冪の定義へ戻す。
  | succ k ih =>
      calc qbarMatrixEval L ξ (rowMatrixPow L A (k + 1))
          = qbarMatrixEval L ξ (rowMatrixProduct L (rowMatrixPow L A k) A) := rfl
          -- 一歩の第 1 段。ℤ[x] の冪の定義（A^{k+1} = A^k A）。
        _ = qbarRowMatrixProduct L (qbarMatrixEval L ξ (rowMatrixPow L A k))
              (qbarMatrixEval L ξ A) := qbarMatrixEval_product L ξ _ A
          -- 一歩の第 2 段。評価が行列の積を保つこと。
        _ = qbarRowMatrixProduct L (qbarMatrixPow L (qbarMatrixEval L ξ A) (k + 1))
              (qbarMatrixEval L ξ A) := by rw [ih]
          -- 一歩の第 3 段。帰納法の仮定。
        _ = qbarMatrixPow L (qbarMatrixEval L ξ A) (k + 1 + 1) :=
            (qbarMatrixPow_succ_right L (qbarMatrixEval L ξ A) (k + 1)).symm
          -- 一歩の第 4 段。冪は右から掛けても得られること。

end Ising2DLambda.AlgebraicEigenvalue
