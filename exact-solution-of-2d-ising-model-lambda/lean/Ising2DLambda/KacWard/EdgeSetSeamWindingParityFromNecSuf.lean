/-
「辺部分集合の横（縦）切断線の偶奇は巻き付き偶奇に等しい」の具体版を、
必要十分版 `line_indicator_sum_eq_line_count` の特殊化として得る導出版。
横は辺番号の分解 `edgeEquiv` をそのまま、縦は二種類の辺と行・列の座標を入れ替えた分解を使う。
-/
import Ising2DLambda.KacWard.EdgeSetSeamWindingParity
import Ising2DLambda.NecSuf.KacWard.EdgeSetSeamWindingParity

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero

variable {L : ℕ} [NeZero L]

theorem edgeSetHorizontalSeamParity_eq_windingParity_from_necSuf (A : Finset (Edge L)) :
    (edgeSetSeamParities A).1 = (horizontalWindingParity L A : ℕ) := by
  have h := Ising2DLambda.NecSuf.KacWard.line_indicator_sum_eq_line_count (edgeEquiv L) (-1)
    (fun e => horizontalSeamParity ((e, false) : OrientedEdge L))
    (fun i j => by
      have hbound : (edgeOfRow L false i j).val < L ^ 2 := by
        simpa [edgeOfRow] using rowColumnIndex_lt L i j
      simp only [edgeEquiv_inl, horizontalSeamParity, hbound, true_and, edgeColumn_edgeOfRow,
        residueVal_eq_pred_iff])
    (fun k => by
      rcases k with ⟨r, c⟩
      have ht : ¬ (edgeOfRow L true r c).val < L ^ 2 := by simp [edgeOfRow]
      simp [horizontalSeamParity, ht]) A
  simp only [edgeEquiv_inl] at h
  show (∑ e ∈ A, horizontalSeamParity ((e, false) : OrientedEdge L)) % 2 = _
  rw [h, horizontalWindingParity, finTwo_indicatorSum_val]
  -- 両辺の指示子の決定可能性の証拠だけが異なる
  congr

/-- 縦の辺を一種類目に置き、座標を（列, 行）の順にした辺番号の分解。 -/
noncomputable def verticalFirstEdgeEquiv (L : ℕ) [NeZero L] :
    ((ZMod L × ZMod L) ⊕ (ZMod L × ZMod L)) ≃ Edge L :=
  ((Equiv.sumCongr (Equiv.prodComm _ _) (Equiv.refl _)).trans (Equiv.sumComm _ _)).trans
    (edgeEquiv L)

@[simp] theorem verticalFirstEdgeEquiv_inl (j i : ZMod L) :
    verticalFirstEdgeEquiv L (Sum.inl (j, i)) = edgeOfRow L true i j := rfl

@[simp] theorem verticalFirstEdgeEquiv_inr (i j : ZMod L) :
    verticalFirstEdgeEquiv L (Sum.inr (i, j)) = edgeOfRow L false i j := rfl

theorem edgeSetVerticalSeamParity_eq_windingParity_from_necSuf (A : Finset (Edge L)) :
    (edgeSetSeamParities A).2 = (verticalWindingParity L A : ℕ) := by
  have h := Ising2DLambda.NecSuf.KacWard.line_indicator_sum_eq_line_count
    (verticalFirstEdgeEquiv L) (-1)
    (fun e => verticalSeamParity ((e, false) : OrientedEdge L))
    (fun j i => by
      have ht : ¬ (edgeOfRow L true i j).val < L ^ 2 := by simp [edgeOfRow]
      simp only [verticalFirstEdgeEquiv_inl, verticalSeamParity, ht, not_false_eq_true, true_and,
        edgeRow_edgeOfRow, residueVal_eq_pred_iff])
    (fun k => by
      rcases k with ⟨r, c⟩
      have hf : (edgeOfRow L false r c).val < L ^ 2 := by
        simpa [edgeOfRow] using rowColumnIndex_lt L r c
      simp [verticalSeamParity, hf]) A
  simp only [verticalFirstEdgeEquiv_inl] at h
  show (∑ e ∈ A, verticalSeamParity ((e, false) : OrientedEdge L)) % 2 = _
  rw [h, verticalWindingParity, finTwo_indicatorSum_val]
  -- 両辺の指示子の決定可能性の証拠だけが異なる
  congr

end Ising2DLambda.KacWard
