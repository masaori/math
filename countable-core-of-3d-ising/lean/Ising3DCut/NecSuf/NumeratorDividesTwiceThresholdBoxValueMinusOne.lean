import Mathlib

/-!
具体的な自然数・冪・有限等比和・整除を落とすと、関係を保つ写像、関係の推移、
および最後の対象の等号だけが残る。
-/

namespace Ising3DCut.NecSuf

theorem relation_of_relation_preserving_map_and_target_equality
    {α : Type*} (relation : α → α → Prop) (map : α → α)
    (source base reached target : α)
    (hsource : relation source (map base))
    (hstep : relation base reached)
    (hmap : ∀ x y, relation x y → relation (map x) (map y))
    (htrans : ∀ x y z, relation x y → relation y z → relation x z)
    (htarget : map reached = target) :
    relation source target := by
  have hmapped : relation (map base) (map reached) := hmap base reached hstep
  have hreached : relation source (map reached) :=
    htrans source (map base) (map reached) hsource hmapped
  exact htarget ▸ hreached

end Ising3DCut.NecSuf
