/-
具体版が必要十分版の特殊化として得られることを明示する。

必要十分版 `Ising2DLambda.NecSuf.TransferMatrix.card_filter_eq_sum_add_sum` の
仮定へ、この模型の対象を入れる。

  必要十分版の仮定            ここで入れるもの
  `ι`（数える対象）           `Edge L`（辺の番号の集合）
  `α`（行の添字）             `ZMod L`（行番号）
  `β`（列の添字）             `ZMod L`（列番号）
  `p`（数える述語）           「その辺が σ のもとで破れている」
  `(α × β) ⊕ (α × β) ≃ ι`     `edgeEquiv`（人手証明の `claim_edge_row_partition`）

特殊化した結果を、人手証明の右辺（行内破れ数と行間破れ数の和）へ直すために使うのは
端点の計算（`edgeOfRow_boundary0` と 2 つの `edgeOfRow_boundary1_*`）だけである。
これは人手証明の Step 4・Step 5 の後半にあたる。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.Basic
import Ising2DLambda.NecSuf.TransferMatrix.RowDecomposition

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 具体版と同じ主張を、必要十分版の特殊化として導く。 -/
theorem brokenBondCount_eq_row_decomposition_from_necSuf (σ : Config L) :
    brokenBondCount L σ
      = (∑ i : ZMod L, intraRowBrokenCount L (rowRestriction L σ i))
        + ∑ i : ZMod L, interRowBrokenCount L (rowRestriction L σ i)
            (rowRestriction L σ (i + 1)) := by
  -- 必要十分版を、この模型の辺・行番号・列番号・破れの述語へ特殊化する。
  rw [brokenBondCount,
    NecSuf.TransferMatrix.card_filter_eq_sum_add_sum (edgeEquiv L)
      fun e => σ (boundary0 L e) ≠ σ (boundary1 L e)]
  -- Step 4・Step 5 の後半。端点を行配位への制限で書き直す。
  congr 1
  · refine sum_congr rfl fun i _ => ?_
    rw [intraRowBrokenCount]
    refine congrArg Finset.card (filter_congr fun j _ => ?_)
    rw [edgeEquiv_inl, edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal]
    rfl
  · refine sum_congr rfl fun i _ => ?_
    rw [interRowBrokenCount]
    refine congrArg Finset.card (filter_congr fun j _ => ?_)
    rw [edgeEquiv_inr, edgeOfRow_boundary0, edgeOfRow_boundary1_vertical]
    rfl

end Ising2DLambda.TransferMatrix
