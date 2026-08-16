/-
章「反復モノイドの主イデアル列」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-principal-ideal-tail.ts。

有限舞台上の二値 CA の大域写像について、反復写像の後尾集合、主イデアル表示、
合成の吸収、包含の減少、反復写像の衝突後の安定、有限代表集合上の有限走査を、
人手証明と同じ順序で形式化する。比較回数のコストモデル自体は形式化しない。
有限集合と自然数だけを使い、無限反復の極限、位相、R / C は使わない。
-/
import CellularAutomata.IterateMonoidIdempotents
import CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

namespace CellularAutomata.IterateMonoidPrincipalIdealTail

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidIdempotents

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 後尾集合 I_n(F)（`def_iterate_monoid_tail`）。 -/
def tail (n : ℕ) : Set ((V → State) → (V → State)) :=
  {g | ∃ k : ℕ, iterateMap N f (n + k) = g}

omit [Fintype V] [DecidableEq V] in
/-- 後尾集合は F^n が生成する主イデアルである
    （`claim_iterate_monoid_tail_is_principal_ideal`）。 -/
theorem tail_eq_principal_ideal (n : ℕ) :
    tail N f n = {h | ∃ g, g ∈ powerSet N f ∧ iterateMap N f n ∘ g = h} := by
  ext h
  constructor
  · rintro ⟨k, rfl⟩
    exact ⟨iterateMap N f k, ⟨k, rfl⟩, iterateMap_comp_add N f n k⟩
  · rintro ⟨g, ⟨k, rfl⟩, rfl⟩
    exact ⟨k, (iterateMap_comp_add N f n k).symm⟩

omit [Fintype V] [DecidableEq V] in
/-- 後尾集合は反復写像の合成を吸収する
    （`claim_iterate_monoid_tail_absorbs_composition`）。 -/
theorem tail_absorbs_composition (n : ℕ)
    {g h : (V → State) → (V → State)}
    (hg : g ∈ powerSet N f) (hh : h ∈ tail N f n) : g ∘ h ∈ tail N f n := by
  rcases hg with ⟨a, rfl⟩
  rcases hh with ⟨b, rfl⟩
  refine ⟨a + b, ?_⟩
  rw [iterateMap_comp_add]
  congr 1
  omega

omit [Fintype V] [DecidableEq V] in
/-- I_{n+1}(F) ⊆ I_n(F)（`claim_iterate_monoid_tails_descend`）。 -/
theorem tails_descend (n : ℕ) : tail N f (n + 1) ⊆ tail N f n := by
  rintro h ⟨k, rfl⟩
  refine ⟨1 + k, ?_⟩
  congr 1
  omega

omit [Fintype V] [DecidableEq V] in
/-- 反復写像の衝突後は後尾集合が安定する
    （`claim_iterate_collision_stabilizes_tails`）。 -/
theorem collision_stabilizes_tails {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) {n : ℕ} (hin : i ≤ n) :
    tail N f n = tail N f i := by
  apply Set.Subset.antisymm
  · rintro g ⟨k, rfl⟩
    refine ⟨(n - i) + k, ?_⟩
    congr 1
    omega
  · rintro g ⟨k, rfl⟩
    have hp : 1 ≤ j - i := by omega
    have hperiod := collision_period_multiple N f hij h (n := i + k) (by omega) (n - i)
    let q := k + (n - i) * (j - i) - (n - i)
    have hq : n - i ≤ k + (n - i) * (j - i) := by
      have hdp : n - i ≤ (n - i) * (j - i) := by
        simpa only [Nat.mul_one] using Nat.mul_le_mul_left (n - i) hp
      omega
    refine ⟨q, ?_⟩
    have hexp : n + q = (i + k) + (n - i) * (j - i) := by
      simp only [q]
      omega
    rw [hexp, hperiod]

/-- 衝突指数 j 未満の有限代表から後尾集合を走査する有限集合。 -/
def finiteTail (j n : ℕ) : Finset ((V → State) → (V → State)) :=
  (representatives N f j).image (fun g => iterateMap N f n ∘ g)

/-- 衝突があれば、有限走査で得る集合は後尾集合全体と一致する。 -/
theorem mem_finiteTail_iff_tail {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (n : ℕ) (g : (V → State) → (V → State)) :
    g ∈ finiteTail N f j n ↔ g ∈ tail N f n := by
  constructor
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨a, ha, rfl⟩
    have ha' := (mem_representatives_iff_powerSet N f hij h a).mp ha
    rcases ha' with ⟨k, rfl⟩
    exact ⟨k, (iterateMap_comp_add N f n k).symm⟩
  · rintro ⟨k, rfl⟩
    apply Finset.mem_image.mpr
    refine ⟨iterateMap N f k, ?_, iterateMap_comp_add N f n k⟩
    exact (mem_representatives_iff_powerSet N f hij h _).mpr ⟨k, rfl⟩

/-- 衝突の始点までの有限走査で安定位置が必ず見つかる。 -/
theorem exists_stable_index_in_finite_scan {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    ∃ n ∈ Finset.range (i + 1), finiteTail N f j n = finiteTail N f j (n + 1) := by
  refine ⟨i, Finset.mem_range.mpr (Nat.lt_succ_self i), ?_⟩
  ext g
  rw [mem_finiteTail_iff_tail N f hij h, mem_finiteTail_iff_tail N f hij h]
  rw [collision_stabilizes_tails N f hij h le_rfl,
    collision_stabilizes_tails N f hij h (Nat.le_succ i)]

/-- 有限走査する候補位置と安定性の真理値表。 -/
def stableIndices (i j : ℕ) : Finset ℕ :=
  (Finset.range (i + 1)).filter (fun n => finiteTail N f j n = finiteTail N f j (n + 1))

theorem stableIndices_nonempty {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) : (stableIndices N f i j).Nonempty := by
  obtain ⟨n, hn, hs⟩ := exists_stable_index_in_finite_scan N f hij h
  exact ⟨n, Finset.mem_filter.mpr ⟨hn, hs⟩⟩

/-- 有限走査で得る最初の安定位置。 -/
def firstStableIndex {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) : ℕ :=
  (stableIndices N f i j).min' (stableIndices_nonempty N f hij h)

/-- 最初の安定位置は有限走査の真理値表に属する。 -/
theorem firstStableIndex_spec {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    firstStableIndex N f hij h ∈ stableIndices N f i j := by
  exact Finset.min'_mem _ _

/-- 上の構成は、有限代表の合成と有限回の集合等号判定だけで実行できる
    （`claim_iterate_monoid_tail_finite_decidability`）。 -/
theorem tail_finite_decidability {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    ∃ n ≤ i, tail N f n = tail N f (n + 1) := by
  let n := firstStableIndex N f hij h
  have hn := firstStableIndex_spec N f hij h
  have hn' := (Finset.mem_filter.mp hn)
  refine ⟨n, Nat.le_of_lt_succ (Finset.mem_range.mp hn'.1), ?_⟩
  ext g
  rw [← mem_finiteTail_iff_tail N f hij h,
    ← mem_finiteTail_iff_tail N f hij h]
  exact Finset.ext_iff.mp hn'.2 g

/-! ## 必要十分版からの導出
具体版は必要十分版を X := V → State、F := globalMap N f へ特殊化したものである。 -/

omit [Fintype V] [DecidableEq V] in
theorem tail_eq_necessary_sufficient (n : ℕ) :
    tail N f n =
      CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tail (globalMap N f) n := by
  ext g
  simp only [tail, CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tail,
    Set.mem_setOf_eq, iterateMap_eq_necessary_sufficient]

omit [Fintype V] [DecidableEq V] in
theorem tail_eq_principal_ideal_from_necessary_sufficient (n : ℕ) :
    tail N f n = {h | ∃ g, g ∈ powerSet N f ∧ iterateMap N f n ∘ g = h} := by
  rw [tail_eq_necessary_sufficient, powerSet_eq_necessary_sufficient,
    iterateMap_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tail_eq_principal_ideal
    (globalMap N f) n

omit [Fintype V] [DecidableEq V] in
theorem tail_absorbs_composition_from_necessary_sufficient (n : ℕ)
    {g h : (V → State) → (V → State)}
    (hg : g ∈ powerSet N f) (hh : h ∈ tail N f n) : g ∘ h ∈ tail N f n := by
  rw [tail_eq_necessary_sufficient] at hh ⊢
  rw [powerSet_eq_necessary_sufficient] at hg
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tail_absorbs_composition
    (globalMap N f) n hg hh

omit [Fintype V] [DecidableEq V] in
theorem tails_descend_from_necessary_sufficient (n : ℕ) : tail N f (n + 1) ⊆ tail N f n := by
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tails_descend (globalMap N f) n

omit [Fintype V] [DecidableEq V] in
theorem collision_stabilizes_tails_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) {n : ℕ} (hin : i ≤ n) :
    tail N f n = tail N f i := by
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient]
  simp only [iterateMap_eq_necessary_sufficient] at h
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.collision_stabilizes_tails
    (globalMap N f) hij h hin

/-- 有限舞台では、有限型 V → State 上の自己写像への特殊化により、
    ある位置以後で後尾集合が安定する。 -/
theorem exists_stabilization_index_from_necessary_sufficient :
    ∃ i : ℕ, ∀ n : ℕ, i ≤ n → tail N f n = tail N f i := by
  obtain ⟨i, hi⟩ :=
    CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.exists_stabilization_index
      (globalMap N f)
  refine ⟨i, fun n hin => ?_⟩
  rw [tail_eq_necessary_sufficient, tail_eq_necessary_sufficient]
  exact hi n hin

theorem finiteTail_eq_necessary_sufficient (j n : ℕ) :
    finiteTail N f j n =
      CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.finiteTail (globalMap N f) j n := by
  ext g
  simp only [finiteTail, CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.finiteTail,
    Finset.mem_image, representatives_eq_necessary_sufficient, iterateMap_eq_necessary_sufficient]

theorem mem_finiteTail_iff_tail_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (n : ℕ) (g : (V → State) → (V → State)) :
    g ∈ finiteTail N f j n ↔ g ∈ tail N f n := by
  rw [finiteTail_eq_necessary_sufficient, tail_eq_necessary_sufficient]
  simp only [iterateMap_eq_necessary_sufficient] at h
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.mem_finiteTail_iff_tail
    (globalMap N f) hij h n g

theorem stableIndices_eq_necessary_sufficient (i j : ℕ) :
    stableIndices N f i j =
      CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.stableIndices (globalMap N f) i j := by
  ext n
  simp only [stableIndices, CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.stableIndices,
    Finset.mem_filter, finiteTail_eq_necessary_sufficient]

theorem tail_finite_decidability_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) :
    ∃ n ≤ i, tail N f n = tail N f (n + 1) := by
  simp only [tail_eq_necessary_sufficient]
  simp only [iterateMap_eq_necessary_sufficient] at h
  exact CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail.tail_finite_decidability
    (globalMap N f) hij h

end CellularAutomata.IterateMonoidPrincipalIdealTail
