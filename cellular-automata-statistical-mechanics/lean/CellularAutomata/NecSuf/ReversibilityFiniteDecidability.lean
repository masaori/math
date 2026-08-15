/-
章「大域写像の可逆性の有限決定」の必要十分版。

具体版（CellularAutomata.ReversibilityFiniteDecidability）と同じ順序で、像・単射・全射の定義、
「単射 ⟺ 全射」（像の元の個数の数え上げ）、「単射 ⟺ 全ての元で最小前周期が 0」
（最小前周期の最小性と反復の帰納的定義）、全対の走査と全元の最小前周期走査による有限決定を示す。

必要な構造の検査結果:
  - 単射の定義には型 X 上の自己写像 F : X → X だけが要り、有限性も等号判定も要らない。
  - 像・全射・「単射 ⟺ 全射」には X の有限性（`Fintype X`）が要る。数え上げの各段
    （部分集合の個数、個数一致 ⟺ 集合一致、単射な像の個数、像の個数の上界、1 元除去の個数）が
    有限集合の個数を比較するからである。像を `Finset` として作る箇所は古典的な等号判定で済ませ、
    実行可能な等号判定は要求しない。
  - 「単射 ⟺ 全ての元で μ = 0」には有限性が要る。μ・π の定義（最小元の存在）が
    軌道の衝突、すなわち有限性を使うからである。
  - 実行可能な判定（`Decidable`）にだけ X の等号判定を要求する。
  - 二値状態、セル、近傍、局所規則、物理的名称、R / C は使わない。
    具体版の 2^{|V|}・2^{2|V|} は特殊化で現れ、ここでは |X|・|X|^2 である。
-/
import CellularAutomata.NecSuf.PeriodicPointCount

namespace CellularAutomata.NecSuf.ReversibilityFiniteDecidability

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod
open CellularAutomata.NecSuf.PeriodicPointCount

variable {X : Type} (F : X → X)

open Classical in
/-- 像 Im(F) := { F x : x ∈ X }。有限性だけを使い、等号判定は古典的に済ませる。 -/
noncomputable def image [Fintype X] : Finset X := Finset.univ.image F

theorem mem_image [Fintype X] (z : X) : z ∈ image F ↔ ∃ x : X, F x = z := by
  classical
  simp [image]

/-- F が単射: ∀ x x', F x = F x' → x = x'。有限性は要らない。 -/
def Injective : Prop := ∀ x x' : X, F x = F x' → x = x'

/-- F が全射: Im(F) = X。 -/
def Surjective [Fintype X] : Prop := image F = Finset.univ

/-- 前段: |Im(F)| ≤ |X|（Im(F) ⊆ X）。 -/
theorem card_image_le_card_univ [Fintype X] :
    (image F).card ≤ (Finset.univ : Finset X).card :=
  Finset.card_le_card (Finset.subset_univ _)

/-- 前段: |Im(F)| = |X| ⟺ Im(F) = X。 -/
theorem image_eq_univ_iff_card [Fintype X] :
    image F = Finset.univ ↔ (image F).card = (Finset.univ : Finset X).card := by
  constructor
  · intro h; rw [h]
  · intro h
    exact Finset.eq_of_subset_of_card_le (Finset.subset_univ _) (le_of_eq h.symm)

/-- （⇒ の中間段）F が単射なら |Im(F)| = |X|。 -/
theorem card_image_of_injective_eq [Fintype X] (hinj : Injective F) :
    (image F).card = (Finset.univ : Finset X).card := by
  classical
  exact Finset.card_image_of_injective _ (fun x x' h => hinj x x' h)

open Classical in
/-- （⇐ の中間段）x₀ ≠ x₁、F x₀ = F x₁ のとき、B := X ∖ {x₁} について Im(F) = { F x : x ∈ B }。 -/
theorem image_eq_image_erase [Fintype X] {x₀ x₁ : X} (hne : x₀ ≠ x₁) (heq : F x₀ = F x₁) :
    image F = (Finset.univ.erase x₁).image F := by
  apply Finset.Subset.antisymm
  · intro z hz
    obtain ⟨x, hx⟩ := (mem_image F z).1 hz
    rw [Finset.mem_image]
    by_cases hx1 : x = x₁
    · refine ⟨x₀, ?_, ?_⟩
      · exact Finset.mem_erase.2 ⟨hne, Finset.mem_univ _⟩
      · rw [heq, ← hx1, hx]
    · exact ⟨x, Finset.mem_erase.2 ⟨hx1, Finset.mem_univ _⟩, hx⟩
  · exact Finset.image_subset_image (Finset.subset_univ _)

/-- 有限型上では単射性と全射性は同値。 -/
theorem injective_iff_surjective [Fintype X] : Injective F ↔ Surjective F := by
  classical
  constructor
  · intro hinj
    exact (image_eq_univ_iff_card F).2 (card_image_of_injective_eq F hinj)
  · intro hsurj
    by_contra hnot
    have hex : ∃ x₀ x₁ : X, F x₀ = F x₁ ∧ x₀ ≠ x₁ := by
      by_contra hno
      apply hnot
      intro x x' h
      by_contra hne
      exact hno ⟨x, x', h, hne⟩
    obtain ⟨x₀, x₁, heq, hne⟩ := hex
    have hB : (Finset.univ.erase x₁).card = (Finset.univ : Finset X).card - 1 :=
      Finset.card_erase_of_mem (Finset.mem_univ _)
    have hle : (image F).card ≤ (Finset.univ.erase x₁).card := by
      rw [image_eq_image_erase F hne heq]
      exact Finset.card_image_le
    have hcard : (image F).card = (Finset.univ : Finset X).card :=
      (image_eq_univ_iff_card F).1 hsurj
    have hpos : 1 ≤ (Finset.univ : Finset X).card :=
      Finset.card_pos.2 ⟨x₁, Finset.mem_univ _⟩
    omega

/-- （⇒）F が単射なら全ての元で μ(x) = 0。 -/
theorem minPreperiod_eq_zero_of_injective [Fintype X] (hinj : Injective F) (x : X) :
    minPreperiod F x = 0 := by
  by_contra hne
  have hμ1 : 1 ≤ minPreperiod F x := by omega
  have hcol := (isPeriodicityPair_iff_collision F x _ _).1 (minPeriod_spec F x)
  obtain ⟨hπ1, hcoll⟩ := hcol
  set m := minPreperiod F x - 1 with hm
  have hμm : minPreperiod F x = m + 1 := by omega
  have hsum : minPreperiod F x + minPeriod F x = (m + minPeriod F x) + 1 := by omega
  rw [hsum, hμm, iterate_succ, iterate_succ] at hcoll
  have hcoll' : iterate F (m + minPeriod F x) x = iterate F m x := hinj _ _ hcoll
  have hpair : IsPeriodicityPair F x m (minPeriod F x) :=
    (isPeriodicityPair_iff_collision F x m _).2 ⟨hπ1, hcoll'⟩
  have hle : minPreperiod F x ≤ m := minPreperiod_le F x ⟨_, hpair⟩
  omega

/-- （⇐）全ての元で μ(x) = 0 なら F は全射。 -/
theorem surjective_of_forall_minPreperiod_zero [Fintype X]
    (h : ∀ x : X, minPreperiod F x = 0) : Surjective F := by
  classical
  unfold Surjective
  apply Finset.Subset.antisymm (Finset.subset_univ _)
  intro x _
  obtain ⟨n, hn, hFn⟩ := (isPeriodicPoint_iff_minPreperiod_zero F x).2 (h x)
  set k := n - 1 with hk
  have hnk : n = k + 1 := by omega
  rw [hnk, iterate_succ] at hFn
  exact (mem_image F x).2 ⟨iterate F k x, hFn⟩

/-- 単射性は全ての元の最小前周期が 0 であることと同値。 -/
theorem injective_iff_forall_minPreperiod_zero [Fintype X] :
    Injective F ↔ ∀ x : X, minPreperiod F x = 0 := by
  constructor
  · exact minPreperiod_eq_zero_of_injective F
  · intro h
    exact (injective_iff_surjective F).2 (surjective_of_forall_minPreperiod_zero F h)

/-- 言い換え: 単射 ⟺ 全ての元が周期点。 -/
theorem injective_iff_forall_isPeriodicPoint [Fintype X] :
    Injective F ↔ ∀ x : X, IsPeriodicPoint F x := by
  rw [injective_iff_forall_minPreperiod_zero]
  constructor
  · intro h x; exact (isPeriodicPoint_iff_minPreperiod_zero F x).2 (h x)
  · intro h x; exact (isPeriodicPoint_iff_minPreperiod_zero F x).1 (h x)

/-! ## 有限決定 -/

/-- （全対の走査）単射性は X × X 上の全称文であり、走査する対の有限集合で言い換えられる。 -/
theorem injective_iff_forall_pairs [Fintype X] :
    Injective F ↔
      ∀ q ∈ (Finset.univ : Finset X) ×ˢ (Finset.univ : Finset X),
        F q.1 = F q.2 → q.1 = q.2 := by
  constructor
  · intro h q _; exact h q.1 q.2
  · intro h x x' hxx'
    exact h (x, x') (Finset.mem_product.2 ⟨Finset.mem_univ _, Finset.mem_univ _⟩) hxx'

/-- 走査する対の総数は |X|^2。 -/
theorem card_pairs [Fintype X] :
    ((Finset.univ : Finset X) ×ˢ (Finset.univ : Finset X)).card = (Fintype.card X) ^ 2 := by
  rw [Finset.card_product, Finset.card_univ, sq]

/-- X の等号が決定可能なら単射性は決定可能（有限個の対それぞれの含意の連言）。 -/
instance [Fintype X] [DecidableEq X] : Decidable (Injective F) :=
  decidable_of_iff _ (injective_iff_forall_pairs F).symm

/-- （最小前周期の走査）単射性は |X| 個の元それぞれの μ(x) = 0 の連言である。 -/
theorem injective_iff_forall_elem_minPreperiod_zero [Fintype X] :
    Injective F ↔ ∀ x ∈ (Finset.univ : Finset X), minPreperiod F x = 0 := by
  rw [injective_iff_forall_minPreperiod_zero]
  constructor
  · intro h x _; exact h x
  · intro h x; exact h x (Finset.mem_univ _)

end CellularAutomata.NecSuf.ReversibilityFiniteDecidability
