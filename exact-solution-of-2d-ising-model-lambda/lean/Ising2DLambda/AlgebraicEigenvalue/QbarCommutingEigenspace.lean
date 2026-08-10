/-
章「固有値の代数性」の「可換な行列は固有空間を保つ」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_commuting_preserves_eigenspace`）に対応する。

  人手証明                                  このファイル
  鎖の第 1 段（作用の積を右辺から左辺へ）   qbarAction_product の .symm
  鎖の第 2 段（仮定 AB = BA）               仮定 hcomm の書き換え
  鎖の第 3 段（作用の積）                   qbarAction_product
  鎖の第 4 段（固有空間の条件）             仮定 hv の書き換え
  鎖の第 5 段（作用がスカラー倍を保つ）     qbarAction_smul

mathlib の固有空間の一般論（`Module.End.eigenspace` と可換な自己準同型の理論）へは
委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の本体。`AB = BA` ならば `B` の作用は `A` の固有空間を保つ
（`claim_qbar_commuting_preserves_eigenspace`）。 -/
theorem qbarCommuting_preserves_eigenspace
    (A B : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (hcomm : qbarRowMatrixProduct L A B = qbarRowMatrixProduct L B A)
    (hv : v ∈ qbarEigenspace L A z) :
    qbarAction L B v ∈ qbarEigenspace L A z := by
  simp only [qbarEigenspace, Set.mem_setOf_eq] at hv ⊢
  have hv' : qbarAction L A v = qbarVectorSmul L z v := hv
  calc qbarAction L A (qbarAction L B v)
      = qbarAction L (qbarRowMatrixProduct L A B) v :=
        -- 第 1 段。作用の積（右辺から左辺へ）。
        (qbarAction_product L A B v).symm
    _ = qbarAction L (qbarRowMatrixProduct L B A) v := by
        -- 第 2 段。仮定 AB = BA。
        rw [hcomm]
    _ = qbarAction L B (qbarAction L A v) :=
        -- 第 3 段。作用の積。
        qbarAction_product L B A v
    _ = qbarAction L B (qbarVectorSmul L z v) := by
        -- 第 4 段。固有空間の条件（v ∈ E_A(z)）。
        rw [hv']
    _ = qbarVectorSmul L z (qbarAction L B v) :=
        -- 第 5 段。作用がスカラー倍を保つこと。
        qbarAction_smul L B z v

end Ising2DLambda.AlgebraicEigenvalue
