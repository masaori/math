/-
有限舞台の対数値の必要十分版。本文 binary-ca-logarithmic-counts.ts の手順を保つ。
繊維とその個数・被覆は有限部分集合 s と任意の値写像 H だけで成立する。
台全体の有限性、整数値域、二値性、局所性、反復回数、保存条件を全て外す。
差と比の公式には二つの非空繊維だけが要り、値域の加法も隣接条件も不要である。
自由エントロピーの上界には有限な上界集合 t と s ⊆ t だけを残す。
反例の反復帰納法は恒等自己写像だけ、除算不能は繊維の個数1と2と係数の非整除だけを使う。
有限台の整数倍と正有理数の対数は前節のままで、実数値の対数へ移さない。

本文との対応:
def_binary_ca_fixed_point_fibers / def_binary_ca_fiber_multiplicity → fiber, multiplicity
 def_binary_ca_positive_fiber_levels → levels, mem_levels
claim_binary_ca_fiber_count_partition → fibers_disjoint, fibers_cover, partition_count
 def_binary_ca_fiber_logarithmic_entropy → entropy
 def_binary_ca_unit_logarithmic_difference / claim_binary_ca_unit_difference_ratio
   → difference, difference_ratio（具体版でだけ v=u+1 を代入）
def_binary_ca_logarithmic_free_count / claim_binary_ca_logarithmic_free_count_fibers
   → freeCount, fiber_sum_positive, free_fibers
claim_binary_ca_logarithmic_free_count_bound → free_count_bound
claim_binary_ca_logarithmic_gap_division_obstruction → identity_iterate, identity_fixed_full,
  one_two_difference, one_two_obstruction, no_adjacent_three_levels
最後の Derivation と GapDerivation で局所規則と反復不動点集合を戻す。
-/
import CellularAutomata.BinaryCALogarithmicCounts
import CellularAutomata.NecSuf.PrimeLogarithm

namespace CellularAutomata.NecSuf.LogarithmicCounts

open CellularAutomata.PrimeLogarithm
open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount

variable {X U : Type*} (s : Finset X) (H : X → U)

noncomputable def fiber (u : U) : Finset X := by
  classical
  exact s.filter (fun x => H x = u)

noncomputable def multiplicity (u : U) : ℕ := (fiber s H u).card

noncomputable def levels : Finset U := by
  classical
  exact s.image H

theorem mem_fiber (u : U) (x : X) :
    x ∈ fiber s H u ↔ x ∈ s ∧ H x = u := by
  classical
  simp [fiber]

theorem mem_levels (u : U) : u ∈ levels s H ↔ 0 < multiplicity s H u := by
  classical
  simp only [levels, Finset.mem_image, multiplicity, Finset.card_pos, Finset.Nonempty,
    mem_fiber]

theorem fibers_disjoint (u v : U) (huv : u ≠ v) : Disjoint (fiber s H u) (fiber s H v) := by
  classical
  apply Finset.disjoint_left.mpr
  intro x hxu hxv
  have hu := (mem_fiber s H u x).1 hxu
  have hv := (mem_fiber s H v x).1 hxv
  exact huv (hu.2.symm.trans hv.2)

open Classical in
theorem fibers_cover : (levels s H).biUnion (fiber s H) = s := by
  classical
  ext x
  constructor
  · intro hx
    obtain ⟨u, _, hxu⟩ := Finset.mem_biUnion.mp hx
    exact ((mem_fiber s H u x).1 hxu).1
  · intro hx
    apply Finset.mem_biUnion.mpr
    refine ⟨H x, Finset.mem_image.mpr ⟨x, hx, rfl⟩, ?_⟩
    exact (mem_fiber s H (H x) x).2 ⟨hx, rfl⟩

theorem partition_count : ∑ u ∈ levels s H, multiplicity s H u = s.card := by
  classical
  have hd : (↑(levels s H) : Set U).PairwiseDisjoint (fiber s H) := by
    intro u _ v _ huv
    exact fibers_disjoint s H u v huv
  calc
    ∑ u ∈ levels s H, multiplicity s H u = ∑ u ∈ levels s H, (fiber s H u).card := rfl
    _ = ((levels s H).biUnion (fiber s H)).card := (Finset.card_biUnion hd).symm
    _ = s.card := congrArg Finset.card (fibers_cover s H)

noncomputable def entropy (u : U) (hu : u ∈ levels s H) : LogVector :=
  logarithm (positiveNat (multiplicity s H u) ((mem_levels s H u).1 hu))

noncomputable def difference (u v : U) (hu : u ∈ levels s H) (hv : v ∈ levels s H) : LogVector :=
  entropy s H v hv - entropy s H u hu

theorem difference_ratio (u v : U) (hu : u ∈ levels s H) (hv : v ∈ levels s H) :
    difference s H u v hu hv = logarithm
      ⟨(multiplicity s H v : ℚ) / (multiplicity s H u : ℚ),
        div_pos (by exact_mod_cast (mem_levels s H v).1 hv)
          (by exact_mod_cast (mem_levels s H u).1 hu)⟩ := by
  calc
    difference s H u v hu hv = entropy s H v hv - entropy s H u hu := rfl
    _ = logarithm (positiveNat (multiplicity s H v) ((mem_levels s H v).1 hv)) -
        logarithm (positiveNat (multiplicity s H u) ((mem_levels s H u).1 hu)) := rfl
    _ = logarithm (positiveDiv
        (positiveNat (multiplicity s H v) ((mem_levels s H v).1 hv))
        (positiveNat (multiplicity s H u) ((mem_levels s H u).1 hu))) :=
      (PrimeLogarithm.Derivation.ratio _ _).symm
    _ = _ := by congr 1; apply Subtype.ext; simp [positiveDiv, positiveNat]

noncomputable def freeCount (hs : 0 < s.card) : LogVector := logarithm (positiveNat s.card hs)

theorem fiber_sum_positive (hs : 0 < s.card) : 0 < ∑ u ∈ levels s H, multiplicity s H u := by
  rw [partition_count]
  exact hs

theorem free_fibers (hs : 0 < s.card) :
    freeCount s hs = logarithm (positiveNat (∑ u ∈ levels s H, multiplicity s H u)
      (fiber_sum_positive s H hs)) := by
  calc
    freeCount s hs = logarithm (positiveNat s.card hs) := rfl
    _ = _ := by congr 1; apply Subtype.ext; simp only [positiveNat, partition_count]

theorem free_count_bound (t : Finset X) (hst : s ⊆ t) (hs : 0 < s.card) :
    vectorLE 0 (freeCount s hs) ∧ vectorLE (freeCount s hs)
      (logarithm (positiveNat t.card (lt_of_lt_of_le hs (Finset.card_le_card hst)))) := by
  unfold freeCount
  rw [← logarithm_one, natural_log_order, natural_log_order]
  exact ⟨hs, Finset.card_le_card hst⟩

-- Cardinalities are the only data of the two fibers used by the arithmetic obstruction.
theorem one_two_difference (u v : U) (hu : u ∈ levels s H) (hv : v ∈ levels s H)
    (hlo : multiplicity s H u = 1) (hhi : multiplicity s H v = 2) :
    difference s H u v hu hv = logarithm (positiveNat 2 (by decide)) := by
  have htwo : entropy s H v hv = logarithm (positiveNat 2 (by decide)) := by
    unfold entropy
    congr 1
    apply Subtype.ext
    simp only [positiveNat, hhi]
  have hzero : entropy s H u hu = logarithm (positiveNat 1 (by decide)) := by
    unfold entropy
    congr 1
    apply Subtype.ext
    simp only [positiveNat, hlo]
  calc
    difference s H u v hu hv = logarithm (positiveNat 2 (by decide)) -
        logarithm (positiveNat 1 (by decide)) := by unfold difference; rw [htwo, hzero]
    _ = logarithm (positiveDiv (positiveNat 2 (by decide)) (positiveNat 1 (by decide))) :=
      (PrimeLogarithm.Derivation.ratio _ _).symm
    _ = logarithm (positiveNat 2 (by decide)) := by
      congr 1
      apply Subtype.ext
      norm_num [positiveDiv, positiveNat]

theorem one_two_obstruction (u v : U) (hu : u ∈ levels s H) (hv : v ∈ levels s H)
    (hlo : multiplicity s H u = 1) (hhi : multiplicity s H v = 2)
    (d : ℤ) (hd : ¬ d ∣ (1 : ℤ)) :
    ¬ ∃ b : LogVector, scale d b = difference s H u v hu hv := by
  rw [one_two_difference s H u v hu hv hlo hhi]
  rintro ⟨b, hb⟩
  have h := congrArg (fun a : LogVector => a ⟨2, by decide⟩) hb
  rw [scale_apply, logarithm_two_at_two] at h
  exact hd ⟨b ⟨2, by decide⟩, h.symm⟩

-- No finite type, equality decision, or two-valued state is needed for this induction.
theorem identity_iterate {Y : Type} (F : Y → Y) (hF : ∀ x, F x = x) (n : ℕ) (x : Y) :
    iterate F n x = x := by
  induction n with
  | zero => rfl
  | succ n ih =>
    calc
      iterate F (n+1) x = F (iterate F n x) := rfl
      _ = F x := congrArg F ih
      _ = x := hF x

theorem identity_fixed_full {Y : Type} [Fintype Y] (F : Y → Y) (hF : ∀ x, F x = x) (n : ℕ) :
    fixedPoints F n = Finset.univ := by
  apply Finset.eq_univ_of_forall
  intro x
  exact (mem_fixedPoints F n x).mpr (identity_iterate F hF n x)

theorem no_adjacent_three_levels (D : Finset ℤ) (hD : D ⊆ {0, 2, 4}) (u : ℤ) :
    ¬ (u ∈ D ∧ u+1 ∈ D) := by
  rintro ⟨hu, hv⟩
  have h := hD hu
  have h' := hD hv
  simp only [Finset.mem_insert, Finset.mem_singleton] at h h'
  omega

namespace Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.PositiveFixedPointCountDomain

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)
variable (H : (V → State) → ℤ)
variable (n : CellularAutomata.BinaryCALogarithmicCounts.PositiveTime)

-- The map from the concrete input is E=Fix_n(F); the label map remains H.
theorem fiber_agrees (u : ℤ) :
    fiber (fixedPoints (globalMap N f) n.val) H u =
      CellularAutomata.BinaryCALogarithmicCounts.fiber N f H n u := by
  classical
  ext x
  rw [mem_fiber, CellularAutomata.BinaryCALogarithmicCounts.mem_fiber]

theorem multiplicity_agrees (u : ℤ) :
    multiplicity (fixedPoints (globalMap N f) n.val) H u =
      CellularAutomata.BinaryCALogarithmicCounts.multiplicity N f H n u := by
  exact congrArg Finset.card (fiber_agrees N f H n u)

theorem levels_agree : levels (fixedPoints (globalMap N f) n.val) H =
    CellularAutomata.BinaryCALogarithmicCounts.levels N f H n := by
  classical
  ext u
  simp [levels, CellularAutomata.BinaryCALogarithmicCounts.levels]

theorem partition : ∑ u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n,
    CellularAutomata.BinaryCALogarithmicCounts.multiplicity N f H n u =
      fixedPointCount (globalMap N f) n.val := by
  have h := partition_count (fixedPoints (globalMap N f) n.val) H
  simpa only [levels_agree, multiplicity_agrees, fixedPointCount] using h

theorem entropy_agrees (u : ℤ) (hu : u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n) :
    entropy (fixedPoints (globalMap N f) n.val) H u (by rw [levels_agree]; exact hu) =
      CellularAutomata.BinaryCALogarithmicCounts.entropy N f H n u hu := by
  unfold entropy CellularAutomata.BinaryCALogarithmicCounts.entropy
  congr 1
  apply Subtype.ext
  simp only [positiveNat, multiplicity_agrees]

theorem difference_agrees (u : ℤ)
    (hu : u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n)
    (hv : u+1 ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n) :
    difference (fixedPoints (globalMap N f) n.val) H u (u+1)
      (by rw [levels_agree]; exact hu) (by rw [levels_agree]; exact hv) =
      CellularAutomata.BinaryCALogarithmicCounts.beta N f H n u hu hv := by
  rw [difference, entropy_agrees, entropy_agrees]
  rfl

theorem beta_ratio (u : ℤ)
    (hu : u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n)
    (hv : u+1 ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H n) :
    CellularAutomata.BinaryCALogarithmicCounts.beta N f H n u hu hv = logarithm
      ⟨(CellularAutomata.BinaryCALogarithmicCounts.multiplicity N f H n (u+1) : ℚ) /
        (CellularAutomata.BinaryCALogarithmicCounts.multiplicity N f H n u : ℚ),
        div_pos (by exact_mod_cast (CellularAutomata.BinaryCALogarithmicCounts.mem_levels N f H n _).1 hv)
          (by exact_mod_cast (CellularAutomata.BinaryCALogarithmicCounts.mem_levels N f H n _).1 hu)⟩ := by
  have h := difference_ratio (fixedPoints (globalMap N f) n.val) H u (u+1)
    (by rw [levels_agree]; exact hu) (by rw [levels_agree]; exact hv)
  simpa only [difference_agrees N f H n u hu hv, multiplicity_agrees] using h

theorem free_agrees (m : positiveDomain (globalMap N f)) :
    freeCount (fixedPoints (globalMap N f) m.val) m.property.2 =
      CellularAutomata.BinaryCALogarithmicCounts.freeCount N f m := by
  rfl

theorem free_partition (m : positiveDomain (globalMap N f)) :
    CellularAutomata.BinaryCALogarithmicCounts.freeCount N f m = logarithm (positiveNat
      (∑ u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels N f H ⟨m.val, m.property.1⟩,
        CellularAutomata.BinaryCALogarithmicCounts.multiplicity N f H ⟨m.val, m.property.1⟩ u)
      (CellularAutomata.BinaryCALogarithmicCounts.fiber_sum_positive N f H m)) := by
  have h := free_fibers (fixedPoints (globalMap N f) m.val) H m.property.2
  simpa only [free_agrees, levels_agree N f H ⟨m.val, m.property.1⟩,
    multiplicity_agrees N f H ⟨m.val, m.property.1⟩] using h

theorem bound (m : positiveDomain (globalMap N f)) :
    vectorLE 0 (CellularAutomata.BinaryCALogarithmicCounts.freeCount N f m) ∧
      vectorLE (CellularAutomata.BinaryCALogarithmicCounts.freeCount N f m)
        (logarithm (positiveNat (2 ^ Fintype.card V) (pow_pos (by decide) _))) := by
  have h := free_count_bound (fixedPoints (globalMap N f) m.val) Finset.univ
    (Finset.subset_univ _) m.property.2
  have hc : (Finset.univ : Finset (V → State)).card = 2 ^ Fintype.card V := by
    rw [Finset.card_univ, CellularAutomata.GlobalMapIteration.card_config]
  simpa only [hc, free_agrees] using h

end Derivation

namespace GapDerivation
open CellularAutomata.BinaryCALogarithmicCounts
open CellularAutomata.TimeExpansionDependency
open Gap

theorem iteration (n : ℕ) (x : Fin 2 → CellularAutomata.EssentialDependency.State) :
    iterate (globalMap neighborhood rule) n x = x := by
  exact identity_iterate (globalMap neighborhood rule) global_identity n x

theorem fixed (n : PositiveTime) : fixedPoints (globalMap neighborhood rule) n.val = Finset.univ := by
  exact identity_fixed_full (globalMap neighborhood rule) global_identity n.val

theorem counts (n : PositiveTime) :
    multiplicity (fixedPoints (globalMap neighborhood rule) n.val) observable 0 = 1 ∧
    multiplicity (fixedPoints (globalMap neighborhood rule) n.val) observable 2 = 2 ∧
    multiplicity (fixedPoints (globalMap neighborhood rule) n.val) observable 4 = 1 := by
  have h0 := Derivation.multiplicity_agrees neighborhood rule observable n 0
  have h2 := Derivation.multiplicity_agrees neighborhood rule observable n 2
  have h4 := Derivation.multiplicity_agrees neighborhood rule observable n 4
  rw [h0, h2, h4]
  unfold CellularAutomata.BinaryCALogarithmicCounts.multiplicity
    CellularAutomata.BinaryCALogarithmicCounts.fiber
  rw [fixed]
  decide

theorem obstruction (n : PositiveTime) : ¬ ∃ b : LogVector, scale 2 b =
    CellularAutomata.BinaryCALogarithmicCounts.entropy neighborhood rule observable n 2 (level_two n) -
    CellularAutomata.BinaryCALogarithmicCounts.entropy neighborhood rule observable n 0 (level_zero n) := by
  have h := one_two_obstruction (fixedPoints (globalMap neighborhood rule) n.val) observable
    0 2 (by rw [Derivation.levels_agree]; exact level_zero n)
      (by rw [Derivation.levels_agree]; exact level_two n)
      (counts n).1 (counts n).2.1 2 (by decide)
  simpa only [difference,
    Derivation.entropy_agrees neighborhood rule observable n 2 (level_two n),
    Derivation.entropy_agrees neighborhood rule observable n 0 (level_zero n)] using h

theorem levels (n : PositiveTime) :
    CellularAutomata.BinaryCALogarithmicCounts.levels neighborhood rule observable n = {0,2,4} := by
  change (fixedPoints (globalMap neighborhood rule) n.val).image observable = {0,2,4}
  rw [fixed]
  decide

theorem no_adjacent (n : PositiveTime) (u : ℤ) :
    ¬ (u ∈ CellularAutomata.BinaryCALogarithmicCounts.levels neighborhood rule observable n ∧
      u+1 ∈ CellularAutomata.BinaryCALogarithmicCounts.levels neighborhood rule observable n) := by
  apply no_adjacent_three_levels
  rw [levels]

end GapDerivation
end CellularAutomata.NecSuf.LogarithmicCounts
