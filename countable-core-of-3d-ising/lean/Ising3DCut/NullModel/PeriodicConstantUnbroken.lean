/-
人手証明の主張「定数配位は周期辺を破らない」
（ラベル `claim_periodic_constant_unbroken`）の具体版。

人手証明とこのファイルの対応:

  周期辺の集合 E^per_L（始点に条件を置かない）        `PeriodicEdge`
  周期端点写像 ∂^per_0, ∂^per_1（端で 0 へ巻き戻す）   `periodicEndpoint0` / `periodicEndpoint1`
  破れ辺集合 D^per_L(σ) と破れ数 m^per_L(σ)          `periodicBrokenSet` / `periodicBrokenCount`
  周期族の多重度 Ω^per_L(m)                          `periodicMultiplicity`
  σ⁺(∂^per_0 e) = +1 = σ⁺(∂^per_1 e)                `constConfig_periodic_unbroken` の中の等式
  D^per_L(σ⁺) = ∅ ゆえ m^per_L(σ⁺) = 0              `periodicBrokenCount_constConfig`
  Ω^per_L(0) の数える集合が σ⁺ を含むので 1 以上      `one_le_periodicMultiplicity_zero`

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NullModel

/-- 周期辺。始点と方向の組で、前章の `Edge` と違い始点に条件を置かない
（`def_periodic_edge_set` の具体化）。 -/
structure PeriodicEdge (L : ℕ) where
  start : Site L
  axis : Fin 3

/-- 周期辺の等号は、始点と方向の等号として決定できる。 -/
instance {L : ℕ} : DecidableEq (PeriodicEdge L) :=
  fun e f =>
    decidable_of_iff (e.start = f.start ∧ e.axis = f.axis) (by cases e; cases f; simp)

/-- 周期辺と「始点と方向の組」の全単射。周期辺の有限性はここから出す。 -/
def periodicEdgeEquiv {L : ℕ} : PeriodicEdge L ≃ Site L × Fin 3 where
  toFun e := (e.start, e.axis)
  invFun p := ⟨p.1, p.2⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- 周期辺は有限個である。#E^per_L は `Fintype.card (PeriodicEdge L)` と書く。 -/
instance {L : ℕ} : Fintype (PeriodicEdge L) :=
  Fintype.ofEquiv _ periodicEdgeEquiv.symm

/-- 周期端点写像の第一端点。∂^per_0(a,i) = a（`def_periodic_endpoint_maps` の前半）。 -/
def periodicEndpoint0 {L : ℕ} (e : PeriodicEdge L) : Site L := e.start

/-- 周期端点写像の第二端点。始点の `axis` 成分だけを、箱に収まるなら 1 増やし、
端（`a_i = L-1`）なら 0 へ巻き戻す（`def_periodic_endpoint_maps` の後半。
人手証明の場合分けと同じ二分岐で書く）。 -/
def periodicEndpoint1 {L : ℕ} (e : PeriodicEdge L) : Site L :=
  ⟨Function.update e.start.1 e.axis
      (if e.start.1 e.axis + 1 < L then e.start.1 e.axis + 1 else 0), by
    intro i
    by_cases hi : i = e.axis
    · subst i
      simp only [Function.update_self]
      by_cases hlt : e.start.1 e.axis + 1 < L
      · simp [hlt]
      · -- 端の場合。第 i 成分は 0 になり、0 < L は始点の成分が L 未満であることから従う。
        have hpos : 0 < L := Nat.lt_of_le_of_lt (Nat.zero_le _) (e.start.2 e.axis)
        simp [hlt, hpos]
    · rw [Function.update_of_ne hi]
      exact e.start.2 i⟩

/-- 破れている周期辺の集合 D^per_L(σ)（`def_periodic_broken_count` の前半）。 -/
def periodicBrokenSet {L : ℕ} (σ : Config L) : Finset (PeriodicEdge L) :=
  Finset.univ.filter (fun e => σ (periodicEndpoint0 e) ≠ σ (periodicEndpoint1 e))

/-- 周期族の破れ数 m^per_L(σ) = #D^per_L(σ)（`def_periodic_broken_count` の後半）。 -/
def periodicBrokenCount {L : ℕ} (σ : Config L) : ℕ := (periodicBrokenSet σ).card

/-- 周期族の多重度 Ω^per_L(m)（`def_periodic_multiplicity` の具体化）。
配位の集合は前章と同じなので、有限性は既出の `Fintype (Config L)` から出る。 -/
noncomputable def periodicMultiplicity (L m : ℕ) : ℕ :=
  Fintype.card ↥(Finset.univ.filter (fun σ : Config L => periodicBrokenCount σ = m))

/-- すべての点で値 +1 を取る定数配位 σ⁺。 -/
def constConfig (L : ℕ) : Config L := fun _ => ⟨1, Or.inl rfl⟩

/-- 人手証明の等式 σ⁺(∂^per_0 e) = σ⁺(∂^per_1 e)。定数配位はどの周期辺も破らない。 -/
lemma constConfig_periodic_unbroken {L : ℕ} (e : PeriodicEdge L) :
    constConfig L (periodicEndpoint0 e) = constConfig L (periodicEndpoint1 e) := rfl

/-- 人手証明の帰結 D^per_L(σ⁺) = ∅、よって m^per_L(σ⁺) = 0。 -/
lemma periodicBrokenCount_constConfig (L : ℕ) :
    periodicBrokenCount (constConfig L) = 0 := by
  rw [periodicBrokenCount, Finset.card_eq_zero]
  ext e
  simp [periodicBrokenSet, constConfig_periodic_unbroken e]

/-- `claim_periodic_constant_unbroken` の具体版。Ω^per_L(0) ≥ 1。 -/
theorem one_le_periodicMultiplicity_zero (L : ℕ) :
    1 ≤ periodicMultiplicity L 0 := by
  rw [periodicMultiplicity]
  apply Nat.succ_le_of_lt
  apply Fintype.card_pos_iff.mpr
  exact ⟨⟨constConfig L, Finset.mem_filter.mpr
    ⟨Finset.mem_univ _, periodicBrokenCount_constConfig L⟩⟩⟩

end Ising3DCut.NullModel
