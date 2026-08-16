/-
章「反復モノイドの冪等元」の必要十分版。

具体版と同じ手順（衝突の右合成による移送から以後の周期、周期の有限回反復、
衝突の始点 i=0 と i≥1 の場合分けによる正の冪等指数の構成、
有限代表集合を対角合成で絞る有限決定、恒等写像と定値写像による反例）を保ち、
実際に使う構造だけを残す。

* 冪等元の集合と冪等指数の定義、衝突からの以後の周期、周期の q 回適用には
  型 X と自己写像 F : X → X だけを使う。有限性も等号判定も要らない。
* 正の冪等指数の存在に要るのは「ある衝突 F^i = F^j（i < j）が存在すること」だけである。
  X の有限性は衝突を与えるためにだけ使う（前章の必要十分版 `iterateMap_collision`）ので、
  衝突を仮定した定理と、有限性から衝突を得る定理を分ける。
* 有限代表集合を対角合成で絞る有限決定にだけ、代表集合の `Finset` 化と述語の判定のために
  X → X の等号判定が要る（前章と同じく X の有限性と等号判定から得る）。
* 反例のうち「単位元でない冪等元は強制されない」には恒等写像だけが要り、X に構造は要らない。
  「一意性は成り立たない」には相異なる二点 a ≠ b と、a への定値写像だけが要る。
  二値状態、セル、近傍、局所規則は要らない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoid

namespace CellularAutomata.NecSuf.IterateMonoidIdempotents

open CellularAutomata.NecSuf.IterateMonoid

variable {X : Type}

/-- 反復モノイドの冪等元。X に構造は要らない。 -/
def idempotents (F : X → X) : Set (X → X) :=
  {g | g ∈ powerSet F ∧ g ∘ g = g}

/-- 冪等指数。 -/
def IsIdempotentExponent (F : X → X) (e : ℕ) : Prop := iterateMap F e ∈ idempotents F

/-- 衝突 F^i = F^j は時刻 i 以後に周期 p = j - i を与える。具体版と同じ式変形
    （n = i + k、加法の結合律・交換律、j = i + p、加法則、衝突、加法則）。構造は要らない。 -/
theorem collision_gives_eventual_period (F : X → X) {i j n : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) (hn : i ≤ n) :
    iterateMap F (n + (j - i)) = iterateMap F n := by
  have hn' : n = i + (n - i) := by omega
  calc
    iterateMap F (n + (j - i)) = iterateMap F (j + (n - i)) := by
      congr 1
      omega
    _ = iterateMap F (i + (n - i)) :=
      (iterateMap_collision_shift F h (n - i)).symm
    _ = iterateMap F n := by rw [← hn']

/-- 以後の周期を q 回適用する。q についての帰納法。構造は要らない。 -/
theorem collision_period_multiple (F : X → X) {i j n : ℕ} (hij : i < j)
    (h : iterateMap F i = iterateMap F j) (hn : i ≤ n) (q : ℕ) :
    iterateMap F (n + q * (j - i)) = iterateMap F n := by
  induction q with
  | zero => simp
  | succ q ih =>
    calc
      iterateMap F (n + (q + 1) * (j - i)) =
          iterateMap F ((n + q * (j - i)) + (j - i)) := by
        congr 1
        simp [Nat.succ_mul, Nat.add_assoc]
      _ = iterateMap F (n + q * (j - i)) :=
        collision_gives_eventual_period F hij h (by omega)
      _ = iterateMap F n := ih

/-- 正の冪等指数の存在。要るのは衝突の存在だけであり、有限性そのものは要らない。
    具体版と同じく衝突の始点 i = 0 と i ≥ 1 を分ける。 -/
theorem positive_idempotent_iterate_exists_of_collision (F : X → X)
    (hcol : ∃ i j : ℕ, i < j ∧ iterateMap F i = iterateMap F j) :
    ∃ e : ℕ, 0 < e ∧ IsIdempotentExponent F e := by
  obtain ⟨i, j, hij, h⟩ := hcol
  let p := j - i
  have hp : 0 < p := by omega
  by_cases hi : i = 0
  · subst i
    refine ⟨p, hp, ?_⟩
    constructor
    · exact ⟨p, rfl⟩
    · rw [iterateMap_comp_add]
      simpa [p] using collision_gives_eventual_period F hij h (n := p) (by omega)
  · have hi1 : 1 ≤ i := by omega
    let e := i * p
    have hei : i ≤ e := by
      calc
        i = i * 1 := by simp
        _ ≤ i * p := Nat.mul_le_mul_left i hp
    refine ⟨e, by simp [e]; omega, ?_⟩
    constructor
    · exact ⟨e, rfl⟩
    · rw [iterateMap_comp_add]
      have hm := collision_period_multiple F hij h hei i
      simpa [e, p, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hm

/-- 有限型 X 上では衝突が存在するので、正の冪等指数が存在する。
    有限性はここでだけ（衝突を得るために）使う。 -/
theorem positive_idempotent_iterate_exists [Fintype X] (F : X → X) :
    ∃ e : ℕ, 0 < e ∧ IsIdempotentExponent F e := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision F
  exact positive_idempotent_iterate_exists_of_collision F ⟨i, j, hij, h⟩

/-- 衝突から得た有限代表集合のうち、対角合成が自分自身に等しい元だけを集める。
    `Finset` の filter に X → X の等号判定が要る。 -/
def idempotentRepresentatives [DecidableEq (X → X)] (F : X → X) (j : ℕ) : Finset (X → X) :=
  (representatives F j).filter (fun g => g ∘ g = g)

/-- 有限走査で得た集合は冪等元全体と一致する。 -/
theorem mem_idempotentRepresentatives_iff [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) (g : X → X) :
    g ∈ idempotentRepresentatives F j ↔ g ∈ idempotents F := by
  simp only [idempotentRepresentatives, Finset.mem_filter, idempotents, Set.mem_setOf_eq]
  rw [mem_representatives_iff_powerSet F hij h]

/-! ### 反例。X に構造は要らない（一意性の反例には相異なる二点だけが要る） -/

/-- 恒等写像の全反復は恒等写像である。 -/
theorem iterateMap_id (n : ℕ) : iterateMap (id : X → X) n = id := by
  induction n with
  | zero => rfl
  | succ n ih =>
    funext x
    simp only [iterateMap, GlobalMapIteration.iterate_succ]
    exact congrFun ih x

/-- 恒等写像の反復モノイドには単位元以外の冪等元がない。 -/
theorem id_no_nonidentity_idempotent (g : X → X)
    (hg : g ∈ idempotents (id : X → X)) : g = id := by
  rcases hg.1 with ⟨n, rfl⟩
  exact iterateMap_id n

/-- 定値写像は冪等である。 -/
theorem const_idempotent (a : X) :
    (fun _ : X => a) ∘ (fun _ : X => a) = fun _ : X => a := rfl

/-- 相異なる二点 a ≠ b があれば、a への定値写像 F について、恒等写像と F が
    相異なる冪等元になり、冪等元の一意性は成り立たない。 -/
theorem const_idempotent_uniqueness_fails {a b : X} (hab : a ≠ b) :
    ∃ g h : X → X,
      g ∈ idempotents (fun _ : X => a) ∧
      h ∈ idempotents (fun _ : X => a) ∧ g ≠ h := by
  refine ⟨id, fun _ => a, ?_, ?_, ?_⟩
  · exact ⟨⟨0, rfl⟩, rfl⟩
  · exact ⟨⟨1, rfl⟩, const_idempotent a⟩
  · intro hEq
    exact hab (congrFun hEq b).symm

end CellularAutomata.NecSuf.IterateMonoidIdempotents
