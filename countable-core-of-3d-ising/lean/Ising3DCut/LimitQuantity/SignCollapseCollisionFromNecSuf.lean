/-
「符号への潰しは値の衝突を持つ」を必要十分版の特殊化として導く。
-/
import Ising3DCut.LimitQuantity.SignCollapseCollision
import Ising3DCut.NecSuf.SignCollapseCollision

namespace Ising3DCut.LimitQuantity

/-- 必要十分版から導いた「符号への潰しは値の衝突を持つ」。 -/
theorem sign_collapse_has_a_value_collision_fromNecSuf :
    ∃ u w : ℚ, 0 < u ∧ 0 < w ∧ u ≠ w ∧
      ∀ p : ℕ, p.Prime → signCollapse u p = signCollapse w p := by
  have hcollapse : intSign (padicValRat 2 ((2 ^ 1 : ℕ) : ℚ)) =
      intSign (padicValRat 2 ((2 ^ 2 : ℕ) : ℚ)) := by
    rw [padicValRat_two_pow 1, padicValRat_two_pow 2]
    rw [intSign_of_pos (by norm_num), intSign_of_pos (by norm_num)]
  have hagree : ∀ p : {p : ℕ // Nat.Prime p}, p ≠ ⟨2, Nat.prime_two⟩ →
      padicValRat (p : ℕ) ((2 ^ 1 : ℕ) : ℚ) =
        padicValRat (p : ℕ) ((2 ^ 2 : ℕ) : ℚ) := by
    intro p hp
    have hp2 : (p : ℕ) ≠ 2 := fun h => hp (Subtype.ext h)
    rw [padicValRat_ne_two_pow (p : ℕ) 1 p.2 hp2,
      padicValRat_ne_two_pow (p : ℕ) 2 p.2 hp2]
  obtain ⟨u, w, hu, hw, hne, heq⟩ :=
    Ising3DCut.NecSuf.coordinatewise_map_has_a_value_collision
      (fun p : {p : ℕ // Nat.Prime p} => fun a : ℚ => padicValRat (p : ℕ) a)
      intSign (fun a : ℚ => 0 < a) ⟨2, Nat.prime_two⟩
      (((2 ^ 1 : ℕ) : ℚ)) (((2 ^ 2 : ℕ) : ℚ))
      (by norm_num) (by norm_num) (by norm_num) hcollapse hagree
  refine ⟨u, w, hu, hw, hne, ?_⟩
  intro p hp
  exact congrFun heq ⟨p, hp⟩

end Ising3DCut.LimitQuantity
