/-
章「有限伝播境界」の必要十分版。

具体版と同じ経路長の帰納法・伝播球の再帰・有限合併による境界を保ち、
実際に使う構造だけを残す。

* 経路の時刻差には、自然数時刻と各一段で時刻が 1 増えることだけを使う。
* 伝播球には、セル型の等号判定と各セルの有限な依存元集合だけを使う。
  セル型全体の有限性は要らない。
* 依存元集合の有限性には、舞台全体の有限性でなく、選んだイベント集合 X の
  有限性だけを使う。

状態、近傍、局所規則、グラフ、物理的因果、R / C は使わない。
-/
import CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

namespace CellularAutomata.NecSuf.FinitePropagationBoundary

open CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

variable {Cell : Type} [DecidableEq Cell]

omit [DecidableEq Cell] in
/-- 一段ごとに時刻が 1 増えるなら、経路終点の時刻は始点時刻と経路長の和になる。
    具体版と同じく経路長について帰納する。 -/
theorem path_time_increment_exact
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (step_time_succ : ∀ a b, (a, b) ∈ D → b.1 = a.1 + 1)
    (n : Nat) (p : Nat → Nat × Cell) (hpath : IsDepPath X D n p) :
    (p n).1 = (p 0).1 + n := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · subst hm
      exact step_time_succ (p 0) (p 1) (hstep 0 Nat.one_pos)
    · have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have h0m : (p m).1 = (p 0).1 + m :=
        ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hlast : (p (m + 1)).1 = (p m).1 + 1 :=
        step_time_succ (p m) (p (m + 1)) (hstep m (Nat.lt_succ_self m))
      rw [hlast, h0m, Nat.add_assoc]

/-- 各セルの有限な直接依存元集合から再帰的に作る伝播球。
    0 は具体版と同じく定義域外の番人値である。 -/
def propagationBall (parents : Cell → Finset Cell) : Nat → Cell → Finset Cell
  | 0, _ => ∅
  | 1, v => parents v
  | n + 2, v => (parents v).biUnion (fun u => propagationBall parents (n + 1) u)

theorem propagationBall_one (parents : Cell → Finset Cell) (v : Cell) :
    propagationBall parents 1 v = parents v := rfl

theorem propagationBall_succ (parents : Cell → Finset Cell)
    (n : Nat) (hn : 1 ≤ n) (v : Cell) :
    propagationBall parents (n + 1) v =
      (parents v).biUnion (fun u => propagationBall parents n u) := by
  cases n with
  | zero => omega
  | succ m => rfl

theorem card_propagationBall_one (parents : Cell → Finset Cell) (v : Cell) :
    (propagationBall parents 1 v).card = (parents v).card := rfl

theorem card_propagationBall_succ_le (parents : Cell → Finset Cell)
    (n : Nat) (hn : 1 ≤ n) (v : Cell) :
    (propagationBall parents (n + 1) v).card ≤
      ∑ u ∈ parents v, (propagationBall parents n u).card := by
  rw [propagationBall_succ parents n hn v]
  exact Finset.card_biUnion_le

/-- 一段関係の始点セルが終点セルの直接依存元なら、経路始点のセルは
    終点セルの深さ n の伝播球に属する。 -/
theorem start_cell_in_propagationBall
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (parents : Cell → Finset Cell)
    (step_source_mem : ∀ a b, (a, b) ∈ D → a.2 ∈ parents b.2)
    (n : Nat) (p : Nat → Nat × Cell) (hpath : IsDepPath X D n p) :
    (p 0).2 ∈ propagationBall parents n (p n).2 := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · subst hm
      exact step_source_mem (p 0) (p 1) (hstep 0 Nat.one_pos)
    · have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have hmem : (p 0).2 ∈ propagationBall parents m (p m).2 :=
        ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hw : (p m).2 ∈ parents (p (m + 1)).2 :=
        step_source_mem (p m) (p (m + 1)) (hstep m (Nat.lt_succ_self m))
      rw [propagationBall_succ parents m h1]
      exact Finset.mem_biUnion.mpr ⟨(p m).2, hw, hmem⟩

/-- 有限イベント集合 X 内で target へ到達できる依存元の集合。 -/
def dependencySourceSet (X : Set (Nat × Cell))
    (D : Set ((Nat × Cell) × (Nat × Cell))) (target : Nat × Cell) :
    Set (Nat × Cell) :=
  {a | a ∈ X ∧ (a, target) ∈ Reachable X D}

omit [DecidableEq Cell] in
theorem dependencySourceSet_finite
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (target : Nat × Cell) (hX : X.Finite) :
    (dependencySourceSet X D target).Finite :=
  hX.subset (fun _ ha => ha.1)

/-- 時刻 t の終点セル v に対する、伝播球から作る有限境界。 -/
def propagationBoundary (parents : Cell → Finset Cell) (t : Nat) (v : Cell) :
    Finset (Nat × Cell) :=
  (Finset.Icc 1 t).biUnion (fun n => {t - n} ×ˢ propagationBall parents n v)

/-- 到達可能性の一つの証人経路について、時刻差とセルの所属を同じ経路長で
    組み合わせると依存元は有限境界に入る。 -/
theorem dependencySourceSet_subset_boundary
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (parents : Cell → Finset Cell)
    (step_time_succ : ∀ a b, (a, b) ∈ D → b.1 = a.1 + 1)
    (step_source_mem : ∀ a b, (a, b) ∈ D → a.2 ∈ parents b.2)
    (t : Nat) (v : Cell) :
    dependencySourceSet X D (t, v) ⊆ ↑(propagationBoundary parents t v) := by
  rintro ⟨s, u⟩ ⟨-, hreach⟩
  obtain ⟨n, p, hpath, hp0, hpn⟩ := hreach
  have hn1 : 1 ≤ n := hpath.one_le
  have htime : t = s + n := by
    have h := path_time_increment_exact X D step_time_succ n p hpath
    rw [hp0, hpn] at h
    exact h
  have hnt : n ≤ t := by omega
  have hball : u ∈ propagationBall parents n v := by
    have h := start_cell_in_propagationBall X D parents step_source_mem n p hpath
    rw [hp0, hpn] at h
    exact h
  refine Finset.mem_coe.mpr (Finset.mem_biUnion.mpr
    ⟨n, Finset.mem_Icc.mpr ⟨hn1, hnt⟩, Finset.mem_product.mpr ⟨?_, hball⟩⟩)
  exact Finset.mem_singleton.mpr (by omega)

/-- 個数上界に X の有限性は要らない。境界が `Finset` であること（部分集合の個数は
    有限な上位集合の個数以下）だけで通る。X の有限性が要るのは
    `dependencySourceSet_finite` の注記だけである。 -/
theorem card_dependencySourceSet_le
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (parents : Cell → Finset Cell)
    (step_time_succ : ∀ a b, (a, b) ∈ D → b.1 = a.1 + 1)
    (step_source_mem : ∀ a b, (a, b) ∈ D → a.2 ∈ parents b.2)
    (t : Nat) (v : Cell) :
    (dependencySourceSet X D (t, v)).ncard ≤
      ∑ n ∈ Finset.Icc 1 t, (propagationBall parents n v).card := by
  calc
    (dependencySourceSet X D (t, v)).ncard
        ≤ (↑(propagationBoundary parents t v) : Set (Nat × Cell)).ncard :=
      Set.ncard_le_ncard
        (dependencySourceSet_subset_boundary X D parents step_time_succ step_source_mem t v)
        (Finset.finite_toSet _)
    _ = (propagationBoundary parents t v).card := Set.ncard_coe_finset _
    _ ≤ ∑ n ∈ Finset.Icc 1 t, ({t - n} ×ˢ propagationBall parents n v).card :=
      Finset.card_biUnion_le
    _ = ∑ n ∈ Finset.Icc 1 t, (propagationBall parents n v).card := by
      refine Finset.sum_congr rfl fun n _ => ?_
      rw [Finset.card_product, Finset.card_singleton, one_mul]

theorem dependencySourceSet_zero_empty
    (X : Set (Nat × Cell)) (D : Set ((Nat × Cell) × (Nat × Cell)))
    (parents : Cell → Finset Cell)
    (step_time_succ : ∀ a b, (a, b) ∈ D → b.1 = a.1 + 1)
    (step_source_mem : ∀ a b, (a, b) ∈ D → a.2 ∈ parents b.2)
    (v : Cell) : dependencySourceSet X D (0, v) = ∅ := by
  have hsub := dependencySourceSet_subset_boundary X D parents
    step_time_succ step_source_mem 0 v
  have hempty : propagationBoundary parents 0 v = ∅ := by
    rw [propagationBoundary, Finset.Icc_eq_empty (by omega), Finset.biUnion_empty]
  rw [hempty] at hsub
  exact Set.subset_empty_iff.mp (by simpa using hsub)

end CellularAutomata.NecSuf.FinitePropagationBoundary
