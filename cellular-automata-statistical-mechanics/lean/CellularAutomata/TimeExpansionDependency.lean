/-
章「時間展開上の直接依存」の具体版。
人手証明の正本は structured-latex/content/time-expansion-dependency.ts。

人手証明のブロックとこのファイルの対応:

  有限近傍系 (V, N)（`def_finite_neighborhood_system`）        `V` は `Fintype`・`DecidableEq` を持つ型、
                                                `N : V → Finset V`（順序のない有限集合。番号付けを仮定しない）
  有限舞台上の 2 値 CA（`def_finite_ca`）        `f : (v : V) → (↥(N v) → State) → State`（局所真理値表の族）
  大域写像 F（`def_global_map`）                 `globalMap`（(F y)(v) := f_v(ρ^V_{N(v)} y)）と
                                                `globalMap_eq_extendRule`（値写像が冗長拡大に等しいこと）
  claim_global_flip_characterization             `globalFlip_iff_mem_supp`
                                                （前二章の同値と依存台不変性の合成。人手証明と同じ順）
  時間区間 [0,τ]_ℕ（`def_finite_index_interval`）        `timeInterval`（{t ∈ ℕ | t ≤ τ}。`mem_timeInterval`）と
                                                `card_timeInterval`（|[0,τ]_ℕ| = τ+1）
  イベント集合 E_τ（`def_event_set`）            `eventSet`（[0,τ]_ℕ × V の直積）
  claim_event_set_cardinality                    `card_eventSet`（|E_τ| = (τ+1)·|V|。直積の積の法則）
  一段依存関係 D_τ（`def_one_step_dependency`）  `oneStepDep`（E_τ × E_τ を条件で filter した有限集合）、
                                                `mem_oneStepDep`（所属 ⟺ t = s+1 かつ u ∈ supp(f_v)）、
                                                `mem_supp_map_imp_mem_neighborhood`（supp(f_v) ⊆ N(v) の含意）
  claim_one_step_dependency_finite_decidability  `oneStepDep_subset`（有限集合 E_τ × E_τ の部分集合であること）と
                                                `card_scan_pairs_local`（依存台走査の組数 |N(v)|·2^{|N(v)|}）
  claim_time_strictly_increases                  `time_strictly_increases`（t = s+1 と ℕ の s < s+1）

claim_one_step_dependency_finite_decidability について形式化した範囲:
  「D_τ が有限集合 E_τ × E_τ の部分集合であること」（`oneStepDep_subset`。`oneStepDep` は
  `Finset` なので有限性は型で表れる）、「所属条件が ℕ の等号と supp(f_v) の所属の連言で
  書けること」（`mem_oneStepDep`。`Finset` の所属なので決定できる）、「依存台走査の組
  (w, x) の総数が |N(v)|·2^{|N(v)|} であること」（`card_scan_pairs_local`。前章
  `card_scan_pairs` の S = ↥(N v) への適用）。人手証明の「等号検査 1 回＋比較高々
  |N(v)|·2^{|N(v)|} 回」という回数の主張のうち、計算のコストモデル自体は前二章と同じく
  形式化していない。

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。時間に使う ℕ の構造は
大小比較と後者（+1）だけである（人手証明 `def_finite_index_interval` と同じ）。

抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
（有限集合の直積の個数の積、範囲 {0,…,τ} の個数、filter の所属）に限る。
-/
import CellularAutomata.RedundantNeighbor
import CellularAutomata.NecSuf.TimeExpansionDependency

namespace CellularAutomata.TimeExpansionDependency

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor

/-
有限近傍系 (V, N)（`def_finite_neighborhood_system`）。V は有限型、N(v) ⊆ V は順序のない有限部分集合。
V の有限性から各 N(v) の有限性が従うことは、`Finset V` の型がそのまま表している。
-/
variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)

/-
有限舞台上の 2 値セルオートマトン（`def_finite_ca`）。各 v に局所真理値表 (N(v), f_v) を与える。
A^{N(v)} は前章と同じく部分型 ↥(N v) 上の写像で表す（同一視をしない）。
-/
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 大域写像 F（`def_global_map`）。(F y)(v) := f_v(ρ^V_{N(v)} y)。
    ρ^V_{N(v)} は前章の制限写像 `restrict` を T = V、S = N(v) と取ったものである。 -/
def globalMap (y : V → State) : V → State :=
  fun v => f v (restrict (N v) y)

omit [Fintype V] [DecidableEq V] in
/-- `def_global_map` の後段: 各 v の値写像 y ↦ (F y)(v) は冗長拡大 f_v ∘ ρ^V_{N(v)}
    （`extendRule` を T = V、S = N(v) と取ったもの）に等しい。定義の書き換えだけで従う。
    V の有限性も等号判定も要らない（定義の一致だけの主張である）。 -/
theorem globalMap_eq_extendRule (v : V) (y : V → State) :
    globalMap N f y v = extendRule (N v) (f v) y := rfl

/-- `claim_global_flip_characterization` の具体版。
    大域写像の値 (F y)(v) が u での一点反転で変わりうることと、u ∈ supp(f_v) は同値である。
    右辺は supp(f_v) ⊆ N(v) を包含写像で V の部分集合へ写した像への所属である
    （人手証明の「u ∈ supp(f_v)」。supp は N(v) の部分集合なので、V の元 u で述べるには
    前章と同じく像を通す）。人手証明と同じ順で、値写像が冗長拡大に等しいこと、
    `claim_flip_test_equivalence`、supp の定義、`claim_support_invariance` を順に適用する。 -/
theorem globalFlip_iff_mem_supp (u v : V) :
    (∃ y : V → State, globalMap N f y v ≠ globalMap N f (flip u y) v) ↔
      u ∈ (supp (f v)).map (Function.Embedding.subtype (· ∈ N v)) := by
  -- 各 y で (F y)(v) = (f_v∘ρ)(y)、(F(φ_u y))(v) = (f_v∘ρ)(φ_u y)（`def_global_map`）。
  -- したがって左辺は ∃ y, (f_v∘ρ)(y) ≠ (f_v∘ρ)(φ_u y) に等しい（定義の書き換え）。
  show (∃ y : V → State, extendRule (N v) (f v) y ≠ extendRule (N v) (f v) (flip u y)) ↔ _
  -- `claim_flip_test_equivalence` を局所真理値表 (V, f_v∘ρ^V_{N(v)}) と u に適用する。
  rw [← essentialDep_iff_flip (extendRule (N v) (f v)) u]
  -- `def_essential_dependency_support` より、本質的依存は supp(f_v∘ρ) への所属と同値。
  rw [← mem_supp_iff (extendRule (N v) (f v)) u]
  -- `claim_support_invariance` を S = N(v)、T = V に適用すると supp(f_v∘ρ) = supp(f_v) の像。
  rw [supp_extendRule (N v) (f v)]

/-- 時間区間 [0,τ]_ℕ = {t ∈ ℕ | t ≤ τ}（`def_finite_index_interval`）。 -/
def timeInterval (τ : ℕ) : Finset ℕ :=
  Finset.range (τ + 1)

/-- [0,τ]_ℕ の所属は ℕ の大小比較 t ≤ τ である（`def_finite_index_interval` の所属条件）。 -/
theorem mem_timeInterval (τ t : ℕ) : t ∈ timeInterval τ ↔ t ≤ τ := by
  simp [timeInterval, Nat.lt_succ_iff]

/-- [0,τ]_ℕ = {0,1,…,τ} の元は τ+1 個（`claim_event_set_cardinality` の証明の最終行の根拠）。 -/
theorem card_timeInterval (τ : ℕ) : (timeInterval τ).card = τ + 1 :=
  Finset.card_range (τ + 1)

/-- イベント集合 E_τ := [0,τ]_ℕ × V（`def_event_set`）。直積の有限集合である。 -/
def eventSet (τ : ℕ) : Finset (ℕ × V) :=
  timeInterval τ ×ˢ (Finset.univ : Finset V)

omit [DecidableEq V] in
/-- `claim_event_set_cardinality` の具体版。|E_τ| = |[0,τ]_ℕ × V| = |[0,τ]_ℕ|·|V| = (τ+1)·|V|。
    人手証明と同じ順: イベント集合の定義、直積の積の法則、|[0,τ]_ℕ| = τ+1。 -/
theorem card_eventSet (τ : ℕ) :
    (eventSet (V := V) τ).card = (τ + 1) * Fintype.card V := by
  rw [eventSet, Finset.card_product, card_timeInterval, Finset.card_univ]

/-- 一段依存関係 D_τ（`def_one_step_dependency`）。E_τ × E_τ の元 ((s,u),(t,v)) のうち
    t = s+1（ℕ の等号）かつ u ∈ supp(f_v)（V の部分集合へ写した像への所属）を満たすもの。 -/
def oneStepDep (τ : ℕ) : Finset ((ℕ × V) × (ℕ × V)) :=
  (eventSet τ ×ˢ eventSet τ).filter
    (fun p => p.2.1 = p.1.1 + 1 ∧
      p.1.2 ∈ (supp (f p.2.2)).map (Function.Embedding.subtype (· ∈ N p.2.2)))

/-- `def_one_step_dependency` の所属の言い換え。((s,u),(t,v)) ∈ D_τ は、両イベントが
    E_τ に属し、t = s+1 かつ u ∈ supp(f_v) であることと同値である（filter と直積の所属）。 -/
theorem mem_oneStepDep (τ : ℕ) (s t : ℕ) (u v : V) :
    ((s, u), (t, v)) ∈ oneStepDep N f τ ↔
      ((s, u) ∈ eventSet (V := V) τ ∧ (t, v) ∈ eventSet (V := V) τ) ∧
        (t = s + 1 ∧
          u ∈ (supp (f v)).map (Function.Embedding.subtype (· ∈ N v))) := by
  rw [oneStepDep, Finset.mem_filter, Finset.mem_product]

omit [Fintype V] in
/-- `def_one_step_dependency` の後段: supp(f_v) ⊆ N(v) なので、条件 u ∈ supp(f_v) は
    u ∈ N(v) を含意する（像の元は部分型の値なので所属の証明を持つ）。 -/
theorem mem_supp_map_imp_mem_neighborhood (v u : V)
    (h : u ∈ (supp (f v)).map (Function.Embedding.subtype (· ∈ N v))) :
    u ∈ N v := by
  obtain ⟨w, _, hw⟩ := Finset.mem_map.mp h
  exact hw ▸ w.property

/-- `claim_one_step_dependency_finite_decidability` の具体版・前半。
    D_τ は有限集合 E_τ × E_τ の部分集合である（filter は部分集合を返す。
    E_τ の有限性は `card_eventSet` の型 `Finset` がそのまま表している）。 -/
theorem oneStepDep_subset (τ : ℕ) :
    oneStepDep N f τ ⊆ eventSet τ ×ˢ eventSet τ :=
  Finset.filter_subset _ _

omit [Fintype V] in
/-- `claim_one_step_dependency_finite_decidability` の具体版・後半。
    条件 u ∈ supp(f_v) の決定に走査する組 (w, x) ∈ N(v) × A^{N(v)} の総数は
    |N(v)|·2^{|N(v)|} である（前章 `card_scan_pairs` の S = ↥(N v) への適用）。
    ℕ の等号検査 t = s+1 の 1 回は `mem_oneStepDep` の連言の第 1 成分である。 -/
theorem card_scan_pairs_local (v : V) :
    Fintype.card (↥(N v) × (↥(N v) → State)) = (N v).card * 2 ^ (N v).card := by
  rw [card_scan_pairs, Fintype.card_coe]

/-- `claim_time_strictly_increases` の具体版。((s,u),(t,v)) ∈ D_τ ならば s < t。
    人手証明と同じ順: `def_one_step_dependency` より t = s+1、ℕ で s < s+1。 -/
theorem time_strictly_increases (τ : ℕ) (s t : ℕ) (u v : V)
    (h : ((s, u), (t, v)) ∈ oneStepDep N f τ) : s < t := by
  obtain ⟨-, ht, -⟩ := (mem_oneStepDep N f τ s t u v).mp h
  exact ht ▸ Nat.lt_succ_self s

omit [Fintype V] [DecidableEq V] in
/-- 具体版の大域写像の定義の一致が、必要十分版の状態型を `State` に
    特殊化して得られること。 -/
theorem globalMap_eq_extendRule_from_necessary_sufficient (v : V) (y : V → State) :
    globalMap N f y v = extendRule (N v) (f v) y := by
  exact CellularAutomata.NecSuf.TimeExpansionDependency.globalMap_eq_extendRule N f v y

omit [Fintype V] in
/-- 具体版の大域一点反転の特徴づけが、必要十分版を `State`、`nu`、
    基準値 `zero` に特殊化し、点ごとの依存を有限依存台に集めることで得られる。 -/
theorem globalFlip_iff_mem_supp_from_necessary_sufficient (u v : V) :
    (∃ y : V → State, globalMap N f y v ≠ globalMap N f (flip u y) v) ↔
      u ∈ (supp (f v)).map (Function.Embedding.subtype (· ∈ N v)) := by
  change (∃ y : V → State,
    CellularAutomata.NecSuf.TimeExpansionDependency.globalMap N f y v ≠
      CellularAutomata.NecSuf.TimeExpansionDependency.globalMap N f
        (CellularAutomata.NecSuf.EssentialDependency.flip nu u y) v) ↔ _
  rw [CellularAutomata.NecSuf.TimeExpansionDependency.globalFlip_iff_essentialDep
    N f nu ne_iff_eq_nu State.zero u v]
  constructor
  · rintro ⟨hu, hdep⟩
    exact Finset.mem_map.mpr ⟨⟨u, hu⟩, (mem_supp_iff (f v) ⟨u, hu⟩).mpr hdep, rfl⟩
  · intro hmem
    obtain ⟨w, hw, hwu⟩ := Finset.mem_map.mp hmem
    have hu : u ∈ N v := hwu ▸ w.property
    have hw' : w = ⟨u, hu⟩ := Subtype.ext hwu
    exact ⟨hu, (mem_supp_iff (f v) ⟨u, hu⟩).mp (hw' ▸ hw)⟩

omit [DecidableEq V] in
/-- イベント集合の個数公式が、必要十分版の有限集合の直積公式に
    `I = [0,τ]_ℕ` を代入して得られること。 -/
theorem card_eventSet_from_necessary_sufficient (τ : ℕ) :
    (eventSet (V := V) τ).card = (τ + 1) * Fintype.card V := by
  calc
    (eventSet (V := V) τ).card =
        (CellularAutomata.NecSuf.TimeExpansionDependency.eventSet
          (V := V) (timeInterval τ)).card := rfl
    _ = (timeInterval τ).card * Fintype.card V :=
      CellularAutomata.NecSuf.TimeExpansionDependency.card_eventSet (timeInterval τ)
    _ = (τ + 1) * Fintype.card V := by rw [card_timeInterval]

/-- 具体版の時刻増加が、必要十分版の `next s = s+1`、`lt = (<)` と
    `s < s+1` の特殊化で得られること。 -/
theorem time_strictly_increases_from_necessary_sufficient
    (τ : ℕ) (s t : ℕ) (u v : V)
    (h : ((s, u), (t, v)) ∈ oneStepDep N f τ) : s < t := by
  obtain ⟨-, ht, hmem⟩ := (mem_oneStepDep N f τ s t u v).mp h
  obtain ⟨w, hw, hwu⟩ := Finset.mem_map.mp hmem
  have hu : u ∈ N v := hwu ▸ w.property
  have hw' : w = ⟨u, hu⟩ := Subtype.ext hwu
  have hdep : EssentialDep (f v) ⟨u, hu⟩ :=
    (mem_supp_iff (f v) ⟨u, hu⟩).mp (hw' ▸ hw)
  exact CellularAutomata.NecSuf.TimeExpansionDependency.time_strictly_increases
    N f (· + 1) (· < ·) Nat.lt_succ_self (s, u) (t, v) ⟨ht, hu, hdep⟩

end CellularAutomata.TimeExpansionDependency
