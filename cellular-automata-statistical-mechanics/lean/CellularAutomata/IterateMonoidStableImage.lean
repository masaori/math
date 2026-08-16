/-
章「反復モノイドの冪等元が定める安定像」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-stable-image.ts。

安定像、安定後の反復写像の像の一致、安定像上での一段発展の全単射性を、
人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidCyclicGroup

namespace CellularAutomata.IterateMonoidStableImage

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidTailCycleDecomposition
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidCyclicGroup

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `Q_F := E_F(A^V)`。 -/
noncomputable def stableImage : Set (V → State) :=
  Set.range (cycleIdempotent N f)

/-- `E_F` は `Q_F` 上で恒等写像になる。 -/
theorem cycleIdempotent_retracts_stableImage
    {z : V → State} (hz : z ∈ stableImage N f) :
    cycleIdempotent N f z = z := by
  rcases hz with ⟨y, rfl⟩
  exact congrFun (cycleIdempotent_mem_and_idempotent N f).2 y

/-- 衝突開始後の反復写像は全て `Q_F` と同じ像をもつ。 -/
theorem stable_power_image_eq (n : ℕ) (hn : minCollisionStart N f ≤ n) :
    Set.range (iterateMap N f n) = stableImage N f := by
  have hFn : iterateMap N f n ∈ cyclePart N f := by
    apply (mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp
    refine ⟨n - minCollisionStart N f, ?_⟩
    congr 1
    omega
  have hleft := cycleIdempotent_comp_eq N f hFn
  let H := iterateMap N f
    (minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1))
  have hright : iterateMap N f n ∘ H = cycleIdempotent N f := by
    simpa [H] using (inverse_candidate_two_sided N f n).1
  ext z
  constructor
  · rintro ⟨y, rfl⟩
    exact ⟨iterateMap N f n y, congrFun hleft y⟩
  · rintro ⟨y, rfl⟩
    exact ⟨H y, congrFun hright y⟩

/-- `R_F := F^(e_F+λ_F-1)`。 -/
noncomputable def stableInverse : (V → State) → (V → State) :=
  iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f - 1)

/-- `F ∘ R_F = E_F` と `R_F ∘ F = E_F`。 -/
theorem stableInverse_two_sided :
    globalMap N f ∘ stableInverse N f = cycleIdempotent N f ∧
      stableInverse N f ∘ globalMap N f = cycleIdempotent N f := by
  have hperiod := period_propagates_after_collision_start N f
    (minPositivePeriod_spec N f) (minStablePeriodMultiple_spec N f).1
  have hF : globalMap N f = iterateMap N f 1 := by
    funext y
    rfl
  have hlam := minPositivePeriod_pos N f
  have hindex : 1 + (minStablePeriodMultiple N f + minPositivePeriod N f - 1) =
      minStablePeriodMultiple N f + minPositivePeriod N f := by omega
  constructor
  · rw [stableInverse, hF, iterateMap_comp_add]
    rw [hindex]
    simpa [cycleIdempotent] using hperiod.symm
  · rw [stableInverse, hF, iterateMap_comp_add]
    rw [Nat.add_comm, hindex]
    simpa [cycleIdempotent] using hperiod.symm

/-- `F` は `Q_F` をそれ自身へ写す。 -/
theorem globalMap_maps_stableImage
    {z : V → State} (hz : z ∈ stableImage N f) :
    globalMap N f z ∈ stableImage N f := by
  rcases hz with ⟨y, rfl⟩
  have hF : globalMap N f = iterateMap N f 1 := by
    funext x
    rfl
  rw [cycleIdempotent, hF]
  change (iterateMap N f 1 ∘ iterateMap N f (minStablePeriodMultiple N f)) y ∈
    stableImage N f
  rw [iterateMap_comp_add]
  have he := (minStablePeriodMultiple_spec N f).1
  rw [← stable_power_image_eq N f (1 + minStablePeriodMultiple N f)
    (by omega)]
  exact ⟨y, rfl⟩

/-- `R_F` は `Q_F` をそれ自身へ写す。 -/
theorem stableInverse_maps_stableImage
    {z : V → State} (hz : z ∈ stableImage N f) :
    stableInverse N f z ∈ stableImage N f := by
  rcases hz with ⟨y, rfl⟩
  rw [stableInverse, cycleIdempotent]
  change (iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f - 1) ∘
    iterateMap N f (minStablePeriodMultiple N f)) y ∈ stableImage N f
  rw [iterateMap_comp_add]
  rw [← stable_power_image_eq N f
    (minStablePeriodMultiple N f + minPositivePeriod N f - 1 +
      minStablePeriodMultiple N f) (by
        exact (minStablePeriodMultiple_spec N f).1.trans
          (Nat.le_add_left _ _))]
  exact ⟨y, rfl⟩

/-- `F` の `Q_F` への制限。 -/
noncomputable def stableStep : stableImage N f → stableImage N f :=
  fun z => ⟨globalMap N f z.1, globalMap_maps_stableImage N f z.2⟩

/-- `R_F` の `Q_F` への制限。 -/
noncomputable def stableStepInverse : stableImage N f → stableImage N f :=
  fun z => ⟨stableInverse N f z.1, stableInverse_maps_stableImage N f z.2⟩

/-- 二つの制限は互いに逆写像である。 -/
theorem stableStep_inverse_laws :
    Function.LeftInverse (stableStepInverse N f) (stableStep N f) ∧
      Function.RightInverse (stableStepInverse N f) (stableStep N f) := by
  constructor <;> intro z <;> apply Subtype.ext
  · exact (congrFun (stableInverse_two_sided N f).2 z.1).trans
      (cycleIdempotent_retracts_stableImage N f z.2)
  · exact (congrFun (stableInverse_two_sided N f).1 z.1).trans
      (cycleIdempotent_retracts_stableImage N f z.2)

/-- 一段発展の安定像への制限は全単射である。 -/
theorem stableStep_bijective : Function.Bijective (stableStep N f) :=
  ⟨(stableStep_inverse_laws N f).1.injective,
    (stableStep_inverse_laws N f).2.surjective⟩

/-- 全配位へ `E_F` を適用して重複を除く有限走査表。 -/
noncomputable def stableImageTable : Finset (V → State) :=
  Finset.univ.image (cycleIdempotent N f)

/-- 有限走査表は安定像をちょうど列挙する。 -/
theorem coe_stableImageTable :
    (stableImageTable N f : Set (V → State)) = stableImage N f := by
  ext z
  simp [stableImageTable, stableImage]

/-- `Q_F` 上の `E_F`、`F`、`R_F` の有限な表。 -/
noncomputable def stableRestrictedTables : Finset
    ((V → State) × (V → State) × (V → State) × (V → State)) :=
  (stableImageTable N f).image
    (fun z => (z, cycleIdempotent N f z, globalMap N f z, stableInverse N f z))

/-- 安定像と三つの制限写像は有限型上の有限走査で決定可能である。 -/
noncomputable instance : Fintype (stableImage N f) := Fintype.ofFinite _

end CellularAutomata.IterateMonoidStableImage
