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
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Ising3DCut.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NullModel

noncomputable section

local instance levelSetDecidableEq {L m : ℕ} : DecidableEq (LevelSet L m) := Classical.decEq _

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

/-- 水準集合の元 `σ` が属する二元軌道 `{σ, Fσ}`。 -/
noncomputable def globalFlipOrbit {L m : ℕ} (σ : LevelSet L m) : Finset (LevelSet L m) :=
  open Classical in {σ, levelSetGlobalFlip σ}

/-- 二元軌道の族。重複する軌道は `Finset.image` が一つにまとめる。 -/
noncomputable def globalFlipOrbits {L m : ℕ} : Finset (Finset (LevelSet L m)) :=
  open Classical in Finset.univ.image globalFlipOrbit

/-- 同じ二元軌道に属する二点から作った軌道は一致する。 -/
lemma globalFlipOrbit_eq_of_mem {L m : ℕ} {σ τ : LevelSet L m}
    (hτ : τ ∈ globalFlipOrbit σ) : globalFlipOrbit τ = globalFlipOrbit σ := by
  classical
  simp only [globalFlipOrbit, Finset.mem_insert, Finset.mem_singleton] at hτ
  rcases hτ with rfl | rfl
  · rfl
  · simp only [globalFlipOrbit]
    rw [show levelSetGlobalFlip (levelSetGlobalFlip σ) = σ from
      (levelSetGlobalFlip (L := L) (m := m)).left_inv σ]
    exact Finset.pair_comm _ _

/-- 相異なる二元軌道は互いに素である。 -/
lemma globalFlipOrbits_pairwise_disjoint {L m : ℕ} :
    ∀ O ∈ globalFlipOrbits (L := L) (m := m),
      ∀ O' ∈ globalFlipOrbits (L := L) (m := m), O ≠ O' → Disjoint O O' := by
  classical
  intro O hO O' hO' hne
  simp only [globalFlipOrbits, Finset.mem_image] at hO hO'
  obtain ⟨σ, _, rfl⟩ := hO
  obtain ⟨τ, _, rfl⟩ := hO'
  rw [Finset.disjoint_left]
  intro ρ hρ hρ'
  apply hne
  exact (globalFlipOrbit_eq_of_mem hρ).symm.trans (globalFlipOrbit_eq_of_mem hρ')

/-- 二元軌道の合併は水準集合全体である。 -/
lemma globalFlipOrbits_biUnion {L m : ℕ} :
    (globalFlipOrbits (L := L) (m := m)).biUnion (fun O => O) = Finset.univ := by
  classical
  apply Finset.eq_univ_of_forall
  intro σ
  rw [Finset.mem_biUnion]
  exact ⟨globalFlipOrbit σ, Finset.mem_image.mpr ⟨σ, Finset.mem_univ _, rfl⟩,
    Finset.mem_insert_self _ _⟩

/-- 不動点が無いとき、各軌道はちょうど二元からなる。 -/
lemma globalFlipOrbit_card {L m : ℕ} (hL : 2 ≤ L) (σ : LevelSet L m) :
    (globalFlipOrbit σ).card = 2 := by
  classical
  rw [globalFlipOrbit, Finset.card_pair]
  intro h
  have hval := congrArg Subtype.val h
  exact globalFlip_ne_self hL σ.1 hval.symm

/-- `claim_even_multiplicity` の具体版。Ω_L(m) = 2 k_m。 -/
theorem multiplicity_even {L m : ℕ} (hL : 2 ≤ L) :
    ∃ k : ℕ, multiplicity L m = 2 * k := by
  classical
  refine ⟨(globalFlipOrbits (L := L) (m := m)).card, ?_⟩
  rw [multiplicity, ← Finset.card_univ, ← globalFlipOrbits_biUnion,
    Finset.card_biUnion globalFlipOrbits_pairwise_disjoint]
  rw [show ∑ O ∈ globalFlipOrbits (L := L) (m := m), O.card =
      ∑ _O ∈ globalFlipOrbits (L := L) (m := m), 2 by
    apply Finset.sum_congr rfl
    intro O hO
    simp only [globalFlipOrbits, Finset.mem_image] at hO
    obtain ⟨σ, _, rfl⟩ := hO
    exact globalFlipOrbit_card hL σ]
  rw [Finset.sum_const]
  simp [Nat.mul_comm]

end

end Ising3DCut.NullModel
