import Ising2DLambda.FisherZero.IncreasingPositiveConeUnionRestriction
import Ising2DLambda.NecSuf.FisherZero.IncreasingPositiveConeUnionRestriction

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を部分体の台と正錐に特殊化した導出版。 -/
theorem increasingPositiveConeUnion_restrictsToStage_from_necSuf
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1)))
    (n : ℕ) (z : Qbar) :
    (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ F n) ↔ z ∈ C n := by
  exact Ising2DLambda.NecSuf.FisherZero.increasingPositiveConeUnion_restrictsToStage
    (fun j => (F j : Set Qbar)) C
    (fun j => (hstep j).subfield_le)
    (fun j => (hstep j).cone_F.subset)
    (fun j x => (hstep j).inter_eq x) n z

end Ising2DLambda.FisherZero
