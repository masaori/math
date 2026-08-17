/-
章「安定ファイバーの層別完全逆像」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-stable-fiber-layer-preimage.ts。

零層の保存、正の層と零層の完全逆像、および有限走査表を、人手証明と
同じ対象・仮定・順序で形式化する。有限集合・自然数・写像の等号だけを使い、
R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberDepth

namespace CellularAutomata.IterateMonoidStableFiberLayerPreimage

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberDynamics
open CellularAutomata.IterateMonoidStableFiberDepth

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 最小前周期が零なら、一段発展後の最小前周期も零である。 -/
theorem minPreperiod_globalMap_eq_zero
    (y : V → State) (hzero : minPreperiod N f y = 0) :
    minPreperiod N f (globalMap N f y) = 0 := by
  let p := minPeriod N f y
  have hp : IsPeriodicityPair N f y 0 p := by
    simpa [hzero] using minPeriod_spec N f y
  have hpair : IsPeriodicityPair N f (globalMap N f y) 0 p := by
    refine ⟨hp.1, ?_⟩
    intro n _hn
    calc
      iterate N f (n + p) (globalMap N f y) =
          iterate N f (n + p + 1) y := iterate_globalMap N f (n + p) y
      _ = iterate N f (n + 1 + p) y := by congr 1 <;> omega
      _ = iterate N f (n + 1) y := hp.2 (n + 1) (by omega)
      _ = iterate N f n (globalMap N f y) :=
        (iterate_globalMap N f n y).symm
  exact Nat.eq_zero_of_le_zero (minPreperiod_le N f (globalMap N f y) ⟨p, hpair⟩)

/-- 正の層の完全逆像は一つ上の層である。 -/
theorem positive_depthLayer_exact_preimage
    (q : stableImage N f) (k : ℕ) (hk : 0 < k) :
    globalMap N f ⁻¹'
        stableFiberDepthLayer N f (stableIndexMap N f q) k =
      stableFiberDepthLayer N f q (k + 1) := by
  ext y
  constructor
  · intro hy
    have hyq : y ∈ stableFiber N f q :=
      (globalMap_mem_stableFiber_index_iff N f q y).1 hy.1
    have hyk : minPreperiod N f (globalMap N f y) = k := hy.2
    have hypos : 0 < minPreperiod N f y := by
      by_contra h
      have hyzero : minPreperiod N f y = 0 := by omega
      have hnextZero := minPreperiod_globalMap_eq_zero N f y hyzero
      omega
    have hdec := minPreperiod_globalMap_eq_sub_one N f y hypos
    refine ⟨hyq, ?_⟩
    omega
  · intro hy
    have hydepth : minPreperiod N f y = k + 1 := hy.2
    have hypos : 0 < minPreperiod N f y := by omega
    refine ⟨(globalMap_mem_stableFiber_index_iff N f q y).2 hy.1, ?_⟩
    rw [minPreperiod_globalMap_eq_sub_one N f y hypos]
    omega

/-- 零層の完全逆像は零層と一層の合併である。 -/
theorem zero_depthLayer_exact_preimage (q : stableImage N f) :
    globalMap N f ⁻¹'
        stableFiberDepthLayer N f (stableIndexMap N f q) 0 =
      stableFiberDepthLayer N f q 0 ∪ stableFiberDepthLayer N f q 1 := by
  ext y
  constructor
  · intro hy
    have hyq : y ∈ stableFiber N f q :=
      (globalMap_mem_stableFiber_index_iff N f q y).1 hy.1
    by_cases hzero : minPreperiod N f y = 0
    · exact Or.inl ⟨hyq, hzero⟩
    · right
      have hpos : 0 < minPreperiod N f y := Nat.pos_of_ne_zero hzero
      have htarget : minPreperiod N f (globalMap N f y) = 0 := hy.2
      have hdec := minPreperiod_globalMap_eq_sub_one N f y hpos
      exact ⟨hyq, by omega⟩
  · rintro (hy | hy)
    · refine ⟨(globalMap_mem_stableFiber_index_iff N f q y).2 hy.1, ?_⟩
      exact minPreperiod_globalMap_eq_zero N f y hy.2
    · refine ⟨(globalMap_mem_stableFiber_index_iff N f q y).2 hy.1, ?_⟩
      have hyone : minPreperiod N f y = 1 := hy.2
      have hpos : 0 < minPreperiod N f y := by omega
      have hdec := minPreperiod_globalMap_eq_sub_one N f y hpos
      omega

/-- 層の一段完全逆像を全配位から有限走査した表。 -/
noncomputable def depthLayerPreimageTable
    (q : stableImage N f) (k : ℕ) : Finset (V → State) :=
  Finset.univ.filter fun y =>
    globalMap N f y ∈ stableFiberDepthLayerTable N f (stableIndexMap N f q) k

theorem mem_depthLayerPreimageTable_iff
    (q : stableImage N f) (k : ℕ) (y : V → State) :
    y ∈ depthLayerPreimageTable N f q k ↔
      globalMap N f y ∈ stableFiberDepthLayer N f (stableIndexMap N f q) k := by
  classical
  simp [depthLayerPreimageTable, mem_stableFiberDepthLayerTable_iff]

/-- 全安定ファイバー・全深さについて、層とその完全逆像を有限列挙する。 -/
noncomputable def depthLayerPreimageDataTable :
    Finset (stableImage N f × ℕ × Finset (V → State) × Finset (V → State)) :=
  Finset.univ.biUnion fun q =>
    (Finset.range (2 ^ Fintype.card V + 1)).image fun k =>
      (q, k, stableFiberDepthLayerTable N f q k,
        depthLayerPreimageTable N f q k)

end CellularAutomata.IterateMonoidStableFiberLayerPreimage
