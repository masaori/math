/-
人手証明の主張「負の単位元を含まない前錐とその符号反転の共通部分は零元だけである」
（ラベル `claim_precone_avoiding_minus_one_meets_negation_at_zero`）と、
「負の単位元を含まず符号の両側を覆う前錐から零元を除くと、もとの正錐を延長する正錐になる」
（ラベル `claim_covering_precone_gives_positive_cone_extension`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldPrecone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_precone_avoiding_minus_one_meets_negation_at_zero` の具体版。
本文の段（`0 = 0·0` の所属、`-1` の三行の書き直し、右辺の各項の所属）の順に示す。 -/
theorem precone_zero_mem_and_eq_zero_of_mem_neg (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) :
    (0 : Qbar) ∈ T ∧ ∀ z : Qbar, z ∈ T → -z ∈ T → z = 0 := by
  refine ⟨?_, ?_⟩
  · -- 0 = 0·0 ∈ T
    have h := hT.sq_mem 0 E.zero_mem
    rw [mul_zero] at h
    exact h
  · intro z hz hnz
    by_contra hz0
    have hzE : z ∈ E := hT.subset z hz
    have hinvE : z⁻¹ ∈ E := E.inv_mem hzE
    have hzz : z * z⁻¹ = 1 := mul_inv_cancel₀ hz0
    -- -1 の書き直し（本文の三行）
    have key : (-1 : Qbar) = ((-z) * z) * (z⁻¹ * z⁻¹) := by
      calc (-1 : Qbar) = -(1 * 1) := by ring
        _ = -((z * z⁻¹) * (z * z⁻¹)) := by rw [hzz]
        _ = ((-z) * z) * (z⁻¹ * z⁻¹) := by ring
    -- 右辺の各項の所属
    have h1 : (-z) * z ∈ T := hT.mul_mem _ _ hnz hz
    have h2 : z⁻¹ * z⁻¹ ∈ T := hT.sq_mem _ hinvE
    have h3 : ((-z) * z) * (z⁻¹ * z⁻¹) ∈ T := hT.mul_mem _ _ h1 h2
    rw [← key] at h3
    exact hneg h3

/-- 本文の集合 `C_E = {z | z ∈ T かつ z ≠ 0}`。 -/
def preconeNonzeroPart (T : Set Qbar) : Set Qbar := {z | z ∈ T ∧ z ≠ 0}

/-- `claim_covering_precone_gives_positive_cone_extension` の具体版。本文の段
（`C_E ⊆ E`、和、積、三分法、延長の等号）の順に示す。 -/
theorem coveringPrecone_extendsPositiveCone (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T)
    (hcov : ∀ z : Qbar, z ∈ E → z ∈ T ∨ -z ∈ T) :
    ExtendsPositiveCone F E CF (preconeNonzeroPart T) := by
  obtain ⟨_, hzero⟩ := precone_zero_mem_and_eq_zero_of_mem_neg F E CF T hT hneg
  have hcone : IsSubfieldPositiveCone E (preconeNonzeroPart T) := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · -- C_E ⊆ E
      rintro z ⟨hz, _⟩
      exact hT.subset z hz
    · -- 和で閉じること
      rintro a b ⟨ha, ha0⟩ ⟨hb, hb0⟩
      refine ⟨hT.add_mem a b ha hb, ?_⟩
      intro hab
      have hna : -a = b := by
        calc -a = -a + 0 := by ring
          _ = -a + (a + b) := by rw [hab]
          _ = b := by ring
      have hnaT : -a ∈ T := by rw [hna]; exact hb
      exact ha0 (hzero a ha hnaT)
    · -- 積で閉じること
      rintro a b ⟨ha, ha0⟩ ⟨hb, hb0⟩
      refine ⟨hT.mul_mem a b ha hb, ?_⟩
      intro hab
      have hb' : b = 0 := by
        calc b = (a⁻¹ * a) * b := by rw [inv_mul_cancel₀ ha0, one_mul]
          _ = a⁻¹ * (a * b) := by rw [mul_assoc]
          _ = a⁻¹ * 0 := by rw [hab]
          _ = 0 := by rw [mul_zero]
      exact hb0 hb'
    · -- 三分法
      intro z hzE
      refine ⟨?_, ?_, ?_, ?_⟩
      · by_cases hz0 : z = 0
        · exact Or.inl hz0
        · have hnz0 : -z ≠ 0 := neg_ne_zero.mpr hz0
          rcases hcov z hzE with h | h
          · exact Or.inr (Or.inl ⟨h, hz0⟩)
          · exact Or.inr (Or.inr ⟨h, hnz0⟩)
      · rintro ⟨hz0, _, hne⟩
        exact hne hz0
      · rintro ⟨hz0, _, hne⟩
        rw [hz0, neg_zero] at hne
        exact hne rfl
      · rintro ⟨⟨hz, hz0⟩, ⟨hnz, _⟩⟩
        exact hz0 (hzero z hz hnz)
  refine ⟨hT.subfield_le, hT.cone_F, hcone, ?_⟩
  -- 延長の等号 C_E ∩ F = C_F
  intro z
  constructor
  · rintro ⟨⟨hz, hz0⟩, hzF⟩
    rcases (hT.cone_F.trichotomy z hzF).1 with h | h | h
    · exact absurd h hz0
    · exact h
    · exact absurd (hzero z hz (hT.cone_subset _ h)) hz0
  · intro hz
    have hzF : z ∈ F := hT.cone_F.subset z hz
    have hz0 : z ≠ 0 := fun h0 => (hT.cone_F.trichotomy z hzF).2.1 ⟨h0, hz⟩
    exact ⟨⟨hT.cone_subset z hz, hz0⟩, hzF⟩

end Ising2DLambda.FisherZero
