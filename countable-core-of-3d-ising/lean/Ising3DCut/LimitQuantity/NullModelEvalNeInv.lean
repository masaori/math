/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・$Z_L(q)\neq Z_L(1/q)$ の零モデル版。

$L\ge2$ なら箱に辺が少なくとも 1 本あり（$\#E_L\ge1$）、
`two_le_multiplicity_full` により $\Omega(\#E_L)\ge2\neq0$ である。
これを `eval_polyOfMultiplicity_ne_eval_inv` に渡し、$q>0$・$q\neq1$ の下で
零モデルの重複度多項式について $P(q)\neq P(1/q)$ を得る。
-/
import Ising3DCut.LimitQuantity.PolyOfMultiplicityEvalNeInv
import Ising3DCut.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.LimitQuantity

open Polynomial NullModel

/-- $L\ge2$ の箱には辺が少なくとも 1 本ある（原点から第 0 軸方向の辺）。 -/
lemma one_le_card_edge {L : ℕ} (hL : 2 ≤ L) : 1 ≤ Fintype.card (Edge L) := by
  have e : Edge L := ⟨zeroSite (by omega), 0, by simp [zeroSite]; omega⟩
  exact Fintype.card_pos_iff.mpr ⟨e⟩

/-- 零モデル：$L\ge2$、$q>0$、$q\neq1$ なら $P(q)\neq P(1/q)$。 -/
theorem nullModel_eval_polyOfMultiplicity_ne_eval_inv {L : ℕ} (hL : 2 ≤ L)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1) :
    (polyOfMultiplicity (Fintype.card (Edge L)) (multiplicity L)).eval q ≠
      (polyOfMultiplicity (Fintype.card (Edge L)) (multiplicity L)).eval (1 / q) :=
  eval_polyOfMultiplicity_ne_eval_inv (one_le_card_edge hL)
    (by have := two_le_multiplicity_full (L := L) (by omega); omega) hq hq1

end Ising3DCut.LimitQuantity
