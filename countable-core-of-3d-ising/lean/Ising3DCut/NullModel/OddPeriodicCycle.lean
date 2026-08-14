/-
人手証明の主張「奇数周期ではすべての周期辺を破る配位は無い」
（ラベル `claim_periodic_no_all_broken`）の具体版。

人手証明とこのファイルの対応:

  方向 1 の一周の点 v_k と辺 e_k             `cycleSite` / `cycleEdge`
  周期端点は v_k と v_{k+1}（末尾は v_0）    `periodicEndpoint0_cycleEdge` /
                                                  `periodicEndpoint1_cycleEdge`
  全辺破れなら一周の隣接値がすべて異なる        `cycle_values_opposite_of_all_broken`
  奇数周回では積が -1 と整数の二乗に同時になる  `no_odd_cycle_all_opposite` を同じ積の鎖へ特殊化
  全辺破れの水準集合が空なので多重度は 0        `periodicMultiplicity_full_eq_zero`

住処: `Fin`、`Nat`、整数 ±1、有限集合・有限積のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PeriodicConstantUnbroken
import Ising3DCut.NecSuf.NullModel.OddPeriodicCycle
import Mathlib.Tactic.FinCases

namespace Ising3DCut.NullModel

/-- 方向 1 の一周で使う点 `v_k = (k,0,0)`。 -/
def cycleSite {L : ℕ} (hpos : 0 < L) (k : Fin L) : Site L :=
  ⟨fun i => if i = 0 then k.1 else 0, by
    intro i
    by_cases hi : i = 0
    · simpa [hi] using k.2
    · simpa [hi] using hpos⟩

/-- 方向 1 の一周で使う周期辺 `e_k = (v_k,1)`。Lean の方向番号は 0 始まりなので軸は 0。 -/
def cycleEdge {L : ℕ} (hpos : 0 < L) (k : Fin L) : PeriodicEdge L :=
  ⟨cycleSite hpos k, 0⟩

/-- `e_k` の第一端点は `v_k`。 -/
lemma periodicEndpoint0_cycleEdge {L : ℕ} (hpos : 0 < L) (k : Fin L) :
    periodicEndpoint0 (cycleEdge hpos k) = cycleSite hpos k := rfl

/-- `e_k` の第二端点は次の点であり、末尾では `v_0` へ巻き戻る。 -/
lemma periodicEndpoint1_cycleEdge {L : ℕ} (hpos : 0 < L) (k : Fin L) :
    periodicEndpoint1 (cycleEdge hpos k) = cycleSite hpos (finRotate L k) := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hpos)
  apply Subtype.ext
  funext i
  fin_cases i
  · simp only [periodicEndpoint1, cycleEdge, cycleSite, Function.update_self,
      Fin.isValue, if_pos, Subtype.coe_eta, finRotate_apply]
    rw [Fin.val_add_one]
    by_cases hlast : k = Fin.last n
    · subst k
      simp
    · have hlt : k.1 < n := Fin.val_lt_last hlast
      simp [hlast, hlt]
  · simp [periodicEndpoint1, cycleEdge, cycleSite, Function.update]
  · simp [periodicEndpoint1, cycleEdge, cycleSite, Function.update]

/-- 破れ数が周期辺総数なら、方向 1 の一周の各隣接値も異なる。 -/
lemma cycle_values_opposite_of_all_broken {L : ℕ} (hpos : 0 < L) (σ : Config L)
    (hall : periodicBrokenCount σ = Fintype.card (PeriodicEdge L)) (k : Fin L) :
    σ (cycleSite hpos k) ≠ σ (cycleSite hpos (finRotate L k)) := by
  have hset : periodicBrokenSet σ = Finset.univ := by
    apply (Finset.card_eq_iff_eq_univ (periodicBrokenSet σ)).mp
    simpa [periodicBrokenCount] using hall
  have hmem : cycleEdge hpos k ∈ periodicBrokenSet σ := by
    rw [hset]
    exact Finset.mem_univ _
  have hbroken := (Finset.mem_filter.mp hmem).2
  simpa [periodicEndpoint0_cycleEdge, periodicEndpoint1_cycleEdge] using hbroken

/-- 奇数周期では破れ数が周期辺総数になる配位は存在しない。 -/
theorem no_config_all_periodic_edges_broken {L : ℕ} (hodd : Odd L) (σ : Config L) :
    periodicBrokenCount σ ≠ Fintype.card (PeriodicEdge L) := by
  intro hall
  have hpos : 0 < L := Nat.pos_of_ne_zero (by
    intro hzero
    subst L
    exact Nat.not_odd_zero hodd)
  apply NecSuf.NullModel.no_odd_cycle_all_opposite hodd
      (fun k => (σ (cycleSite hpos k)).1)
  · intro k
    exact (σ (cycleSite hpos k)).2
  · intro k hvalue
    apply cycle_values_opposite_of_all_broken hpos σ hall k
    apply Subtype.ext
    exact hvalue

/-- `claim_periodic_no_all_broken` の具体版。奇数周期では Ω^per_L(#E^per_L) = 0。 -/
theorem periodicMultiplicity_full_eq_zero {L : ℕ} (hodd : Odd L) :
    periodicMultiplicity L (Fintype.card (PeriodicEdge L)) = 0 := by
  rw [periodicMultiplicity, Fintype.card_eq_zero_iff]
  exact ⟨fun x => no_config_all_periodic_edges_broken hodd x.1
    (Finset.mem_filter.mp x.2).2⟩

end Ising3DCut.NullModel
