/-
正本: content/binary-ca-logarithmic-counts.ts の具体版。
def_binary_ca_integer_conserved_observable → Conserved
def_binary_ca_fixed_point_fibers / def_binary_ca_fiber_multiplicity → fiber, multiplicity
def_binary_ca_positive_fiber_levels → levels, mem_levels
claim_binary_ca_fiber_count_partition → fibers_disjoint, fibers_cover, partition_count
def_binary_ca_fiber_logarithmic_entropy → entropy
def_binary_ca_unit_logarithmic_difference / claim_binary_ca_unit_difference_ratio → beta, beta_ratio
def_binary_ca_logarithmic_free_count / claim_binary_ca_logarithmic_free_count_fibers → freeCount, free_fibers
claim_binary_ca_logarithmic_free_count_bound → free_count_bound
claim_binary_ca_logarithmic_gap_division_obstruction → Gap.global_identity, conserved,
  iterate_identity, fixed_full, fiber_table, count_zero, count_two, count_four,
  entropy_difference, division_obstruction, levels_table, no_adjacent_levels
整数値写像の保存条件は、本文と同じく繊維の数え上げには使わない。
時刻は正の自然数、対数の入力は正値性の証明を持つ部分型に固定する。
-/
import CellularAutomata.PrimeLogarithm
import CellularAutomata.BinaryCAPositiveCountDomain

namespace CellularAutomata.BinaryCALogarithmicCounts

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.PrimeLogarithm
open CellularAutomata.PositiveFixedPointCountDomain
open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount

abbrev PositiveTime := {n : ℕ // 1 ≤ n}

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)
variable (H : (V → State) → ℤ)

def Conserved : Prop := ∀ x, H (globalMap N f x) = H x

noncomputable def fiber (n : PositiveTime) (u : ℤ) : Finset (V → State) :=
  (fixedPoints (globalMap N f) n.val).filter (fun x => H x = u)

noncomputable def multiplicity (n : PositiveTime) (u : ℤ) : ℕ := (fiber N f H n u).card

noncomputable def levels (n : PositiveTime) : Finset ℤ :=
  (fixedPoints (globalMap N f) n.val).image H

theorem mem_fiber (n : PositiveTime) (u : ℤ) (x : V → State) :
    x ∈ fiber N f H n u ↔ x ∈ fixedPoints (globalMap N f) n.val ∧ H x = u := by
  classical
  simp [fiber]

theorem mem_levels (n : PositiveTime) (u : ℤ) :
    u ∈ levels N f H n ↔ 0 < multiplicity N f H n u := by
  classical
  simp only [levels, Finset.mem_image, multiplicity, Finset.card_pos, Finset.Nonempty,
    mem_fiber]

theorem fibers_disjoint (n : PositiveTime) (u v : ℤ) (huv : u ≠ v) :
    Disjoint (fiber N f H n u) (fiber N f H n v) := by
  classical
  apply Finset.disjoint_left.mpr
  intro x hxu hxv
  have hu := (mem_fiber N f H n u x).1 hxu
  have hv := (mem_fiber N f H n v x).1 hxv
  exact huv (hu.2.symm.trans hv.2)

theorem fibers_cover (n : PositiveTime) :
    (levels N f H n).biUnion (fiber N f H n) = fixedPoints (globalMap N f) n.val := by
  classical
  ext x
  constructor
  · intro hx
    obtain ⟨u, _, hxu⟩ := Finset.mem_biUnion.mp hx
    exact ((mem_fiber N f H n u x).1 hxu).1
  · intro hx
    apply Finset.mem_biUnion.mpr
    refine ⟨H x, Finset.mem_image.mpr ⟨x, hx, rfl⟩, ?_⟩
    exact (mem_fiber N f H n (H x) x).2 ⟨hx, rfl⟩

theorem partition_count (n : PositiveTime) :
    ∑ u ∈ levels N f H n, multiplicity N f H n u = fixedPointCount (globalMap N f) n.val := by
  classical
  have hd : (↑(levels N f H n) : Set ℤ).PairwiseDisjoint (fiber N f H n) := by
    intro u _ v _ huv
    exact fibers_disjoint N f H n u v huv
  calc
    ∑ u ∈ levels N f H n, multiplicity N f H n u =
        ∑ u ∈ levels N f H n, (fiber N f H n u).card := rfl
    _ = ((levels N f H n).biUnion (fiber N f H n)).card := (Finset.card_biUnion hd).symm
    _ = (fixedPoints (globalMap N f) n.val).card := congrArg Finset.card (fibers_cover N f H n)
    _ = fixedPointCount (globalMap N f) n.val := rfl

noncomputable def entropy (n : PositiveTime) (u : ℤ) (hu : u ∈ levels N f H n) : LogVector :=
  logarithm (positiveNat (multiplicity N f H n u) ((mem_levels N f H n u).1 hu))

noncomputable def beta (n : PositiveTime) (u : ℤ)
    (hu : u ∈ levels N f H n) (hv : u + 1 ∈ levels N f H n) : LogVector :=
  entropy N f H n (u + 1) hv - entropy N f H n u hu

theorem beta_ratio (n : PositiveTime) (u : ℤ)
    (hu : u ∈ levels N f H n) (hv : u + 1 ∈ levels N f H n) :
    beta N f H n u hu hv = logarithm
      ⟨(multiplicity N f H n (u + 1) : ℚ) / (multiplicity N f H n u : ℚ),
        div_pos (by exact_mod_cast (mem_levels N f H n (u + 1)).1 hv)
          (by exact_mod_cast (mem_levels N f H n u).1 hu)⟩ := by
  calc
    beta N f H n u hu hv = entropy N f H n (u + 1) hv - entropy N f H n u hu := rfl
    _ = logarithm (positiveNat (multiplicity N f H n (u + 1)) ((mem_levels N f H n _).1 hv)) -
        logarithm (positiveNat (multiplicity N f H n u) ((mem_levels N f H n _).1 hu)) := rfl
    _ = logarithm (positiveDiv
        (positiveNat (multiplicity N f H n (u + 1)) ((mem_levels N f H n _).1 hv))
        (positiveNat (multiplicity N f H n u) ((mem_levels N f H n _).1 hu))) :=
      (logarithm_ratio _ _).symm
    _ = _ := by congr 1; apply Subtype.ext; simp [positiveDiv, positiveNat]

noncomputable def freeCount (n : positiveDomain (globalMap N f)) : LogVector :=
  logarithm (rationalInput (globalMap N f) n)

theorem fiber_sum_positive (n : positiveDomain (globalMap N f)) :
    0 < ∑ u ∈ levels N f H ⟨n.val, n.property.1⟩, multiplicity N f H ⟨n.val, n.property.1⟩ u := by
  rw [partition_count]
  exact n.property.2

theorem free_fibers (n : positiveDomain (globalMap N f)) :
    freeCount N f n = logarithm (positiveNat
      (∑ u ∈ levels N f H ⟨n.val, n.property.1⟩, multiplicity N f H ⟨n.val, n.property.1⟩ u)
      (fiber_sum_positive N f H n)) := by
  calc
    freeCount N f n = logarithm (rationalInput (globalMap N f) n) := rfl
    _ = logarithm (positiveNat (fixedPointCount (globalMap N f) n.val) n.property.2) := rfl
    _ = _ := by congr 1; apply Subtype.ext; simp only [positiveNat, partition_count]


theorem free_count_bound (n : positiveDomain (globalMap N f)) :
    vectorLE 0 (freeCount N f n) ∧ vectorLE (freeCount N f n)
      (logarithm (positiveNat (2 ^ Fintype.card V) (pow_pos (by decide) _))) := by
  have hn : 0 < fixedPointCount (globalMap N f) n.val := n.property.2
  have hdef : freeCount N f n = logarithm (positiveNat
      (fixedPointCount (globalMap N f) n.val) hn) := rfl
  rw [hdef, ← logarithm_one, natural_log_order, natural_log_order]
  exact ⟨hn, (CellularAutomata.BinaryCAPositiveCountDomain.count_bound N f n.val).2⟩

namespace Gap

def neighborhood (z : Fin 2) : Finset (Fin 2) := {z}

def rule (z : Fin 2) (y : ↥(neighborhood z) → State) : State :=
  y ⟨z, by simp [neighborhood]⟩

def observable (x : Fin 2 → State) : ℤ :=
  match x 0, x 1 with
  | .zero, .zero => 0
  | .one, .one => 4
  | _, _ => 2

theorem global_identity (x : Fin 2 → State) : globalMap neighborhood rule x = x := by
  funext z
  calc
    globalMap neighborhood rule x z = rule z
      (CellularAutomata.RedundantNeighbor.restrict (neighborhood z) x) := rfl
    _ = (CellularAutomata.RedundantNeighbor.restrict (neighborhood z) x)
      ⟨z, by simp [neighborhood]⟩ := rfl
    _ = x z := rfl

theorem conserved : Conserved neighborhood rule observable := by
  intro x
  rw [global_identity]

theorem iterate_identity (n : ℕ) (x : Fin 2 → State) :
    iterate (globalMap neighborhood rule) n x = x := by
  induction n with
  | zero => rfl
  | succ n ih =>
    calc
      iterate (globalMap neighborhood rule) (n + 1) x =
        globalMap neighborhood rule (iterate (globalMap neighborhood rule) n x) := rfl
      _ = globalMap neighborhood rule x := congrArg (globalMap neighborhood rule) ih
      _ = x := global_identity x

theorem fixed_full (n : PositiveTime) :
    fixedPoints (globalMap neighborhood rule) n.val = Finset.univ := by
  apply Finset.eq_univ_of_forall
  intro x
  exact (mem_fixedPoints _ _ _).mpr (iterate_identity n.val x)

theorem fiber_table (n : PositiveTime) (u : ℤ) :
    fiber neighborhood rule observable n u = Finset.univ.filter (fun x => observable x = u) := by
  unfold fiber
  rw [fixed_full]

theorem count_zero (n : PositiveTime) : multiplicity neighborhood rule observable n 0 = 1 := by
  unfold multiplicity
  rw [fiber_table]
  decide

theorem count_two (n : PositiveTime) : multiplicity neighborhood rule observable n 2 = 2 := by
  unfold multiplicity
  rw [fiber_table]
  decide

theorem count_four (n : PositiveTime) : multiplicity neighborhood rule observable n 4 = 1 := by
  unfold multiplicity
  rw [fiber_table]
  decide

theorem level_zero (n : PositiveTime) : 0 ∈ levels neighborhood rule observable n := by
  rw [mem_levels, count_zero]
  decide

theorem level_two (n : PositiveTime) : 2 ∈ levels neighborhood rule observable n := by
  rw [mem_levels, count_two]
  decide

theorem entropy_difference (n : PositiveTime) :
    entropy neighborhood rule observable n 2 (level_two n) -
      entropy neighborhood rule observable n 0 (level_zero n) = logarithm (positiveNat 2 (by decide)) := by
  have htwo : entropy neighborhood rule observable n 2 (level_two n) =
      logarithm (positiveNat 2 (by decide)) := by
    unfold entropy
    congr 1
    apply Subtype.ext
    simp only [positiveNat, count_two]
  have hzero : entropy neighborhood rule observable n 0 (level_zero n) =
      logarithm (positiveNat 1 (by decide)) := by
    unfold entropy
    congr 1
    apply Subtype.ext
    simp only [positiveNat, count_zero]
  calc
    entropy neighborhood rule observable n 2 (level_two n) -
        entropy neighborhood rule observable n 0 (level_zero n) =
        logarithm (positiveNat 2 (by decide)) - logarithm (positiveNat 1 (by decide)) := by
          rw [htwo, hzero]
    _ = logarithm (positiveDiv (positiveNat 2 (by decide)) (positiveNat 1 (by decide))) :=
      (logarithm_ratio _ _).symm
    _ = logarithm (positiveNat 2 (by decide)) := by
      congr 1
      apply Subtype.ext
      norm_num [positiveDiv, positiveNat]

theorem division_obstruction (n : PositiveTime) :
    ¬ ∃ b : LogVector, scale 2 b = entropy neighborhood rule observable n 2 (level_two n) -
      entropy neighborhood rule observable n 0 (level_zero n) := by
  rw [entropy_difference]
  rintro ⟨b, hb⟩
  have h := congrArg (fun a : LogVector => a ⟨2, by decide⟩) hb
  rw [scale_apply, logarithm_two_at_two] at h
  omega

theorem levels_table (n : PositiveTime) : levels neighborhood rule observable n = {0, 2, 4} := by
  unfold levels
  rw [fixed_full]
  decide

theorem no_adjacent_levels (n : PositiveTime) (u : ℤ) :
    ¬ (u ∈ levels neighborhood rule observable n ∧ u + 1 ∈ levels neighborhood rule observable n) := by
  rw [levels_table]
  simp only [Finset.mem_insert, Finset.mem_singleton]
  omega

end Gap

end CellularAutomata.BinaryCALogarithmicCounts
