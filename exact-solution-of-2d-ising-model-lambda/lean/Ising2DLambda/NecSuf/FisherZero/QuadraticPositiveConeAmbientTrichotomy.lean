import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- 部分集合上で示した三分法を、包含先の集合上へ移す。必要なのは包含と符号反転の保存だけ。 -/
theorem positiveCone_ambient_trichotomy
    {K : Type} [Zero K] [Neg K] (F : Set K) (P : Set {z : K // z ∈ F})
    (negLift : ∀ _ : {z : K // z ∈ F}, {z : K // z ∈ F})
    (hneg : ∀ z, ((negLift z : {z : K // z ∈ F}) : K) = -(z : K))
    (htri : ∀ z : {z : K // z ∈ F},
      ((z : K) = 0 ∨ z ∈ P ∨ negLift z ∈ P) ∧
      ¬ (z ∈ P ∧ (z : K) = 0) ∧
      ¬ ((z : K) = 0 ∧ negLift z ∈ P) ∧
      ¬ (z ∈ P ∧ negLift z ∈ P))
    (z : K) (hz : z ∈ F) :
    ((z = 0 ∨ (∃ h : z ∈ F, (⟨z, h⟩ : {z : K // z ∈ F}) ∈ P) ∨
      (∃ h : -z ∈ F, (⟨-z, h⟩ : {z : K // z ∈ F}) ∈ P)) ∧
      ¬ (z = 0 ∧ (∃ h : z ∈ F, (⟨z, h⟩ : {z : K // z ∈ F}) ∈ P)) ∧
      ¬ (z = 0 ∧ (∃ h : -z ∈ F, (⟨-z, h⟩ : {z : K // z ∈ F}) ∈ P)) ∧
      ¬ ((∃ h : z ∈ F, (⟨z, h⟩ : {z : K // z ∈ F}) ∈ P) ∧
        (∃ h : -z ∈ F, (⟨-z, h⟩ : {z : K // z ∈ F}) ∈ P))) := by
  let x : {z : K // z ∈ F} := ⟨z, hz⟩
  have hp : (∃ h : z ∈ F, (⟨z, h⟩ : {z : K // z ∈ F}) ∈ P) ↔ x ∈ P := by
    constructor
    · rintro ⟨h, hP⟩
      have heq : (⟨z, h⟩ : {z : K // z ∈ F}) = x := Subtype.ext rfl
      simpa [heq] using hP
    · intro hP
      exact ⟨hz, hP⟩
  have hn : (∃ h : -z ∈ F, (⟨-z, h⟩ : {z : K // z ∈ F}) ∈ P) ↔
      negLift x ∈ P := by
    constructor
    · rintro ⟨h, hP⟩
      have heq : (⟨-z, h⟩ : {z : K // z ∈ F}) = negLift x := by
        apply Subtype.ext
        exact (hneg x).symm
      simpa [heq] using hP
    · intro hP
      have hmem : -z ∈ F := by
        rw [← hneg x]
        exact (negLift x).property
      exact ⟨hmem, by
        have heq : (⟨-z, hmem⟩ : {z : K // z ∈ F}) =
            negLift x := Subtype.ext (hneg x).symm
        simpa [heq] using hP⟩
  rcases htri x with ⟨hsome, hzeroPos, hzeroNeg, hposNeg⟩
  constructor
  · rcases hsome with hzero | hpos | hnegP
    · exact Or.inl hzero
    · exact Or.inr (Or.inl (hp.mpr hpos))
    · exact Or.inr (Or.inr (hn.mpr hnegP))
  constructor
  · rintro ⟨hzero, hpos⟩
    exact hzeroPos ⟨hp.mp hpos, hzero⟩
  constructor
  · rintro ⟨hzero, hnegP⟩
    exact hzeroNeg ⟨hzero, hn.mp hnegP⟩
  · rintro ⟨hpos, hnegP⟩
    exact hposNeg ⟨hp.mp hpos, hn.mp hnegP⟩

end Ising2DLambda.NecSuf.FisherZero
