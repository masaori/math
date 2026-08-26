import Mathlib

/-!
具体的な整数・冪・最大公約数を落とすと、ある関係が中間値について成り立つことと、
その中間値を三段で目標値へ書き換えられることだけが残る。
-/

namespace Ising3DCut.NecSuf

theorem relation_of_relation_and_three_equalities
    {α β : Type*} (relation : α → β → Prop) (a : α)
    (combined scaled reached target : β)
    (hcombined : relation a combined)
    (hscale : combined = scaled)
    (hreached : scaled = reached)
    (htarget : reached = target) :
    relation a target := by
  have hscaled : relation a scaled := hscale ▸ hcombined
  have hreached' : relation a reached := hreached ▸ hscaled
  exact htarget ▸ hreached'

end Ising3DCut.NecSuf
