/-
章「固有値の代数性」の「代数的数を成分とする行列の冪と、その作用が反復した作用で
あること」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_qbar_matrix_power` / `def_qbar_action_iterate`）と主張 1 件
（`claim_qbar_action_pow`）に対応する。

  人手証明                                      このファイル
  冪 A^k（A^0 = I, A^{k+1} = A A^k）             qbarMatrixPow
  作用の反復 it^[k]_A(v)                         qbarActionIterate
  出発点の第 1 段（冪の定義）                    qbarMatrixPow の展開（rfl）
  出発点の第 2 段（単位行列の作用）              qbarIdentity_action
  出発点の第 3 段（作用の反復の定義）            qbarActionIterate の展開（rfl）
  一歩の第 1 段（冪の定義）                      qbarMatrixPow の展開（rfl）
  一歩の第 2 段（積の作用）                      qbarAction_product
  一歩の第 3 段（帰納法の仮定）                  ih
  一歩の第 4 段（作用の反復の定義）              qbarActionIterate の展開（rfl）

mathlib の `Matrix.pow_mulVec` の類やモノイドの冪の一般論へは委ねず、人手証明の
帰納法をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 代数的数を成分とする行列の冪（`def_qbar_matrix_power`）。
`A^0 = I^Qbar_L`、`A^{k+1} = A A^k`（左から掛ける）。 -/
noncomputable def qbarMatrixPow (A : QbarRowMatrix L) : ℕ → QbarRowMatrix L
  | 0 => qbarIdentityMatrix L
  | k + 1 => qbarRowMatrixProduct L A (qbarMatrixPow A k)

/-- 作用の反復（`def_qbar_action_iterate`）。
`it^[0](v) = v`、`it^[k+1](v) = A · it^[k](v)`。 -/
noncomputable def qbarActionIterate (A : QbarRowMatrix L) (v : QbarRowVector L) :
    ℕ → QbarRowVector L
  | 0 => v
  | k + 1 => qbarAction L A (qbarActionIterate A v k)

/-- 人手証明の本体。`A^k · v = it^[k]_A(v)`（`claim_qbar_action_pow`）。
`k` についての帰納法。 -/
theorem qbarAction_pow (A : QbarRowMatrix L) (v : QbarRowVector L) (k : ℕ) :
    qbarAction L (qbarMatrixPow L A k) v = qbarActionIterate L A v k := by
  induction k with
  | zero =>
      calc qbarAction L (qbarMatrixPow L A 0) v
          = qbarAction L (qbarIdentityMatrix L) v := rfl
            -- 出発点の第 1 段。冪の定義。
        _ = v := qbarIdentity_action L v
            -- 出発点の第 2 段。単位行列の作用は列ベクトルを動かさない。
        _ = qbarActionIterate L A v 0 := rfl
            -- 出発点の第 3 段。作用の反復の定義。
  | succ k ih =>
      calc qbarAction L (qbarMatrixPow L A (k + 1)) v
          = qbarAction L (qbarRowMatrixProduct L A (qbarMatrixPow L A k)) v := rfl
            -- 一歩の第 1 段。冪の定義。
        _ = qbarAction L A (qbarAction L (qbarMatrixPow L A k) v) :=
            qbarAction_product L A (qbarMatrixPow L A k) v
            -- 一歩の第 2 段。行列の積の作用は、作用を 2 度施したものである。
        _ = qbarAction L A (qbarActionIterate L A v k) := by rw [ih]
            -- 一歩の第 3 段。帰納法の仮定。
        _ = qbarActionIterate L A v (k + 1) := rfl
            -- 一歩の第 4 段。作用の反復の定義。

end Ising2DLambda.AlgebraicEigenvalue
