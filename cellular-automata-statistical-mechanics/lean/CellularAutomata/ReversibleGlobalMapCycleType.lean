/-
章「可逆な大域写像の巡回型」の Lean 具体版。
人手証明の正本は structured-latex/content/reversible-global-map-cycle-type.ts。

有限舞台 V の配位型 A^V 上の単射な自己写像を有限置換へ移し、非自明周期の長さに
固定点の個数だけ 1 を加えた有限多重集合を巡回型とする。これにより固定点を落とす
Mathlib の `Equiv.Perm.cycleType` と、人手証明の「全周期軌道の元数」の定義を一致させる。
有限集合・自然数・有限多重集合だけを使い、R / C は使わない。

対応表（人手証明 → この file）
  def_reversible_global_maps                         `ReversibleMap`, `toPerm`
  claim_reversible_all_configurations_periodic       `all_configurations_periodic`
  def_reversible_cycle_type                          `cycleType`
  claim_reversible_cycle_type_sum                    `cycleType_sum`, `cycleType_members_positive`
  claim_reversible_cycle_type_conjugacy_invariance   `cycleType_eq_of_conj`
  claim_reversible_cycle_type_completeness           `conj_of_cycleType_eq`

周期軌道の分割と各軌道の元数＝最小周期は、`Equiv.Perm.cycleType` の周期分解に含まれる。
本ファイルではその既製分解を、人手証明で導いた後の段（巡回型・共役）だけに適用する。
分割の任意実現と共役類との全単射は次の Lean 必要十分版で分離する。
-/
import CellularAutomata.ConjugacyClassCodeImageBijection
import CellularAutomata.NecSuf.ReversibilityFiniteDecidability
import Mathlib.GroupTheory.Perm.Cycle.PossibleTypes

namespace CellularAutomata.ReversibleGlobalMapCycleType

open CellularAutomata.EssentialDependency
open CellularAutomata.NecSuf

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限舞台 V 上の配位型 A^V。 -/
abbrev Config (V : Type) := V → State

/-- 一つの有限舞台上の可逆な大域写像全体（単射な自己写像）。 -/
def ReversibleMap (V : Type) [Fintype V] [DecidableEq V] :=
  {F : Config V → Config V // Function.Injective F}

instance : CoeFun (ReversibleMap V) (fun _ => Config V → Config V) :=
  ⟨fun F => F.1⟩

/-- 有限集合上の単射な自己写像を、同じ写像を持つ有限置換として読む。 -/
noncomputable def toPerm (F : ReversibleMap V) : Equiv.Perm (Config V) :=
  Equiv.ofBijective F.1
    ((Fintype.bijective_iff_injective_and_card F.1).2 ⟨F.2, rfl⟩)

@[simp]
theorem toPerm_apply (F : ReversibleMap V) (y : Config V) : toPerm F y = F y := rfl

/-- 可逆なら全ての配位が周期点である。有限自己写像について既証明の
    「単射 ⟺ 全点が周期点」をそのまま適用する。 -/
theorem all_configurations_periodic (F : ReversibleMap V) (y : Config V) :
    CellularAutomata.NecSuf.PeriodicPointCount.IsPeriodicPoint F.1 y := by
  exact (CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_forall_isPeriodicPoint F.1).1 F.2 y

/-- 固定点を含む巡回型。Mathlib の巡回型は非自明周期だけを集めるので、
    固定点の個数だけ 1 を明示的に加える。 -/
noncomputable def cycleType (F : ReversibleMap V) : Multiset ℕ :=
  (toPerm F).cycleType +
    Multiset.replicate (Fintype.card (Config V) - (toPerm F).cycleType.sum) 1

/-- 巡回型から 1 を除けば、非自明周期だけを持つ Mathlib の巡回型へ戻る。 -/
theorem filter_cycleType (F : ReversibleMap V) :
    (cycleType F).filter (fun n => 2 ≤ n) = (toPerm F).cycleType := by
  classical
  rw [cycleType, Multiset.filter_add]
  have hmain : (toPerm F).cycleType.filter (fun n => 2 ≤ n) = (toPerm F).cycleType := by
    apply Multiset.filter_eq_self.2
    intro n hn
    exact Equiv.Perm.two_le_of_mem_cycleType hn
  rw [hmain]
  have hrep :
      (Multiset.replicate (Fintype.card (Config V) - (toPerm F).cycleType.sum) 1).filter
        (fun n => 2 ≤ n) = 0 := by
    induction (Fintype.card (Config V) - (toPerm F).cycleType.sum) with
    | zero => simp
    | succ k ih => simp [Multiset.replicate_succ, ih]
  rw [hrep, add_zero]

/-- 巡回型の各要素は正の自然数である。 -/
theorem cycleType_members_positive (F : ReversibleMap V) {n : ℕ} (hn : n ∈ cycleType F) :
    1 ≤ n := by
  classical
  rw [cycleType, Multiset.mem_add] at hn
  rcases hn with hn | hn
  · exact (Equiv.Perm.two_le_of_mem_cycleType hn).trans' (by omega)
  · rw [Multiset.mem_replicate] at hn
    omega

/-- 巡回型の重複度つき和は配位数に等しい。 -/
theorem cycleType_sum (F : ReversibleMap V) :
    (cycleType F).sum = 2 ^ Fintype.card V := by
  classical
  have hle : (toPerm F).cycleType.sum ≤ Fintype.card (Config V) :=
    Equiv.Perm.sum_cycleType_le (toPerm F)
  have hsum (k : ℕ) : (Multiset.replicate k 1 : Multiset ℕ).sum = k := by
    induction k with
    | zero => simp
    | succ k ih => simp [Multiset.replicate_succ, ih, Nat.add_comm]
  rw [cycleType, Multiset.sum_add, hsum]
  rw [Nat.add_sub_of_le hle]
  exact CellularAutomata.GlobalMapIteration.card_config

/-- 同一舞台上の二つの可逆な大域写像の間の共役全単射。 -/
def Conj (F G : ReversibleMap V) : Prop :=
  ∃ h : Config V ≃ Config V, ∀ y, h (F y) = G (h y)

/-- 共役全単射は、対応する有限置換を群論的な共役で結ぶ。 -/
theorem perm_conj_eq {F G : ReversibleMap V} {h : Config V ≃ Config V}
    (hcomm : ∀ y, h (F y) = G (h y)) :
    h * toPerm F * h⁻¹ = toPerm G := by
  apply Equiv.ext
  intro y
  simpa using hcomm (h⁻¹ y)

/-- 共役全単射は巡回型を保存する。 -/
theorem cycleType_eq_of_conj {F G : ReversibleMap V} (hFG : Conj F G) :
    cycleType F = cycleType G := by
  classical
  obtain ⟨h, hcomm⟩ := hFG
  have hperm := perm_conj_eq hcomm
  have hnontrivial : (toPerm F).cycleType = (toPerm G).cycleType := by
    rw [← hperm, Equiv.Perm.cycleType_conj]
  simp [cycleType, hnontrivial]

/-- 巡回型の一致から共役全単射を構成できる。Mathlib の有限置換の共役分類へ渡す前に、
    固定点を表す 1 を除いて非自明周期の巡回型の一致を取り出す。 -/
theorem conj_of_cycleType_eq {F G : ReversibleMap V} (hct : cycleType F = cycleType G) :
    Conj F G := by
  classical
  have hnontrivial : (toPerm F).cycleType = (toPerm G).cycleType := by
    rw [← filter_cycleType F, ← filter_cycleType G, hct]
  have his : IsConj (toPerm F) (toPerm G) :=
    Equiv.Perm.isConj_iff_cycleType_eq.2 hnontrivial
  obtain ⟨h, hconj⟩ := isConj_iff.1 his
  refine ⟨h, ?_⟩
  intro y
  have hy := congrArg (fun p : Equiv.Perm (Config V) => p (h y)) hconj
  simpa using hy

/-- 巡回型は可逆な大域写像の共役に関する完全不変量である。 -/
theorem conj_iff_cycleType_eq (F G : ReversibleMap V) :
    Conj F G ↔ cycleType F = cycleType G :=
  ⟨cycleType_eq_of_conj, conj_of_cycleType_eq⟩

end CellularAutomata.ReversibleGlobalMapCycleType
