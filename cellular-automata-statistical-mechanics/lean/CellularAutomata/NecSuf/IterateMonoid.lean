/-
章「大域写像の反復が生成する有限可換モノイド」の必要十分版。

具体版と同じ手順（m についての帰納法による加法則、写像空間への鳩の巣原理、
衝突の右合成による移送、自然数の除法による有限代表への還元、写像等号の点ごとの分解、
指数の加法による合成）を保ち、実際に使う構造だけを残す。

* 反復写像の集合、加法則、有限可換モノイドの各公理（単位元・閉性・結合律・可換律）には、
  型 X と自己写像 F : X → X だけを使う。有限性も等号判定も要らない。
* 個数上界 |P_F| ≤ |X|^|X| と衝突 F^i = F^j（0 ≤ i < j ≤ |X|^|X|）には X の有限性だけを追加する。
  写像空間 X → X の有限性は X の有限性から従い、証明内で古典論理により Fintype 構造を得る。
  等号判定は仮定に含めない（具体版は V の等号判定から X → X の Fintype 構造を得ていたが、
  それは Lean の構成上の都合であって鳩の巣原理の内容には要らない）。
* 衝突の移送、除法による還元、有限代表集合と P_F の一致には、衝突の存在以外に構造は要らない。
* 写像等号の点ごとの分解には外延性だけが要る。X が配位型 V → S なら各セルの状態等号へ分解できる。
* 有限候補上の衝突存在文の決定可能性にだけ X の等号判定を追加する
  （X → X の等号判定を得るのに X の有限性も要る）。

二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Data.Set.Card
import CellularAutomata.NecSuf.GlobalMapIteration

namespace CellularAutomata.NecSuf.IterateMonoid

open CellularAutomata.NecSuf.GlobalMapIteration

variable {X : Type}

/-- 反復 F^n を X 上の写像として取り出す。 -/
def iterateMap (F : X → X) (n : ℕ) : X → X := fun x => iterate F n x

/-- 反復写像の集合 P_F。 -/
def powerSet (F : X → X) : Set (X → X) := {g | ∃ n : ℕ, iterateMap F n = g}

/-- 加法則。具体版と同じく m について帰納する。 -/
theorem iterateMap_comp_add (F : X → X) (m n : ℕ) :
    iterateMap F m ∘ iterateMap F n = iterateMap F (m + n) := by
  funext x
  induction m with
  | zero => simp [iterateMap, iterate]
  | succ m ih =>
    simp only [iterateMap, Function.comp_apply, iterate_succ, Nat.succ_add]
    change iterate F m (iterate F n x) = iterate F (m + n) x at ih
    rw [ih]

theorem identity_mem_powerSet (F : X → X) : id ∈ powerSet F := ⟨0, rfl⟩

theorem comp_mem_powerSet (F : X → X) {g h : X → X}
    (hg : g ∈ powerSet F) (hh : h ∈ powerSet F) : g ∘ h ∈ powerSet F := by
  rcases hg with ⟨m, rfl⟩
  rcases hh with ⟨n, rfl⟩
  exact ⟨m + n, (iterateMap_comp_add F m n).symm⟩

theorem comp_comm_on_powerSet (F : X → X) {g h : X → X}
    (hg : g ∈ powerSet F) (hh : h ∈ powerSet F) : g ∘ h = h ∘ g := by
  rcases hg with ⟨m, rfl⟩
  rcases hh with ⟨n, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

theorem comp_assoc_on_powerSet (F : X → X) (g h k : X → X)
    (_hg : g ∈ powerSet F) (_hh : h ∈ powerSet F) (_hk : k ∈ powerSet F) :
    (g ∘ h) ∘ k = g ∘ (h ∘ k) := rfl

theorem identity_laws_on_powerSet (F : X → X) (g : X → X) (_hg : g ∈ powerSet F) :
    id ∘ g = g ∧ g ∘ id = g := ⟨rfl, rfl⟩

/-- 有限型 X 上の自己写像全体の個数は |X|^|X|。等号判定は要らない（証明内で古典論理を使う）。 -/
theorem card_endofunctions [Fintype X] :
    Nat.card (X → X) = Fintype.card X ^ Fintype.card X := by
  rw [Nat.card_fun, Nat.card_eq_fintype_card]

/-- P_F は有限集合である。要るのは X の有限性だけ。 -/
theorem powerSet_finite [Finite X] (F : X → X) : (powerSet F).Finite := Set.toFinite _

/-- 個数上界 |P_F| ≤ |X|^|X|。 -/
theorem ncard_powerSet_le [Fintype X] (F : X → X) :
    (powerSet F).ncard ≤ Fintype.card X ^ Fintype.card X := by
  calc
    (powerSet F).ncard ≤ (Set.univ : Set (X → X)).ncard :=
      Set.ncard_le_ncard (powerSet F).subset_univ
    _ = Nat.card (X → X) := Set.ncard_univ _
    _ = Fintype.card X ^ Fintype.card X := card_endofunctions

/-- 有限可換モノイドの公理。有限性は最初の連言肢にだけ要る。 -/
theorem finite_commutative_monoid_laws [Finite X] (F : X → X) :
    (powerSet F).Finite ∧
      id ∈ powerSet F ∧
      (∀ g ∈ powerSet F, id ∘ g = g ∧ g ∘ id = g) ∧
      (∀ g ∈ powerSet F, ∀ h ∈ powerSet F, g ∘ h ∈ powerSet F) ∧
      (∀ g ∈ powerSet F, ∀ h ∈ powerSet F, g ∘ h = h ∘ g) ∧
      (∀ g h k, g ∈ powerSet F → h ∈ powerSet F → k ∈ powerSet F →
        (g ∘ h) ∘ k = g ∘ (h ∘ k)) :=
  ⟨powerSet_finite F, identity_mem_powerSet F,
    fun g hg => identity_laws_on_powerSet F g hg,
    fun _ hg _ hh => comp_mem_powerSet F hg hh,
    fun _ hg _ hh => comp_comm_on_powerSet F hg hh,
    fun g h k hg hh hk => comp_assoc_on_powerSet F g h k hg hh hk⟩

/-- K = |X|^|X| までの K+1 個の反復写像には衝突がある。具体版と同じ鳩の巣原理。
    要るのは X の有限性だけで、X → X の Fintype 構造は古典論理で得る。 -/
theorem iterateMap_collision [Fintype X] (F : X → X) :
    ∃ i j : ℕ, i < j ∧ j ≤ Fintype.card X ^ Fintype.card X ∧
      iterateMap F i = iterateMap F j := by
  classical
  let K : ℕ := Fintype.card X ^ Fintype.card X
  let ι : Fin (K + 1) → (X → X) := fun n => iterateMap F n.val
  have hcard : Fintype.card (X → X) < Fintype.card (Fin (K + 1)) := by
    rw [Fintype.card_fin, Fintype.card_fun]
    exact Nat.lt_succ_self _
  obtain ⟨a, b, hab, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt ι hcard
  rcases lt_or_gt_of_ne hab with h | h
  · exact ⟨a.val, b.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp b.isLt, heq⟩
  · exact ⟨b.val, a.val, Fin.lt_def.mp h, Nat.lt_succ_iff.mp a.isLt, heq.symm⟩

/-- 衝突の右合成による移送。構造は要らない。 -/
theorem iterateMap_collision_shift (F : X → X) {i j : ℕ}
    (h : iterateMap F i = iterateMap F j) (k : ℕ) :
    iterateMap F (i + k) = iterateMap F (j + k) := by
  rw [← iterateMap_comp_add, ← iterateMap_comp_add, h]

/-- 指数から p を q 回除く。q についての帰納法。 -/
theorem iterateMap_reduce_period (F : X → X) {i p : ℕ}
    (h : iterateMap F i = iterateMap F (i + p)) (q r : ℕ) :
    iterateMap F (i + q * p + r) = iterateMap F (i + r) := by
  induction q with
  | zero => simp
  | succ q ih =>
    have hs := iterateMap_collision_shift F h (q * p + r)
    have hs' : iterateMap F (i + (q + 1) * p + r) = iterateMap F (i + q * p + r) := by
      simpa [Nat.succ_mul, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hs.symm
    exact hs'.trans ih

/-- 一つの衝突から、全反復写像が j 未満の指数で代表される。自然数の除法だけを使う。 -/
theorem exists_representative_below_of_collision (F : X → X) {i j : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) (n : ℕ) :
    ∃ r : ℕ, r < j ∧ iterateMap F n = iterateMap F r := by
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
    apply iterateMap_reduce_period F (i := i) (p := p) _ q r
    simpa [hip] using h

/-- 衝突後の j 未満の反復写像を集めた有限代表集合。像を Finset として作るために
    X → X の等号判定が要る（X の有限性と等号判定から得る）。 -/
def representatives [DecidableEq (X → X)] (F : X → X) (j : ℕ) : Finset (X → X) :=
  (Finset.range j).image (iterateMap F)

theorem mem_representatives_iff_powerSet [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) (g : X → X) :
    g ∈ representatives F j ↔ g ∈ powerSet F := by
  constructor
  · intro hg
    rcases Finset.mem_image.mp hg with ⟨n, hn, rfl⟩
    exact ⟨n, rfl⟩
  · rintro ⟨n, rfl⟩
    obtain ⟨r, hrj, hr⟩ := exists_representative_below_of_collision F hij h n
    exact Finset.mem_image.mpr ⟨r, Finset.mem_range.mpr hrj, hr.symm⟩

/-- 写像の等号は点ごとの等号に分解される。外延性だけを使う。 -/
theorem map_eq_iff_pointwise (g h : X → X) : g = h ↔ ∀ x : X, g x = h x := by
  constructor
  · rintro rfl x
    rfl
  · intro hgh
    funext x
    exact hgh x

/-- X が配位型 V → S のときは、さらに各座標の状態等号へ分解される。V, S に構造は要らない。 -/
theorem map_eq_iff_state_eq {V S : Type} (g h : (V → S) → (V → S)) :
    g = h ↔ ∀ y : V → S, ∀ v : V, g y v = h y v := by
  constructor
  · rintro rfl y v
    rfl
  · intro hgh
    funext y v
    exact hgh y v

/-- 代表二元の合成は指数の加法で得られる。 -/
theorem representative_composition (F : X → X) (m n : ℕ) :
    iterateMap F m ∘ iterateMap F n = iterateMap F (m + n) :=
  iterateMap_comp_add F m n

/-- 有限候補上の衝突存在文の決定可能性。X の有限性と等号判定だけを追加する。 -/
instance [Fintype X] [DecidableEq X] (F : X → X) (K : ℕ) :
    Decidable (∃ i ∈ Finset.range (K + 1), ∃ j ∈ Finset.range (K + 1),
      i < j ∧ iterateMap F i = iterateMap F j) :=
  Finset.decidableExistsAndFinset

end CellularAutomata.NecSuf.IterateMonoid
