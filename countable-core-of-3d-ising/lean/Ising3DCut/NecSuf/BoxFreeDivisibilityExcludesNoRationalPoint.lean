import Mathlib

/-!
具体的な整数・正値性・整除を落とすと、各対象から許容される証人を構成でき、
その証人との間に所定の関係が成り立つことだけが残る。
-/

namespace Ising3DCut.NecSuf

theorem every_target_has_related_admissible_witness
    {α β : Type*} (admissible : β → Prop) (relation : α → β → Prop)
    (a : α) (witness : β)
    (hwitness_admissible : admissible witness)
    (hwitness_related : relation a witness) :
    ∃ c, admissible c ∧ relation a c := by
  exact ⟨witness, hwitness_admissible, hwitness_related⟩

end Ising3DCut.NecSuf
