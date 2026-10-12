/-
必要十分版の二写像へ置換と逆置換を渡し、両側逆の法則を供給する導出版。
隣接点の選択・対の族・完全マッチングの述語は定義を展開すると一致する。
独立具体版の色反転・対合・マッチングの証明は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.AlternatingNeighborMatchings
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.AlternatingNeighborMatchings

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 置換と逆置換の両側逆の法則により、必要十分版の全入力を満たす。 -/
theorem alternatingNeighbor_matchings_from_necSuf (σ : Equiv.Perm J) (C : Set J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∉ C) :
    IsPerfectMatching (alternatingNeighborPairs σ C) ∧
      IsPerfectMatching (alternatingNeighborPairs σ.symm C) := by
  exact NecSuf.AlgebraicEigenvalue.alternatingNeighbor_matchings
    σ σ.symm σ.symm_apply_apply σ.apply_symm_apply C h

end Ising2DLambda.AlgebraicEigenvalue
