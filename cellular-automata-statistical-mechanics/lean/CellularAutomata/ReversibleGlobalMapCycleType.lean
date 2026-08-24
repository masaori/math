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
import CellularAutomata.NecSuf.PeriodicPointCount
import CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree
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


/-
以下は人手証明の
  claim_periodic_orbit_card_eq_min_period            `card_orbit_eq_minPeriod`
  claim_reversible_orbits_partition_configurations   `self_mem_orbit`, `orbit_eq_of_mem_orbit`,
                                                     `orbit_eq_of_not_disjoint`
に対応する段である。周期軌道は人手証明と同じく「一周期分の反復列」として定義し、
その元数が最小周期に等しいこと、および周期軌道が配位集合を分割することを、
Mathlib の巡回置換の分解を使わずに人手証明と同じ順序で示す。
-/

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod
open CellularAutomata.NecSuf.PeriodicPointCount

/-- 周期軌道。最小周期の長さぶんの反復列を集めた有限集合。 -/
noncomputable def orbit (F : ReversibleMap V) (q : Config V) : Finset (Config V) :=
  (Finset.range (minPeriod F.1 q)).image fun r => iterate F.1 r q

/-- 最小周期より小さい二つの反復回数が同じ値を与えるなら、その回数は等しい。
人手証明の第二段（差を周期の組へ移して最小性に反する）をそのまま写す。 -/
theorem iterate_inj_below_minPeriod (F : ReversibleMap V) (q : Config V) {i j : ℕ}
    (hi : i < minPeriod F.1 q) (hj : j < minPeriod F.1 q)
    (h : iterate F.1 i q = iterate F.1 j q) : i = j := by
  classical
  have key : ∀ a b : ℕ, a < b → b < minPeriod F.1 q →
      iterate F.1 a q = iterate F.1 b q → False := by
    intro a b hab hb hval
    have hp : 1 ≤ b - a := by omega
    have hcol : iterate F.1 (a + (b - a)) q = iterate F.1 a q := by
      have hab' : a + (b - a) = b := by omega
      rw [hab', ← hval]
    have hpair : IsPeriodicityPair F.1 q a (b - a) :=
      (isPeriodicityPair_iff_collision F.1 q a (b - a)).2 ⟨hp, hcol⟩
    have hle := (period_descends_to_minPreperiod F.1 q hpair).2.2
    omega
  rcases lt_trichotomy i j with hlt | heq | hgt
  · exact absurd (key i j hlt hj h) (by simp)
  · exact heq
  · exact absurd (key j i hgt hi h.symm) (by simp)

/-- 周期軌道の元数は最小周期に等しい。 -/
theorem card_orbit_eq_minPeriod (F : ReversibleMap V) (q : Config V) :
    (orbit F q).card = minPeriod F.1 q := by
  classical
  rw [orbit, Finset.card_image_of_injOn, Finset.card_range]
  intro i hi j hj h
  exact iterate_inj_below_minPeriod F q
    (Finset.mem_range.1 (Finset.mem_coe.1 hi)) (Finset.mem_range.1 (Finset.mem_coe.1 hj)) h

/-- 可逆な大域写像では、周期軌道は反復で到達できる配位全体に一致する。 -/
theorem mem_orbit_iff (F : ReversibleMap V) (q z : Config V) :
    z ∈ orbit F q ↔ ∃ n : ℕ, iterate F.1 n q = z := by
  classical
  constructor
  · intro hz
    rw [orbit, Finset.mem_image] at hz
    obtain ⟨r, _, hr⟩ := hz
    exact ⟨r, hr⟩
  · rintro ⟨n, rfl⟩
    have hzero : minPreperiod F.1 q = 0 :=
      (isPeriodicPoint_iff_minPreperiod_zero F.1 q).1 (all_configurations_periodic F q)
    have hp1 : 1 ≤ minPeriod F.1 q := one_le_minPeriod F.1 q
    have hcol : iterate F.1 (0 + minPeriod F.1 q) q = iterate F.1 0 q := by
      have hspec :=
        ((isPeriodicityPair_iff_collision F.1 q (minPreperiod F.1 q) (minPeriod F.1 q)).1
          (minPeriod_spec F.1 q)).2
      rwa [hzero] at hspec
    have hmul := period_multiples F.1 q hcol (n / minPeriod F.1 q)
    have hfix : iterate F.1 (n / minPeriod F.1 q * minPeriod F.1 q) q = q := by
      simpa [iterate_zero] using hmul
    refine Finset.mem_image.2 ⟨n % minPeriod F.1 q, Finset.mem_range.2 (Nat.mod_lt _ hp1), ?_⟩
    have hsplit : n / minPeriod F.1 q * minPeriod F.1 q + n % minPeriod F.1 q = n :=
      Nat.div_add_mod' n (minPeriod F.1 q)
    calc iterate F.1 (n % minPeriod F.1 q) q
        = iterate F.1 (n % minPeriod F.1 q)
            (iterate F.1 (n / minPeriod F.1 q * minPeriod F.1 q) q) := by rw [hfix]
      _ = iterate F.1 (n / minPeriod F.1 q * minPeriod F.1 q + n % minPeriod F.1 q) q :=
            (CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree.iterate_add F.1 _ _ q).symm
      _ = iterate F.1 n q := by rw [hsplit]

/-- 各配位は自分の周期軌道に属する（分割の被覆側）。 -/
theorem self_mem_orbit (F : ReversibleMap V) (q : Config V) : q ∈ orbit F q :=
  (mem_orbit_iff F q q).2 ⟨0, rfl⟩

/-- 周期軌道に属する配位の周期軌道は、もとの周期軌道に等しい。 -/
theorem orbit_eq_of_mem_orbit (F : ReversibleMap V) (q z : Config V) (hz : z ∈ orbit F q) :
    orbit F z = orbit F q := by
  classical
  obtain ⟨n, hn⟩ := (mem_orbit_iff F q z).1 hz
  have hzero : minPreperiod F.1 q = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero F.1 q).1 (all_configurations_periodic F q)
  have hp1 : 1 ≤ minPeriod F.1 q := one_le_minPeriod F.1 q
  have hcol : iterate F.1 (0 + minPeriod F.1 q) q = iterate F.1 0 q := by
    have hspec :=
      ((isPeriodicityPair_iff_collision F.1 q (minPreperiod F.1 q) (minPeriod F.1 q)).1
        (minPeriod_spec F.1 q)).2
    rwa [hzero] at hspec
  have hmul := period_multiples F.1 q hcol (n + 1)
  have hfix : iterate F.1 ((n + 1) * minPeriod F.1 q) q = q := by simpa [iterate_zero] using hmul
  have hge : n ≤ (n + 1) * minPeriod F.1 q := by
    have : n + 1 ≤ (n + 1) * minPeriod F.1 q := Nat.le_mul_of_pos_right _ hp1
    omega
  have hback : iterate F.1 ((n + 1) * minPeriod F.1 q - n) z = q := by
    rw [← hn,
      ← CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree.iterate_add F.1 n _ q]
    have hsum : n + ((n + 1) * minPeriod F.1 q - n) = (n + 1) * minPeriod F.1 q := by omega
    rw [hsum, hfix]
  apply Finset.ext
  intro u
  rw [mem_orbit_iff, mem_orbit_iff]
  constructor
  · rintro ⟨m, hm⟩
    refine ⟨n + m, ?_⟩
    rw [CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree.iterate_add F.1 n m q, hn, hm]
  · rintro ⟨m, hm⟩
    refine ⟨(n + 1) * minPeriod F.1 q - n + m, ?_⟩
    rw [CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree.iterate_add F.1 _ m z,
      hback, hm]

/-- 交わる二つの周期軌道は等しい（分割の非交差側）。 -/
theorem orbit_eq_of_not_disjoint (F : ReversibleMap V) (q q' z : Config V)
    (hz : z ∈ orbit F q) (hz' : z ∈ orbit F q') : orbit F q = orbit F q' := by
  rw [← orbit_eq_of_mem_orbit F q z hz, orbit_eq_of_mem_orbit F q' z hz']

end CellularAutomata.ReversibleGlobalMapCycleType