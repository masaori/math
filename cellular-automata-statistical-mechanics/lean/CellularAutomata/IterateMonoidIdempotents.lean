/-
章「反復モノイドの冪等元」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-idempotents.ts。

有限舞台上の二値 CA の大域写像について、衝突後の周期、正の冪等指数の存在、
有限代表集合からの冪等元全体の決定、および一元舞台上の二つの反例を、
人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoid
import CellularAutomata.NecSuf.IterateMonoidIdempotents

namespace CellularAutomata.IterateMonoidIdempotents

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 反復モノイドの冪等元（`def_iterate_monoid_idempotent`）。 -/
def idempotents : Set ((V → State) → (V → State)) :=
  {g | g ∈ powerSet N f ∧ g ∘ g = g}

/-- 冪等指数（`def_iterate_monoid_idempotent`）。 -/
def IsIdempotentExponent (e : ℕ) : Prop := iterateMap N f e ∈ idempotents N f

omit [Fintype V] [DecidableEq V] in
/-- 衝突 F^i=F^j は時刻 i 以後に周期 p=j-i を与える
    （`claim_iterate_collision_gives_repeating_tail`）。 -/
theorem collision_gives_eventual_period {i j n : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (hn : i ≤ n) :
    iterateMap N f (n + (j - i)) = iterateMap N f n := by
  have hj : j = i + (j - i) := by omega
  have hn' : n = i + (n - i) := by omega
  calc
    iterateMap N f (n + (j - i)) = iterateMap N f (j + (n - i)) := by
      congr 1
      omega
    _ = iterateMap N f (i + (n - i)) :=
      (iterateMap_collision_shift N f h (n - i)).symm
    _ = iterateMap N f n := by rw [← hn']

omit [Fintype V] [DecidableEq V] in
/-- 以後の周期を q 回適用する。人手証明で e,e+p,... に順に適用する段に対応する。 -/
theorem collision_period_multiple {i j n : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (hn : i ≤ n) (q : ℕ) :
    iterateMap N f (n + q * (j - i)) = iterateMap N f n := by
  induction q with
  | zero => simp
  | succ q ih =>
    calc
      iterateMap N f (n + (q + 1) * (j - i)) =
          iterateMap N f ((n + q * (j - i)) + (j - i)) := by
        congr 1
        simp [Nat.succ_mul, Nat.add_assoc]
      _ = iterateMap N f (n + q * (j - i)) :=
        collision_gives_eventual_period N f hij h (by omega)
      _ = iterateMap N f n := ih

/-- 正の冪等指数は必ず存在する（`claim_positive_idempotent_iterate_exists`）。
    人手証明どおり衝突の始点 i=0 と i≥1 を分ける。 -/
theorem positive_idempotent_iterate_exists :
    ∃ e : ℕ, 0 < e ∧ IsIdempotentExponent N f e := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision N f
  let p := j - i
  have hp : 0 < p := by omega
  by_cases hi : i = 0
  · subst i
    refine ⟨p, hp, ?_⟩
    constructor
    · exact ⟨p, rfl⟩
    · rw [iterateMap_comp_add]
      simpa [p] using collision_gives_eventual_period N f hij h (n := p) (by omega)
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
      have hm := collision_period_multiple N f hij h hei i
      simpa [e, p, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hm

/-- 衝突から得た有限代表集合のうち、対角合成が自分自身に等しい元だけを集める。 -/
def idempotentRepresentatives (j : ℕ) : Finset ((V → State) → (V → State)) :=
  (representatives N f j).filter (fun g => g ∘ g = g)

/-- 有限走査で得た集合は冪等元全体と一致する
    （`claim_iterate_monoid_idempotents_finite_decidability`）。 -/
theorem mem_idempotentRepresentatives_iff {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (g : (V → State) → (V → State)) :
    g ∈ idempotentRepresentatives N f j ↔ g ∈ idempotents N f := by
  simp only [idempotentRepresentatives, Finset.mem_filter, idempotents, Set.mem_setOf_eq]
  rw [mem_representatives_iff_powerSet N f hij h]

/-! ### 一元舞台上の反例 -/

def oneCellNeighborhood : Unit → Finset Unit := fun _ => {()}

def identityLocalRule (v : Unit) (
    x : ↥(oneCellNeighborhood v) → State) : State := x ⟨(), by simp [oneCellNeighborhood]⟩

def constantZeroLocalRule (v : Unit) (
    _x : ↥(oneCellNeighborhood v) → State) : State := State.zero

/-- 一元舞台の恒等局所規則の大域写像は恒等写像である。 -/
theorem identity_globalMap :
    globalMap oneCellNeighborhood identityLocalRule = id := by
  funext y v
  cases v
  rfl

/-- 恒等 CA の反復モノイドには単位元以外の冪等元がない
    （`claim_nonidentity_idempotent_not_forced`）。 -/
theorem identity_ca_no_nonidentity_idempotent
    (g : (Unit → State) → (Unit → State))
    (hg : g ∈ idempotents oneCellNeighborhood identityLocalRule) : g = id := by
  rcases hg.1 with ⟨n, rfl⟩
  clear hg
  induction n with
  | zero => rfl
  | succ n ih =>
    funext y v
    cases v
    simp only [iterateMap, GlobalMapIteration.iterate_succ]
    rw [identity_globalMap]
    exact congrFun (congrFun ih y) ()

/-- 一元舞台の定値規則の大域写像は全配位を零配位へ送る。 -/
theorem constantZero_globalMap (y : Unit → State) :
    globalMap oneCellNeighborhood constantZeroLocalRule y = fun _ => State.zero := by
  rfl

/-- 定値規則の大域写像は冪等である。 -/
theorem constantZero_globalMap_idempotent :
    globalMap oneCellNeighborhood constantZeroLocalRule ∘
        globalMap oneCellNeighborhood constantZeroLocalRule =
      globalMap oneCellNeighborhood constantZeroLocalRule := by
  funext y v
  rfl

/-- 定値規則の反復モノイドでは恒等写像と定値写像が相異なる冪等元であり、
    冪等元の一意性は成り立たない（`claim_iterate_monoid_idempotent_uniqueness_fails`）。 -/
theorem constant_ca_idempotent_uniqueness_fails :
    ∃ g h : (Unit → State) → (Unit → State),
      g ∈ idempotents oneCellNeighborhood constantZeroLocalRule ∧
      h ∈ idempotents oneCellNeighborhood constantZeroLocalRule ∧ g ≠ h := by
  let F := globalMap oneCellNeighborhood constantZeroLocalRule
  refine ⟨id, F, ?_, ?_, ?_⟩
  · exact ⟨⟨0, rfl⟩, rfl⟩
  · exact ⟨⟨1, rfl⟩, constantZero_globalMap_idempotent⟩
  · intro hEq
    have hw := congrFun (congrFun hEq (fun _ => State.one)) ()
    cases hw

/-! ## 必要十分版からの導出
具体版は必要十分版を X := V → State、F := globalMap N f へ特殊化したものである。 -/

omit [Fintype V] [DecidableEq V] in
theorem idempotents_eq_necessary_sufficient :
    idempotents N f =
      CellularAutomata.NecSuf.IterateMonoidIdempotents.idempotents (globalMap N f) := by
  ext g
  simp only [idempotents, CellularAutomata.NecSuf.IterateMonoidIdempotents.idempotents,
    Set.mem_setOf_eq, powerSet_eq_necessary_sufficient]

omit [Fintype V] [DecidableEq V] in
theorem isIdempotentExponent_iff_necessary_sufficient (e : ℕ) :
    IsIdempotentExponent N f e ↔
      CellularAutomata.NecSuf.IterateMonoidIdempotents.IsIdempotentExponent (globalMap N f) e := by
  unfold IsIdempotentExponent CellularAutomata.NecSuf.IterateMonoidIdempotents.IsIdempotentExponent
  rw [idempotents_eq_necessary_sufficient, iterateMap_eq_necessary_sufficient]

omit [Fintype V] [DecidableEq V] in
theorem collision_gives_eventual_period_from_necessary_sufficient {i j n : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (hn : i ≤ n) :
    iterateMap N f (n + (j - i)) = iterateMap N f n := by
  simp only [iterateMap_eq_necessary_sufficient] at h ⊢
  exact CellularAutomata.NecSuf.IterateMonoidIdempotents.collision_gives_eventual_period
    (globalMap N f) hij h hn

omit [Fintype V] [DecidableEq V] in
theorem collision_period_multiple_from_necessary_sufficient {i j n : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j) (hn : i ≤ n) (q : ℕ) :
    iterateMap N f (n + q * (j - i)) = iterateMap N f n := by
  simp only [iterateMap_eq_necessary_sufficient] at h ⊢
  exact CellularAutomata.NecSuf.IterateMonoidIdempotents.collision_period_multiple
    (globalMap N f) hij h hn q

/-- 正の冪等指数の存在は、有限型 V → State 上の自己写像への特殊化で得られる。
    必要十分版では有限性は衝突を得るためにだけ使われる。 -/
theorem positive_idempotent_iterate_exists_from_necessary_sufficient :
    ∃ e : ℕ, 0 < e ∧ IsIdempotentExponent N f e := by
  obtain ⟨e, he, hidem⟩ :=
    CellularAutomata.NecSuf.IterateMonoidIdempotents.positive_idempotent_iterate_exists
      (globalMap N f)
  exact ⟨e, he, (isIdempotentExponent_iff_necessary_sufficient N f e).mpr hidem⟩

theorem idempotentRepresentatives_eq_necessary_sufficient (j : ℕ) :
    idempotentRepresentatives N f j =
      CellularAutomata.NecSuf.IterateMonoidIdempotents.idempotentRepresentatives
        (globalMap N f) j := by
  ext g
  simp only [idempotentRepresentatives,
    CellularAutomata.NecSuf.IterateMonoidIdempotents.idempotentRepresentatives,
    Finset.mem_filter, representatives_eq_necessary_sufficient]

theorem mem_idempotentRepresentatives_iff_from_necessary_sufficient {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (g : (V → State) → (V → State)) :
    g ∈ idempotentRepresentatives N f j ↔ g ∈ idempotents N f := by
  rw [idempotentRepresentatives_eq_necessary_sufficient, idempotents_eq_necessary_sufficient]
  simp only [iterateMap_eq_necessary_sufficient] at h
  exact CellularAutomata.NecSuf.IterateMonoidIdempotents.mem_idempotentRepresentatives_iff
    (globalMap N f) hij h g

/-- 恒等 CA の反例は、恒等写像に関する必要十分版の反例の特殊化である。 -/
theorem identity_ca_no_nonidentity_idempotent_from_necessary_sufficient
    (g : (Unit → State) → (Unit → State))
    (hg : g ∈ idempotents oneCellNeighborhood identityLocalRule) : g = id := by
  rw [idempotents_eq_necessary_sufficient, identity_globalMap] at hg
  exact CellularAutomata.NecSuf.IterateMonoidIdempotents.id_no_nonidentity_idempotent g hg

/-- 定値規則の反例は、零配位への定値写像と、相異なる二点（零配位と一配位）に関する
    必要十分版の反例の特殊化である。 -/
theorem constant_ca_idempotent_uniqueness_fails_from_necessary_sufficient :
    ∃ g h : (Unit → State) → (Unit → State),
      g ∈ idempotents oneCellNeighborhood constantZeroLocalRule ∧
      h ∈ idempotents oneCellNeighborhood constantZeroLocalRule ∧ g ≠ h := by
  have hF : globalMap oneCellNeighborhood constantZeroLocalRule =
      fun _ : Unit → State => (fun _ : Unit => State.zero) := by
    funext y
    exact constantZero_globalMap y
  rw [idempotents_eq_necessary_sufficient, hF]
  have hab : (fun _ : Unit => State.zero) ≠ (fun _ : Unit => State.one) := by
    intro hEq
    cases congrFun hEq ()
  exact CellularAutomata.NecSuf.IterateMonoidIdempotents.const_idempotent_uniqueness_fails hab

end CellularAutomata.IterateMonoidIdempotents
