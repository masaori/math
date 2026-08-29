/-
章「依存順序から得る部分構造」の具体版。
人手証明の正本は structured-latex/content/dependency-order-substructures.ts。

人手証明のブロックとこのファイルの対応:

  順序凸部分集合（`def_order_convex_subset`）    `IsOrderConvex` の X := E_τ、R := ⪯_τ への特殊化
                                                （a,c ∈ K、b ∈ E_τ、
                                                a ⪯_τ b かつ b ⪯_τ c ならば b ∈ K。
                                                `claim_order_convex_subset_finite` は `Finset` の型が表す）
  下方集合（`def_down_set`）                     `IsDownSet`
  上方集合（`def_up_set`）                       `IsUpSet`
  claim_down_set_order_convex                    `down_set_order_convex`（b ⪯_τ a の向きの
                                                下方性を b ⪯_τ c と c ∈ J に適用。
                                                仮定 a ⪯_τ b は人手証明どおり使わない）
  claim_up_set_order_convex                      `up_set_order_convex`（a ⪯_τ b と a ∈ U。
                                                仮定 b ⪯_τ c は人手証明どおり使わない）
  claim_order_convex_intersection                `order_convex_intersection`（両成分へ
                                                順序凸性を同じ仮定で適用）
  非比較関係（`def_incomparability`）            `Incomparable` と `incomparable_symm`
                                                （定義中の「入れ替えで互いに移り合う」の注記）
  反鎖（`def_antichain`）                        `IsAntichainOn`
  claim_antichain_order_convex                   `antichain_order_convex`（a = c か否かの
                                                場合分け。a ≠ c は推移性と非比較の矛盾、
                                                a = c は反対称性で b = a）
  時刻切片（`def_time_slice`）                   `timeSlice`（E_τ の filter）
  claim_time_slice_antichain                     `time_slice_antichain`（⪯_τ を仮定すると
                                                経路の時刻増加から t < t、ℕ の非反射性で矛盾。
                                                a・b を入れ替えて両向き）
  一段境界（`def_one_step_boundary`）            `oneStepBoundary`
  claim_one_step_boundary_finite                 `oneStepBoundary_finite`（K の部分集合ゆえ有限）
  claim_down_set_no_incoming_edge                `down_set_no_incoming_edge`（D_τ ⊆ C_τ、
                                                反射的到達可能性、下方性の順で矛盾）
  claim_down_set_boundary_outgoing               `down_set_boundary_outgoing`（両包含。
                                                内向きの選言肢は前 claim で消える）

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。使う ℕ の構造は
大小比較だけである（人手証明と同じ）。

抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
（有限集合の所属・共通部分・filter・部分集合の有限性）に限る。
人手証明の主張が置く部分集合条件（K ⊆ E_τ 等）は、証明で使わない場合も
主張どおり仮定に置き、使わないことを引数名の下線で明示する。
-/
import CellularAutomata.NecSuf.DependencyOrderSubstructures
import CellularAutomata.TransitiveClosureAntisymmetry

namespace CellularAutomata.DependencyOrderSubstructures

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.TransitiveClosureAntisymmetry

/-
有限舞台 (V, N) と有限舞台上の 2 値セルオートマトン (f_v)（前章までと同じ設定）。
-/
variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 有限半順序の順序凸部分集合（`def_order_convex_subset`）を
    X := E_τ、R := ⪯_τ へ特殊化する。K ⊆ E_τ が順序凸であるとは、
    すべての a, c ∈ K とすべての b ∈ E_τ について、a ⪯_τ b かつ b ⪯_τ c ならば
    b ∈ K が成り立つこと。`claim_order_convex_subset_finite` は `Finset` の型が表す。 -/
def IsOrderConvex (τ : ℕ) (K : Finset (ℕ × V)) : Prop :=
  ∀ a ∈ K, ∀ c ∈ K, ∀ b ∈ eventSet (V := V) τ,
    (a, b) ∈ ReflReachable N f τ → (b, c) ∈ ReflReachable N f τ → b ∈ K

/-- 下方集合（`def_down_set`）。すべての a ∈ J とすべての b ∈ E_τ について、
    b ⪯_τ a ならば b ∈ J が成り立つこと。 -/
def IsDownSet (τ : ℕ) (J : Finset (ℕ × V)) : Prop :=
  ∀ a ∈ J, ∀ b ∈ eventSet (V := V) τ,
    (b, a) ∈ ReflReachable N f τ → b ∈ J

/-- 上方集合（`def_up_set`）。すべての a ∈ U とすべての b ∈ E_τ について、
    a ⪯_τ b ならば b ∈ U が成り立つこと。 -/
def IsUpSet (τ : ℕ) (U : Finset (ℕ × V)) : Prop :=
  ∀ a ∈ U, ∀ b ∈ eventSet (V := V) τ,
    (a, b) ∈ ReflReachable N f τ → b ∈ U

/-- `claim_down_set_order_convex` の具体版。下方集合は順序凸である。
    b ⪯_τ c と c ∈ J に下方性を適用する。人手証明どおり、部分集合条件 J ⊆ E_τ と
    仮定 a ⪯_τ b はこの証明では使わない。 -/
theorem down_set_order_convex (τ : ℕ) (J : Finset (ℕ × V))
    (_hJE : J ⊆ eventSet (V := V) τ) (hJ : IsDownSet N f τ J) :
    IsOrderConvex N f τ J := by
  intro _a _ha c hc b hb _hab hbc
  -- b ⪯_τ c かつ c ∈ J なので `def_down_set` より b ∈ J
  exact hJ c hc b hb hbc

/-- `claim_up_set_order_convex` の具体版。上方集合は順序凸である。
    a ⪯_τ b と a ∈ U に上方性を適用する。人手証明どおり、部分集合条件 U ⊆ E_τ と
    仮定 b ⪯_τ c はこの証明では使わない。 -/
theorem up_set_order_convex (τ : ℕ) (U : Finset (ℕ × V))
    (_hUE : U ⊆ eventSet (V := V) τ) (hU : IsUpSet N f τ U) :
    IsOrderConvex N f τ U := by
  intro a ha _c _hc b hb hab _hbc
  -- a ⪯_τ b かつ a ∈ U なので `def_up_set` より b ∈ U
  exact hU a ha b hb hab

/-- `claim_order_convex_intersection` の具体版。順序凸部分集合の共通部分は順序凸である。
    共通部分の定義で両成分へ分け、同じ仮定に K₁・K₂ の順序凸性をそれぞれ適用する。
    人手証明どおり、部分集合条件はこの証明では使わない。 -/
theorem order_convex_intersection (τ : ℕ) (K₁ K₂ : Finset (ℕ × V))
    (_hK₁E : K₁ ⊆ eventSet (V := V) τ) (_hK₂E : K₂ ⊆ eventSet (V := V) τ)
    (h₁ : IsOrderConvex N f τ K₁) (h₂ : IsOrderConvex N f τ K₂) :
    IsOrderConvex N f τ (K₁ ∩ K₂) := by
  intro a ha c hc b hb hab hbc
  -- 共通部分の定義より a, c ∈ K₁ かつ a, c ∈ K₂
  have ha' := Finset.mem_inter.mp ha
  have hc' := Finset.mem_inter.mp hc
  -- K₁ の順序凸性より b ∈ K₁、K₂ の順序凸性より b ∈ K₂
  exact Finset.mem_inter.mpr
    ⟨h₁ a ha'.1 c hc'.1 b hb hab hbc, h₂ a ha'.2 c hc'.2 b hb hab hbc⟩

/-- 非比較関係 ⊥_τ（`def_incomparability`）。E_τ × E_τ の元 (a,b) のうち
    (a,b) ∉ ⪯_τ かつ (b,a) ∉ ⪯_τ を満たすもの。 -/
def Incomparable (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  { ab | ab.1 ∈ eventSet (V := V) τ ∧ ab.2 ∈ eventSet (V := V) τ ∧
      (ab.1, ab.2) ∉ ReflReachable N f τ ∧ (ab.2, ab.1) ∉ ReflReachable N f τ }

/-- `def_incomparability` の注記: 定義の 2 条件は a と b の入れ替えで互いに移り合うので、
    (a,b) ∈ ⊥_τ と (b,a) ∈ ⊥_τ は同値である。 -/
theorem incomparable_symm (τ : ℕ) (a b : ℕ × V) :
    (a, b) ∈ Incomparable N f τ ↔ (b, a) ∈ Incomparable N f τ := by
  constructor <;> rintro ⟨ha, hb, h₁, h₂⟩ <;> exact ⟨hb, ha, h₂, h₁⟩

/-- 反鎖（`def_antichain`）。すべての a, b ∈ K について、a ≠ b ならば
    (a,b) ∈ ⊥_τ が成り立つこと（等号は直積集合の元の等号）。 -/
def IsAntichainOn (τ : ℕ) (K : Finset (ℕ × V)) : Prop :=
  ∀ a ∈ K, ∀ b ∈ K, a ≠ b → (a, b) ∈ Incomparable N f τ

/-- `claim_antichain_order_convex` の具体版。反鎖は順序凸である。
    a = c か否かで場合を分ける。a ≠ c の場合は ⪯_τ の推移性
    （`claim_reachability_partial_order`）で a ⪯_τ c を得て、反鎖の非比較と矛盾する。
    a = c の場合は b ⪯_τ a と a ⪯_τ b から反対称性で b = a ∈ K。
    人手証明どおり、部分集合条件 K ⊆ E_τ はこの証明では使わない。 -/
theorem antichain_order_convex (τ : ℕ) (K : Finset (ℕ × V))
    (_hKE : K ⊆ eventSet (V := V) τ) (hK : IsAntichainOn N f τ K) :
    IsOrderConvex N f τ K := by
  intro a ha c hc b _hb hab hbc
  by_cases hac : a = c
  · -- a = c の場合: b ⪯_τ c の c を等しい元 a で置き換えて b ⪯_τ a。
    -- a ⪯_τ b と合わせて反対称性（`claim_reachability_partial_order`）より b = a ∈ K
    subst hac
    have hanti := (reflReachable_partial_order N f τ).2.1
    have hba : a = b := hanti a b hab hbc
    exact hba ▸ ha
  · -- a ≠ c の場合: 推移性（`claim_reachability_partial_order`）より a ⪯_τ c。
    -- 一方、反鎖（`def_antichain`）より (a,c) ∈ ⊥_τ、すなわち (a,c) ∉ ⪯_τ で矛盾
    have htrans := (reflReachable_partial_order N f τ).2.2
    have hac' : (a, c) ∈ ReflReachable N f τ := htrans a b c hab hbc
    exact ((hK a ha c hc hac).2.2.1 hac').elim

/-- 時刻切片 E_τ^{(t)}（`def_time_slice`）。E_τ のうち時刻成分が t に等しいもの
    （等号は ℕ の元の等号）。 -/
def timeSlice (τ t : ℕ) : Finset (ℕ × V) :=
  (eventSet (V := V) τ).filter (fun a => a.1 = t)

/-- `claim_time_slice_antichain` の具体版。時刻切片は反鎖である。
    a ≠ b と (a,b) ∈ ⪯_τ を仮定すると、等号は a ≠ b に矛盾し、到達可能なら
    依存経路の時刻増加（`claim_path_time_strictly_increases`）より t < t となって
    ℕ の大小比較の非反射性に矛盾する。a と b を入れ替えて同じ論証を行う。 -/
theorem time_slice_antichain (τ t : ℕ) :
    IsAntichainOn N f τ (timeSlice (V := V) τ t) := by
  intro a ha b hb hne
  have ha' := Finset.mem_filter.mp ha
  have hb' := Finset.mem_filter.mp hb
  -- 同時刻の相異なるイベントの間に ⪯_τ は成り立たない
  have key : ∀ x y : ℕ × V, x.1 = t → y.1 = t → x ≠ y →
      (x, y) ∉ ReflReachable N f τ := by
    rintro x y hx hy hxy ⟨-, -, heq | hreach⟩
    · -- 前者（等号）は仮定 x ≠ y に矛盾する
      exact hxy heq
    · -- 後者（到達可能）は依存経路の時刻増加より t < t となり非反射性に矛盾する
      obtain ⟨n, p, hpath, hp0, hpn⟩ := hreach
      have h := path_time_strictly_increases N f τ n p hpath
      rw [hp0, hpn, hx, hy] at h
      exact Nat.lt_irrefl t h
  exact ⟨ha'.1, hb'.1, key a b ha'.2 hb'.2 hne, key b a hb'.2 ha'.2 hne.symm⟩

/-- 一段境界 ∂K（`def_one_step_boundary`）。K の元 a のうち、ある b ∈ E_τ ∖ K について
    (a,b) ∈ D_τ または (b,a) ∈ D_τ を満たすもの。 -/
def oneStepBoundary (τ : ℕ) (K : Finset (ℕ × V)) : Set (ℕ × V) :=
  { a | a ∈ K ∧ ∃ b, b ∈ eventSet (V := V) τ ∧ b ∉ K ∧
      ((a, b) ∈ oneStepDep N f τ ∨ (b, a) ∈ oneStepDep N f τ) }

/-- `claim_one_step_boundary_finite`: ∂K は有限集合 K の部分集合なので有限である。 -/
theorem oneStepBoundary_finite (τ : ℕ) (K : Finset (ℕ × V)) :
    (oneStepBoundary N f τ K).Finite :=
  Set.Finite.subset (Finset.finite_toSet K) (fun _a ha => ha.1)

/-- `claim_down_set_no_incoming_edge` の具体版。下方集合 J には、a ∈ J、
    b ∈ E_τ ∖ J、(b,a) ∈ D_τ を満たす組が存在しない。
    `claim_one_step_subset_reachability` より (b,a) ∈ C_τ、
    `def_reflexive_reachability` より b ⪯_τ a、下方性より b ∈ J となって
    b ∉ J に矛盾する。人手証明どおり、部分集合条件 J ⊆ E_τ は使わない。 -/
theorem down_set_no_incoming_edge (τ : ℕ) (J : Finset (ℕ × V))
    (_hJE : J ⊆ eventSet (V := V) τ) (hJ : IsDownSet N f τ J)
    (a b : ℕ × V) (ha : a ∈ J) (hbE : b ∈ eventSet (V := V) τ) (hbJ : b ∉ J)
    (hD : (b, a) ∈ oneStepDep N f τ) : False := by
  -- `claim_one_step_subset_reachability` より (b,a) ∈ C_τ
  have hreach : (b, a) ∈ Reachable N f τ := oneStep_subset_reachable N f τ b a hD
  -- 両端の E_τ 所属は D_τ ⊆ E_τ × E_τ（前章 `oneStepDep_subset`）による
  have hE := Finset.mem_product.mp (oneStepDep_subset N f τ hD)
  -- `def_reflexive_reachability` より b ⪯_τ a
  have hba : (b, a) ∈ ReflReachable N f τ := ⟨hE.1, hE.2, Or.inr hreach⟩
  -- a ∈ J なので `def_down_set` より b ∈ J となり、b ∉ J に矛盾する
  exact hbJ (hJ a ha b hbE hba)

/-- `claim_down_set_boundary_outgoing` の具体版。下方集合の一段境界は外向きの
    一段依存だけで定まる。両方向の包含で示し、⊆ の向きでは選言の後者
    （内向きの一段依存）が `claim_down_set_no_incoming_edge` より起こらない。 -/
theorem down_set_boundary_outgoing (τ : ℕ) (J : Finset (ℕ × V))
    (hJE : J ⊆ eventSet (V := V) τ) (hJ : IsDownSet N f τ J) :
    oneStepBoundary N f τ J =
      { a | a ∈ J ∧ ∃ b, b ∈ eventSet (V := V) τ ∧ b ∉ J ∧
          (a, b) ∈ oneStepDep N f τ } := by
  ext a
  constructor
  · -- ∂J ⊆ B: 選言の後者は起こらないので前者が成り立つ
    rintro ⟨haJ, b, hbE, hbJ, hout | hin⟩
    · exact ⟨haJ, b, hbE, hbJ, hout⟩
    · exact (down_set_no_incoming_edge N f τ J hJE hJ a b haJ hbE hbJ hin).elim
  · -- B ⊆ ∂J: 選言の前者がそのまま成り立つ
    rintro ⟨haJ, b, hbE, hbJ, hout⟩
    exact ⟨haJ, b, hbE, hbJ, Or.inl hout⟩

private abbrev EventSetAsSetDOS (τ : ℕ) : Set (ℕ × V) :=
  ↑(eventSet (V := V) τ)

private abbrev ReflReachableAsSetDOS (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  ReflReachable N f τ

private abbrev OneStepAsSetDOS (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  ↑(oneStepDep N f τ)

/-- 具体版の下方集合の順序凸性は、必要十分版で集合と関係だけを使う定理の特殊化である。 -/
theorem down_set_order_convex_from_necessary_sufficient (τ : ℕ) (J : Finset (ℕ × V))
    (_hJE : J ⊆ eventSet (V := V) τ) (hJ : IsDownSet N f τ J) :
    IsOrderConvex N f τ J := by
  exact CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_order_convex
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ) ↑J hJ

/-- 具体版の上方集合の順序凸性は、必要十分版の特殊化である。 -/
theorem up_set_order_convex_from_necessary_sufficient (τ : ℕ) (U : Finset (ℕ × V))
    (_hUE : U ⊆ eventSet (V := V) τ) (hU : IsUpSet N f τ U) :
    IsOrderConvex N f τ U := by
  exact CellularAutomata.NecSuf.DependencyOrderSubstructures.up_set_order_convex
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ) ↑U hU

/-- 具体版の順序凸部分集合の共通部分は、必要十分版の特殊化である。 -/
theorem order_convex_intersection_from_necessary_sufficient
    (τ : ℕ) (K₁ K₂ : Finset (ℕ × V))
    (_hK₁E : K₁ ⊆ eventSet (V := V) τ) (_hK₂E : K₂ ⊆ eventSet (V := V) τ)
    (h₁ : IsOrderConvex N f τ K₁) (h₂ : IsOrderConvex N f τ K₂) :
    IsOrderConvex N f τ (K₁ ∩ K₂) := by
  simpa only [IsOrderConvex,
    CellularAutomata.NecSuf.DependencyOrderSubstructures.IsOrderConvex,
    Finset.mem_inter, Finset.mem_coe, Set.mem_inter_iff] using
    (CellularAutomata.NecSuf.DependencyOrderSubstructures.order_convex_intersection
      (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ) ↑K₁ ↑K₂ h₁ h₂)

/-- 具体版の非比較関係の対称性は、必要十分版の特殊化である。 -/
theorem incomparable_symm_from_necessary_sufficient (τ : ℕ) (a b : ℕ × V) :
    (a, b) ∈ Incomparable N f τ ↔ (b, a) ∈ Incomparable N f τ := by
  exact CellularAutomata.NecSuf.DependencyOrderSubstructures.incomparable_symm
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ) a b

/-- 具体版の反鎖の順序凸性は、必要十分版へ反射的到達可能関係の
    反対称性と推移性だけを代入した特殊化である。 -/
theorem antichain_order_convex_from_necessary_sufficient
    (τ : ℕ) (K : Finset (ℕ × V)) (_hKE : K ⊆ eventSet (V := V) τ)
    (hK : IsAntichainOn N f τ K) : IsOrderConvex N f τ K := by
  have hpo := reflReachable_partial_order N f τ
  exact CellularAutomata.NecSuf.DependencyOrderSubstructures.antichain_order_convex
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ)
    hpo.2.1 hpo.2.2 ↑K hK

/-- 具体版の時刻切片は、必要十分版へ自然数時刻と反射的到達可能関係を代入した特殊化である。 -/
theorem time_slice_antichain_from_necessary_sufficient (τ t : ℕ) :
    IsAntichainOn N f τ (timeSlice (V := V) τ t) := by
  have hinc : ∀ a b : ℕ × V, (a, b) ∈ ReflReachable N f τ →
      a = b ∨ a.1 < b.1 := by
    rintro a b ⟨-, -, heq | hreach⟩
    · exact Or.inl heq
    · obtain ⟨n, p, hpath, hp0, hpn⟩ := hreach
      right
      have h := path_time_strictly_increases N f τ n p hpath
      simpa [hp0, hpn] using h
  simpa only [IsAntichainOn, Incomparable, timeSlice, Finset.mem_filter,
    CellularAutomata.NecSuf.DependencyOrderSubstructures.IsAntichainOn,
    CellularAutomata.NecSuf.DependencyOrderSubstructures.Incomparable,
    CellularAutomata.NecSuf.DependencyOrderSubstructures.timeSlice, Set.mem_setOf_eq,
    Finset.mem_coe] using
    (CellularAutomata.NecSuf.DependencyOrderSubstructures.time_slice_antichain
      (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ)
      Prod.fst Nat.lt Nat.lt_irrefl hinc t)

/-- 具体版の一段境界の有限性は、必要十分版で K の有限性だけから得られる。 -/
theorem oneStepBoundary_finite_from_necessary_sufficient (τ : ℕ) (K : Finset (ℕ × V)) :
    (oneStepBoundary N f τ K).Finite := by
  exact CellularAutomata.NecSuf.DependencyOrderSubstructures.oneStepBoundary_finite
    (EventSetAsSetDOS (V := V) τ) (OneStepAsSetDOS N f τ) ↑K (Finset.finite_toSet K)

/-- 具体版の「下方集合には外から入る一段依存がない」は、必要十分版へ
    D_τ ⊆ ⪯_τ だけを代入した特殊化である。 -/
theorem down_set_no_incoming_edge_from_necessary_sufficient
    (τ : ℕ) (J : Finset (ℕ × V)) (_hJE : J ⊆ eventSet (V := V) τ)
    (hJ : IsDownSet N f τ J) (a b : ℕ × V) (ha : a ∈ J)
    (hbE : b ∈ eventSet (V := V) τ) (hbJ : b ∉ J)
    (hD : (b, a) ∈ oneStepDep N f τ) : False := by
  apply CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_no_incoming_edge
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ)
    (OneStepAsSetDOS N f τ) _ ↑J hJ a b ha hbE hbJ hD
  intro ab hab
  have hE := Finset.mem_product.mp (oneStepDep_subset N f τ hab)
  exact ⟨hE.1, hE.2, Or.inr (oneStep_subset_reachable N f τ ab.1 ab.2 hab)⟩

/-- 具体版の下方集合の境界等式は、必要十分版の特殊化である。 -/
theorem down_set_boundary_outgoing_from_necessary_sufficient
    (τ : ℕ) (J : Finset (ℕ × V)) (_hJE : J ⊆ eventSet (V := V) τ)
    (hJ : IsDownSet N f τ J) :
    oneStepBoundary N f τ J =
      { a | a ∈ J ∧ ∃ b, b ∈ eventSet (V := V) τ ∧ b ∉ J ∧
          (a, b) ∈ oneStepDep N f τ } := by
  apply CellularAutomata.NecSuf.DependencyOrderSubstructures.down_set_boundary_outgoing
    (EventSetAsSetDOS (V := V) τ) (ReflReachableAsSetDOS N f τ)
    (OneStepAsSetDOS N f τ) _ ↑J hJ
  intro ab hab
  have hE := Finset.mem_product.mp (oneStepDep_subset N f τ hab)
  exact ⟨hE.1, hE.2, Or.inr (oneStep_subset_reachable N f τ ab.1 ab.2 hab)⟩

end CellularAutomata.DependencyOrderSubstructures
