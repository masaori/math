/-
章「根付き木の深さと最小前周期層の対応」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-root-depth-preperiod-correspondence.ts。

全写像の最小正周期を各配位の最小前周期位置へ移し、最小前周期を
λ_F 単位で切り上げた値 c_F(y) を定義する。人手証明と同じ順序で、
切り上げ位置での根到達、それより前の非到達、根付き木の深さとの一致、
有限走査を形式化する。有限集合・自然数・写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberRootedTree

namespace CellularAutomata.IterateMonoidRootDepthPreperiodCorrespondence

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberRootedTree

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 全写像の最小正周期は各配位の最小前周期位置でも周期になる
    （`claim_iterate_monoid_global_period_at_point_min_preperiod`）。 -/
theorem globalPeriod_at_minPreperiod (y : V → State) :
    minPreperiod N f y ≤ minCollisionStart N f ∧
      iterate N f (minPreperiod N f y + minPositivePeriod N f) y =
        iterate N f (minPreperiod N f y) y := by
  have hcollision : iterate N f
      (minCollisionStart N f + minPositivePeriod N f) y =
      iterate N f (minCollisionStart N f) y := by
    exact congrFun (minPositivePeriod_spec N f).2.symm y
  have hpair : IsPeriodicityPair N f y (minCollisionStart N f)
      (minPositivePeriod N f) :=
    (isPeriodicityPair_iff_collision N f y _ _).2
      ⟨minPositivePeriod_pos N f, hcollision⟩
  exact ⟨minPreperiod_le N f y ⟨minPositivePeriod N f, hpair⟩,
    (period_descends_to_minPreperiod N f y hpair).1⟩

/-- `c_F(y)` の最小化集合は `m_F` を含む。 -/
theorem exists_roundedPreperiod (y : V → State) :
    ∃ d : ℕ, minPreperiod N f y ≤ d * minPositivePeriod N f := by
  refine ⟨rootReachExponent N f, ?_⟩
  calc
    minPreperiod N f y ≤ minCollisionStart N f := (globalPeriod_at_minPreperiod N f y).1
    _ ≤ minStablePeriodMultiple N f := (minStablePeriodMultiple_spec N f).1
    _ = rootReachExponent N f * minPositivePeriod N f :=
      (rootReachExponent_mul_minPositivePeriod N f).symm

/-- `c_F(y) := min {d | μ(y) ≤ d λ_F}`
    （`def_iterate_monoid_rounded_preperiod_depth`）。 -/
noncomputable def roundedPreperiod (y : V → State) : ℕ := by
  classical
  exact Nat.find (exists_roundedPreperiod N f y)

theorem roundedPreperiod_spec (y : V → State) :
    minPreperiod N f y ≤ roundedPreperiod N f y * minPositivePeriod N f := by
  classical
  exact Nat.find_spec (exists_roundedPreperiod N f y)

theorem roundedPreperiod_le (y : V → State) {d : ℕ}
    (hd : minPreperiod N f y ≤ d * minPositivePeriod N f) :
    roundedPreperiod N f y ≤ d := by
  classical
  exact Nat.find_min' (exists_roundedPreperiod N f y) hd

/-- 切り上げた最小前周期の一周期反復で根へ到達する
    （`claim_iterate_monoid_rounded_preperiod_reaches_root`）。 -/
theorem roundedPreperiod_reaches_root (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    iterateMap N f (roundedPreperiod N f y * minPositivePeriod N f) y = q.1 := by
  let c := roundedPreperiod N f y
  let m := rootReachExponent N f
  have hcμ : minPreperiod N f y ≤ c * minPositivePeriod N f := by
    simpa [c] using roundedPreperiod_spec N f y
  have hcm : c ≤ m := by
    apply roundedPreperiod_le N f y
    simpa [m] using calc
      minPreperiod N f y ≤ minCollisionStart N f := (globalPeriod_at_minPreperiod N f y).1
      _ ≤ minStablePeriodMultiple N f := (minStablePeriodMultiple_spec N f).1
      _ = rootReachExponent N f * minPositivePeriod N f :=
        (rootReachExponent_mul_minPositivePeriod N f).symm
  obtain ⟨h, hmh⟩ : ∃ h : ℕ, m = c + h := Nat.exists_eq_add_of_le hcm
  have hperiod := (globalPeriod_at_minPreperiod N f y).2
  have hmultiple := period_multiples N f y hperiod h
  let a := c * minPositivePeriod N f - minPreperiod N f y
  have hshift := collision_shift N f y hmultiple a
  have ha : minPreperiod N f y + a = c * minPositivePeriod N f := by
    simp [a, Nat.add_sub_of_le hcμ]
  have hleft : minPreperiod N f y + h * minPositivePeriod N f + a =
      m * minPositivePeriod N f := by
    rw [Nat.add_assoc, Nat.add_comm (h * minPositivePeriod N f) a, ← Nat.add_assoc, ha,
      ← Nat.add_mul, ← hmh]
  calc
    iterateMap N f (c * minPositivePeriod N f) y =
        iterate N f (minPreperiod N f y + a) y := by rw [ha]; rfl
    _ = iterate N f (minPreperiod N f y + h * minPositivePeriod N f + a) y :=
      hshift.symm
    _ = iterateMap N f (m * minPositivePeriod N f) y := by rw [hleft]; rfl
    _ = q.1 := by
      simpa [m] using iterateMap_rootReachExponent_reaches_root N f q hy

/-- 切り上げ位置より前の一周期反復は根へ到達しない
    （`claim_iterate_monoid_before_rounded_preperiod_not_root`）。 -/
theorem before_roundedPreperiod_not_root (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) {d : ℕ}
    (hd : d < roundedPreperiod N f y) :
    iterateMap N f (d * minPositivePeriod N f) y ≠ q.1 := by
  intro hroot
  have hnot : ¬ minPreperiod N f y ≤ d * minPositivePeriod N f := by
    intro hle
    exact (Nat.not_le_of_lt hd) (roundedPreperiod_le N f y hle)
  let m := rootReachExponent N f
  have hcm : roundedPreperiod N f y ≤ m := by
    apply roundedPreperiod_le N f y
    simpa [m] using calc
      minPreperiod N f y ≤ minCollisionStart N f := (globalPeriod_at_minPreperiod N f y).1
      _ ≤ minStablePeriodMultiple N f := (minStablePeriodMultiple_spec N f).1
      _ = rootReachExponent N f * minPositivePeriod N f :=
        (rootReachExponent_mul_minPositivePeriod N f).symm
  have hdm : d * minPositivePeriod N f < m * minPositivePeriod N f := by
    have hlam := minPositivePeriod_pos N f
    exact Nat.mul_lt_mul_of_pos_right (lt_of_lt_of_le hd hcm) hlam
  let p := m * minPositivePeriod N f - d * minPositivePeriod N f
  have hp : 1 ≤ p := by simp [p]; omega
  have hsum : d * minPositivePeriod N f + p = m * minPositivePeriod N f := by
    simp [p, Nat.add_sub_of_le (Nat.le_of_lt hdm)]
  have hcollision : iterate N f (d * minPositivePeriod N f + p) y =
      iterate N f (d * minPositivePeriod N f) y := by
    calc
      iterate N f (d * minPositivePeriod N f + p) y =
          iterateMap N f (m * minPositivePeriod N f) y := by rw [hsum]; rfl
      _ = q.1 := by
        simpa [m] using iterateMap_rootReachExponent_reaches_root N f q hy
      _ = iterateMap N f (d * minPositivePeriod N f) y := hroot.symm
  have hpair : IsPeriodicityPair N f y (d * minPositivePeriod N f) p :=
    (isPeriodicityPair_iff_collision N f y _ _).2 ⟨hp, hcollision⟩
  exact hnot (minPreperiod_le N f y ⟨p, hpair⟩)

/-- 根への深さは最小前周期を一周期単位で切り上げた値である
    （`claim_iterate_monoid_fiber_tree_depth_equals_rounded_preperiod`）。 -/
theorem fiberTreeDepth_eq_roundedPreperiod (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    fiberTreeDepth N f y = roundedPreperiod N f y := by
  apply Nat.le_antisymm
  · apply fiberTreeDepth_le
    calc
      iterateMap N f (roundedPreperiod N f y * minPositivePeriod N f) y = q.1 :=
        roundedPreperiod_reaches_root N f q hy
      _ = cycleIdempotent N f y := ((mem_stableFiber_iff N f q y).1 hy).symm
  · by_contra hnot
    have hlt : fiberTreeDepth N f y < roundedPreperiod N f y := Nat.lt_of_not_ge hnot
    exact before_roundedPreperiod_not_root N f q hy hlt
      (fiberTreeDepth_reaches_root N f q hy)

/-- 全配位を有限走査して `(y, μ(y), c_F(y), d_F(y))` を得る表
    （`claim_iterate_monoid_root_depth_preperiod_correspondence_finite_decidability`）。 -/
noncomputable def correspondenceTable :
    Finset ((V → State) × ℕ × ℕ × ℕ) := by
  classical
  exact Finset.univ.image (fun y =>
    (y, minPreperiod N f y, roundedPreperiod N f y, fiberTreeDepth N f y))

theorem mem_correspondenceTable (y : V → State) :
    (y, minPreperiod N f y, roundedPreperiod N f y, fiberTreeDepth N f y) ∈
      correspondenceTable N f := by
  classical
  exact Finset.mem_image.mpr ⟨y, Finset.mem_univ y, rfl⟩

theorem roundedPreperiod_le_rootReachExponent (y : V → State) :
    roundedPreperiod N f y ≤ rootReachExponent N f := by
  apply roundedPreperiod_le N f y
  simpa using calc
    minPreperiod N f y ≤ minCollisionStart N f := (globalPeriod_at_minPreperiod N f y).1
    _ ≤ minStablePeriodMultiple N f := (minStablePeriodMultiple_spec N f).1
    _ = rootReachExponent N f * minPositivePeriod N f :=
      (rootReachExponent_mul_minPositivePeriod N f).symm

end CellularAutomata.IterateMonoidRootDepthPreperiodCorrespondence
