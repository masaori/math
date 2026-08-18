/-
章「安定ファイバー上の一周期写像が定める根付き木」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-stable-fiber-rooted-tree.ts。

一周期写像 R_F = F^{λ_F} と根到達指数 m_F = e_F / λ_F を定義し、最小正周期の
倍数だけの遅れの伝播、一周期写像の逐次合成、安定ファイバーの保存、全元の根への
到達、根が唯一の不動点であること、根付き辺集合の辺数、深さの零特徴づけと一段減少、
有向閉路の不存在、辺・深さ・分岐数の有限走査を人手証明と同じ対象・仮定・順序で
形式化する。有限集合・自然数・写像の等号だけを使い、R / C は使わない。
比較回数のコストモデル自体は既出章と同じく形式化しない。
-/
import CellularAutomata.IterateMonoidStableFiberLayerBranching

namespace CellularAutomata.IterateMonoidStableFiberRootedTree

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidCycleIdempotent
open CellularAutomata.IterateMonoidStableImage
open CellularAutomata.IterateMonoidStablePartition

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `R_F := F^{λ_F}`（`def_iterate_monoid_one_period_map`）。 -/
noncomputable def onePeriodMap : (V → State) → (V → State) :=
  iterateMap N f (minPositivePeriod N f)

/-- 最小正周期の倍数だけの遅れは衝突開始後に消える
    （`claim_iterate_monoid_period_multiple_propagates`）。
    人手証明と同じく d について帰納する。 -/
theorem iterateMap_period_multiple_propagates {n : ℕ}
    (hn : minCollisionStart N f ≤ n) (d : ℕ) :
    iterateMap N f (n + d * minPositivePeriod N f) = iterateMap N f n := by
  induction d with
  | zero => simp
  | succ d ih =>
    calc
      iterateMap N f (n + (d + 1) * minPositivePeriod N f) =
          iterateMap N f (n + d * minPositivePeriod N f + minPositivePeriod N f) := by
        congr 1
        rw [Nat.succ_mul, Nat.add_assoc]
      _ = iterateMap N f (n + d * minPositivePeriod N f) :=
        (period_propagates_after_collision_start N f (minPositivePeriod_spec N f)
          (by omega)).symm
      _ = iterateMap N f n := ih

/-- `m_F`: `e_F = m_F · λ_F` を満たす自然数
    （`def_iterate_monoid_root_reach_exponent`）。 -/
noncomputable def rootReachExponent : ℕ :=
  minStablePeriodMultiple N f / minPositivePeriod N f

/-- `m_F · λ_F = e_F`（λ_F ∣ e_F による）。 -/
theorem rootReachExponent_mul_minPositivePeriod :
    rootReachExponent N f * minPositivePeriod N f = minStablePeriodMultiple N f :=
  Nat.div_mul_cancel (minStablePeriodMultiple_spec N f).2

/-- 最小正周期の倍数乗は一周期写像の合成で一段ずつ進む
    （`claim_iterate_monoid_one_period_step_composition`）。 -/
theorem iterateMap_succ_mul_minPositivePeriod (d : ℕ) :
    iterateMap N f ((d + 1) * minPositivePeriod N f) =
      onePeriodMap N f ∘ iterateMap N f (d * minPositivePeriod N f) := by
  rw [onePeriodMap, iterateMap_comp_add]
  congr 1
  rw [Nat.succ_mul, Nat.add_comm]

/-- `E_F ∘ R_F = E_F` の点ごとの形。人手証明のファイバー保存の計算の本体
    （`claim_iterate_monoid_one_period_map_preserves_fiber` の等式連鎖）。 -/
theorem cycleIdempotent_onePeriodMap (y : V → State) :
    cycleIdempotent N f (onePeriodMap N f y) = cycleIdempotent N f y := by
  have hcomp : cycleIdempotent N f ∘ onePeriodMap N f =
      iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f) := by
    rw [cycleIdempotent, onePeriodMap, iterateMap_comp_add]
  have h1 : cycleIdempotent N f (onePeriodMap N f y) =
      iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f) y :=
    congrFun hcomp y
  have h2 : iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f) =
      iterateMap N f (minStablePeriodMultiple N f) := by
    simpa [one_mul] using
      iterateMap_period_multiple_propagates N f (minStablePeriodMultiple_spec N f).1 1
  calc
    cycleIdempotent N f (onePeriodMap N f y) =
        iterateMap N f (minStablePeriodMultiple N f + minPositivePeriod N f) y := h1
    _ = iterateMap N f (minStablePeriodMultiple N f) y := congrFun h2 y
    _ = cycleIdempotent N f y := rfl

/-- 一周期写像は各安定ファイバーを保つ
    （`claim_iterate_monoid_one_period_map_preserves_fiber`）。 -/
theorem onePeriodMap_mem_stableFiber (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    onePeriodMap N f y ∈ stableFiber N f q := by
  rw [mem_stableFiber_iff] at hy ⊢
  rw [cycleIdempotent_onePeriodMap, hy]

/-- 根到達指数乗の一周期写像は全元を根へ送る
    （`claim_iterate_monoid_one_period_map_reaches_root`）。 -/
theorem iterateMap_rootReachExponent_reaches_root (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    iterateMap N f (rootReachExponent N f * minPositivePeriod N f) y = q.1 := by
  rw [rootReachExponent_mul_minPositivePeriod]
  exact (mem_stableFiber_iff N f q y).1 hy

/-- 根は一周期写像の不動点である
    （`claim_iterate_monoid_one_period_map_fixes_root`）。 -/
theorem onePeriodMap_fixes_root (q : stableImage N f) :
    onePeriodMap N f q.1 = q.1 := by
  have hq : cycleIdempotent N f q.1 = q.1 :=
    cycleIdempotent_retracts_stableImage N f q.2
  calc
    onePeriodMap N f q.1 = onePeriodMap N f (cycleIdempotent N f q.1) := by rw [hq]
    _ = cycleIdempotent N f (onePeriodMap N f q.1) := by
      have hcomm : onePeriodMap N f ∘ cycleIdempotent N f =
          cycleIdempotent N f ∘ onePeriodMap N f := by
        rw [onePeriodMap, cycleIdempotent, iterateMap_comp_add, iterateMap_comp_add,
          Nat.add_comm]
      exact congrFun hcomm q.1
    _ = cycleIdempotent N f q.1 := cycleIdempotent_onePeriodMap N f q.1
    _ = q.1 := hq

/-- 各安定ファイバー内で一周期写像の不動点は根だけである
    （`claim_iterate_monoid_one_period_map_unique_fixed_point`）。
    人手証明と同じく、まず d の帰納法で `F^{dλ_F}(y) = y` を示す。 -/
theorem onePeriodMap_unique_fixed_point (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q)
    (hfix : onePeriodMap N f y = y) : y = q.1 := by
  have hiter : ∀ d : ℕ, iterateMap N f (d * minPositivePeriod N f) y = y := by
    intro d
    induction d with
    | zero => simp [iterateMap, iterate_zero]
    | succ d ih =>
      calc
        iterateMap N f ((d + 1) * minPositivePeriod N f) y =
            onePeriodMap N f (iterateMap N f (d * minPositivePeriod N f) y) :=
          congrFun (iterateMap_succ_mul_minPositivePeriod N f d) y
        _ = onePeriodMap N f y := by rw [ih]
        _ = y := hfix
  calc
    y = iterateMap N f (rootReachExponent N f * minPositivePeriod N f) y :=
      (hiter (rootReachExponent N f)).symm
    _ = q.1 := iterateMap_rootReachExponent_reaches_root N f q hy

/-- 根付き辺集合 `T_F(q)` を有限走査の表として書いたもの
    （`def_iterate_monoid_fiber_tree_edges`）。 -/
noncomputable def fiberTreeEdgeTable (q : stableImage N f) :
    Finset ((V → State) × (V → State)) :=
  ((stableFiberTable N f q).erase q.1).image (fun y => (y, onePeriodMap N f y))

/-- 辺の所属条件は定義どおりの三条件である。 -/
theorem mem_fiberTreeEdgeTable_iff (q : stableImage N f)
    (e : (V → State) × (V → State)) :
    e ∈ fiberTreeEdgeTable N f q ↔
      e.1 ∈ stableFiber N f q ∧ e.1 ≠ q.1 ∧ e.2 = onePeriodMap N f e.1 := by
  classical
  obtain ⟨a, b⟩ := e
  simp only [fiberTreeEdgeTable, Finset.mem_image, Finset.mem_erase,
    mem_stableFiberTable_iff, Prod.mk.injEq]
  constructor
  · rintro ⟨y, ⟨hyne, hymem⟩, rfl, rfl⟩
    exact ⟨hymem, hyne, rfl⟩
  · rintro ⟨hmem, hne, hb⟩
    exact ⟨a, ⟨hne, hmem⟩, rfl, hb.symm⟩

/-- 根付き辺集合の辺数は頂点数より一つ少ない
    （`claim_iterate_monoid_fiber_tree_edge_count`）。
    人手証明と同じく `y ↦ (y, R_F(y))` の全単射と `q ∈ B_F(q)` を使う。 -/
theorem fiberTreeEdgeTable_card (q : stableImage N f) :
    (fiberTreeEdgeTable N f q).card = (stableFiberTable N f q).card - 1 := by
  classical
  rw [fiberTreeEdgeTable, Finset.card_image_of_injOn
    (fun a _ b _ hab => congrArg Prod.fst hab)]
  rw [Finset.card_erase_of_mem]
  exact (mem_stableFiberTable_iff N f q q.1).2 (representative_mem_stableFiber N f q)

/-- 深さの定義に使う集合は空でない（`def_iterate_monoid_fiber_tree_depth` の
    「m_F を含む」）。目標値は `E_F(y)`、すなわち `y` の属するファイバーの根である。 -/
theorem exists_period_multiple_reaches_root (y : V → State) :
    ∃ d : ℕ, iterateMap N f (d * minPositivePeriod N f) y =
      cycleIdempotent N f y :=
  ⟨rootReachExponent N f, by rw [rootReachExponent_mul_minPositivePeriod]; rfl⟩

/-- `d_F(y) := min{d | F^{dλ_F}(y) = E_F(y)}`（自然数の整列性。
    `def_iterate_monoid_fiber_tree_depth`）。 -/
noncomputable def fiberTreeDepth (y : V → State) : ℕ := by
  classical
  exact Nat.find (exists_period_multiple_reaches_root N f y)

theorem fiberTreeDepth_spec (y : V → State) :
    iterateMap N f (fiberTreeDepth N f y * minPositivePeriod N f) y =
      cycleIdempotent N f y := by
  classical
  exact Nat.find_spec (exists_period_multiple_reaches_root N f y)

theorem fiberTreeDepth_le {y : V → State} {d : ℕ}
    (hd : iterateMap N f (d * minPositivePeriod N f) y = cycleIdempotent N f y) :
    fiberTreeDepth N f y ≤ d := by
  classical
  exact Nat.find_min' (exists_period_multiple_reaches_root N f y) hd

/-- ファイバーの元では深さの目標値は根 `q` である。 -/
theorem fiberTreeDepth_reaches_root (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    iterateMap N f (fiberTreeDepth N f y * minPositivePeriod N f) y = q.1 :=
  (fiberTreeDepth_spec N f y).trans ((mem_stableFiber_iff N f q y).1 hy)

/-- 深さが零であることと根であることは同値である
    （`claim_iterate_monoid_fiber_tree_depth_zero_iff_root`）。 -/
theorem fiberTreeDepth_eq_zero_iff_root (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) :
    fiberTreeDepth N f y = 0 ↔ y = q.1 := by
  constructor
  · intro h0
    have h := fiberTreeDepth_reaches_root N f q hy
    rw [h0, Nat.zero_mul] at h
    exact h
  · intro hyq
    have h0 : iterateMap N f (0 * minPositivePeriod N f) y =
        cycleIdempotent N f y := by
      rw [Nat.zero_mul]
      calc
        iterateMap N f 0 y = y := iterate_zero N f y
        _ = q.1 := hyq
        _ = cycleIdempotent N f y := ((mem_stableFiber_iff N f q y).1 hy).symm
    exact Nat.le_zero.mp (fiberTreeDepth_le N f h0)

/-- 一周期写像は非根の深さをちょうど一つ減らす
    （`claim_iterate_monoid_fiber_tree_depth_decrement`）。
    人手証明と同じく上界・下界の二つの不等式と反対称性で示す。 -/
theorem fiberTreeDepth_decrement (q : stableImage N f)
    {y : V → State} (hy : y ∈ stableFiber N f q) (hne : y ≠ q.1) :
    1 ≤ fiberTreeDepth N f y ∧
      fiberTreeDepth N f (onePeriodMap N f y) = fiberTreeDepth N f y - 1 := by
  have hdpos : 0 < fiberTreeDepth N f y := by
    rcases Nat.eq_zero_or_pos (fiberTreeDepth N f y) with h0 | hpos
    · exact absurd ((fiberTreeDepth_eq_zero_iff_root N f q hy).1 h0) hne
    · exact hpos
  refine ⟨hdpos, ?_⟩
  have hupper : fiberTreeDepth N f (onePeriodMap N f y) ≤
      fiberTreeDepth N f y - 1 := by
    apply fiberTreeDepth_le
    rw [cycleIdempotent_onePeriodMap]
    calc
      iterateMap N f ((fiberTreeDepth N f y - 1) * minPositivePeriod N f)
          (onePeriodMap N f y) =
          iterateMap N f
            ((fiberTreeDepth N f y - 1) * minPositivePeriod N f +
              minPositivePeriod N f) y := by
        simpa [onePeriodMap] using congrFun (iterateMap_comp_add N f
          ((fiberTreeDepth N f y - 1) * minPositivePeriod N f)
          (minPositivePeriod N f)) y
      _ = iterateMap N f (fiberTreeDepth N f y * minPositivePeriod N f) y := by
        have hexp : (fiberTreeDepth N f y - 1) * minPositivePeriod N f +
            minPositivePeriod N f =
            fiberTreeDepth N f y * minPositivePeriod N f := by
          calc
            (fiberTreeDepth N f y - 1) * minPositivePeriod N f +
                minPositivePeriod N f =
                (fiberTreeDepth N f y - 1 + 1) * minPositivePeriod N f :=
              (Nat.succ_mul _ _).symm
            _ = fiberTreeDepth N f y * minPositivePeriod N f := by
              have h1 : fiberTreeDepth N f y - 1 + 1 = fiberTreeDepth N f y := by
                omega
              rw [h1]
        rw [hexp]
      _ = cycleIdempotent N f y := fiberTreeDepth_spec N f y
  have hlower : fiberTreeDepth N f y ≤
      fiberTreeDepth N f (onePeriodMap N f y) + 1 := by
    apply fiberTreeDepth_le
    calc
      iterateMap N f
          ((fiberTreeDepth N f (onePeriodMap N f y) + 1) * minPositivePeriod N f) y =
          iterateMap N f
            (fiberTreeDepth N f (onePeriodMap N f y) * minPositivePeriod N f)
            (onePeriodMap N f y) := by
        have hexp : (fiberTreeDepth N f (onePeriodMap N f y) + 1) *
            minPositivePeriod N f =
            fiberTreeDepth N f (onePeriodMap N f y) * minPositivePeriod N f +
              minPositivePeriod N f := Nat.succ_mul _ _
        rw [hexp]
        simpa [onePeriodMap] using (congrFun (iterateMap_comp_add N f
          (fiberTreeDepth N f (onePeriodMap N f y) * minPositivePeriod N f)
          (minPositivePeriod N f)) y).symm
      _ = cycleIdempotent N f (onePeriodMap N f y) :=
        fiberTreeDepth_spec N f (onePeriodMap N f y)
      _ = cycleIdempotent N f y := cycleIdempotent_onePeriodMap N f y
  omega

/-- 根付き辺集合に有向閉路は存在しない
    （`claim_iterate_monoid_fiber_tree_no_cycle`）。
    人手証明と同じく、深さが一段ずつ厳密に減ることの帰納法で矛盾を導く。 -/
theorem fiberTree_no_cycle (q : stableImage N f) {n : ℕ} (hn : 0 < n)
    (p : ℕ → V → State) (hcycle : p n = p 0)
    (hedge : ∀ i, i < n → (p i, p (i + 1)) ∈ fiberTreeEdgeTable N f q) :
    False := by
  have hstep : ∀ i, i < n → 1 ≤ fiberTreeDepth N f (p i) ∧
      fiberTreeDepth N f (p (i + 1)) = fiberTreeDepth N f (p i) - 1 := by
    intro i hi
    obtain ⟨hmem, hne, hnext⟩ :=
      (mem_fiberTreeEdgeTable_iff N f q (p i, p (i + 1))).1 (hedge i hi)
    have hd := fiberTreeDepth_decrement N f q hmem hne
    refine ⟨hd.1, ?_⟩
    rw [show p (i + 1) = onePeriodMap N f (p i) from hnext]
    exact hd.2
  have hind : ∀ i, i ≤ n → i ≤ fiberTreeDepth N f (p 0) ∧
      fiberTreeDepth N f (p i) = fiberTreeDepth N f (p 0) - i := by
    intro i
    induction i with
    | zero => intro _; exact ⟨Nat.zero_le _, by simp⟩
    | succ i ih =>
      intro hin
      obtain ⟨hle, heq⟩ := ih (by omega)
      obtain ⟨hpos, hdec⟩ := hstep i (by omega)
      constructor
      · omega
      · rw [hdec, heq]
        omega
  obtain ⟨hlen, heqn⟩ := hind n (le_refl n)
  rw [hcycle] at heqn
  omega

/-- 組 `(B_F(q), q, T_F(q))`（`def_iterate_monoid_stable_fiber_rooted_tree`）。
    根付き木の呼び名の根拠は既証明の辺数・深さ・閉路不存在の各定理である。 -/
noncomputable def stableFiberRootedTree (q : stableImage N f) :
    Finset (V → State) × (V → State) × Finset ((V → State) × (V → State)) :=
  (stableFiberTable N f q, q.1, fiberTreeEdgeTable N f q)

/-- 深さの走査は `d = 0,…,m_F` の範囲で必ず停止する
    （`claim_iterate_monoid_fiber_tree_finite_decidability` の深さの段）。 -/
theorem fiberTreeDepth_le_rootReachExponent (y : V → State) :
    fiberTreeDepth N f y ≤ rootReachExponent N f :=
  fiberTreeDepth_le N f
    (by rw [rootReachExponent_mul_minPositivePeriod]; rfl)

/-- 分岐数: `T_F(q)` の第二成分が `y` に等しい辺の個数の有限走査
    （`claim_iterate_monoid_fiber_tree_finite_decidability` の分岐数の段）。 -/
noncomputable def fiberTreeBranchCount (q : stableImage N f) (y : V → State) : ℕ := by
  classical
  exact ((fiberTreeEdgeTable N f q).filter (fun e => e.2 = y)).card

/-- 分岐数の走査の各元は、辺の所属と第二成分の等号で特徴づけられる。 -/
theorem mem_fiberTreeBranch_iff (q : stableImage N f) (y : V → State)
    (e : (V → State) × (V → State)) :
    (e ∈ (fiberTreeEdgeTable N f q).filter (fun e => e.2 = y)) ↔
      (e.1 ∈ stableFiber N f q ∧ e.1 ≠ q.1 ∧ e.2 = onePeriodMap N f e.1) ∧
        e.2 = y := by
  classical
  rw [Finset.mem_filter, mem_fiberTreeEdgeTable_iff]

end CellularAutomata.IterateMonoidStableFiberRootedTree
