/-
章「反復モノイドの主イデアル列」の必要十分版。

具体版と同じ手順（後尾集合の定義、加法則による主イデアル表示の両包含、
加法の結合律・交換律による合成の吸収、(n+1)+k = n+(1+k) による減少、
衝突後の安定を「以後の周期の d 回適用」で示す両包含、有限代表からの走査、
衝突の始点までの有限候補から最初の安定位置を選ぶ構成）を保ち、
実際に使う構造だけを残す。

* 後尾集合、主イデアル表示、合成の吸収、包含の減少には型 X と自己写像 F : X → X
  だけを使う。有限性も等号判定も要らない（自然数の加法だけ）。
* 衝突後の安定に要るのは「衝突 F^i = F^j（i < j）が一つ与えられていること」だけである。
  X の有限性は衝突を与えるためにだけ使う（前々章の必要十分版 `iterateMap_collision`）。
* 有限代表から後尾集合を走査する `Finset` の構成、および安定位置を有限候補から
  `Finset.min'` で選ぶ構成にだけ、X → X の等号判定が要る（像と filter の判定のため。
  X の有限性と等号判定から得る）。
* 存在文としての有限決定（衝突の始点 i 以下に安定位置がある）は、上の走査を経由して
  等号判定つきで示す。具体版と同じ構成に固定するためであり、別の論法（`Set` の等号を
  直接示す）には差し替えない。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidIdempotents

namespace CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidIdempotents

variable {X : Type}

/-- 後尾集合 I_n(F)。X に構造は要らない。 -/
def tail (F : X → X) (n : ℕ) : Set (X → X) :=
  {g | ∃ k : ℕ, iterateMap F (n + k) = g}

/-- 後尾集合は F^n が生成する主イデアルである。具体版と同じ両包含（加法則）。 -/
theorem tail_eq_principal_ideal (F : X → X) (n : ℕ) :
    tail F n = {h | ∃ g, g ∈ powerSet F ∧ iterateMap F n ∘ g = h} := by
  ext h
  constructor
  · rintro ⟨k, rfl⟩
    exact ⟨iterateMap F k, ⟨k, rfl⟩, iterateMap_comp_add F n k⟩
  · rintro ⟨g, ⟨k, rfl⟩, rfl⟩
    exact ⟨k, (iterateMap_comp_add F n k).symm⟩

/-- 後尾集合は反復写像の合成を吸収する。加法則と ℕ の結合律・交換律だけ。 -/
theorem tail_absorbs_composition (F : X → X) (n : ℕ) {g h : X → X}
    (hg : g ∈ powerSet F) (hh : h ∈ tail F n) : g ∘ h ∈ tail F n := by
  rcases hg with ⟨a, rfl⟩
  rcases hh with ⟨b, rfl⟩
  refine ⟨a + b, ?_⟩
  rw [iterateMap_comp_add]
  congr 1
  omega

/-- I_{n+1}(F) ⊆ I_n(F)。ℕ の結合律だけ。 -/
theorem tails_descend (F : X → X) (n : ℕ) : tail F (n + 1) ⊆ tail F n := by
  rintro h ⟨k, rfl⟩
  refine ⟨1 + k, ?_⟩
  congr 1
  omega

/-- 衝突後は後尾集合が安定する。要るのは衝突が一つ与えられていることだけで、
    有限性は要らない。具体版と同じく以後の周期を d = n - i 回適用する。 -/
theorem collision_stabilizes_tails (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) {n : ℕ} (hin : i ≤ n) :
    tail F n = tail F i := by
  apply Set.Subset.antisymm
  · rintro g ⟨k, rfl⟩
    refine ⟨(n - i) + k, ?_⟩
    congr 1
    omega
  · rintro g ⟨k, rfl⟩
    have hp : 1 ≤ j - i := by omega
    have hperiod := collision_period_multiple F hij h (n := i + k) (by omega) (n - i)
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

/-- 有限型 X 上では衝突が存在するので、ある i 以後で後尾集合が安定する。
    有限性はここでだけ（衝突を得るために）使う。 -/
theorem exists_stabilization_index [Fintype X] (F : X → X) :
    ∃ i : ℕ, ∀ n : ℕ, i ≤ n → tail F n = tail F i := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision F
  exact ⟨i, fun n hin => collision_stabilizes_tails F hij h hin⟩

/-! ### 有限走査。像と filter の判定に X → X の等号判定が要る -/

/-- 衝突指数 j 未満の有限代表から後尾集合を走査する有限集合。 -/
def finiteTail [DecidableEq (X → X)] (F : X → X) (j n : ℕ) : Finset (X → X) :=
  (representatives F j).image (fun g => iterateMap F n ∘ g)

/-- 衝突があれば、有限走査で得る集合は後尾集合全体と一致する。 -/
theorem mem_finiteTail_iff_tail [DecidableEq (X → X)] (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) (n : ℕ) (g : X → X) :
    g ∈ finiteTail F j n ↔ g ∈ tail F n := by
  constructor
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨a, ha, rfl⟩
    have ha' := (mem_representatives_iff_powerSet F hij h a).mp ha
    rcases ha' with ⟨k, rfl⟩
    exact ⟨k, (iterateMap_comp_add F n k).symm⟩
  · rintro ⟨k, rfl⟩
    apply Finset.mem_image.mpr
    refine ⟨iterateMap F k, ?_, iterateMap_comp_add F n k⟩
    exact (mem_representatives_iff_powerSet F hij h _).mpr ⟨k, rfl⟩

/-- 衝突の始点までの有限走査で安定位置が必ず見つかる。 -/
theorem exists_stable_index_in_finite_scan [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) :
    ∃ n ∈ Finset.range (i + 1), finiteTail F j n = finiteTail F j (n + 1) := by
  refine ⟨i, Finset.mem_range.mpr (Nat.lt_succ_self i), ?_⟩
  ext g
  rw [mem_finiteTail_iff_tail F hij h, mem_finiteTail_iff_tail F hij h]
  rw [collision_stabilizes_tails F hij h le_rfl,
    collision_stabilizes_tails F hij h (Nat.le_succ i)]

/-- 有限走査する候補位置と安定性の真理値表。 -/
def stableIndices [DecidableEq (X → X)] (F : X → X) (i j : ℕ) : Finset ℕ :=
  (Finset.range (i + 1)).filter (fun n => finiteTail F j n = finiteTail F j (n + 1))

theorem stableIndices_nonempty [DecidableEq (X → X)] (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) : (stableIndices F i j).Nonempty := by
  obtain ⟨n, hn, hs⟩ := exists_stable_index_in_finite_scan F hij h
  exact ⟨n, Finset.mem_filter.mpr ⟨hn, hs⟩⟩

/-- 有限走査で得る最初の安定位置。 -/
def firstStableIndex [DecidableEq (X → X)] (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) : ℕ :=
  (stableIndices F i j).min' (stableIndices_nonempty F hij h)

theorem firstStableIndex_spec [DecidableEq (X → X)] (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) :
    firstStableIndex F hij h ∈ stableIndices F i j := by
  exact Finset.min'_mem _ _

/-- 上の構成は、有限代表の合成と有限回の集合等号判定だけで実行できる。
    具体版と同じく走査を経由するため等号判定を仮定に残す。 -/
theorem tail_finite_decidability [DecidableEq (X → X)] (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) :
    ∃ n ≤ i, tail F n = tail F (n + 1) := by
  let n := firstStableIndex F hij h
  have hn := firstStableIndex_spec F hij h
  have hn' := (Finset.mem_filter.mp hn)
  refine ⟨n, Nat.le_of_lt_succ (Finset.mem_range.mp hn'.1), ?_⟩
  ext g
  rw [← mem_finiteTail_iff_tail F hij h, ← mem_finiteTail_iff_tail F hij h]
  exact Finset.ext_iff.mp hn'.2 g

end CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail
