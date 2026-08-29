/-
章「大域写像の反復と軌道の最終周期性」の具体版。
人手証明の正本は structured-latex/content/global-map-iteration.ts。

有限舞台上の 2 値 CA の大域写像 F の反復 F^n と軌道を定義し、人手証明と同じ対象・仮定・順序で
「軌道は高々 2^{|V|} 回の反復のうちに衝突する」（鳩の巣）、「衝突は反復で保たれる」（k の帰納法）、
「軌道は最終的に周期的である」（p := j - i）、「衝突する組は有限個の等号検査で見つかる」を形式化する。
ℕ について使うのは後者・加法・大小比較・等号だけで、R / C は使わない。
無限舞台・極限集合・最小前周期・最小周期は扱わない（人手証明の remark と同じ範囲）。
等号検査の回数のコストモデル自体は形式化せず、走査する候補組の総数（2 倍が 2^{|V|}(2^{|V|}+1)）と、
配位の等号が各セルの状態の等号に分解されること、候補組上の存在文が決定可能であることを形式化する。

対応表（人手証明 → この file）
  def_finite_self_map_iterate                     `iterate`, `iterate_zero`, `iterate_succ`
  def_orbit                                  `orbit`
  claim_orbit_collision                      `card_config`（既出 `card_state` を使う）, `orbit_collision`
  claim_collision_shift                      `collision_shift`
  claim_finite_self_map_repeating_tail                 `eventual_periodicity`
  claim_collision_finite_decidability        `scanPairs`, `mem_scanPairs`, `card_scanPairs_two_mul`,
                                             `exists_collision_in_scanPairs`, `config_eq_iff`,
                                             `instance : Decidable (∃ x ∈ scanPairs M, ...)`
-/
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Algebra.BigOperators.Intervals
import CellularAutomata.TimeExpansionDependency
import CellularAutomata.NecSuf.GlobalMapIteration

namespace CellularAutomata.GlobalMapIteration

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 大域写像の n 回反復 F^n（`def_finite_self_map_iterate`）。n についての再帰で定める。 -/
def iterate : ℕ → (V → State) → (V → State)
  | 0, y => y
  | n + 1, y => globalMap N f (iterate n y)

omit [Fintype V] [DecidableEq V] in
theorem iterate_zero (y : V → State) : iterate N f 0 y = y := rfl

omit [Fintype V] [DecidableEq V] in
theorem iterate_succ (n : ℕ) (y : V → State) :
    iterate N f (n + 1) y = globalMap N f (iterate N f n y) := rfl

/-- 配位 y の軌道 O(y) = { F^n y | n ∈ ℕ }（`def_orbit`）。 -/
def orbit (y : V → State) : Set (V → State) := {z | ∃ n : ℕ, iterate N f n y = z}

/-- 配位集合 A^V の元の個数は 2^{|V|}（`claim_orbit_collision` の証明の第一段）。 -/
theorem card_config : Fintype.card (V → State) = 2 ^ Fintype.card V := by
  rw [Fintype.card_fun, card_state]

/-- 軌道は高々 2^{|V|} 回の反復のうちに衝突する（`claim_orbit_collision`）。
    ι_y : {0,…,M} → A^V, n ↦ F^n y は定義域の個数 M+1 が終域の個数 M より大きいので単射でなく、
    i ≠ j で ι_y i = ι_y j を得て、ℕ の全順序で i < j に並べ替える。 -/
theorem orbit_collision (y : V → State) :
    ∃ i j : ℕ, i < j ∧ j ≤ 2 ^ Fintype.card V ∧ iterate N f i y = iterate N f j y := by
  let M : ℕ := 2 ^ Fintype.card V
  let ι : Fin (M + 1) → (V → State) := fun n => iterate N f n.val y
  have hcard : Fintype.card (V → State) < Fintype.card (Fin (M + 1)) := by
    rw [Fintype.card_fin, card_config]
    exact Nat.lt_succ_self _
  obtain ⟨a, b, hab, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt ι hcard
  rcases lt_or_gt_of_ne hab with h | h
  · exact ⟨a.val, b.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp b.isLt, heq⟩
  · exact ⟨b.val, a.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp a.isLt, heq.symm⟩

omit [Fintype V] [DecidableEq V] in
/-- 衝突は反復で保たれる（`claim_collision_shift`）。k についての帰納法。 -/
theorem collision_shift (y : V → State) {i j : ℕ}
    (h : iterate N f i y = iterate N f j y) (k : ℕ) :
    iterate N f (i + k) y = iterate N f (j + k) y := by
  induction k with
  | zero => simpa using h
  | succ k ih =>
    show globalMap N f (iterate N f (i + k) y) = globalMap N f (iterate N f (j + k) y)
    rw [ih]

/-- 軌道は最終的に周期的である（`claim_finite_self_map_repeating_tail`）。
    衝突 (i, j) から p := j - i とし、n ≥ i に対し k := n - i で衝突の反復不変性を使う。 -/
theorem eventual_periodicity (y : V → State) :
    ∃ i p : ℕ, 1 ≤ p ∧ i + p ≤ 2 ^ Fintype.card V ∧
      ∀ n : ℕ, i ≤ n → iterate N f (n + p) y = iterate N f n y := by
  obtain ⟨i, j, hij, hjM, heq⟩ := orbit_collision N f y
  refine ⟨i, j - i, by omega, by omega, ?_⟩
  intro n hn
  have hk := collision_shift N f y heq (n - i)
  have h1 : i + (n - i) = n := by omega
  have h2 : j + (n - i) = n + (j - i) := by omega
  rw [h1, h2] at hk
  exact hk.symm

/-- 走査する候補組の全体（`claim_collision_finite_decidability`）。
    ⟨j, i⟩ が「0 ≤ i < j ≤ M」を表す。 -/
def scanPairs (M : ℕ) : Finset (Σ _ : ℕ, ℕ) :=
  (Finset.range (M + 1)).sigma fun j => Finset.range j

theorem mem_scanPairs (M i j : ℕ) : (⟨j, i⟩ : Σ _ : ℕ, ℕ) ∈ scanPairs M ↔ i < j ∧ j ≤ M := by
  simp only [scanPairs, Finset.mem_sigma, Finset.mem_range, Nat.lt_succ_iff]
  exact and_comm

/-- 候補組の総数の 2 倍は M (M+1)。すなわち総数は ½ M (M+1)。 -/
theorem card_scanPairs_two_mul (M : ℕ) : (scanPairs M).card * 2 = (M + 1) * M := by
  simp only [scanPairs, Finset.card_sigma, Finset.card_range]
  simpa using Finset.sum_range_id_mul_two (M + 1)

/-- 走査は等号の成り立つ組を返す（`claim_orbit_collision` により少なくとも一つある）。 -/
theorem exists_collision_in_scanPairs (y : V → State) :
    ∃ x ∈ scanPairs (2 ^ Fintype.card V), iterate N f x.2 y = iterate N f x.1 y := by
  obtain ⟨i, j, hij, hjM, heq⟩ := orbit_collision N f y
  exact ⟨⟨j, i⟩, (mem_scanPairs _ i j).mpr ⟨hij, hjM⟩, heq⟩

omit [Fintype V] [DecidableEq V] in
/-- 配位の等号は各セルの状態の等号と同値（写像の外延性）。 -/
theorem config_eq_iff (z z' : V → State) : z = z' ↔ ∀ v : V, z v = z' v := funext_iff

/-- 候補組上の存在文は有限個の論理和として決定できる。 -/
instance (y : V → State) (M : ℕ) :
    Decidable (∃ x ∈ scanPairs M, iterate N f x.2 y = iterate N f x.1 y) :=
  Finset.decidableExistsAndFinset

/-! ## 必要十分版からの導出

以下は、上の具体版の定義・定理が、必要十分版
(`NecSuf.GlobalMapIteration`) を配位集合 `V → State` とその大域写像へ
特殊化したものであることの導出。 -/

omit [Fintype V] [DecidableEq V] in
theorem iterate_eq_necessary_sufficient (n : ℕ) (y : V → State) :
    iterate N f n y =
      CellularAutomata.NecSuf.GlobalMapIteration.iterate (globalMap N f) n y := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [iterate_succ,
      CellularAutomata.NecSuf.GlobalMapIteration.iterate_succ, ih]

omit [Fintype V] [DecidableEq V] in
theorem orbit_eq_necessary_sufficient (y : V → State) :
    orbit N f y =
      CellularAutomata.NecSuf.GlobalMapIteration.orbit (globalMap N f) y := by
  ext z
  simp only [orbit, CellularAutomata.NecSuf.GlobalMapIteration.orbit, Set.mem_setOf_eq]
  constructor
  · rintro ⟨n, hn⟩
    exact ⟨n, (iterate_eq_necessary_sufficient N f n y).symm.trans hn⟩
  · rintro ⟨n, hn⟩
    exact ⟨n, (iterate_eq_necessary_sufficient N f n y).trans hn⟩

/-- 具体版の衝突は、有限型上の自己写像の衝突定理と
    |A^V| = 2^{|V|} から導かれる。 -/
theorem orbit_collision_from_necessary_sufficient (y : V → State) :
    ∃ i j : ℕ, i < j ∧ j ≤ 2 ^ Fintype.card V ∧
      iterate N f i y = iterate N f j y := by
  obtain ⟨i, j, hij, hj, heq⟩ :=
    CellularAutomata.NecSuf.GlobalMapIteration.orbit_collision (globalMap N f) y
  refine ⟨i, j, hij, ?_, ?_⟩
  · rw [card_config (V := V)] at hj
    exact hj
  · simpa only [iterate_eq_necessary_sufficient] using heq

omit [Fintype V] [DecidableEq V] in
theorem collision_shift_from_necessary_sufficient (y : V → State) {i j : ℕ}
    (h : iterate N f i y = iterate N f j y) (k : ℕ) :
    iterate N f (i + k) y = iterate N f (j + k) y := by
  rw [iterate_eq_necessary_sufficient N f i y,
    iterate_eq_necessary_sufficient N f j y] at h
  have hs := CellularAutomata.NecSuf.GlobalMapIteration.collision_shift
    (globalMap N f) y h k
  simpa only [iterate_eq_necessary_sufficient] using hs

/-- 具体版の最終周期性は、有限型上の自己写像の定理と
    |A^V| = 2^{|V|} から導かれる。 -/
theorem eventual_periodicity_from_necessary_sufficient (y : V → State) :
    ∃ i p : ℕ, 1 ≤ p ∧ i + p ≤ 2 ^ Fintype.card V ∧
      ∀ n : ℕ, i ≤ n → iterate N f (n + p) y = iterate N f n y := by
  obtain ⟨i, p, hp, hip, hperiod⟩ :=
    CellularAutomata.NecSuf.GlobalMapIteration.eventual_periodicity (globalMap N f) y
  refine ⟨i, p, hp, ?_, ?_⟩
  · rw [card_config (V := V)] at hip
    exact hip
  · intro n hn
    have h := hperiod n hn
    simpa only [iterate_eq_necessary_sufficient] using h

theorem scanPairs_eq_necessary_sufficient (M : ℕ) :
    scanPairs M = CellularAutomata.NecSuf.GlobalMapIteration.scanPairs M := rfl

theorem mem_scanPairs_from_necessary_sufficient (M i j : ℕ) :
    (⟨j, i⟩ : Σ _ : ℕ, ℕ) ∈ scanPairs M ↔ i < j ∧ j ≤ M := by
  exact CellularAutomata.NecSuf.GlobalMapIteration.mem_scanPairs M i j

theorem card_scanPairs_two_mul_from_necessary_sufficient (M : ℕ) :
    (scanPairs M).card * 2 = (M + 1) * M := by
  exact CellularAutomata.NecSuf.GlobalMapIteration.card_scanPairs_two_mul M

/-- 具体版の衝突候補の存在は、有限配位集合上の自己写像への特殊化である。 -/
theorem exists_collision_in_scanPairs_from_necessary_sufficient (y : V → State) :
    ∃ x ∈ scanPairs (2 ^ Fintype.card V),
      iterate N f x.2 y = iterate N f x.1 y := by
  have h := CellularAutomata.NecSuf.GlobalMapIteration.exists_collision_in_scanPairs
    (globalMap N f) y
  rw [card_config] at h
  simpa only [scanPairs_eq_necessary_sufficient, iterate_eq_necessary_sufficient] using h

end CellularAutomata.GlobalMapIteration
