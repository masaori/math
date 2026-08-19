/-
章「有限大域写像の共役による安定ファイバー根付き木族の不変性」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-conjugacy-invariance.ts。

二つの有限舞台上の二値 CA と、その大域写像を結ぶ共役全単射について、反復、
最小衝突開始位置、最小正周期、巡回冪等元、安定像・安定ファイバー、
一周期写像、根付き辺、深さを、人手証明と同じ順序で移送する。
有限集合・自然数・写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberRootedTree
import CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance

namespace CellularAutomata.IterateMonoidConjugacyInvariance

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition
open CellularAutomata.IterateMonoidStableFiberRootedTree

variable {V W : Type} [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W]
variable (NV : V → Finset V) (fV : (v : V) → (↥(NV v) → State) → State)
variable (NW : W → Finset W) (fW : (w : W) → (↥(NW w) → State) → State)
variable (h : (V → State) ≃ (W → State))
variable (hconj : ∀ y, h (globalMap NV fV y) = globalMap NW fW (h y))

include h hconj

omit [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W] in
/-- 共役全単射は全ての反復を移送する。 -/
theorem conjugate_iterate (n : ℕ) (y : V → State) :
    h (iterate NV fV n y) = iterate NW fW n (h y) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [iterate_succ, iterate_succ, hconj, ih]

/-- 反復写像の等号は共役の両側で同値である。 -/
theorem iterateMap_eq_iff (m n : ℕ) :
    iterateMap NV fV m = iterateMap NV fV n ↔
      iterateMap NW fW m = iterateMap NW fW n := by
  constructor
  · intro heq
    funext z
    obtain ⟨y, rfl⟩ := h.surjective z
    exact (conjugate_iterate NV fV NW fW h hconj m y).symm.trans <|
      congrArg h (congrFun heq y) |>.trans
        (conjugate_iterate NV fV NW fW h hconj n y)
  · intro heq
    funext y
    apply h.injective
    exact (conjugate_iterate NV fV NW fW h hconj m y).trans <|
      congrFun heq (h y) |>.trans
        (conjugate_iterate NV fV NW fW h hconj n y).symm

/-- 衝突開始位置は共役の両側で同値である。 -/
theorem isCollisionStart_iff (n : ℕ) :
    IsCollisionStart NV fV n ↔ IsCollisionStart NW fW n := by
  constructor
  · rintro ⟨p, hp, heq⟩
    exact ⟨p, hp, (iterateMap_eq_iff NV fV NW fW h hconj n (n + p)).mp heq⟩
  · rintro ⟨p, hp, heq⟩
    exact ⟨p, hp, (iterateMap_eq_iff NV fV NW fW h hconj n (n + p)).mpr heq⟩

/-- 共役全単射は最小衝突開始位置を保存する。 -/
theorem minCollisionStart_eq :
    minCollisionStart NV fV = minCollisionStart NW fW := by
  apply Nat.le_antisymm
  · apply minCollisionStart_le
    exact (isCollisionStart_iff NV fV NW fW h hconj _).mpr
      (minCollisionStart_spec NW fW)
  · apply minCollisionStart_le
    exact (isCollisionStart_iff NV fV NW fW h hconj _).mp
      (minCollisionStart_spec NV fV)

/-- 正周期は共役の両側で同値である。 -/
theorem isPositivePeriod_iff (p : ℕ) :
    IsPositivePeriod NV fV p ↔ IsPositivePeriod NW fW p := by
  rw [IsPositivePeriod, IsPositivePeriod, minCollisionStart_eq NV fV NW fW h hconj]
  exact and_congr_right fun _ => iterateMap_eq_iff NV fV NW fW h hconj _ _

/-- 共役全単射は最小正周期を保存する。 -/
theorem minPositivePeriod_eq :
    minPositivePeriod NV fV = minPositivePeriod NW fW := by
  apply Nat.le_antisymm
  · apply minPositivePeriod_le
    exact (isPositivePeriod_iff NV fV NW fW h hconj _).mpr
      (minPositivePeriod_spec NW fW)
  · apply minPositivePeriod_le
    exact (isPositivePeriod_iff NV fV NW fW h hconj _).mp
      (minPositivePeriod_spec NV fV)

/-- 安定後の周期倍数指数は共役の両側で同値である。 -/
theorem isStablePeriodMultiple_iff (n : ℕ) :
    IsStablePeriodMultiple NV fV n ↔ IsStablePeriodMultiple NW fW n := by
  simp only [IsStablePeriodMultiple, minCollisionStart_eq NV fV NW fW h hconj,
    minPositivePeriod_eq NV fV NW fW h hconj]

/-- 共役全単射は最小安定周期倍数指数を保存する。 -/
theorem minStablePeriodMultiple_eq :
    minStablePeriodMultiple NV fV = minStablePeriodMultiple NW fW := by
  apply Nat.le_antisymm
  · apply minStablePeriodMultiple_le
    exact (isStablePeriodMultiple_iff NV fV NW fW h hconj _).mpr
      (minStablePeriodMultiple_spec NW fW)
  · apply minStablePeriodMultiple_le
    exact (isStablePeriodMultiple_iff NV fV NW fW h hconj _).mp
      (minStablePeriodMultiple_spec NV fV)

/-- 共役全単射は巡回部の冪等元を移送する。 -/
theorem conjugate_cycleIdempotent (y : V → State) :
    h (cycleIdempotent NV fV y) = cycleIdempotent NW fW (h y) := by
  simpa [cycleIdempotent, iterateMap,
    minStablePeriodMultiple_eq NV fV NW fW h hconj] using
      conjugate_iterate NV fV NW fW h hconj (minStablePeriodMultiple NV fV) y

/-- 共役全単射は安定像を保存し反映する。 -/
theorem mem_stableImage_iff (y : V → State) :
    y ∈ stableImage NV fV ↔ h y ∈ stableImage NW fW := by
  constructor
  · rintro ⟨x, rfl⟩
    exact ⟨h x, (conjugate_cycleIdempotent NV fV NW fW h hconj x).symm⟩
  · rintro ⟨z, hz⟩
    obtain ⟨x, rfl⟩ := h.surjective z
    refine ⟨x, h.injective ?_⟩
    rw [conjugate_cycleIdempotent NV fV NW fW h hconj]
    exact hz

/-- 共役全単射は安定ファイバーを保存し反映する。 -/
theorem mem_stableFiber_iff (q : stableImage NV fV) (y : V → State) :
    y ∈ stableFiber NV fV q ↔
      h y ∈ stableFiber NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ := by
  rw [CellularAutomata.IterateMonoidStablePartition.mem_stableFiber_iff,
    CellularAutomata.IterateMonoidStablePartition.mem_stableFiber_iff]
  constructor
  · intro heq
    rw [← conjugate_cycleIdempotent NV fV NW fW h hconj, heq]
  · intro heq
    apply h.injective
    rw [conjugate_cycleIdempotent NV fV NW fW h hconj]
    exact heq

/-- 共役全単射は一周期写像を移送する。 -/
theorem conjugate_onePeriodMap (y : V → State) :
    h (onePeriodMap NV fV y) = onePeriodMap NW fW (h y) := by
  simpa [onePeriodMap, iterateMap,
    minPositivePeriod_eq NV fV NW fW h hconj] using
      conjugate_iterate NV fV NW fW h hconj (minPositivePeriod NV fV) y

/-- 共役全単射は根付き辺を保存し反映する。 -/
theorem mem_fiberTreeEdgeTable_iff (q : stableImage NV fV)
    (y z : V → State) :
    (y, z) ∈ fiberTreeEdgeTable NV fV q ↔
      (h y, h z) ∈ fiberTreeEdgeTable NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ := by
  rw [CellularAutomata.IterateMonoidStableFiberRootedTree.mem_fiberTreeEdgeTable_iff,
    CellularAutomata.IterateMonoidStableFiberRootedTree.mem_fiberTreeEdgeTable_iff]
  constructor
  · rintro ⟨hy, hyq, hzy⟩
    exact ⟨(mem_stableFiber_iff NV fV NW fW h hconj q y).mp hy,
      fun heq => hyq (h.injective heq),
      congrArg h hzy |>.trans (conjugate_onePeriodMap NV fV NW fW h hconj y)⟩
  · rintro ⟨hy, hyq, heq⟩
    refine ⟨(mem_stableFiber_iff NV fV NW fW h hconj q y).mpr hy,
      fun heq' => hyq (congrArg h heq'), ?_⟩
    apply h.injective
    rw [conjugate_onePeriodMap NV fV NW fW h hconj]
    exact heq

/-- 共役全単射は一周期写像の全反復を移送する。 -/
theorem conjugate_onePeriod_iterate (n : ℕ) (y : V → State) :
    h (CellularAutomata.NecSuf.GlobalMapIteration.iterate (onePeriodMap NV fV) n y) =
      CellularAutomata.NecSuf.GlobalMapIteration.iterate (onePeriodMap NW fW) n (h y) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [CellularAutomata.NecSuf.GlobalMapIteration.iterate_succ,
        CellularAutomata.NecSuf.GlobalMapIteration.iterate_succ,
        conjugate_onePeriodMap NV fV NW fW h hconj, ih]

/-- 共役全単射は根への深さを保存する。 -/
theorem fiberTreeDepth_eq (y : V → State) :
    fiberTreeDepth NV fV y = fiberTreeDepth NW fW (h y) := by
  apply Nat.le_antisymm
  · apply fiberTreeDepth_le
    apply h.injective
    calc
      h (iterateMap NV fV
          (fiberTreeDepth NW fW (h y) * minPositivePeriod NV fV) y) =
          iterateMap NW fW
            (fiberTreeDepth NW fW (h y) * minPositivePeriod NW fW) (h y) := by
        simpa [iterateMap, minPositivePeriod_eq NV fV NW fW h hconj] using
          conjugate_iterate NV fV NW fW h hconj
            (fiberTreeDepth NW fW (h y) * minPositivePeriod NV fV) y
      _ = cycleIdempotent NW fW (h y) := fiberTreeDepth_spec NW fW (h y)
      _ = h (cycleIdempotent NV fV y) :=
        (conjugate_cycleIdempotent NV fV NW fW h hconj y).symm
  · apply fiberTreeDepth_le
    calc
      iterateMap NW fW
          (fiberTreeDepth NV fV y * minPositivePeriod NW fW) (h y) =
          h (iterateMap NV fV
            (fiberTreeDepth NV fV y * minPositivePeriod NV fV) y) := by
        symm
        simpa [iterateMap, minPositivePeriod_eq NV fV NW fW h hconj] using
          conjugate_iterate NV fV NW fW h hconj
            (fiberTreeDepth NV fV y * minPositivePeriod NV fV) y
      _ = h (cycleIdempotent NV fV y) := congrArg h (fiberTreeDepth_spec NV fV y)
      _ = cycleIdempotent NW fW (h y) :=
        conjugate_cycleIdempotent NV fV NW fW h hconj y

/-- 共役全単射は各頂点へ入る根付き辺の個数を保存する。 -/
theorem fiberTreeBranchCount_eq (q : stableImage NV fV) (y : V → State) :
    fiberTreeBranchCount NV fV q y =
      fiberTreeBranchCount NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ (h y) := by
  classical
  unfold fiberTreeBranchCount
  apply Finset.card_bij
      (fun e _he => (h e.1, h e.2))
  · intro e he
    simp only [Finset.mem_filter] at he ⊢
    exact ⟨(mem_fiberTreeEdgeTable_iff NV fV NW fW h hconj q e.1 e.2).mp he.1,
      congrArg h he.2⟩
  · intro a _ha b _hb hab
    apply Prod.ext <;> apply h.injective
    · exact congrArg Prod.fst hab
    · exact congrArg Prod.snd hab
  · intro b hb
    simp only [Finset.mem_filter] at hb
    let a : (V → State) × (V → State) := (h.symm b.1, h.symm b.2)
    have haEdge : a ∈ fiberTreeEdgeTable NV fV q := by
      apply (mem_fiberTreeEdgeTable_iff NV fV NW fW h hconj q a.1 a.2).mpr
      simpa [a] using hb.1
    have haTarget : a.2 = y := by
      apply h.injective
      simpa [a] using hb.2
    exact ⟨a, Finset.mem_filter.mpr ⟨haEdge, haTarget⟩, by ext <;> simp [a]⟩

/-- 安定像を一度ずつ走査して得る安定ファイバー根付き木族の有限表。 -/
noncomputable def invariantRootedTreeFamily :
    Finset (Finset (V → State) × (V → State) ×
      Finset ((V → State) × (V → State))) :=
  Finset.univ.image (stableFiberRootedTree NV fV)

/-- 局所真理値表から得る共役不変量の有限データ。 -/
noncomputable def invariantData :
    ℕ × ℕ × Finset (V → State) ×
      Finset (Finset (V → State) × (V → State) ×
        Finset ((V → State) × (V → State))) :=
  (minCollisionStart NV fV, minPositivePeriod NV fV,
    stableImageTable NV fV, invariantRootedTreeFamily NV fV)

/-! ## 必要十分版からの導出

具体版は必要十分版を X := V → State、Y := W → State、F := globalMap NV fV、
G := globalMap NW fW、h := 共役全単射へ特殊化したものである。
反復の移送には h が単なる写像で足り、等号の保存は全射性・反映は単射性だけを使う。
根付き辺・深さ・分岐個数は、一周期写像・ファイバー・根だけの
必要十分版へ特殊化する。 -/

omit [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W] in
/-- 反復の移送は必要十分版の特殊化として得られる。 -/
theorem conjugate_iterate_from_necessary_sufficient (n : ℕ) (y : V → State) :
    h (iterate NV fV n y) = iterate NW fW n (h y) := by
  rw [iterate_eq_necessary_sufficient NV fV n y,
    iterate_eq_necessary_sufficient NW fW n (h y)]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.conjugate_iterateMap
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj n y

omit [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W] in
/-- 反復写像の等号の両側同値は必要十分版の特殊化として得られる。 -/
theorem iterateMap_eq_iff_from_necessary_sufficient (m n : ℕ) :
    iterateMap NV fV m = iterateMap NV fV n ↔
      iterateMap NW fW m = iterateMap NW fW n := by
  rw [iterateMap_eq_necessary_sufficient NV fV m,
    iterateMap_eq_necessary_sufficient NV fV n,
    iterateMap_eq_necessary_sufficient NW fW m,
    iterateMap_eq_necessary_sufficient NW fW n]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.iterateMap_eq_iff
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective m n

omit [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W] in
/-- 衝突開始位置の両側同値は必要十分版の特殊化として得られる。 -/
theorem isCollisionStart_iff_from_necessary_sufficient (n : ℕ) :
    IsCollisionStart NV fV n ↔ IsCollisionStart NW fW n := by
  rw [isCollisionStart_eq_necessary_sufficient NV fV n,
    isCollisionStart_eq_necessary_sufficient NW fW n]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.isCollisionStart_iff
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective n

/-- 最小衝突開始位置の保存は必要十分版の特殊化として得られる。 -/
theorem minCollisionStart_eq_from_necessary_sufficient :
    minCollisionStart NV fV = minCollisionStart NW fW := by
  rw [minCollisionStart_eq_necessary_sufficient NV fV,
    minCollisionStart_eq_necessary_sufficient NW fW]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.minCollisionStart_eq
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective
    (CellularAutomata.NecSuf.IterateMonoidStabilizationIndex.exists_collision_start
      (globalMap NV fV))

/-- 最小正周期の保存は必要十分版の特殊化として得られる。 -/
theorem minPositivePeriod_eq_from_necessary_sufficient :
    minPositivePeriod NV fV = minPositivePeriod NW fW := by
  rw [minPositivePeriod_eq_necessary_sufficient NV fV,
    minPositivePeriod_eq_necessary_sufficient NW fW]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.minPositivePeriod_eq
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective (necSufHex NV fV)

/-- 最小安定周期倍数指数の保存は必要十分版の特殊化として得られる。 -/
theorem minStablePeriodMultiple_eq_from_necessary_sufficient :
    minStablePeriodMultiple NV fV = minStablePeriodMultiple NW fW := by
  rw [minStablePeriodMultiple_eq_necessary_sufficient NV fV,
    minStablePeriodMultiple_eq_necessary_sufficient NW fW]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.minStablePeriodMultiple_eq
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective (necSufHex NV fV)

/-- 巡回冪等元の移送は必要十分版の特殊化として得られる。 -/
theorem conjugate_cycleIdempotent_from_necessary_sufficient (y : V → State) :
    h (cycleIdempotent NV fV y) = cycleIdempotent NW fW (h y) := by
  rw [cycleIdempotent_eq_necessary_sufficient NV fV,
    cycleIdempotent_eq_necessary_sufficient NW fW]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.conjugate_cycleIdempotent
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective (necSufHex NV fV) y

/-- 安定像の所属の両側同値は必要十分版の移送定理の特殊化として得られる。
    共役条件には具体版の巡回冪等元の移送を渡す。 -/
theorem mem_stableImage_iff_from_necessary_sufficient (y : V → State) :
    y ∈ stableImage NV fV ↔ h y ∈ stableImage NW fW :=
  CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.StableFiberTransport.mem_stableImage_iff
    (cycleIdempotent NV fV) (cycleIdempotent NW fW) ⇑h
    (conjugate_cycleIdempotent NV fV NW fW h hconj) h.bijective y

/-- 安定ファイバーの所属の両側同値は必要十分版の移送定理の特殊化として得られる。 -/
theorem mem_stableFiber_iff_from_necessary_sufficient
    (q : stableImage NV fV) (y : V → State) :
    y ∈ stableFiber NV fV q ↔
      h y ∈ stableFiber NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ :=
  CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.StableFiberTransport.mem_stableFiber_iff_transport
    (cycleIdempotent NV fV) (cycleIdempotent NW fW) ⇑h
    (conjugate_cycleIdempotent NV fV NW fW h hconj) h.bijective q y
    ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ rfl

/-- 一周期写像の移送は必要十分版の特殊化として得られる。 -/
theorem conjugate_onePeriodMap_from_necessary_sufficient (y : V → State) :
    h (onePeriodMap NV fV y) = onePeriodMap NW fW (h y) := by
  show h (iterateMap NV fV (minPositivePeriod NV fV) y) =
    iterateMap NW fW (minPositivePeriod NW fW) (h y)
  rw [iterateMap_eq_necessary_sufficient NV fV,
    iterateMap_eq_necessary_sufficient NW fW,
    minPositivePeriod_eq_necessary_sufficient NV fV,
    minPositivePeriod_eq_necessary_sufficient NW fW]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.conjugate_onePeriodMap
    (globalMap NV fV) (globalMap NW fW) ⇑h hconj h.bijective (necSufHex NV fV) y

/-- 根付き辺の保存・反映は、一周期写像の共役とファイバー所属の
    両側同値だけを使う必要十分版の特殊化である。 -/
theorem mem_fiberTreeEdgeTable_iff_from_necessary_sufficient
    (q : stableImage NV fV) (y z : V → State) :
    (y, z) ∈ fiberTreeEdgeTable NV fV q ↔
      (h y, h z) ∈ fiberTreeEdgeTable NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ := by
  rw [CellularAutomata.IterateMonoidStableFiberRootedTree.mem_fiberTreeEdgeTable_iff,
    CellularAutomata.IterateMonoidStableFiberRootedTree.mem_fiberTreeEdgeTable_iff]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.RootedTreeTransport.edge_iff
    (onePeriodMap NV fV) (onePeriodMap NW fW) ⇑h
    (stableFiber NV fV q)
    (stableFiber NW fW
      ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩)
    q.1 (h q.1) (conjugate_onePeriodMap NV fV NW fW h hconj)
    (mem_stableFiber_iff NV fV NW fW h hconj q) rfl h.injective y z

/-- 一周期写像の全反復の移送は、任意の自己写像の反復移送の特殊化である。 -/
theorem conjugate_onePeriod_iterate_from_necessary_sufficient (n : ℕ) (y : V → State) :
    h (CellularAutomata.NecSuf.GlobalMapIteration.iterate (onePeriodMap NV fV) n y) =
      CellularAutomata.NecSuf.GlobalMapIteration.iterate (onePeriodMap NW fW) n (h y) :=
  CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.conjugate_iterateMap
    (onePeriodMap NV fV) (onePeriodMap NW fW) ⇑h
    (conjugate_onePeriodMap NV fV NW fW h hconj) n y

/-- 根への深さの保存は、最小根到達回数の共役不変性の特殊化である。 -/
theorem fiberTreeDepth_eq_from_necessary_sufficient (y : V → State) :
    fiberTreeDepth NV fV y = fiberTreeDepth NW fW (h y) := by
  let q := stableRepresentative NV fV y
  let q' : stableImage NW fW :=
    ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩
  have hy : y ∈ stableFiber NV fV q := rfl
  have hhy : h y ∈ stableFiber NW fW q' :=
    (mem_stableFiber_iff NV fV NW fW h hconj q y).mp hy
  rw [NecessarySufficientDerivation.fiberTreeDepth_eq_rootDepth NV fV q hy,
    NecessarySufficientDerivation.fiberTreeDepth_eq_rootDepth NW fW q' hhy]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.RootedTreeTransport.rootDepth_eq
    (onePeriodMap NV fV) (onePeriodMap NW fW) ⇑h
    (stableFiber NV fV q) (stableFiber NW fW q') q.1 q'.1
    (conjugate_onePeriodMap NV fV NW fW h hconj)
    (mem_stableFiber_iff NV fV NW fW h hconj q) rfl h.injective
    (fun x hx => NecessarySufficientDerivation.onePeriodMap_reaches_root_necessary_sufficient
      NV fV q hx)
    (fun x hx => NecessarySufficientDerivation.onePeriodMap_reaches_root_necessary_sufficient
      NW fW q' hx) y hy

/-- 各頂点へ入る辺数の保存は、有限辺表の全単射移送の特殊化である。 -/
theorem fiberTreeBranchCount_eq_from_necessary_sufficient
    (q : stableImage NV fV) (y : V → State) :
    fiberTreeBranchCount NV fV q y =
      fiberTreeBranchCount NW fW
        ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩ (h y) := by
  unfold fiberTreeBranchCount
  rw [← NecessarySufficientDerivation.edgeTable_eq_fiberTreeEdgeTable NV fV q,
    ← NecessarySufficientDerivation.edgeTable_eq_fiberTreeEdgeTable NW fW
      ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩]
  exact CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.RootedTreeTransport.branchCount_eq
    (onePeriodMap NV fV) (onePeriodMap NW fW) ⇑h
    (stableFiber NV fV q)
    (stableFiber NW fW
      ⟨h q.1, (mem_stableImage_iff NV fV NW fW h hconj q.1).mp q.2⟩)
    q.1 (h q.1) (conjugate_onePeriodMap NV fV NW fW h hconj)
    (mem_stableFiber_iff NV fV NW fW h hconj q) rfl h.bijective y

end CellularAutomata.IterateMonoidConjugacyInvariance
