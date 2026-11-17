/-
「負の単位元を含まない前錐とその符号反転の共通部分は零元だけである」と
「負の単位元を含まず符号の両側を覆う前錐から零元を除くと、もとの正錐を延長する正錐になる」の必要十分版。

証明の手順は具体版と同じ。使う性質は次だけである。
- 台は体。`-1` の書き直し `-1 = ((-z)·z)·(z⁻¹·z⁻¹)` が乗法の交換則と零でない元の逆元を、
  積で閉じることの `a·b = 0 ⇒ b = 0` が逆元を使う。
- `E` は零元を含み（`0 ∈ T` に要る）、零でない元の逆元で閉じる（`z⁻¹·z⁻¹ ∈ T` に要る）。
  `E` が和・積・符号反転で閉じることは使わない。
- 前錐の条件は全て使う（`T ⊆ E` は逆元の所属に、和・積・平方・`CF ⊆ T` はそれぞれの段に）。
- `F ⊆ E` と `CF` が `F` の正錐であることは、延長の構造の成分としてそのまま渡す。
  `F` が部分体であることは使わない。
台の可算性・代数閉性は要らない。
-/
import Ising2DLambda.NecSuf.FisherZero.SubfieldPrecone
import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone
import Mathlib.Algebra.Field.Basic

namespace Ising2DLambda.NecSuf.FisherZero

theorem precone_zero_mem_and_eq_zero_of_mem_neg_necSuf {K : Type} [Field K] (E C T : Set K)
    (hE0 : (0 : K) ∈ E) (hEinv : ∀ z : K, z ∈ E → z ≠ 0 → z⁻¹ ∈ E)
    (hT : IsPreconeOn E C T) (hneg : (-1 : K) ∉ T) :
    (0 : K) ∈ T ∧ ∀ z : K, z ∈ T → -z ∈ T → z = 0 := by
  refine ⟨?_, ?_⟩
  · have h := hT.sq_mem 0 hE0
    rw [mul_zero] at h
    exact h
  · intro z hz hnz
    by_contra hz0
    have hinvE : z⁻¹ ∈ E := hEinv z (hT.subset z hz) hz0
    have hzz : z * z⁻¹ = 1 := mul_inv_cancel₀ hz0
    have key : (-1 : K) = ((-z) * z) * (z⁻¹ * z⁻¹) := by
      calc (-1 : K) = -(1 * 1) := by ring
        _ = -((z * z⁻¹) * (z * z⁻¹)) := by rw [hzz]
        _ = ((-z) * z) * (z⁻¹ * z⁻¹) := by ring
    have h3 : ((-z) * z) * (z⁻¹ * z⁻¹) ∈ T :=
      hT.mul_mem _ _ (hT.mul_mem _ _ hnz hz) (hT.sq_mem _ hinvE)
    rw [← key] at h3
    exact hneg h3

/-- 零元を除いた部分。 -/
def nonzeroPart {K : Type} [Zero K] (T : Set K) : Set K := {z | z ∈ T ∧ z ≠ 0}

theorem coveringPrecone_extendsPositiveConeOn_necSuf {K : Type} [Field K] (F E CF T : Set K)
    (hE0 : (0 : K) ∈ E) (hEinv : ∀ z : K, z ∈ E → z ≠ 0 → z⁻¹ ∈ E)
    (hFE : ∀ z : K, z ∈ F → z ∈ E) (hCF : IsPositiveConeOn F CF)
    (hT : IsPreconeOn E CF T) (hneg : (-1 : K) ∉ T)
    (hcov : ∀ z : K, z ∈ E → z ∈ T ∨ -z ∈ T) :
    ExtendsPositiveConeOn F E CF (nonzeroPart T) := by
  obtain ⟨_, hzero⟩ := precone_zero_mem_and_eq_zero_of_mem_neg_necSuf E CF T hE0 hEinv hT hneg
  have hcone : IsPositiveConeOn E (nonzeroPart T) := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · rintro z ⟨hz, _⟩
      exact hT.subset z hz
    · rintro a b ⟨ha, ha0⟩ ⟨hb, hb0⟩
      refine ⟨hT.add_mem a b ha hb, ?_⟩
      intro hab
      have hna : -a = b := by
        calc -a = -a + 0 := by ring
          _ = -a + (a + b) := by rw [hab]
          _ = b := by ring
      have hnaT : -a ∈ T := by rw [hna]; exact hb
      exact ha0 (hzero a ha hnaT)
    · rintro a b ⟨ha, ha0⟩ ⟨hb, hb0⟩
      refine ⟨hT.mul_mem a b ha hb, ?_⟩
      intro hab
      have hb' : b = 0 := by
        calc b = (a⁻¹ * a) * b := by rw [inv_mul_cancel₀ ha0, one_mul]
          _ = a⁻¹ * (a * b) := by rw [mul_assoc]
          _ = a⁻¹ * 0 := by rw [hab]
          _ = 0 := by rw [mul_zero]
      exact hb0 hb'
    · intro z hzE
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
  refine ⟨hFE, hCF, hcone, ?_⟩
  intro z
  constructor
  · rintro ⟨⟨hz, hz0⟩, hzF⟩
    rcases (hCF.trichotomy z hzF).1 with h | h | h
    · exact absurd h hz0
    · exact h
    · exact absurd (hzero z hz (hT.cone_subset _ h)) hz0
  · intro hz
    have hzF : z ∈ F := hCF.subset z hz
    have hz0 : z ≠ 0 := fun h0 => (hCF.trichotomy z hzF).2.1 ⟨h0, hz⟩
    exact ⟨⟨hT.cone_subset z hz, hz0⟩, hzF⟩

end Ising2DLambda.NecSuf.FisherZero
