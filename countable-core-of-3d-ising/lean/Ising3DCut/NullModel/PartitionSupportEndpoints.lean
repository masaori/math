/-
人手証明の主張「分配多項式の台の両端は 0 と辺の本数である」
（ラベル `claim_partition_support_endpoints`）の具体版。

人手証明とこのファイルの対応:

  定数配位 σ⁺, σ⁻ は相異なり破れ数が 0       `two_le_multiplicity_zero`
  Tσ⁺, Tσ⁻ は相異なり破れ数が #E_L            `two_le_multiplicity_full`
  両端の係数は対応する多重度に等しい            `partitionPolynomial_support_endpoints`
  #E_L より大きい次数の係数は有限和の外なので 0  同じ定理の最後の成分

本文では L ≥ 2 を固定しているので、この前提を明示的に受け取る。
住処: `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PartitionCoefficientsNonnegative

namespace Ising3DCut.NullModel

noncomputable section

/-- すべての点で値 +1 を取る定数配位 σ⁺。 -/
def plusConfig (L : ℕ) : Config L := fun _ => ⟨1, Or.inl rfl⟩

/-- すべての点で値 -1 を取る定数配位 σ⁻。 -/
def minusConfig (L : ℕ) : Config L := fun _ => ⟨-1, Or.inr rfl⟩

/-- L > 0 の箱に属する点 (0,0,0)。 -/
def zeroSite {L : ℕ} (hL : 0 < L) : Site L :=
  ⟨fun _ => 0, fun _ => hL⟩

/-- σ⁺ と σ⁻ は、箱の点 (0,0,0) で値が異なるので相異なる。 -/
lemma plusConfig_ne_minusConfig {L : ℕ} (hL : 0 < L) :
    plusConfig L ≠ minusConfig L := by
  intro h
  have hvalue := congrFun h (zeroSite hL)
  have hint : (1 : ℤ) = -1 := congrArg Subtype.val hvalue
  omega

/-- 定数配位のどの辺でも両端の値は等しい。 -/
lemma constConfig_unbroken {L : ℕ} (positive : Bool) (e : Edge L) :
    (if positive then plusConfig L else minusConfig L) (endpoint0 e) =
      (if positive then plusConfig L else minusConfig L) (endpoint1 e) := by
  cases positive <;> rfl

/-- 二つの定数配位の破れ数はいずれも 0。 -/
lemma brokenCount_constConfig {L : ℕ} (positive : Bool) :
    brokenCount (if positive then plusConfig L else minusConfig L) = 0 := by
  rw [brokenCount, Finset.card_eq_zero]
  ext e
  simp [brokenSet, constConfig_unbroken positive e]

/-- 破れ数 0 の水準集合は相異なる二つの定数配位を含む。 -/
lemma two_le_multiplicity_zero {L : ℕ} (hL : 0 < L) :
    2 ≤ multiplicity L 0 := by
  let f : Bool → LevelSet L 0 := fun positive =>
    ⟨if positive then plusConfig L else minusConfig L, by
      simp [levelSetFinset, brokenCount_constConfig]⟩
  have hf : Function.Injective f := by
    intro a b hab
    cases a <;> cases b
    · rfl
    · exact False.elim (plusConfig_ne_minusConfig hL (congrArg Subtype.val hab).symm)
    · exact False.elim (plusConfig_ne_minusConfig hL (congrArg Subtype.val hab))
    · rfl
  simpa [multiplicity] using Fintype.card_le_of_injective f hf

/-- 奇数側反転した二つの定数配位は、破れ数 #E_L の相異なる二配位である。 -/
lemma two_le_multiplicity_full {L : ℕ} (hL : 0 < L) :
    2 ≤ multiplicity L (Fintype.card (Edge L)) := by
  let f : Bool → LevelSet L (Fintype.card (Edge L)) := fun positive =>
    ⟨oddFlip (if positive then plusConfig L else minusConfig L), by
      simp [levelSetFinset, brokenCount_oddFlip, brokenCount_constConfig]⟩
  have hf : Function.Injective f := by
    intro a b hab
    have hbase := (oddFlip_bijective (L := L)).1 (congrArg Subtype.val hab)
    cases a <;> cases b
    · rfl
    · exact False.elim (plusConfig_ne_minusConfig hL hbase.symm)
    · exact False.elim (plusConfig_ne_minusConfig hL hbase)
    · rfl
  simpa [multiplicity] using Fintype.card_le_of_injective f hf

/-- `claim_partition_support_endpoints` の具体版。
両端係数は対応する多重度で 2 以上であり、辺数より大きい次数の係数は 0。 -/
theorem partitionPolynomial_support_endpoints {L : ℕ} (hL : 2 ≤ L) :
    (partitionPolynomial L).coeff 0 = (multiplicity L 0 : ℤ) ∧
    2 ≤ multiplicity L 0 ∧
    (partitionPolynomial L).coeff (Fintype.card (Edge L)) =
      (multiplicity L (Fintype.card (Edge L)) : ℤ) ∧
    2 ≤ multiplicity L (Fintype.card (Edge L)) ∧
    ∀ m, Fintype.card (Edge L) < m → (partitionPolynomial L).coeff m = 0 := by
  have hpositive : 0 < L := Nat.zero_lt_of_lt hL
  refine ⟨partitionPolynomial_coeff_eq_multiplicity L 0 (Nat.zero_le _),
    two_le_multiplicity_zero hpositive,
    partitionPolynomial_coeff_eq_multiplicity L _ (Nat.le_refl _),
    two_le_multiplicity_full hpositive, ?_⟩
  intro m hm
  rw [partitionPolynomial_coeff_eq_delta_sum]
  simp [Finset.sum_ite_eq', Finset.mem_range, Nat.not_lt_of_ge hm]

end

end Ising3DCut.NullModel
