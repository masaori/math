/-
章「固有値の代数性」の「スカラー倍は列ベクトルの有限和を保つ」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_smul_sum`）に対応する。

  人手証明                                    このファイル
  鎖の第 1 段（スカラー倍の定義）             qbarVectorSmul の展開（rfl）
  鎖の第 2 段（有限和の定義）                 qbarVectorSum の展開（rfl）
  鎖の第 3 段（元と有限和の積の分配則）       Finset.mul_sum
  鎖の第 4・5 段（定義へ戻す）                rfl

mathlib の `Finset.smul_sum` のような一般論へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Ising2DLambda.AlgebraicEigenvalue.QbarActionSum
import Ising2DLambda.AlgebraicEigenvalue.QbarActionLinear

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 人手証明の本体。`z ⊙ (⊕_{i∈s} v i) = ⊕_{i∈s} (z ⊙ v i)`（`claim_qbar_smul_sum`）。 -/
theorem qbarSmul_sum {ι : Type*} (L : ℕ) [NeZero L]
    (z : Qbar) (s : Finset ι) (v : ι → QbarRowVector L) :
    qbarVectorSmul L z (qbarVectorSum L s v)
      = qbarVectorSum L s (fun i => qbarVectorSmul L z (v i)) := by
  funext τ
  calc qbarVectorSmul L z (qbarVectorSum L s v) τ
      = z * (qbarVectorSum L s v) τ := rfl
        -- 第 1 段。スカラー倍の定義。
    _ = z * ∑ i ∈ s, v i τ := rfl
        -- 第 2 段。有限和の定義。
    _ = ∑ i ∈ s, z * v i τ := mul_sum _ _ _
        -- 第 3 段。元と有限和の積についての分配則。
    _ = ∑ i ∈ s, qbarVectorSmul L z (v i) τ := rfl
        -- 第 4 段。スカラー倍の定義。
    _ = qbarVectorSum L s (fun i => qbarVectorSmul L z (v i)) τ := rfl
        -- 第 5 段。有限和の定義。

end Ising2DLambda.AlgebraicEigenvalue
