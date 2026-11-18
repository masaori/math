import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldStepChoice

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

private structure OrderedStage where
  field : Subfield Qbar
  cone : Set Qbar
  isCone : IsSubfieldPositiveCone field cone

private noncomputable def nextStage (p : OrderedStage) (x : Qbar) : OrderedStage :=
  Classical.choose (show ∃ q : OrderedStage,
    ExtendsPositiveCone p.field q.field p.cone q.cone ∧
    ((∃ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone p.field E p.cone D ∧ x ∈ E) → x ∈ q.field) from by
      obtain ⟨E, D, hExt, hCapture⟩ :=
        enumeratedOrderedSubfield_stepChoice p.field p.cone p.isCone x
      exact ⟨⟨E, D, hExt.cone_E⟩, hExt, hCapture⟩)

private theorem nextStage_spec (p : OrderedStage) (x : Qbar) :
    ExtendsPositiveCone p.field (nextStage p x).field p.cone (nextStage p x).cone ∧
    ((∃ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone p.field E p.cone D ∧ x ∈ E) →
      x ∈ (nextStage p x).field) := by
  exact Classical.choose_spec (show ∃ q : OrderedStage,
    ExtendsPositiveCone p.field q.field p.cone q.cone ∧
    ((∃ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone p.field E p.cone D ∧ x ∈ E) → x ∈ q.field) from by
      obtain ⟨E, D, hExt, hCapture⟩ :=
        enumeratedOrderedSubfield_stepChoice p.field p.cone p.isCone x
      exact ⟨⟨E, D, hExt.cone_E⟩, hExt, hCapture⟩)

/-- 一段の選択を自然数で反復する具体版。 -/
theorem enumeratedOrderedSubfield_chain
    (F₀ : Subfield Qbar) (C₀ : Set Qbar)
    (hC₀ : IsSubfieldPositiveCone F₀ C₀) (ξ : ℕ → Qbar) :
    ∃ (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar),
      F 0 = F₀ ∧ C 0 = C₀ ∧
      (∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1))) ∧
      (∀ n (E : Subfield Qbar) (D : Set Qbar),
        ExtendsPositiveCone (F n) E (C n) D → ξ n ∈ E → ξ n ∈ F (n + 1)) := by
  let p : ℕ → OrderedStage := Nat.rec ⟨F₀, C₀, hC₀⟩
    (fun n q => nextStage q (ξ n))
  refine ⟨(fun n => (p n).field), (fun n => (p n).cone), rfl, rfl, ?_, ?_⟩
  · intro n
    change ExtendsPositiveCone (p n).field (nextStage (p n) (ξ n)).field
      (p n).cone (nextStage (p n) (ξ n)).cone
    exact (nextStage_spec (p n) (ξ n)).1
  · intro n E D hExt hx
    change ξ n ∈ (nextStage (p n) (ξ n)).field
    exact (nextStage_spec (p n) (ξ n)).2 ⟨E, D, hExt, hx⟩

end Ising2DLambda.FisherZero
