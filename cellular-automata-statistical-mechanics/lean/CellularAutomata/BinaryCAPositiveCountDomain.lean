/-
正本: content/binary-ca-positive-count-domain.ts の具体版。
claim_binary_ca_fixed_point_count_bound → count_bound
claim_binary_ca_positive_count_domain_nonempty → small_witness
 def_single_cell_flip_for_positive_count → singleNeighborhood, singleRule, singleMap, config
claim_single_cell_flip_positive_count_domain → single_step, twice, even_iterate, odd_iterate,
  odd_count, positive_even_count, single_domain, one_excluded
一セルの局所真理値表から大域写像を作り、反復の帰納法を本文どおり行う。
-/
import CellularAutomata.PositiveFixedPointCountDomain
import CellularAutomata.PeriodicPointCount

namespace CellularAutomata.BinaryCAPositiveCountDomain

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.PositiveFixedPointCountDomain
open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)

theorem count_bound (n : ℕ) :
    0 ≤ fixedPointCount (globalMap N f) n ∧
      fixedPointCount (globalMap N f) n ≤ 2 ^ Fintype.card V := by
  have h := count_bounds (globalMap N f) n
  rw [CellularAutomata.GlobalMapIteration.card_config] at h
  exact h

theorem small_witness :
    ∃ p : ℕ, p ∈ positiveDomain (globalMap N f) ∧ p ≤ 2 ^ Fintype.card V := by
  have hx : Nonempty (V → State) := ⟨fun _ => State.zero⟩
  obtain ⟨p, hp, hbound⟩ := (nonempty_iff_small_witness (globalMap N f)).1 hx
  rw [CellularAutomata.GlobalMapIteration.card_config] at hbound
  exact ⟨p, hp, hbound⟩

def singleNeighborhood (_ : Unit) : Finset Unit := {()}

def singleRule (v : Unit) (z : ↥(singleNeighborhood v) → State) : State :=
  nu (z ⟨(), by simp [singleNeighborhood]⟩)

def singleMap : (Unit → State) → (Unit → State) :=
  globalMap singleNeighborhood singleRule

def config (a : State) : Unit → State := fun _ => a

theorem config_exhaustive (x : Unit → State) : x = config (x ()) := by
  funext v
  cases v
  rfl

theorem single_step (a : State) : singleMap (config a) = config (nu a) := by
  funext v
  calc
    singleMap (config a) v = singleRule v (CellularAutomata.RedundantNeighbor.restrict
      (singleNeighborhood v) (config a)) := rfl
    _ = nu ((CellularAutomata.RedundantNeighbor.restrict
      (singleNeighborhood v) (config a)) ⟨(), by simp [singleNeighborhood]⟩) := rfl
    _ = nu (config a ()) := rfl
    _ = nu a := rfl
    _ = config (nu a) v := rfl

theorem twice (a : State) : iterate singleMap 2 (config a) = config a := by
  calc
    iterate singleMap 2 (config a) = singleMap (singleMap (config a)) := rfl
    _ = singleMap (config (nu a)) := congrArg singleMap (single_step a)
    _ = config (nu (nu a)) := single_step (nu a)
    _ = config a := by cases a <;> rfl

theorem even_iterate (k : ℕ) (a : State) :
    iterate singleMap (2 * k) (config a) = config a := by
  induction k with
  | zero => rfl
  | succ k ih =>
    calc
      iterate singleMap (2 * (k + 1)) (config a) =
          iterate singleMap (2 + 2 * k) (config a) := by congr 1; omega
      _ = iterate singleMap 2 (iterate singleMap (2 * k) (config a)) :=
        (congrFun (CellularAutomata.NecSuf.IterateMonoid.iterateMap_comp_add
          singleMap 2 (2 * k)) (config a)).symm
      _ = iterate singleMap 2 (config a) := congrArg (iterate singleMap 2) ih
      _ = config a := twice a

theorem odd_iterate (k : ℕ) (a : State) :
    iterate singleMap (2 * k + 1) (config a) = config (nu a) := by
  calc
    iterate singleMap (2 * k + 1) (config a) =
        singleMap (iterate singleMap (2 * k) (config a)) := rfl
    _ = singleMap (config a) := congrArg singleMap (even_iterate k a)
    _ = config (nu a) := single_step a

theorem odd_count (k : ℕ) : fixedPointCount singleMap (2 * k + 1) = 0 := by
  have hempty : fixedPoints singleMap (2 * k + 1) = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro x hx
    have hfix := (mem_fixedPoints singleMap _ x).1 hx
    rw [config_exhaustive x, odd_iterate] at hfix
    have h := congrFun hfix ()
    cases hx0 : x () <;> simp [config, hx0, nu] at h
  unfold fixedPointCount
  rw [hempty, Finset.card_empty]

theorem positive_even_count (k : ℕ) : fixedPointCount singleMap (2 * k + 2) = 2 := by
  have hfull : fixedPoints singleMap (2 * k + 2) = Finset.univ := by
    apply Finset.eq_univ_of_forall
    intro x
    apply (mem_fixedPoints singleMap _ x).2
    rw [config_exhaustive x]
    have hindex : 2 * k + 2 = 2 * (k + 1) := by omega
    rw [hindex, even_iterate]
  calc
    fixedPointCount singleMap (2 * k + 2) = (fixedPoints singleMap (2 * k + 2)).card := rfl
    _ = (Finset.univ : Finset (Unit → State)).card := congrArg Finset.card hfull
    _ = Fintype.card (Unit → State) := Finset.card_univ
    _ = 2 := by rw [CellularAutomata.GlobalMapIteration.card_config]; simp

theorem single_domain (n : ℕ) :
    n ∈ positiveDomain singleMap ↔ ∃ m : ℕ, 1 ≤ m ∧ n = 2 * m := by
  constructor
  · intro hn
    have hrem := Nat.mod_lt n (by decide : 0 < 2)
    have hdiv := Nat.div_add_mod n 2
    rcases (show n % 2 = 0 ∨ n % 2 = 1 by omega) with h | h
    · refine ⟨n / 2, ?_, by omega⟩
      have hnpos := hn.1
      omega
    · have heq : n = 2 * (n / 2) + 1 := by omega
      have hpos := hn.2
      rw [heq, odd_count] at hpos
      omega
  · rintro ⟨m, hm, rfl⟩
    refine ⟨by omega, ?_⟩
    have heq : 2 * m = 2 * (m - 1) + 2 := by omega
    rw [heq, positive_even_count]
    decide

theorem one_excluded : 1 ∉ positiveDomain singleMap := by
  rw [single_domain]
  rintro ⟨m, hm, h⟩
  omega

end CellularAutomata.BinaryCAPositiveCountDomain
