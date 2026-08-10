/-
章「固有値の代数性」の「列ベクトルの和とスカラー倍、および行列の作用がその 2 つを保つこと」
の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_qbar_vector_add` / `def_qbar_vector_smul`）と主張 2 件
（`claim_qbar_action_add` / `claim_qbar_action_smul`）に対応する。

  人手証明                                  このファイル
  和 v ⊕ w                                  qbarVectorAdd
  スカラー倍 z ⊙ v                          qbarVectorSmul
  和の鎖の第 1 段（作用の定義）             qbarAction の展開（rfl）
  和の鎖の第 2 段（和の定義）               qbarVectorAdd の展開（rfl）
  和の鎖の第 3 段（元と和の積の分配則）     mul_add
  和の鎖の第 4 段（有限和の項ごとの分割）   Finset.sum_add_distrib
  和の鎖の第 5・6 段（定義へ戻す）          rfl
  倍の鎖の第 3・5 段（積の結合則）          mul_assoc
  倍の鎖の第 4 段（積の可換性）             mul_comm
  倍の鎖の第 6 段（元と有限和の積の分配則） Finset.mul_sum

mathlib の `Matrix.mulVec_add` / `Matrix.mulVec_smul` とその一般論へは委ねず、
人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Ising2DLambda.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

variable (L : ℕ)

/-- 列ベクトルの和 `v ⊕ w`（`def_qbar_vector_add`）。 -/
noncomputable def qbarVectorAdd (v w : QbarRowVector L) : QbarRowVector L :=
  fun τ => v τ + w τ

/-- 列ベクトルのスカラー倍 `z ⊙ v`（`def_qbar_vector_smul`）。 -/
noncomputable def qbarVectorSmul (z : Qbar) (v : QbarRowVector L) : QbarRowVector L :=
  fun τ => z * v τ

/-- 人手証明の本体（その 1）。`A·(v ⊕ w) = (A·v) ⊕ (A·w)`（`claim_qbar_action_add`）。 -/
theorem qbarAction_add [NeZero L]
    (A : QbarRowMatrix L) (v w : QbarRowVector L) :
    qbarAction L A (qbarVectorAdd L v w)
      = qbarVectorAdd L (qbarAction L A v) (qbarAction L A w) := by
  funext τ
  calc qbarAction L A (qbarVectorAdd L v w) τ
      = ∑ τ' : RowConfig L, A τ τ' * (qbarVectorAdd L v w) τ' := rfl
        -- 第 1 段。作用の定義。
    _ = ∑ τ' : RowConfig L, A τ τ' * (v τ' + w τ') := rfl
        -- 第 2 段。和の定義。
    _ = ∑ τ' : RowConfig L, (A τ τ' * v τ' + A τ τ' * w τ') :=
        sum_congr rfl fun τ' _ => mul_add _ _ _
        -- 第 3 段。元と 2 元の和の積についての分配則。
    _ = (∑ τ' : RowConfig L, A τ τ' * v τ') + ∑ τ' : RowConfig L, A τ τ' * w τ' :=
        sum_add_distrib
        -- 第 4 段。有限和の項ごとの分割。
    _ = (qbarAction L A v) τ + (qbarAction L A w) τ := rfl
        -- 第 5 段。作用の定義。
    _ = qbarVectorAdd L (qbarAction L A v) (qbarAction L A w) τ := rfl
        -- 第 6 段。和の定義。

/-- 人手証明の本体（その 2）。`A·(z ⊙ v) = z ⊙ (A·v)`（`claim_qbar_action_smul`）。 -/
theorem qbarAction_smul [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) :
    qbarAction L A (qbarVectorSmul L z v)
      = qbarVectorSmul L z (qbarAction L A v) := by
  funext τ
  calc qbarAction L A (qbarVectorSmul L z v) τ
      = ∑ τ' : RowConfig L, A τ τ' * (qbarVectorSmul L z v) τ' := rfl
        -- 第 1 段。作用の定義。
    _ = ∑ τ' : RowConfig L, A τ τ' * (z * v τ') := rfl
        -- 第 2 段。スカラー倍の定義。
    _ = ∑ τ' : RowConfig L, (A τ τ' * z) * v τ' :=
        sum_congr rfl fun τ' _ => (mul_assoc _ _ _).symm
        -- 第 3 段。積の結合則。
    _ = ∑ τ' : RowConfig L, (z * A τ τ') * v τ' :=
        sum_congr rfl fun τ' _ => by rw [mul_comm (A τ τ') z]
        -- 第 4 段。積の可換性。
    _ = ∑ τ' : RowConfig L, z * (A τ τ' * v τ') :=
        sum_congr rfl fun τ' _ => mul_assoc _ _ _
        -- 第 5 段。積の結合則。
    _ = z * ∑ τ' : RowConfig L, A τ τ' * v τ' := (mul_sum _ _ _).symm
        -- 第 6 段。元と有限和の積についての分配則。
    _ = z * (qbarAction L A v) τ := rfl
        -- 第 7 段。作用の定義。
    _ = qbarVectorSmul L z (qbarAction L A v) τ := rfl
        -- 第 8 段。スカラー倍の定義。

end Ising2DLambda.AlgebraicEigenvalue
