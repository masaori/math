import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldChain
import Ising2DLambda.FisherZero.IncreasingPositiveConeUnionRestriction
import Ising2DLambda.FisherZero.QuadraticPositiveConeSubfieldPositiveCone
import Ising2DLambda.AlgebraicEigenvalue.AlgebraicNumbersEnumeration

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 二次体の正錐から列挙に沿って延長し、極大な組を得る具体版。 -/
theorem enumeratedOrderedSubfield_isMaximal
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ (R : Subfield Qbar) (C : Set Qbar),
      ExtendsPositiveCone (quadraticFieldSubfield s hs) R
        (quadraticPositiveConeAmbient s) C ∧
      ∀ (E : Subfield Qbar) (D : Set Qbar),
        ExtendsPositiveCone R E C D → E = R := by
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  let F₀ := quadraticFieldSubfield s hs
  let C₀ := quadraticPositiveConeAmbient s
  have hC₀ : IsSubfieldPositiveCone F₀ C₀ :=
    quadraticPositiveCone_isSubfieldPositiveCone s hs
  obtain ⟨F, C, hF₀, hC₀', hstep, hcapture⟩ :=
    enumeratedOrderedSubfield_chain F₀ C₀ hC₀ ξ
  let hmono : Monotone F :=
    monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)
  let R := increasingSubfieldUnion F hmono
  let CR : Set Qbar := {z | ∃ n, z ∈ C n}
  have hCR : IsSubfieldPositiveCone R CR :=
    increasingPositiveConeUnion_isPositiveCone F C hstep
  have hbase : ExtendsPositiveCone F₀ R C₀ CR := by
    refine ⟨?_, hC₀, hCR, ?_⟩
    · intro z hz
      exact ⟨0, hF₀.symm ▸ hz⟩
    · intro z
      simpa only [CR, Set.mem_setOf_eq, hF₀, hC₀'] using
        (increasingPositiveConeUnion_restrictsToStage F C hstep 0 z)
  refine ⟨R, CR, hbase, ?_⟩
  intro E D hED
  exact enumeratedOrderedSubfield_maximalityCriterion ξ hξ F C hstep
    (increasingPositiveConeUnion_restrictsToStage F C hstep)
    hcapture E D hED

end Ising2DLambda.FisherZero
