/-
章「安定ファイバー間の一段発展」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-stable-fiber-dynamics.ts。

安定像上の添字写像、冪等反復写像との可換性、安定ファイバーの完全逆像、
一元舞台の定値規則による真の包含の反例、有限走査を人手証明と同じ順序で形式化する。
有限集合・写像合成・写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStablePartition
import CellularAutomata.IterateMonoidIdempotents
import CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics

namespace CellularAutomata.IterateMonoidStableFiberDynamics

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidTailCycleDecomposition
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidIdempotents

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `σ_F(q) := F(q)`。前章の `stableStep` と同じ制限写像である。 -/
noncomputable def stableIndexMap : stableImage N f → stableImage N f :=
  stableStep N f

theorem stableIndexMap_val (q : stableImage N f) :
    (stableIndexMap N f q).1 = globalMap N f q.1 := rfl

/-- 安定像上の添字写像は全単射である。 -/
theorem stableIndexMap_bijective : Function.Bijective (stableIndexMap N f) :=
  stableStep_bijective N f

/-- `E_F ∘ F = F ∘ E_F`。反復回数の加法則を両方向に適用する。 -/
theorem cycleIdempotent_commutes_with_globalMap (y : V → State) :
    cycleIdempotent N f (globalMap N f y) =
      globalMap N f (cycleIdempotent N f y) := by
  have hF : globalMap N f = iterateMap N f 1 := by
    funext z
    rfl
  change (cycleIdempotent N f ∘ globalMap N f) y =
    (globalMap N f ∘ cycleIdempotent N f) y
  rw [cycleIdempotent, hF, iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

/-- 点ごとの完全逆像の同値。人手証明の順方向と逆方向をそのまま分ける。 -/
theorem globalMap_mem_stableFiber_index_iff
    (q : stableImage N f) (y : V → State) :
    globalMap N f y ∈ stableFiber N f (stableIndexMap N f q) ↔
      y ∈ stableFiber N f q := by
  constructor
  · intro hy
    have hFE : globalMap N f (cycleIdempotent N f y) = globalMap N f q.1 := by
      calc
        globalMap N f (cycleIdempotent N f y) =
            cycleIdempotent N f (globalMap N f y) :=
          (cycleIdempotent_commutes_with_globalMap N f y).symm
        _ = (stableIndexMap N f q).1 := hy
        _ = globalMap N f q.1 := rfl
    have hstep : stableIndexMap N f (stableRepresentative N f y) =
        stableIndexMap N f q := by
      apply Subtype.ext
      exact hFE
    have hrep := (stableIndexMap_bijective N f).1 hstep
    exact congrArg Subtype.val hrep
  · intro hy
    calc
      cycleIdempotent N f (globalMap N f y) =
          globalMap N f (cycleIdempotent N f y) :=
        cycleIdempotent_commutes_with_globalMap N f y
      _ = globalMap N f q.1 := congrArg (globalMap N f) hy
      _ = (stableIndexMap N f q).1 := rfl

/-- `F⁻¹(B_F(σ_F(q))) = B_F(q)`。 -/
theorem stableFiber_exact_preimage (q : stableImage N f) :
    globalMap N f ⁻¹' stableFiber N f (stableIndexMap N f q) =
      stableFiber N f q := by
  ext y
  exact globalMap_mem_stableFiber_index_iff N f q y

/-- 常に `F(B_F(q)) ⊆ B_F(σ_F(q))`。 -/
theorem stableFiber_image_subset (q : stableImage N f) :
    globalMap N f '' stableFiber N f q ⊆
      stableFiber N f (stableIndexMap N f q) := by
  rintro z ⟨y, hy, rfl⟩
  exact (globalMap_mem_stableFiber_index_iff N f q y).2 hy

/-! ### 一元舞台の定値規則による反例 -/

private def zeroConfig : Unit → State := fun _ => State.zero
private def oneConfig : Unit → State := fun _ => State.one

private theorem constantZero_iterateMap_of_pos (n : ℕ) (hn : 0 < n) :
    iterateMap oneCellNeighborhood constantZeroLocalRule n = fun _ => zeroConfig := by
  cases n with
  | zero => omega
  | succ n =>
      funext y v
      rfl

private theorem constantZero_minCollisionStart :
    minCollisionStart oneCellNeighborhood constantZeroLocalRule = 1 := by
  have hstart : IsCollisionStart oneCellNeighborhood constantZeroLocalRule 1 := by
    refine ⟨1, by omega, ?_⟩
    rw [constantZero_iterateMap_of_pos 1 (by omega),
      constantZero_iterateMap_of_pos 2 (by omega)]
  apply Nat.le_antisymm
  · exact minCollisionStart_le oneCellNeighborhood constantZeroLocalRule hstart
  · have hpos : 0 < minCollisionStart oneCellNeighborhood constantZeroLocalRule := by
      by_contra h
      have hzero : minCollisionStart oneCellNeighborhood constantZeroLocalRule = 0 := by omega
      rcases minCollisionStart_spec oneCellNeighborhood constantZeroLocalRule with ⟨p, hp, heq⟩
      rw [hzero] at heq
      rw [Nat.zero_add] at heq
      have hvalue := congrFun (congrFun heq oneConfig) ()
      rw [constantZero_iterateMap_of_pos p hp] at hvalue
      change oneConfig () = zeroConfig () at hvalue
      exact State.noConfusion hvalue
    omega

private theorem constantZero_minPositivePeriod :
    minPositivePeriod oneCellNeighborhood constantZeroLocalRule = 1 := by
  have hperiod : IsPositivePeriod oneCellNeighborhood constantZeroLocalRule 1 := by
    refine ⟨by omega, ?_⟩
    rw [constantZero_minCollisionStart]
    rw [constantZero_iterateMap_of_pos 1 (by omega),
      constantZero_iterateMap_of_pos 2 (by omega)]
  exact Nat.le_antisymm
    (minPositivePeriod_le oneCellNeighborhood constantZeroLocalRule hperiod)
    (minPositivePeriod_pos oneCellNeighborhood constantZeroLocalRule)

private theorem constantZero_minStablePeriodMultiple :
    minStablePeriodMultiple oneCellNeighborhood constantZeroLocalRule = 1 := by
  have hone : IsStablePeriodMultiple oneCellNeighborhood constantZeroLocalRule 1 := by
    rw [IsStablePeriodMultiple, constantZero_minCollisionStart,
      constantZero_minPositivePeriod]
    exact ⟨le_rfl, dvd_refl 1⟩
  apply Nat.le_antisymm
  · exact minStablePeriodMultiple_le oneCellNeighborhood constantZeroLocalRule hone
  · rw [← constantZero_minCollisionStart]
    exact (minStablePeriodMultiple_spec oneCellNeighborhood constantZeroLocalRule).1

private theorem constantZero_cycleIdempotent_eq_globalMap :
    cycleIdempotent oneCellNeighborhood constantZeroLocalRule =
      globalMap oneCellNeighborhood constantZeroLocalRule := by
  rw [cycleIdempotent, constantZero_minStablePeriodMultiple]
  rfl

/-- 一元舞台の定値規則ではファイバーの像が次のファイバーの真部分集合になる。 -/
theorem constantZero_stableFiber_image_strict :
    ∃ q : stableImage oneCellNeighborhood constantZeroLocalRule,
      globalMap oneCellNeighborhood constantZeroLocalRule ''
          stableFiber oneCellNeighborhood constantZeroLocalRule q ⊂
        stableFiber oneCellNeighborhood constantZeroLocalRule
          (stableIndexMap oneCellNeighborhood constantZeroLocalRule q) := by
  let q : stableImage oneCellNeighborhood constantZeroLocalRule :=
    ⟨zeroConfig, ⟨zeroConfig, by
      rw [constantZero_cycleIdempotent_eq_globalMap]
      exact constantZero_globalMap zeroConfig⟩⟩
  refine ⟨q, stableFiber_image_subset oneCellNeighborhood constantZeroLocalRule q, ?_⟩
  intro hreverse
  have honeTarget : oneConfig ∈ stableFiber oneCellNeighborhood constantZeroLocalRule
      (stableIndexMap oneCellNeighborhood constantZeroLocalRule q) := by
    change cycleIdempotent oneCellNeighborhood constantZeroLocalRule oneConfig =
      globalMap oneCellNeighborhood constantZeroLocalRule q.1
    rw [constantZero_cycleIdempotent_eq_globalMap]
    exact (constantZero_globalMap oneConfig).trans (constantZero_globalMap q.1).symm
  have honeImage : oneConfig ∈
      globalMap oneCellNeighborhood constantZeroLocalRule ''
        stableFiber oneCellNeighborhood constantZeroLocalRule q := hreverse honeTarget
  rcases honeImage with ⟨y, _hy, hy⟩
  have hz := constantZero_globalMap y
  have : oneConfig = zeroConfig := hy.symm.trans hz
  exact State.noConfusion (congrFun this ())

/-! ### 有限走査表 -/

/-- `σ_F` の有限な表。 -/
noncomputable def stableIndexMapTable :
    Finset (stableImage N f × stableImage N f) :=
  Finset.univ.image (fun q => (q, stableIndexMap N f q))

/-- `F(B_F(q))` の有限走査表。 -/
noncomputable def stableFiberImageTable (q : stableImage N f) : Finset (V → State) :=
  (stableFiberTable N f q).image (globalMap N f)

/-- `F⁻¹(B_F(σ_F(q)))` の有限走査表。 -/
noncomputable def stableFiberPreimageTable (q : stableImage N f) : Finset (V → State) :=
  Finset.univ.filter (fun y =>
    globalMap N f y ∈ stableFiberTable N f (stableIndexMap N f q))

theorem mem_stableFiberPreimageTable_iff (q : stableImage N f) (y : V → State) :
    y ∈ stableFiberPreimageTable N f q ↔ y ∈ stableFiber N f q := by
  classical
  simp only [stableFiberPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
  rw [mem_stableFiberTable_iff]
  exact globalMap_mem_stableFiber_index_iff N f q y

/-! ## 必要十分版からの導出

具体版は必要十分版を X := V → State、F := globalMap N f、E := E_F（hex := necSufHex N f）へ
特殊化したものである。安定像・安定ファイバーは前二章の導出により必要十分版の像・ファイバーに一致し、
添字写像の値は定義から `globalMap N f q.1` で一致する。反例は、必要十分版の
「相異なる二点への定値写像」を X := Unit → State、a := zeroConfig、b := oneConfig へ特殊化して得る。 -/

section Derivation

/-- 可換性は必要十分版の反復層の特殊化である。 -/
theorem cycleIdempotent_commutes_with_globalMap_from_necessary_sufficient (y : V → State) :
    cycleIdempotent N f (globalMap N f y) =
      globalMap N f (cycleIdempotent N f y) := by
  rw [cycleIdempotent_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.cycleIdempotent_commutes
    (globalMap N f) (necSufHex N f) y

/-- 安定像の元は必要十分版の像に属する。 -/
theorem stableImage_mem_necessary_sufficient (q : stableImage N f) :
    q.1 ∈ CellularAutomata.NecSuf.IterateMonoidStablePartition.stableImage
      (CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent
        (globalMap N f) (necSufHex N f)) := by
  obtain ⟨y, hy⟩ := q.2
  refine ⟨y, ?_⟩
  rw [← cycleIdempotent_eq_necessary_sufficient]
  exact hy

/-- 完全逆像の点ごとの同値は、必要十分版の一般層（可換性・像上の単射性）の特殊化である。 -/
theorem globalMap_mem_stableFiber_index_iff_from_necessary_sufficient
    (q : stableImage N f) (y : V → State) :
    globalMap N f y ∈ stableFiber N f (stableIndexMap N f q) ↔
      y ∈ stableFiber N f q := by
  have hq := stableImage_mem_necessary_sufficient N f q
  change cycleIdempotent N f (globalMap N f y) = globalMap N f q.1 ↔
    cycleIdempotent N f y = q.1
  rw [cycleIdempotent_eq_necessary_sufficient]
  constructor
  · intro h
    exact CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.index_backward_pointwise
      (globalMap N f) _
      (CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.cycleIdempotent_commutes
        (globalMap N f) (necSufHex N f))
      (CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.globalMap_injOn_range_cycleIdempotent
        (globalMap N f) (necSufHex N f)) hq h
  · intro h
    exact CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.index_forward_pointwise
      (globalMap N f) _
      (CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.cycleIdempotent_commutes
        (globalMap N f) (necSufHex N f)) h

theorem stableFiber_exact_preimage_from_necessary_sufficient (q : stableImage N f) :
    globalMap N f ⁻¹' stableFiber N f (stableIndexMap N f q) =
      stableFiber N f q := by
  ext y
  exact globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y

theorem stableFiber_image_subset_from_necessary_sufficient (q : stableImage N f) :
    globalMap N f '' stableFiber N f q ⊆
      stableFiber N f (stableIndexMap N f q) := by
  rintro z ⟨y, hy, rfl⟩
  exact (globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y).2 hy

/-- 完全逆像の有限走査表の正しさは、必要十分版の点ごとの同値から得られる。 -/
theorem mem_stableFiberPreimageTable_iff_from_necessary_sufficient
    (q : stableImage N f) (y : V → State) :
    y ∈ stableFiberPreimageTable N f q ↔ y ∈ stableFiber N f q := by
  classical
  simp only [stableFiberPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
  rw [mem_stableFiberTable_iff]
  exact globalMap_mem_stableFiber_index_iff_from_necessary_sufficient N f q y

/-- 反例は必要十分版の「相異なる二点への定値写像」の特殊化である。 -/
theorem constantZero_stableFiber_image_strict_from_necessary_sufficient :
    ∃ q : stableImage oneCellNeighborhood constantZeroLocalRule,
      globalMap oneCellNeighborhood constantZeroLocalRule ''
          stableFiber oneCellNeighborhood constantZeroLocalRule q ⊂
        stableFiber oneCellNeighborhood constantZeroLocalRule
          (stableIndexMap oneCellNeighborhood constantZeroLocalRule q) := by
  have hF : globalMap oneCellNeighborhood constantZeroLocalRule =
      fun _ : Unit → State => zeroConfig := funext constantZero_globalMap
  have hab : zeroConfig ≠ oneConfig := fun h => State.noConfusion (congrFun h ())
  obtain ⟨q', hq'⟩ :=
    CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.const_stableFiber_image_strict hab
  have hE : cycleIdempotent oneCellNeighborhood constantZeroLocalRule =
      CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent
        (fun _ : Unit → State => zeroConfig)
        (CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.const_hex (a := zeroConfig)) := by
    rw [cycleIdempotent_eq_necessary_sufficient]
    have key : ∀ (G : (Unit → State) → (Unit → State))
        (hG : globalMap oneCellNeighborhood constantZeroLocalRule = G)
        (hexG : ∃ n : ℕ,
          CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.IsCollisionStart G n),
        CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent
            (globalMap oneCellNeighborhood constantZeroLocalRule)
            (necSufHex oneCellNeighborhood constantZeroLocalRule) =
          CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent G hexG := by
      intro G hG hexG
      subst hG
      rfl
    exact key _ hF _
  let q : stableImage oneCellNeighborhood constantZeroLocalRule :=
    ⟨q'.1, by
      show q'.1 ∈ Set.range (cycleIdempotent oneCellNeighborhood constantZeroLocalRule)
      rw [hE]
      exact q'.2⟩
  have h1 : stableFiber oneCellNeighborhood constantZeroLocalRule q =
      CellularAutomata.NecSuf.IterateMonoidStablePartition.stableFiber _ q' := by
    ext y
    show cycleIdempotent oneCellNeighborhood constantZeroLocalRule y = q'.1 ↔
      CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent
        (fun _ : Unit → State => zeroConfig) _ y = q'.1
    rw [hE]
  have h2 : stableFiber oneCellNeighborhood constantZeroLocalRule
      (stableIndexMap oneCellNeighborhood constantZeroLocalRule q) =
      CellularAutomata.NecSuf.IterateMonoidStablePartition.stableFiber _
        (CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics.iterateStableIndexMap
          (fun _ : Unit → State => zeroConfig) _ q') := by
    ext y
    show cycleIdempotent oneCellNeighborhood constantZeroLocalRule y =
        globalMap oneCellNeighborhood constantZeroLocalRule q'.1 ↔
      CellularAutomata.NecSuf.IterateMonoidCycleIdempotent.cycleIdempotent
        (fun _ : Unit → State => zeroConfig) _ y = (fun _ : Unit → State => zeroConfig) q'.1
    rw [hE, hF]
  refine ⟨q, ?_⟩
  rw [h1, h2, hF]
  exact hq'

end Derivation

end CellularAutomata.IterateMonoidStableFiberDynamics
