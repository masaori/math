/-
章「固有値の代数性」の「列ベクトルの有限和と、行列の作用がそれを保つこと」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_qbar_vector_sum`）と主張 1 件（`claim_qbar_action_sum`）に対応する。

  人手証明                                    このファイル
  有限和 ⊕_{i∈s} v_i（成分ごとの定義）        qbarVectorSum
  鎖の第 1 段（作用の定義）                   qbarAction の展開（rfl）
  鎖の第 2 段（有限和の定義）                 qbarVectorSum の展開（rfl）
  鎖の第 3 段（元と有限和の積の分配則）       Finset.mul_sum
  鎖の第 4 段（有限和の順序の入れ替え）       Finset.sum_comm
  鎖の第 5・6 段（定義へ戻す）                rfl

mathlib の `Matrix.mulVec_sum` のような一般論へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Ising2DLambda.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 列ベクトルの有限和 `⊕_{i∈s} v i`（`def_qbar_vector_sum`）。
成分ごとに `Qbar` の有限和として定める（`⊕` を繰り返す形では定めない）。 -/
noncomputable def qbarVectorSum {ι : Type*} (L : ℕ) (s : Finset ι)
    (v : ι → QbarRowVector L) : QbarRowVector L :=
  fun τ => ∑ i ∈ s, v i τ

/-- 人手証明の本体。`A·(⊕_{i∈s} v i) = ⊕_{i∈s} (A·v i)`（`claim_qbar_action_sum`）。 -/
theorem qbarAction_sum {ι : Type*} (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (s : Finset ι) (v : ι → QbarRowVector L) :
    qbarAction L A (qbarVectorSum L s v)
      = qbarVectorSum L s (fun i => qbarAction L A (v i)) := by
  funext τ
  calc qbarAction L A (qbarVectorSum L s v) τ
      = ∑ τ' : RowConfig L, A τ τ' * (qbarVectorSum L s v) τ' := rfl
        -- 第 1 段。作用の定義。
    _ = ∑ τ' : RowConfig L, A τ τ' * ∑ i ∈ s, v i τ' := rfl
        -- 第 2 段。有限和の定義。
    _ = ∑ τ' : RowConfig L, ∑ i ∈ s, A τ τ' * v i τ' :=
        sum_congr rfl fun τ' _ => mul_sum _ _ _
        -- 第 3 段。元と有限和の積についての分配則。
    _ = ∑ i ∈ s, ∑ τ' : RowConfig L, A τ τ' * v i τ' := sum_comm
        -- 第 4 段。有限和の順序の入れ替え。
    _ = ∑ i ∈ s, qbarAction L A (v i) τ := rfl
        -- 第 5 段。作用の定義。
    _ = qbarVectorSum L s (fun i => qbarAction L A (v i)) τ := rfl
        -- 第 6 段。有限和の定義。

end Ising2DLambda.AlgebraicEigenvalue
