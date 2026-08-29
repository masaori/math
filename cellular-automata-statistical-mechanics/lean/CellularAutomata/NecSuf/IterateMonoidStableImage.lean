/-
章「反復モノイドの冪等元が定める安定像」の必要十分版。

具体版と同じ手順（安定像 Q_F = im E_F、E_F の Q_F 上での恒等性、衝突開始後の反復写像の像と Q_F の
一致、逆写像候補 S_F = F^(e_F+λ_F-1) の左右恒等性、F・S_F が Q_F を保つこと、制限の相互逆性と
全単射性、有限走査表）を保ち、実際に使う構造だけを残す。

* 安定像の定義、E_F の恒等性、S_F の左右恒等性、F・S_F が Q_F を保つこと、制限の相互逆性と
  全単射性には、型 X、自己写像 F : X → X、衝突開始位置の存在（前章の e_F・λ_F・周期の伝播を
  与える）だけが要る。X の有限性はその存在を与える側にだけ現れ、この章の定理には現れない。
* X → X の等号判定（`DecidableEq (X → X)`）は、人手証明が「F^n ∈ C_F」を経由する
  衝突開始後の像の一致（`stable_power_image_eq`）で、巡回部を前章の `Finset` として書く段階にだけ
  要る。使わない定理には `omit` を付けた。
* X の有限性と X の等号判定は、全元へ E_F を適用する有限走査表（`stableImageTable`）にだけ要る。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidCyclicGroup

namespace CellularAutomata.NecSuf.IterateMonoidStableImage

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
open CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
open CellularAutomata.NecSuf.IterateMonoidCyclicGroup

variable {X : Type} [DecidableEq (X → X)]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

omit [DecidableEq (X → X)] in
/-- `Q_F := E_F(X)`。 -/
noncomputable def stableImage : Set X :=
  Set.range (cycleIdempotent F hex)

omit [DecidableEq (X → X)] in
/-- `E_F` は `Q_F` 上で恒等写像になる。冪等性だけを使う。 -/
theorem cycleIdempotent_retracts_stableImage
    {z : X} (hz : z ∈ stableImage F hex) :
    cycleIdempotent F hex z = z := by
  rcases hz with ⟨y, rfl⟩
  exact congrFun (cycleIdempotent_idempotent F hex) y

/-- 衝突開始後の反復写像は全て `Q_F` と同じ像をもつ。
    人手証明どおり `F^n ∈ C_F` を経由するため、ここだけ等号判定を要する。 -/
theorem stable_power_image_eq (n : ℕ) (hn : minCollisionStart F hex ≤ n) :
    Set.range (iterateMap F n) = stableImage F hex := by
  have hFn : iterateMap F n ∈ cyclePart F hex := by
    apply (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp
    refine ⟨n - minCollisionStart F hex, ?_⟩
    congr 1
    omega
  have hleft := cycleIdempotent_comp_eq F hex hFn
  let H := iterateMap F
    (minStablePeriodMultiple F hex + n * (minPositivePeriod F hex - 1))
  have hright : iterateMap F n ∘ H = cycleIdempotent F hex := by
    simpa [H] using (inverse_candidate_two_sided F hex n).1
  ext z
  constructor
  · rintro ⟨y, rfl⟩
    exact ⟨iterateMap F n y, congrFun hleft y⟩
  · rintro ⟨y, rfl⟩
    exact ⟨H y, congrFun hright y⟩

omit [DecidableEq (X → X)] in
/-- `S_F := F^(e_F+λ_F-1)`。 -/
noncomputable def stableInverse : X → X :=
  iterateMap F (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1)

omit [DecidableEq (X → X)] in
/-- `F ∘ S_F = E_F` と `S_F ∘ F = E_F`。周期の伝播と加法則だけを使う。 -/
theorem stableInverse_two_sided :
    F ∘ stableInverse F hex = cycleIdempotent F hex ∧
      stableInverse F hex ∘ F = cycleIdempotent F hex := by
  have hperiod := period_propagates_after_collision_start F hex
    (minPositivePeriod_spec F hex) (minStablePeriodMultiple_spec F hex).1
  have hlam := minPositivePeriod_pos F hex
  have hindex : 1 + (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1) =
      minStablePeriodMultiple F hex + minPositivePeriod F hex := by omega
  constructor
  · change iterateMap F 1 ∘ iterateMap F
      (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1) = _
    rw [iterateMap_comp_add, hindex]
    simpa [cycleIdempotent] using hperiod.symm
  · change iterateMap F
      (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1) ∘ iterateMap F 1 = _
    rw [iterateMap_comp_add, Nat.add_comm, hindex]
    simpa [cycleIdempotent] using hperiod.symm

/-- `F` は `Q_F` をそれ自身へ写す。 -/
theorem globalMap_maps_stableImage
    {z : X} (hz : z ∈ stableImage F hex) :
    F z ∈ stableImage F hex := by
  rcases hz with ⟨y, rfl⟩
  change (iterateMap F 1 ∘ iterateMap F (minStablePeriodMultiple F hex)) y ∈
    stableImage F hex
  rw [iterateMap_comp_add]
  have he := (minStablePeriodMultiple_spec F hex).1
  rw [← stable_power_image_eq F hex (1 + minStablePeriodMultiple F hex) (by omega)]
  exact ⟨y, rfl⟩

/-- `S_F` は `Q_F` をそれ自身へ写す。 -/
theorem stableInverse_maps_stableImage
    {z : X} (hz : z ∈ stableImage F hex) :
    stableInverse F hex z ∈ stableImage F hex := by
  rcases hz with ⟨y, rfl⟩
  rw [stableInverse, cycleIdempotent]
  change (iterateMap F (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1) ∘
    iterateMap F (minStablePeriodMultiple F hex)) y ∈ stableImage F hex
  rw [iterateMap_comp_add]
  rw [← stable_power_image_eq F hex
    (minStablePeriodMultiple F hex + minPositivePeriod F hex - 1 +
      minStablePeriodMultiple F hex) (by
        exact (minStablePeriodMultiple_spec F hex).1.trans
          (Nat.le_add_left _ _))]
  exact ⟨y, rfl⟩

/-- `F` の `Q_F` への制限。 -/
noncomputable def stableStep : stableImage F hex → stableImage F hex :=
  fun z => ⟨F z.1, globalMap_maps_stableImage F hex z.2⟩

/-- `S_F` の `Q_F` への制限。 -/
noncomputable def stableStepInverse : stableImage F hex → stableImage F hex :=
  fun z => ⟨stableInverse F hex z.1, stableInverse_maps_stableImage F hex z.2⟩

/-- 二つの制限は互いに逆写像である。 -/
theorem stableStep_inverse_laws :
    Function.LeftInverse (stableStepInverse F hex) (stableStep F hex) ∧
      Function.RightInverse (stableStepInverse F hex) (stableStep F hex) := by
  constructor <;> intro z <;> apply Subtype.ext
  · exact (congrFun (stableInverse_two_sided F hex).2 z.1).trans
      (cycleIdempotent_retracts_stableImage F hex z.2)
  · exact (congrFun (stableInverse_two_sided F hex).1 z.1).trans
      (cycleIdempotent_retracts_stableImage F hex z.2)

/-- 一段発展の安定像への制限は全単射である。 -/
theorem stableStep_bijective : Function.Bijective (stableStep F hex) :=
  ⟨(stableStep_inverse_laws F hex).1.injective,
    (stableStep_inverse_laws F hex).2.surjective⟩

section FiniteScan

variable [Fintype X] [DecidableEq X]

omit [DecidableEq (X → X)] in
/-- 全元へ `E_F` を適用して重複を除く有限走査表。X の有限性と等号判定を要する。 -/
noncomputable def stableImageTable : Finset X :=
  Finset.univ.image (cycleIdempotent F hex)

omit [DecidableEq (X → X)] in
/-- 有限走査表は安定像をちょうど列挙する。 -/
theorem coe_stableImageTable :
    (stableImageTable F hex : Set X) = stableImage F hex := by
  ext z
  simp [stableImageTable, stableImage]

omit [DecidableEq (X → X)] in
/-- `Q_F` 上の `E_F`、`F`、`S_F` の有限な表。 -/
noncomputable def stableRestrictedTables : Finset (X × X × X × X) :=
  (stableImageTable F hex).image
    (fun z => (z, cycleIdempotent F hex z, F z, stableInverse F hex z))

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStableImage
