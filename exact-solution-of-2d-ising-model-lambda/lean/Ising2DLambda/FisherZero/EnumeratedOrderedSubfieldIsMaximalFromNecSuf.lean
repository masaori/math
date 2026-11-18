import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldIsMaximal
import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldIsMaximal
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の集合論的な極大性を二次体の正錐へ特殊化する。 -/
theorem enumeratedOrderedSubfield_isMaximal_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ (R : Subfield Qbar) (C : Set Qbar),
      ExtendsPositiveCone (quadraticFieldSubfield s hs) R
        (quadraticPositiveConeAmbient s) C ∧
      ∀ (E : Subfield Qbar) (D : Set Qbar),
        ExtendsPositiveCone R E C D → E = R := by
  let F₀ := quadraticFieldSubfield s hs
  let C₀ := quadraticPositiveConeAmbient s
  have hC₀ : IsSubfieldPositiveCone F₀ C₀ :=
    quadraticPositiveCone_isSubfieldPositiveCone s hs
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  obtain ⟨F, C, hF₀, hC₀', hstep', hbase', hmax⟩ :=
    Ising2DLambda.NecSuf.FisherZero.enumeratedOrderedSubfield_isMaximal
      (fun E : Subfield Qbar => (E : Set Qbar)) F₀ C₀
      ((isSubfieldPositiveCone_iff_from_necSuf F₀ C₀).1 hC₀) ξ hξ
  have hstep : ∀ n,
      ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1)) := by
    intro n
    exact (extendsPositiveCone_iff_from_necSuf
      (F n) (F (n + 1)) (C n) (C (n + 1))).2 (hstep' n)
  let R := increasingSubfieldUnion F
    (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le))
  let CR : Set Qbar := {z | ∃ n, z ∈ C n}
  have hbase : ExtendsPositiveCone F₀ R C₀ CR :=
    (extendsPositiveCone_iff_from_necSuf F₀ R C₀ CR).2 hbase'
  refine ⟨R, CR, hbase, ?_⟩
  intro E D hED
  have hED' := (extendsPositiveCone_iff_from_necSuf R E CR D).1 hED
  have hset := hmax E D hED'
  apply Subfield.ext
  intro z
  change (z ∈ (E : Set Qbar)) ↔ (∃ n, z ∈ F n)
  exact Set.ext_iff.mp hset z

end Ising2DLambda.FisherZero
