/-
章「固有値の代数性」の「列ベクトルを固有空間へ落とす写像」と、
「落とす写像への行列の作用は冪の指数を 1 つ進める」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_qbar_projector`）と主張 1 件（`claim_qbar_projector_action`）に対応する。

  人手証明                                        このファイル
  P_{A,z}(v) = ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^k·v)   qbarProjector
  鎖の第 1 段（落とす写像の定義）                 qbarProjector の展開（rfl）
  鎖の第 2 段（作用が有限和を保つこと）           qbarAction_sum
  鎖の第 3 段（作用がスカラー倍を保つこと）       qbarAction_smul
  鎖の第 4 段（作用が行列の積と両立すること）     qbarAction_product
  鎖の第 5 段（冪の一歩の式 A^{k+1} = A A^k）     qbarMatrixPow の展開（rfl）

mathlib の一般論（`Matrix.mulVec_sum` など）へは委ねず、人手証明の鎖をそのまま書く。

住処: 人手証明のこれらのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionSum
import Ising2DLambda.AlgebraicEigenvalue.QbarActionPow

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 列ベクトルを固有空間へ落とす写像 `P_{A,z}`（`def_qbar_projector`）。
`P_{A,z}(v) := ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^k · v)`。
添字は `Finset.range L = {0,1,…,L-1}`。指数 `L - k` は `k ≤ L-1` の範囲でしか使わないので、
自然数の引き算で人手証明の `L-k`（`1 ≤ L-k ≤ L`）と一致する。
`z⁻¹` を使わないので、`z` が零元でないことも逆元の存在も要らない。 -/
noncomputable def qbarProjector (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) : QbarRowVector L :=
  qbarVectorSum L (range L)
    (fun k => qbarVectorSmul L (z ^ (L - k)) (qbarAction L (qbarMatrixPow L A k) v))

/-- 人手証明の本体。`A · P_{A,z}(v) = ⊕_{k=0}^{L-1} z^{L-k} ⊙ (A^{k+1} · v)`
（`claim_qbar_projector_action`）。`A^L = I` も `z^L = 1` も仮定していない。 -/
theorem qbarProjector_action (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) :
    qbarAction L A (qbarProjector L A z v)
      = qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarMatrixPow L A (k + 1)) v)) := by
  calc qbarAction L A (qbarProjector L A z v)
      = qbarAction L A (qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarMatrixPow L A k) v))) := rfl
        -- 第 1 段。落とす写像の定義。
    _ = qbarVectorSum L (range L)
          (fun k => qbarAction L A (qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarMatrixPow L A k) v))) :=
        qbarAction_sum L A (range L) _
        -- 第 2 段。作用が有限和を保つこと。
    _ = qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L A (qbarAction L (qbarMatrixPow L A k) v))) :=
        congrArg (qbarVectorSum L (range L))
          (funext fun k => qbarAction_smul L A (z ^ (L - k)) _)
        -- 第 3 段。作用がスカラー倍を保つこと（有限和の各項へ同時に当てる）。
    _ = qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarRowMatrixProduct L A (qbarMatrixPow L A k)) v)) :=
        congrArg (qbarVectorSum L (range L))
          (funext fun k => congrArg (qbarVectorSmul L (z ^ (L - k)))
            (qbarAction_product L A (qbarMatrixPow L A k) v).symm)
        -- 第 4 段。作用が行列の積と両立すること（有限和の各項へ同時に当てる）。
    _ = qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarMatrixPow L A (k + 1)) v)) := rfl
        -- 第 5 段。冪の一歩の式 A^{k+1} = A A^k。

end Ising2DLambda.AlgebraicEigenvalue
