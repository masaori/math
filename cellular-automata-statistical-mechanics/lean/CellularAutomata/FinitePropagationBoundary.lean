/-
章「有限伝播境界」の具体版。
人手証明の正本は structured-latex/content/finite-propagation-boundary.ts。

人手証明のブロックとこのファイルの対応:

  claim_path_time_increment_exact                `path_time_increment_exact`
                                                （経路長 n についての帰納法。基底は一段依存の
                                                条件 t = s+1、帰納段は制限と ℕ の加法の結合則）
  伝播球（`def_propagation_ball`）               `suppV`（人手証明が supp(f_v) と書く V の部分集合）と
                                                `propagationBall`（B_1(v) = supp(f_v)、
                                                B_{n+1}(v) = ⋃_{u∈supp(f_v)} B_n(u) の再帰）、
                                                `propagationBall_one`・`propagationBall_succ`
                                                （再帰の二つの等式）
  claim_propagation_ball_finite                  伝播球の有限性は `Finset V` の型がそのまま表す。
                                                個数は `card_propagationBall_one`（|B_1(v)| = |supp(f_v)|）と
                                                `card_propagationBall_succ_le`
                                                （|B_{n+1}(v)| ≤ Σ_{u∈supp(f_v)} |B_n(u)|。
                                                有限個の有限集合の合併の個数は個数の和以下）
  claim_start_cell_in_propagation_ball           `start_cell_in_propagationBall`
                                                （経路長 n についての帰納法。基底は一段依存の条件
                                                u ∈ supp(f_v)、帰納段は合併が各被合併集合を含むこと）
  依存元集合（`def_dependency_source_set`）      `dependencySourceSet`（E_τ に属し (t,v) へ到達可能な
                                                イベントの集合）と `dependencySourceSet_finite`
                                                （有限集合 E_τ の部分集合ゆえ有限、という定義中の注記）
  claim_finite_propagation_boundary              `propagationBoundary`（右辺の合併
                                                ⋃_{n∈[1,t]} {t−n} × B_n(v) の有限集合）、
                                                `dependencySourceSet_subset_boundary`（包含）、
                                                `card_dependencySourceSet_le`（個数上界。
                                                部分集合・合併の個数の和・一元集合との直積の順）、
                                                `dependencySourceSet_zero_empty`（t = 0 での空性）

住処: 有限型・自然数のみ。ℝ / ℂ は現れない(人手証明と同じ)。時間・経路長に使う ℕ の構造は
大小比較・後者(+1)・加法・（n ≤ t の下での）減法だけである（人手証明と同じ）。

抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
（ℕ の加法の結合則、有限個の有限集合の合併の個数は個数の和以下、部分集合の個数は全体以下、
一元集合との直積の個数）に限る。
-/
import CellularAutomata.TransitiveClosureAntisymmetry

namespace CellularAutomata.FinitePropagationBoundary

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.TransitiveClosureAntisymmetry

/-
有限舞台 (V, N) と有限舞台上の 2 値セルオートマトン (f_v)（前章までと同じ設定）。
-/
variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 人手証明が supp(f_v) と書く V の部分集合。supp(f_v) ⊆ N(v)
    （`def_essential_dependency_support`）を包含写像で V の部分集合へ写した像である
    （前章 `def_one_step_dependency` の所属条件と同じ表し方）。 -/
def suppV (v : V) : Finset V :=
  (supp (f v)).map (Function.Embedding.subtype (· ∈ N v))

/-- 一段依存の条件の前半: ((s,u),(t,v)) ∈ D_τ ならば t = s+1
    （`def_one_step_dependency`。`mem_oneStepDep` の連言の取り出し）。 -/
theorem oneStep_time_succ (τ : ℕ) (a b : ℕ × V)
    (h : (a, b) ∈ oneStepDep N f τ) : b.1 = a.1 + 1 := by
  obtain ⟨-, ht, -⟩ := (mem_oneStepDep N f τ a.1 b.1 a.2 b.2).mp h
  exact ht

/-- 一段依存の条件の後半: ((s,u),(t,v)) ∈ D_τ ならば u ∈ supp(f_v)
    （`def_one_step_dependency`。`mem_oneStepDep` の連言の取り出し）。 -/
theorem oneStep_source_mem_suppV (τ : ℕ) (a b : ℕ × V)
    (h : (a, b) ∈ oneStepDep N f τ) : a.2 ∈ suppV N f b.2 := by
  obtain ⟨-, -, hmem⟩ := (mem_oneStepDep N f τ a.1 b.1 a.2 b.2).mp h
  exact hmem

/-- `claim_path_time_increment_exact` の具体版。依存経路の終点の時刻は始点の時刻と
    経路長の和に等しい（前章 `path_time_strictly_increases` の不等式 s < t の等式への精密化）。
    人手証明と同じく経路長 n についての帰納法で示す。基底（n = 1）は一段依存の条件 t = s+1、
    帰納段は [0,n-1] への制限に帰納法の仮定、最後の一段に t = s+1、そして ℕ の加法の結合則。 -/
theorem path_time_increment_exact (τ n : ℕ) (p : ℕ → ℕ × V)
    (hpath : IsDepPath N f τ n p) : (p n).1 = (p 0).1 + n := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · -- 基底（n = 1）: (p(0), p(1)) ∈ D_τ の条件 t = s+1
      subst hm
      exact oneStep_time_succ N f τ (p 0) (p 1) (hstep 0 Nat.one_pos)
    · -- 帰納段（n ≥ 2）: [0,m] への制限は長さ m の依存経路
      have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have h0m : (p m).1 = (p 0).1 + m :=
        ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hlast : (p (m + 1)).1 = (p m).1 + 1 :=
        oneStep_time_succ N f τ (p m) (p (m + 1)) (hstep m (Nat.lt_succ_self m))
      -- t_n = t_{n-1}+1 = (t_0+(n-1))+1 = t_0+n（ℕ の加法の結合則）
      rw [hlast, h0m, Nat.add_assoc]

/-- 伝播球 B_n(v)（`def_propagation_ball`）。B_1(v) := supp(f_v)、
    B_{n+1}(v) := ⋃_{u∈supp(f_v)} B_n(u) の n についての再帰で定める。
    人手証明は n ≥ 1 だけを定義する。n = 0 は定義域外なので空集合を番人値として置き、
    以下のすべての主張は n ≥ 1 についてだけ述べる。
    `Finset V` の型が、各段が V の有限部分集合として定まること
    （`claim_propagation_ball_finite` の有限性の部分）をそのまま表す。 -/
def propagationBall : ℕ → V → Finset V
  | 0, _ => ∅
  | 1, v => suppV N f v
  | n + 2, v => (suppV N f v).biUnion (fun u => propagationBall (n + 1) u)

omit [Fintype V] in
/-- `def_propagation_ball` の第一の等式: B_1(v) = supp(f_v)（定義の確認）。
    伝播球の定義と個数の主張に V の有限性は要らない（`omit` で明示する）。 -/
theorem propagationBall_one (v : V) : propagationBall N f 1 v = suppV N f v := rfl

omit [Fintype V] in
/-- `def_propagation_ball` の第二の等式: n ≥ 1 のとき
    B_{n+1}(v) = ⋃_{u∈supp(f_v)} B_n(u)（定義の確認）。 -/
theorem propagationBall_succ (n : ℕ) (hn : 1 ≤ n) (v : V) :
    propagationBall N f (n + 1) v
      = (suppV N f v).biUnion (fun u => propagationBall N f n u) := by
  cases n with
  | zero => omega
  | succ m => rfl

omit [Fintype V] in
/-- `claim_propagation_ball_finite` の個数の等式: |B_1(v)| = |supp(f_v)|（定義の等号による）。 -/
theorem card_propagationBall_one (v : V) :
    (propagationBall N f 1 v).card = (suppV N f v).card := rfl

omit [Fintype V] in
/-- `claim_propagation_ball_finite` の個数の不等式: n ≥ 1 のとき
    |B_{n+1}(v)| ≤ Σ_{u∈supp(f_v)} |B_n(u)|
    （有限個の有限集合の合併の元の個数は個数の和以下。和の法則）。 -/
theorem card_propagationBall_succ_le (n : ℕ) (hn : 1 ≤ n) (v : V) :
    (propagationBall N f (n + 1) v).card
      ≤ ∑ u ∈ suppV N f v, (propagationBall N f n u).card := by
  rw [propagationBall_succ N f n hn v]
  exact Finset.card_biUnion_le

/-- `claim_start_cell_in_propagation_ball` の具体版。依存経路の始点のセルは、
    終点のセルの深さ n（= 経路長）の伝播球に属する。人手証明と同じく経路長 n についての
    帰納法で示す。基底（n = 1）は一段依存の条件 u ∈ supp(f_v) と B_1(v) = supp(f_v)、
    帰納段は [0,n-1] への制限に帰納法の仮定、最後の一段に u ∈ supp(f_v)、
    そして合併が各被合併集合を含むこと。 -/
theorem start_cell_in_propagationBall (τ n : ℕ) (p : ℕ → ℕ × V)
    (hpath : IsDepPath N f τ n p) : (p 0).2 ∈ propagationBall N f n (p n).2 := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · -- 基底（n = 1）: (p(0), p(1)) ∈ D_τ の条件 u ∈ supp(f_v)、B_1(v) = supp(f_v)
      subst hm
      exact oneStep_source_mem_suppV N f τ (p 0) (p 1) (hstep 0 Nat.one_pos)
    · -- 帰納段（n ≥ 2）: 制限に帰納法の仮定、最後の一段の条件、合併が被合併集合を含むこと
      have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have hmem : (p 0).2 ∈ propagationBall N f m (p m).2 :=
        ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hw : (p m).2 ∈ suppV N f (p (m + 1)).2 :=
        oneStep_source_mem_suppV N f τ (p m) (p (m + 1)) (hstep m (Nat.lt_succ_self m))
      rw [propagationBall_succ N f m h1]
      exact Finset.mem_biUnion.mpr ⟨(p m).2, hw, hmem⟩

/-- 依存元集合 P_τ(t,v)（`def_dependency_source_set`）。E_τ の元 a のうち
    (a,(t,v)) ∈ C_τ を満たすものの集合。 -/
def dependencySourceSet (τ t : ℕ) (v : V) : Set (ℕ × V) :=
  { a | a ∈ eventSet (V := V) τ ∧ (a, (t, v)) ∈ Reachable N f τ }

/-- `def_dependency_source_set` の注記: P_τ(t,v) は有限集合 E_τ の部分集合なので有限である。 -/
theorem dependencySourceSet_finite (τ t : ℕ) (v : V) :
    (dependencySourceSet N f τ t v).Finite :=
  Set.Finite.subset (Finset.finite_toSet (eventSet τ))
    (fun _ ha => Finset.mem_coe.mpr ha.1)

/-- `claim_finite_propagation_boundary` の右辺の合併 ⋃_{n∈[1,t]}({t−n} × B_n(v))。
    有限集合 [1,t] で添字づけられた有限集合の合併なので `Finset` である。 -/
def propagationBoundary (t : ℕ) (v : V) : Finset (ℕ × V) :=
  (Finset.Icc 1 t).biUnion (fun n => {t - n} ×ˢ propagationBall N f n v)

/-- `claim_finite_propagation_boundary` の包含の具体版。
    P_τ(t,v) ⊆ ⋃_{n∈[1,t]}({t−n} × B_n(v))。人手証明と同じ順:
    到達可能性から依存経路を取り、`claim_path_time_increment_exact` で t = s+n、
    s ≥ 0 と n ≥ 1 から n ∈ [1,t]、s = t−n（n ≤ t の下での ℕ の減法）、
    `claim_start_cell_in_propagation_ball` で u ∈ B_n(v)。 -/
theorem dependencySourceSet_subset_boundary (τ t : ℕ) (v : V) :
    dependencySourceSet N f τ t v ⊆ ↑(propagationBoundary N f t v) := by
  rintro ⟨s, u⟩ ⟨-, hreach⟩
  obtain ⟨n, p, hpath, hp0, hpn⟩ := hreach
  -- 依存経路の定義より n ≥ 1
  have hn1 : 1 ≤ n := hpath.one_le
  -- `claim_path_time_increment_exact` より t = s + n
  have htime : t = s + n := by
    have h := path_time_increment_exact N f τ n p hpath
    rw [hp0, hpn] at h
    exact h
  -- s ∈ ℕ より s ≥ 0 なので n ≤ t
  have hnt : n ≤ t := by omega
  -- `claim_start_cell_in_propagation_ball` より u ∈ B_n(v)
  have hball : u ∈ propagationBall N f n v := by
    have h := start_cell_in_propagationBall N f τ n p hpath
    rw [hp0, hpn] at h
    exact h
  refine Finset.mem_coe.mpr (Finset.mem_biUnion.mpr
    ⟨n, Finset.mem_Icc.mpr ⟨hn1, hnt⟩, Finset.mem_product.mpr ⟨?_, hball⟩⟩)
  -- t = s + n を s について解くと s = t − n（n ≤ t の下での ℕ の減法）
  refine Finset.mem_singleton.mpr ?_
  show s = t - n
  omega

/-- `claim_finite_propagation_boundary` の個数上界の具体版。
    |P_τ(t,v)| ≤ Σ_{n∈[1,t]} |B_n(v)|。人手証明と同じ順:
    部分集合の個数は全体の個数以下（上の包含）、有限個の有限集合の合併の個数は個数の和以下、
    一元集合との直積の個数は個数に等しい（積の法則）。
    右辺は |V| にも τ にも依存しない（人手証明の statement の注記）。 -/
theorem card_dependencySourceSet_le (τ t : ℕ) (v : V) :
    (dependencySourceSet N f τ t v).ncard
      ≤ ∑ n ∈ Finset.Icc 1 t, (propagationBall N f n v).card := by
  calc (dependencySourceSet N f τ t v).ncard
      ≤ (↑(propagationBoundary N f t v) : Set (ℕ × V)).ncard :=
        Set.ncard_le_ncard (dependencySourceSet_subset_boundary N f τ t v)
          (Finset.finite_toSet _)
    _ = (propagationBoundary N f t v).card := Set.ncard_coe_finset _
    _ ≤ ∑ n ∈ Finset.Icc 1 t, ({t - n} ×ˢ propagationBall N f n v).card :=
        Finset.card_biUnion_le
    _ = ∑ n ∈ Finset.Icc 1 t, (propagationBall N f n v).card := by
        refine Finset.sum_congr rfl fun n _ => ?_
        rw [Finset.card_product, Finset.card_singleton, one_mul]

/-- `claim_finite_propagation_boundary` の特例の具体版。t = 0 のとき [1,0] は空なので
    合併は空集合であり、包含より P_τ(0,v) = ∅。 -/
theorem dependencySourceSet_zero_empty (τ : ℕ) (v : V) :
    dependencySourceSet N f τ 0 v = ∅ := by
  have hsub := dependencySourceSet_subset_boundary N f τ 0 v
  have hempty : propagationBoundary N f 0 v = ∅ := by
    rw [propagationBoundary, Finset.Icc_eq_empty (by omega), Finset.biUnion_empty]
  rw [hempty] at hsub
  exact Set.subset_empty_iff.mp (by simpa using hsub)

end CellularAutomata.FinitePropagationBoundary
