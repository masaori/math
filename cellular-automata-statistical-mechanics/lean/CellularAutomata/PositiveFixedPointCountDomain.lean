/-
正本: content/positive-fixed-point-count-domain.ts の具体版。
本文が数学的道具として有限自己写像へ整理された後の対象に合わせる。
既存の反復・最小周期・不動点は、有限自己写像を扱う既存 NecSuf 名前空間から参照する。
この新対象の必要十分版ではない。有限性を全段で保持し、削除可能な仮定の監査は次層に残す。

def_positive_fixed_point_count_domain → positiveDomain
 def_realized_period_set → realizedLengths, mem_realizedLengths
claim_fixed_point_count_bounded_by_cardinality → count_bounds
claim_positive_count_domain_iff_period_divides → mem_positiveDomain_iff, zero_iff
claim_positive_count_domain_small_witness → nonempty_iff_small_witness
claim_positive_count_domain_finitely_decidable → lengths_subset, lengths_from_period_data,
  remainder_decision, decideFromTable_correct
 def_positive_fixed_point_count_rational_input → rationalInput, rationalInput_value
各証明は本文の参照済み補題と、有限集合・自然数・有理数の初等的操作のみを使う。
-/
import CellularAutomata.NecSuf.PeriodicPointCount
import CellularAutomata.NecSuf.IterateMonoid
import Mathlib.Data.Rat.Cast.Order

namespace CellularAutomata.PositiveFixedPointCountDomain

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod
open CellularAutomata.NecSuf.PeriodicPointCount

variable {X : Type} [Fintype X] (F : X → X)

noncomputable def positiveDomain : Set ℕ := {n | 1 ≤ n ∧ 0 < fixedPointCount F n}

open Classical in
noncomputable def realizedLengths : Finset ℕ :=
  (Finset.univ.filter (IsPeriodicPoint F)).image (minPeriod F)

theorem mem_realizedLengths (d : ℕ) :
    d ∈ realizedLengths F ↔ ∃ x : X, IsPeriodicPoint F x ∧ minPeriod F x = d := by
  classical
  simp [realizedLengths]

theorem count_bounds (n : ℕ) :
    0 ≤ fixedPointCount F n ∧ fixedPointCount F n ≤ Fintype.card X := by
  refine ⟨Nat.zero_le _, ?_⟩
  calc
    fixedPointCount F n = (fixedPoints F n).card := rfl
    _ ≤ (Finset.univ : Finset X).card := Finset.card_le_card (Finset.subset_univ _)
    _ = Fintype.card X := Finset.card_univ

theorem mem_positiveDomain_iff (n : ℕ) (hn : 1 ≤ n) :
    n ∈ positiveDomain F ↔ ∃ d ∈ realizedLengths F, ∃ k : ℕ, 1 ≤ k ∧ n = k * d := by
  classical
  -- 本文の同値列を順に通る。最後だけ n>0 により乗数0を除く。
  have hcount : n ∈ positiveDomain F ↔ ∃ x ∈ fixedPoints F n, True := by
    simp only [positiveDomain, Set.mem_setOf_eq, hn, true_and, fixedPointCount]
    rw [Finset.card_pos]
    simp only [and_true]
    rfl
  rw [hcount]
  constructor
  · rintro ⟨x, hx, _⟩
    obtain ⟨hμ, k, hk⟩ := (mem_fixedPoints_iff_minPeriod_dvd F n hn x).1 hx
    have hp := (isPeriodicPoint_iff_minPreperiod_zero F x).2 hμ
    refine ⟨minPeriod F x, (mem_realizedLengths F _).2 ⟨x, hp, rfl⟩, k, ?_, hk⟩
    by_contra h
    have hk0 : k = 0 := by omega
    rw [hk0, Nat.zero_mul] at hk
    omega
  · rintro ⟨d, hd, k, _, hk⟩
    obtain ⟨x, hp, hπ⟩ := (mem_realizedLengths F d).1 hd
    have hμ := (isPeriodicPoint_iff_minPreperiod_zero F x).1 hp
    refine ⟨x, (mem_fixedPoints_iff_minPeriod_dvd F n hn x).2 ⟨hμ, k, ?_⟩, trivial⟩
    rw [hπ]
    exact hk

theorem zero_iff (n : ℕ) (hn : 1 ≤ n) :
    fixedPointCount F n = 0 ↔ ¬ ∃ d ∈ realizedLengths F, ∃ k : ℕ, 1 ≤ k ∧ n = k * d := by
  rw [← mem_positiveDomain_iff F n hn]
  simp only [positiveDomain, Set.mem_setOf_eq, hn, true_and, not_lt, Nat.le_zero]

theorem nonempty_iff_small_witness :
    Nonempty X ↔ ∃ p : ℕ, p ∈ positiveDomain F ∧ p ≤ Fintype.card X := by
  constructor
  · rintro ⟨x⟩
    obtain ⟨i, j, hij, hj, hcollision⟩ := orbit_collision F x
    let p := j - i
    let y := iterate F i x
    have hp : 1 ≤ p := by dsimp [p]; omega
    have hbound : p ≤ Fintype.card X := by dsimp [p]; omega
    have hreturn : iterate F p y = y := calc
      iterate F p y = iterate F p (iterate F i x) := rfl
      _ = iterate F (p + i) x :=
        congrFun (CellularAutomata.NecSuf.IterateMonoid.iterateMap_comp_add F p i) x
      _ = iterate F j x := by congr 1; dsimp [p]; omega
      _ = iterate F i x := hcollision.symm
      _ = y := rfl
    have hmem := (mem_fixedPoints F p y).2 hreturn
    exact ⟨p, ⟨hp, Finset.card_pos.mpr ⟨y, hmem⟩⟩, hbound⟩
  · rintro ⟨p, hp, _⟩
    have hcard : 0 < Fintype.card X := lt_of_lt_of_le hp.2 (count_bounds F p).2
    exact Fintype.card_pos_iff.mp hcard

theorem lengths_subset : realizedLengths F ⊆ Finset.Icc 1 (Fintype.card X) := by
  intro d hd
  obtain ⟨x, _, rfl⟩ := (mem_realizedLengths F d).1 hd
  have hlo := one_le_minPeriod F x
  have hhi := minPreperiod_add_minPeriod_le F x
  exact Finset.mem_Icc.mpr ⟨hlo, by omega⟩

/-- 本文の前章で有限走査される μ,π の表を入力し、μ=0 の像を重複除去する。 -/
def lengthsFromPeriodData (mu pi : X → ℕ) : Finset ℕ :=
  (Finset.univ.filter (fun x => mu x = 0)).image pi

theorem lengths_from_period_data (mu pi : X → ℕ)
    (hmu : ∀ x, mu x = minPreperiod F x) (hpi : ∀ x, pi x = minPeriod F x) :
    lengthsFromPeriodData mu pi = realizedLengths F := by
  classical
  ext d
  simp only [lengthsFromPeriodData, Finset.mem_image, Finset.mem_filter, Finset.mem_univ,
    true_and, mem_realizedLengths]
  constructor
  · rintro ⟨x, hx, hd⟩
    rw [hmu] at hx
    rw [hpi] at hd
    exact ⟨x, (isPeriodicPoint_iff_minPreperiod_zero F x).2 hx, hd⟩
  · rintro ⟨x, hx, hd⟩
    refine ⟨x, ?_, ?_⟩
    · rw [hmu]; exact (isPeriodicPoint_iff_minPreperiod_zero F x).1 hx
    · rw [hpi]; exact hd

theorem remainder_decision (n : ℕ) (hn : 1 ≤ n) :
    n ∈ positiveDomain F ↔ ∃ d ∈ realizedLengths F, n % d = 0 := by
  rw [mem_positiveDomain_iff F n hn]
  constructor
  · rintro ⟨d, hd, k, _, hk⟩
    exact ⟨d, hd, Nat.mod_eq_zero_of_dvd ⟨k, by rw [hk, Nat.mul_comm]⟩⟩
  · rintro ⟨d, hd, hmod⟩
    obtain ⟨k, hk⟩ := Nat.dvd_of_mod_eq_zero hmod
    refine ⟨d, hd, k, ?_, by rw [hk, Nat.mul_comm]⟩
    by_contra h
    have : k = 0 := by omega
    rw [this, Nat.mul_zero] at hk
    omega

def decideFromTable (table : Finset ℕ) (n : ℕ) : Bool :=
  decide (1 ≤ n ∧ ∃ d ∈ table, n % d = 0)

theorem decideFromTable_correct (table : Finset ℕ) (ht : table = realizedLengths F) (n : ℕ) :
    decideFromTable table n = true ↔ n ∈ positiveDomain F := by
  subst table
  simp only [decideFromTable, decide_eq_true_eq]
  by_cases hn : 1 ≤ n
  · simp only [hn, true_and]
    exact (remainder_decision F n hn).symm
  · simp [positiveDomain, hn]

noncomputable def rationalInput (n : positiveDomain F) : {q : ℚ // 0 < q} :=
  ⟨(fixedPointCount F n.val : ℚ) / 1, by
    rw [div_one]
    exact_mod_cast n.property.2⟩

theorem rationalInput_value (n : positiveDomain F) :
    (rationalInput F n).val = (fixedPointCount F n.val : ℚ) / 1 := rfl

end CellularAutomata.PositiveFixedPointCountDomain
