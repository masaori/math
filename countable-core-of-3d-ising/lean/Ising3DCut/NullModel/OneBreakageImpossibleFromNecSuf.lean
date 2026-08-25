/-
必要十分版を三次元箱へ特殊化し、具体版と同じ「破れ数は 1 でない」を導く。
-/
import Ising3DCut.NullModel.SquareAroundEdge
import Ising3DCut.NecSuf.NullModel.OneBreakageImpossible

namespace Ising3DCut.NullModel

/-- 必要十分版から得る、一辺が二以上の箱での破れ数一の不可能性。 -/
theorem brokenCount_ne_one_from_necSuf {L : ℕ} (hL : 2 ≤ L) (σ : Config L) :
    brokenCount σ ≠ 1 := by
  unfold brokenCount brokenSet
  apply Ising3DCut.NecSuf.NullModel.broken_count_ne_one_of_alternate_chain
    endpoint0 endpoint1 σ
  intro e
  obtain ⟨f₁, f₂, f₃, p, q, hf₁e, hf₂e, hf₃e, hc₁, hc₂, hc₃⟩ :=
    alternate_three_edges_exists hL e
  exact ⟨f₁, f₂, f₃, p, q, hf₁e, hf₂e, hf₃e, hc₁, hc₂, hc₃⟩

end Ising3DCut.NullModel
