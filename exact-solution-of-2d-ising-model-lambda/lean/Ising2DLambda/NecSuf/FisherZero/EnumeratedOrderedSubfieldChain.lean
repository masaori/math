import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldStepChoice

namespace Ising2DLambda.NecSuf.FisherZero

private structure OrderedStage {K T : Type} [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) where
  field : T
  cone : Set K
  isCone : IsPositiveConeOn (carrier field) cone

private noncomputable def nextStage {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (p : OrderedStage carrier) (x : K) : OrderedStage carrier :=
  Classical.choose (show ∃ q : OrderedStage carrier,
    ExtendsPositiveConeOn (carrier p.field) (carrier q.field) p.cone q.cone ∧
    ((∃ (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier p.field) (carrier E) p.cone D ∧
      x ∈ carrier E) → x ∈ carrier q.field) from by
      obtain ⟨E, D, hExt, hCapture⟩ :=
        enumeratedOrderedSubfield_stepChoice carrier p.field p.cone p.isCone x
      exact ⟨⟨E, D, hExt.cone_E⟩, hExt, hCapture⟩)

private theorem nextStage_spec {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (p : OrderedStage carrier) (x : K) :
    ExtendsPositiveConeOn (carrier p.field) (carrier (nextStage carrier p x).field)
      p.cone (nextStage carrier p x).cone ∧
    ((∃ (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier p.field) (carrier E) p.cone D ∧
      x ∈ carrier E) → x ∈ carrier (nextStage carrier p x).field) := by
  exact Classical.choose_spec (show ∃ q : OrderedStage carrier,
    ExtendsPositiveConeOn (carrier p.field) (carrier q.field) p.cone q.cone ∧
    ((∃ (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier p.field) (carrier E) p.cone D ∧
      x ∈ carrier E) → x ∈ carrier q.field) from by
      obtain ⟨E, D, hExt, hCapture⟩ :=
        enumeratedOrderedSubfield_stepChoice carrier p.field p.cone p.isCone x
      exact ⟨⟨E, D, hExt.cone_E⟩, hExt, hCapture⟩)

/-- 反復に要るのは各段の台、正錐の制限、一段の選択だけである。 -/
theorem enumeratedOrderedSubfield_chain {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (F₀ : T) (C₀ : Set K)
    (hC₀ : IsPositiveConeOn (carrier F₀) C₀) (ξ : ℕ → K) :
    ∃ (F : ℕ → T) (C : ℕ → Set K),
      F 0 = F₀ ∧ C 0 = C₀ ∧
      (∀ n, ExtendsPositiveConeOn (carrier (F n)) (carrier (F (n + 1)))
        (C n) (C (n + 1))) ∧
      (∀ n (E : T) (D : Set K),
        ExtendsPositiveConeOn (carrier (F n)) (carrier E) (C n) D →
        ξ n ∈ carrier E → ξ n ∈ carrier (F (n + 1))) := by
  let p : ℕ → OrderedStage carrier := Nat.rec ⟨F₀, C₀, hC₀⟩
    (fun n q => nextStage carrier q (ξ n))
  refine ⟨(fun n => (p n).field), (fun n => (p n).cone), rfl, rfl, ?_, ?_⟩
  · intro n
    change ExtendsPositiveConeOn (carrier (p n).field)
      (carrier (nextStage carrier (p n) (ξ n)).field)
      (p n).cone (nextStage carrier (p n) (ξ n)).cone
    exact (nextStage_spec carrier (p n) (ξ n)).1
  · intro n E D hExt hx
    change ξ n ∈ carrier (nextStage carrier (p n) (ξ n)).field
    exact (nextStage_spec carrier (p n) (ξ n)).2 ⟨E, D, hExt, hx⟩

end Ising2DLambda.NecSuf.FisherZero
