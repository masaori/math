/-
人手証明の主張「各破れ数の多重度は偶数である」
（ラベル `claim_even_multiplicity`）の具体版。

人手証明とこのファイルの対応:

  F(Fσ) = σ                                  `globalFlip_globalFlip`
  D_L(Fσ) = D_L(σ), m_L(Fσ) = m_L(σ)         `brokenSet_globalFlip`, `brokenCount_globalFlip`
  Fσ ≠ σ                                     `globalFlip_ne_self`
  S_m 上の不動点のない二元軌道              `levelSetGlobalFlip`
  Ω_L(m) = 2 k_m                             `multiplicity_even`

住処: `Fin`、`Nat`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Mathlib.GroupTheory.Perm.Cycle.Type
import Ising3DCut.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NullModel

noncomputable section

/-- 全スピン反転 F。 -/
def globalFlip {L : ℕ} (σ : Config L) : Config L := fun a => negSpin (σ a)

/-- 全スピン反転を二回適用すると元の配位へ戻る。 -/
theorem globalFlip_globalFlip {L : ℕ} (σ : Config L) :
    globalFlip (globalFlip σ) = σ := by
  funext a
  exact negSpin_negSpin (σ a)

/-- 両端をともに反転しても、辺が破れているかどうかは変わらない。 -/
lemma brokenSet_globalFlip {L : ℕ} (σ : Config L) :
    brokenSet (globalFlip σ) = brokenSet σ := by
  ext e
  simp only [brokenSet, Finset.mem_filter, Finset.mem_univ, true_and]
  change negSpin (σ (endpoint0 e)) ≠ negSpin (σ (endpoint1 e)) ↔ _
  constructor
  · intro h hEq
    exact h (congrArg negSpin hEq)
  · intro h hEq
    apply h
    have h' := congrArg negSpin hEq
    simpa only [negSpin_negSpin] using h'

/-- 全スピン反転は破れ数を保つ。 -/
lemma brokenCount_globalFlip {L : ℕ} (σ : Config L) :
    brokenCount (globalFlip σ) = brokenCount σ := by
  rw [brokenCount, brokenSet_globalFlip, brokenCount]

/-- ±1 の値は符号反転で変わる。 -/
lemma negSpin_ne_self (z : Spin) : negSpin z ≠ z := by
  intro h
  have hval := congrArg Subtype.val h
  simp [negSpin] at hval
  rcases z.2 with hz | hz <;> omega

/-- `L ≥ 2` の箱では原点の値が変わるため、全スピン反転に不動点は無い。 -/
theorem globalFlip_ne_self {L : ℕ} (hL : 2 ≤ L) (σ : Config L) : globalFlip σ ≠ σ := by
  let origin : Site L := ⟨fun _ => 0, by intro i; simp; omega⟩
  intro h
  have hAt := congrFun h origin
  exact negSpin_ne_self (σ origin) hAt

/-- 破れ数 `m` の水準集合上で全スピン反転が定める置換。 -/
def levelSetGlobalFlip {L m : ℕ} : Equiv.Perm (LevelSet L m) where
  toFun σ := ⟨globalFlip σ.1, by
    have hs := (Finset.mem_filter.mp σ.2).2
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [brokenCount_globalFlip, hs]⟩⟩
  invFun σ := ⟨globalFlip σ.1, by
    have hs := (Finset.mem_filter.mp σ.2).2
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [brokenCount_globalFlip, hs]⟩⟩
  left_inv σ := Subtype.ext (globalFlip_globalFlip σ.1)
  right_inv σ := Subtype.ext (globalFlip_globalFlip σ.1)

/-- `claim_even_multiplicity` の具体版。Ω_L(m) = 2 k_m。 -/
theorem multiplicity_even {L m : ℕ} (hL : 2 ≤ L) :
    ∃ k : ℕ, multiplicity L m = 2 * k := by
  have hpow : (levelSetGlobalFlip (L := L) (m := m)) ^ (2 : ℕ) ^ (1 : ℕ) = 1 := by
    ext σ
    simp only [pow_one, pow_two, Equiv.Perm.mul_apply, one_apply]
    exact (levelSetGlobalFlip (L := L) (m := m)).left_inv σ
  have hdiv : 2 ∣ Fintype.card (LevelSet L m) := by
    by_contra hnot
    obtain ⟨σ, hfixed⟩ := Equiv.Perm.exists_fixed_point_of_prime
      (p := 2) (n := 1) hnot hpow
    have hval := congrArg Subtype.val hfixed
    exact globalFlip_ne_self hL σ.1 hval
  rcases hdiv with ⟨k, hk⟩
  exact ⟨k, by simpa [multiplicity, Nat.mul_comm] using hk⟩

end

end Ising3DCut.NullModel
