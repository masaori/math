/-
章「大域写像の反復が生成する有限可換モノイド」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid.ts。

有限舞台上の二値 CA の大域写像 F について、反復写像の集合 P_F、反復回数の加法則、
合成に関する有限可換モノイドの各公理、写像空間の鳩の巣原理から得る衝突と有限代表集合、
有限真理値表による元と合成の決定を、人手証明と同じ順序で形式化する。

末尾に、必要十分版（NecSuf/IterateMonoid.lean。型 X と自己写像 F だけの反復モノイド）の
特殊化として具体版の各主張が得られる導出定理を置く。

比較回数のコストモデル自体は形式化しない。代わりに、写像の等号が全配位・全セルの
二値状態の等号へ分解されること、有限候補から衝突を選べること、有限代表集合が P_F と
一致すること、代表二元の合成が指数の加法で得られることを形式化する。
有限集合と自然数だけを使い、無限反復の極限、位相、R / C は使わない。
-/
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Data.Set.Card
import CellularAutomata.GlobalMapIteration
import CellularAutomata.NecSuf.IterateMonoid

namespace CellularAutomata.IterateMonoid

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 反復 F^n を配位空間上の写像として取り出す（`def_iterate_monoid`）。 -/
def iterateMap (n : ℕ) : (V → State) → (V → State) := fun y => iterate N f n y

/-- 反復写像の集合 P_F（`def_iterate_monoid`）。 -/
def powerSet : Set ((V → State) → (V → State)) :=
  {g | ∃ n : ℕ, iterateMap N f n = g}

omit [Fintype V] [DecidableEq V] in
/-- 反復回数の加法は写像の合成に一致する（`claim_iterate_composition_addition`）。
    人手証明と同じく m について帰納する。 -/
theorem iterateMap_comp_add (m n : ℕ) :
    iterateMap N f m ∘ iterateMap N f n = iterateMap N f (m + n) := by
  funext y
  induction m with
  | zero => simp [iterateMap, iterate]
  | succ m ih =>
    simp only [iterateMap, Function.comp_apply, iterate_succ, Nat.succ_add]
    change iterate N f m (iterate N f n y) = iterate N f (m + n) y at ih
    rw [ih]

omit [Fintype V] [DecidableEq V] in
/-- F^0 は恒等写像であり P_F に属する。 -/
theorem identity_mem_powerSet : id ∈ powerSet N f := by
  exact ⟨0, rfl⟩

omit [Fintype V] [DecidableEq V] in
/-- P_F は写像の合成について閉じる。 -/
theorem comp_mem_powerSet {g h : (V → State) → (V → State)}
    (hg : g ∈ powerSet N f) (hh : h ∈ powerSet N f) : g ∘ h ∈ powerSet N f := by
  rcases hg with ⟨m, rfl⟩
  rcases hh with ⟨n, rfl⟩
  exact ⟨m + n, (iterateMap_comp_add N f m n).symm⟩

omit [Fintype V] [DecidableEq V] in
/-- P_F の二元は可換である。 -/
theorem comp_comm_on_powerSet {g h : (V → State) → (V → State)}
    (hg : g ∈ powerSet N f) (hh : h ∈ powerSet N f) : g ∘ h = h ∘ g := by
  rcases hg with ⟨m, rfl⟩
  rcases hh with ⟨n, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

omit [Fintype V] [DecidableEq V] in
/-- P_F 上の合成は結合的である。 -/
theorem comp_assoc_on_powerSet
    (g h k : (V → State) → (V → State))
    (_hg : g ∈ powerSet N f) (_hh : h ∈ powerSet N f) (_hk : k ∈ powerSet N f) :
    (g ∘ h) ∘ k = g ∘ (h ∘ k) := by
  rfl

omit [Fintype V] [DecidableEq V] in
/-- 恒等写像は P_F の左右単位元である。 -/
theorem identity_laws_on_powerSet
    (g : (V → State) → (V → State)) (_hg : g ∈ powerSet N f) :
    id ∘ g = g ∧ g ∘ id = g := by
  exact ⟨rfl, rfl⟩

/-- 配位空間上の自己写像全体の個数は M^M（M = 2^{|V|}）。 -/
theorem card_endofunctions :
    Fintype.card ((V → State) → (V → State)) =
      (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) := by
  rw [Fintype.card_fun, card_config]

omit [DecidableEq V] in
/-- P_F は有限集合である。 -/
theorem powerSet_finite : (powerSet N f).Finite := Set.toFinite _

/-- 人手証明の個数上界 |P_F| ≤ M^M。 -/
theorem ncard_powerSet_le :
    (powerSet N f).ncard ≤ (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) := by
  calc
    (powerSet N f).ncard
        ≤ (Set.univ : Set ((V → State) → (V → State))).ncard :=
      Set.ncard_le_ncard (powerSet N f).subset_univ
    _ = Fintype.card ((V → State) → (V → State)) := by simp
    _ = (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) := card_endofunctions

omit [DecidableEq V] in
/-- 反復写像は有限可換モノイドの公理を満たす
    （`claim_iterate_powers_form_finite_commutative_monoid`）。 -/
theorem finite_commutative_monoid_laws :
    (powerSet N f).Finite ∧
      id ∈ powerSet N f ∧
      (∀ g ∈ powerSet N f, id ∘ g = g ∧ g ∘ id = g) ∧
      (∀ g ∈ powerSet N f, ∀ h ∈ powerSet N f, g ∘ h ∈ powerSet N f) ∧
      (∀ g ∈ powerSet N f, ∀ h ∈ powerSet N f, g ∘ h = h ∘ g) ∧
      (∀ g h k, g ∈ powerSet N f → h ∈ powerSet N f → k ∈ powerSet N f →
        (g ∘ h) ∘ k = g ∘ (h ∘ k)) := by
  exact ⟨powerSet_finite N f, identity_mem_powerSet N f,
    fun g hg => identity_laws_on_powerSet N f g hg,
    fun _ hg _ hh => comp_mem_powerSet N f hg hh,
    fun _ hg _ hh => comp_comm_on_powerSet N f hg hh,
    fun g h k hg hh hk => comp_assoc_on_powerSet N f g h k hg hh hk⟩

/-- K=M^M までの K+1 個の反復写像には衝突がある。 -/
theorem iterateMap_collision :
    ∃ i j : ℕ, i < j ∧
      j ≤ (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) ∧
      iterateMap N f i = iterateMap N f j := by
  let K : ℕ := (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V)
  let ι : Fin (K + 1) → ((V → State) → (V → State)) :=
    fun n => iterateMap N f n.val
  have hcard :
      Fintype.card ((V → State) → (V → State)) < Fintype.card (Fin (K + 1)) := by
    rw [Fintype.card_fin, card_endofunctions]
    exact Nat.lt_succ_self _
  obtain ⟨a, b, hab, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt ι hcard
  rcases lt_or_gt_of_ne hab with h | h
  · exact ⟨a.val, b.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp b.isLt, heq⟩
  · exact ⟨b.val, a.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp a.isLt, heq.symm⟩

omit [Fintype V] [DecidableEq V] in
/-- 写像としての衝突は、右から同じ反復を合成しても保たれる。 -/
theorem iterateMap_collision_shift {i j : ℕ} (h : iterateMap N f i = iterateMap N f j) (k : ℕ) :
    iterateMap N f (i + k) = iterateMap N f (j + k) := by
  rw [← iterateMap_comp_add, ← iterateMap_comp_add, h]

omit [Fintype V] [DecidableEq V] in
/-- F^i=F^{i+p} なら、指数から p を q 回除いても反復写像は変わらない。 -/
theorem iterateMap_reduce_period {i p : ℕ}
    (h : iterateMap N f i = iterateMap N f (i + p)) (q r : ℕ) :
    iterateMap N f (i + q * p + r) = iterateMap N f (i + r) := by
  induction q with
  | zero => simp
  | succ q ih =>
    have hs := iterateMap_collision_shift N f h (q * p + r)
    have hs' : iterateMap N f (i + (q + 1) * p + r) =
        iterateMap N f (i + q * p + r) := by
      simpa [Nat.succ_mul, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hs.symm
    exact hs'.trans ih

omit [Fintype V] [DecidableEq V] in
/-- 一つの衝突から、全反復写像が j 未満の指数で代表される
    （`claim_iterate_map_collision_finite_representatives` の後半）。 -/
theorem exists_representative_below_of_collision {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (n : ℕ) :
    ∃ r : ℕ, r < j ∧ iterateMap N f n = iterateMap N f r := by
  by_cases hn : n < i
  · exact ⟨n, hn.trans hij, rfl⟩
  · let p := j - i
    have hp : 0 < p := by omega
    let q := (n - i) / p
    let r := (n - i) % p
    have hdiv : n - i = q * p + r := by
      simpa [q, r, Nat.mul_comm, Nat.add_comm] using (Nat.mod_add_div (n - i) p).symm
    have hrp : r < p := Nat.mod_lt _ hp
    have hnform : n = i + q * p + r := by omega
    have hip : i + p = j := by omega
    refine ⟨i + r, by omega, ?_⟩
    rw [hnform]
    apply iterateMap_reduce_period N f (i := i) (p := p) _ q r
    simpa [hip] using h

/-- 衝突後の j 未満の反復写像を集めた有限代表集合。 -/
def representatives (j : ℕ) : Finset ((V → State) → (V → State)) :=
  (Finset.range j).image (iterateMap N f)

/-- 衝突があれば、有限代表集合は P_F と一致する。 -/
theorem mem_representatives_iff_powerSet {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (g : (V → State) → (V → State)) :
    g ∈ representatives N f j ↔ g ∈ powerSet N f := by
  constructor
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨n, hn, rfl⟩
    exact ⟨n, rfl⟩
  · rintro ⟨n, rfl⟩
    obtain ⟨r, hrj, hr⟩ := exists_representative_below_of_collision N f hij h n
    exact Finset.mem_image.mpr ⟨r, Finset.mem_range.mpr hrj, hr.symm⟩

omit [Fintype V] [DecidableEq V] in
/-- 配位写像の等号は全配位・全セルの二値状態の等号に分解される。 -/
theorem map_eq_iff_state_eq (g h : (V → State) → (V → State)) :
    g = h ↔ ∀ y : V → State, ∀ v : V, g y v = h y v := by
  constructor
  · rintro rfl y v
    rfl
  · intro hgh
    funext y v
    exact hgh y v

omit [Fintype V] [DecidableEq V] in
/-- 有限代表二元の合成は指数の加法で得られる。 -/
theorem representative_composition (m n : ℕ) :
    iterateMap N f m ∘ iterateMap N f n = iterateMap N f (m + n) :=
  iterateMap_comp_add N f m n

/-- 反復写像の衝突は有限候補上で決定可能である。 -/
instance (K : ℕ) :
    Decidable (∃ i ∈ Finset.range (K + 1), ∃ j ∈ Finset.range (K + 1),
      i < j ∧ iterateMap N f i = iterateMap N f j) :=
  Finset.decidableExistsAndFinset

/-! ## 必要十分版からの導出
具体版は必要十分版を X := V → State、F := globalMap N f へ特殊化したものである。 -/

omit [Fintype V] [DecidableEq V] in
theorem iterateMap_eq_necessary_sufficient (n : ℕ) :
    iterateMap N f n =
      CellularAutomata.NecSuf.IterateMonoid.iterateMap (globalMap N f) n := by
  funext y
  exact iterate_eq_necessary_sufficient N f n y

omit [Fintype V] [DecidableEq V] in
theorem powerSet_eq_necessary_sufficient :
    powerSet N f = CellularAutomata.NecSuf.IterateMonoid.powerSet (globalMap N f) := by
  ext g
  simp only [powerSet, CellularAutomata.NecSuf.IterateMonoid.powerSet, Set.mem_setOf_eq,
    iterateMap_eq_necessary_sufficient]

omit [Fintype V] [DecidableEq V] in
theorem iterateMap_comp_add_from_necessary_sufficient (m n : ℕ) :
    iterateMap N f m ∘ iterateMap N f n = iterateMap N f (m + n) := by
  simp only [iterateMap_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoid.iterateMap_comp_add (globalMap N f) m n

omit [DecidableEq V] in
/-- 有限可換モノイドの公理は、有限型 V → State 上の自己写像への特殊化で得られる。 -/
theorem finite_commutative_monoid_laws_from_necessary_sufficient :
    (powerSet N f).Finite ∧
      id ∈ powerSet N f ∧
      (∀ g ∈ powerSet N f, id ∘ g = g ∧ g ∘ id = g) ∧
      (∀ g ∈ powerSet N f, ∀ h ∈ powerSet N f, g ∘ h ∈ powerSet N f) ∧
      (∀ g ∈ powerSet N f, ∀ h ∈ powerSet N f, g ∘ h = h ∘ g) ∧
      (∀ g h k, g ∈ powerSet N f → h ∈ powerSet N f → k ∈ powerSet N f →
        (g ∘ h) ∘ k = g ∘ (h ∘ k)) := by
  rw [powerSet_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoid.finite_commutative_monoid_laws (globalMap N f)

/-- 個数上界 M^M は、|X| = 2^{|V|} を代入して得られる。 -/
theorem ncard_powerSet_le_from_necessary_sufficient :
    (powerSet N f).ncard ≤ (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) := by
  rw [powerSet_eq_necessary_sufficient]
  have h := CellularAutomata.NecSuf.IterateMonoid.ncard_powerSet_le (globalMap N f)
  rw [card_config] at h
  exact h

/-- 衝突 F^i = F^j（j ≤ M^M）は、|X| = 2^{|V|} を代入して得られる。 -/
theorem iterateMap_collision_from_necessary_sufficient :
    ∃ i j : ℕ, i < j ∧
      j ≤ (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) ∧
      iterateMap N f i = iterateMap N f j := by
  obtain ⟨i, j, hij, hj, heq⟩ :=
    CellularAutomata.NecSuf.IterateMonoid.iterateMap_collision (globalMap N f)
  refine ⟨i, j, hij, ?_, ?_⟩
  · rw [card_config (V := V)] at hj
    exact hj
  · simpa only [iterateMap_eq_necessary_sufficient] using heq

omit [Fintype V] [DecidableEq V] in
theorem exists_representative_below_of_collision_from_necessary_sufficient {i j : ℕ}
    (hij : i < j) (h : iterateMap N f i = iterateMap N f j) (n : ℕ) :
    ∃ r : ℕ, r < j ∧ iterateMap N f n = iterateMap N f r := by
  simp only [iterateMap_eq_necessary_sufficient] at h ⊢
  exact CellularAutomata.NecSuf.IterateMonoid.exists_representative_below_of_collision
    (globalMap N f) hij h n

theorem representatives_eq_necessary_sufficient (j : ℕ) :
    representatives N f j =
      CellularAutomata.NecSuf.IterateMonoid.representatives (globalMap N f) j := by
  ext g
  simp only [representatives, CellularAutomata.NecSuf.IterateMonoid.representatives,
    Finset.mem_image, iterateMap_eq_necessary_sufficient]

theorem mem_representatives_iff_powerSet_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (g : (V → State) → (V → State)) :
    g ∈ representatives N f j ↔ g ∈ powerSet N f := by
  rw [representatives_eq_necessary_sufficient, powerSet_eq_necessary_sufficient]
  simp only [iterateMap_eq_necessary_sufficient] at h
  exact CellularAutomata.NecSuf.IterateMonoid.mem_representatives_iff_powerSet
    (globalMap N f) hij h g

omit [Fintype V] [DecidableEq V] in
theorem map_eq_iff_state_eq_from_necessary_sufficient
    (g h : (V → State) → (V → State)) :
    g = h ↔ ∀ y : V → State, ∀ v : V, g y v = h y v :=
  CellularAutomata.NecSuf.IterateMonoid.map_eq_iff_state_eq g h

end CellularAutomata.IterateMonoid
