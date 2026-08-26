/-
並行ストリーム（測定量の事前予言）の一段。
直前に閉じた `forall_even_card_selected_of_card_incidentEdges_eq_four` は、
「どの頂点にも接続辺がちょうど四本ある」という仮定の下で偶部分グラフ性を結論する。
ここではその仮定を満たす舞台を具体的に構成する。

構成: 周期境界の平面正方格子。頂点は `Fin n × Fin n`、辺は「起点の頂点」と「方向（横・縦）」の組
`(Fin n × Fin n) × Fin 2` とし、横の辺 `((i,j),0)` は `(i,j)` と `(i+1,j)` を、
縦の辺 `((i,j),1)` は `(i,j)` と `(i,j+1)` を結ぶ（添字は `Fin n` の巡回和）。
接続辺は端点写像から定義するので、格子の形を担うのは端点写像だけである。

扱うのは有限集合の要素数だけであり、箱の大きさの極限も実数も現れない。
接続辺数が四であることは、辺集合が有限なので各 `n` について決定計算で確かめられる。
-/
import Mathlib

namespace Ising3DCut.Prediction

/-- 周期境界の平面正方格子の頂点。 -/
abbrev LatticeVertex (n : ℕ) : Type := Fin n × Fin n

/-- 周期境界の平面正方格子の辺。起点の頂点と方向（`0` が横、`1` が縦）の組で表す。 -/
abbrev LatticeEdge (n : ℕ) : Type := (Fin n × Fin n) × Fin 2

/-- 辺の第一の端点。方向によらず起点そのものである。 -/
def latticeEndpoint₀ {n : ℕ} (e : LatticeEdge n) : LatticeVertex n := e.1

/-- 辺の第二の端点。横の辺は第一座標を、縦の辺は第二座標を巡回的に一つ進める。 -/
def latticeEndpoint₁ {n : ℕ} [NeZero n] (e : LatticeEdge n) : LatticeVertex n :=
  if e.2 = 0 then (e.1.1 + 1, e.1.2) else (e.1.1, e.1.2 + 1)

/-- 頂点に接続する辺。二つの端点写像のいずれかが自分に等しい辺を集める。 -/
def latticeIncidentEdges {n : ℕ} [NeZero n] (v : LatticeVertex n) :
    Finset (LatticeEdge n) :=
  Finset.univ.filter (fun e => latticeEndpoint₀ e = v ∨ latticeEndpoint₁ e = v)

/-- 一辺 `n` の周期格子の辺は、各頂点を起点とする横辺と縦辺の二本ずつで、総数は `2n²`。 -/
theorem card_univ_latticeEdge (n : ℕ) :
    (Finset.univ : Finset (LatticeEdge n)).card = 2 * n ^ 2 := by
  simp [LatticeEdge, Nat.mul_comm, Nat.mul_assoc, pow_two]

/-- 接続辺は定義から端点条件を満たす。直前の定理が要求する仮定 `hIncident` にそのまま渡せる。 -/
theorem latticeIncident {n : ℕ} [NeZero n] (v : LatticeVertex n)
    (e : LatticeEdge n) (he : e ∈ latticeIncidentEdges v) :
    latticeEndpoint₀ e = v ∨ latticeEndpoint₁ e = v := by
  simpa [latticeIncidentEdges] using (Finset.mem_filter.mp he).2

/-- 各頂点を起点とする横辺と縦辺は、ともにその頂点へ接続し、相異なる。 -/
theorem outgoing_lattice_edges_mem_and_ne {n : ℕ} [NeZero n] (v : LatticeVertex n) :
    ((v, 0) : LatticeEdge n) ∈ latticeIncidentEdges v ∧
      ((v, 1) : LatticeEdge n) ∈ latticeIncidentEdges v ∧
      ((v, 0) : LatticeEdge n) ≠ (v, 1) := by
  simp [latticeIncidentEdges, latticeEndpoint₀]

/-- 各頂点へ入る横辺と縦辺は、ともにその頂点へ接続し、相異なる。 -/
theorem incoming_lattice_edges_mem_and_ne {n : ℕ} [NeZero n] (v : LatticeVertex n) :
    ((((v.1 - 1, v.2), 0)) : LatticeEdge n) ∈ latticeIncidentEdges v ∧
      ((((v.1, v.2 - 1), 1)) : LatticeEdge n) ∈ latticeIncidentEdges v ∧
      ((((v.1 - 1, v.2), 0)) : LatticeEdge n) ≠ (((v.1, v.2 - 1), 1)) := by
  simp [latticeIncidentEdges, latticeEndpoint₁]

/-- 一辺 `3` の周期格子では、どの頂点にも接続辺がちょうど四本ある。
横に二本（自分が起点のものと、左隣が起点のもの）、縦に二本である。 -/
theorem card_latticeIncidentEdges_eq_four_three (v : LatticeVertex 3) :
    (latticeIncidentEdges v).card = 4 := by
  revert v
  decide

/-- 一辺 `4` の周期格子でも同じ。周期の大きさによらないことの傍証である。 -/
theorem card_latticeIncidentEdges_eq_four_four (v : LatticeVertex 4) :
    (latticeIncidentEdges v).card = 4 := by
  revert v
  decide

/-- 一辺が二以上のとき、巡回座標を一つ戻すと元へは戻らない。
一辺が一のときはこれが破れる（`Fin 1` では全ての元が等しい）ので、
出る辺と入る辺が相異なることを言うには一辺が二以上という仮定が要る。 -/
theorem fin_sub_one_ne_self {n : ℕ} [NeZero n] (hn : 2 ≤ n) (x : Fin n) :
    x - 1 ≠ x := by
  intro h
  have h1 : (1 : Fin n) = 0 := sub_eq_self.mp h
  have hval : ((1 : Fin n) : ℕ) = ((0 : Fin n) : ℕ) := congrArg Fin.val h1
  simp [Nat.mod_eq_of_lt (show 1 < n by omega)] at hval

/-- 一辺が二以上なら、各頂点を起点とする横・縦の二辺と、各頂点へ入る横・縦の二辺は
四本とも相異なる。方向が違う組は方向成分で区別し、方向が同じ組は巡回座標で区別する。 -/
theorem four_incident_lattice_edges_pairwise_ne {n : ℕ} [NeZero n]
    (hn : 2 ≤ n) (v : LatticeVertex n) :
    ((v, 0) : LatticeEdge n) ≠ (v, 1) ∧
      ((v, 0) : LatticeEdge n) ≠ ((v.1 - 1, v.2), 0) ∧
      ((v, 0) : LatticeEdge n) ≠ ((v.1, v.2 - 1), 1) ∧
      ((v, 1) : LatticeEdge n) ≠ ((v.1 - 1, v.2), 0) ∧
      ((v, 1) : LatticeEdge n) ≠ ((v.1, v.2 - 1), 1) ∧
      ((((v.1 - 1, v.2), 0)) : LatticeEdge n) ≠ ((v.1, v.2 - 1), 1) := by
  constructor
  · simp
  constructor
  · intro h
    exact fin_sub_one_ne_self hn v.1 (congrArg (fun e : LatticeEdge n => e.1.1) h).symm
  constructor
  · simp
  constructor
  · simp
  constructor
  · intro h
    exact fin_sub_one_ne_self hn v.2 (congrArg (fun e : LatticeEdge n => e.1.2) h).symm
  · simp

/-- 接続辺は上の四本で尽きる。端点条件の場合分けで、起点が自分なら出る二辺、
第二の端点が自分なら巡回座標を一つ戻した入る二辺になる。 -/
theorem latticeIncidentEdges_subset_four {n : ℕ} [NeZero n] (v : LatticeVertex n) :
    latticeIncidentEdges v ⊆
      ({(v, 0), (v, 1), ((v.1 - 1, v.2), 0), ((v.1, v.2 - 1), 1)} :
        Finset (LatticeEdge n)) := by
  intro e he
  have h := latticeIncident v e he
  obtain ⟨⟨a, b⟩, d⟩ := e
  fin_cases d
  · rcases h with h | h
    · simp only [latticeEndpoint₀] at h
      simp [h]
    · simp only [latticeEndpoint₁] at h
      obtain ⟨h1, h2⟩ := Prod.mk.injEq .. ▸ h
      have ha : a = v.1 - 1 := eq_sub_of_add_eq h1
      simp [ha, h2]
  · rcases h with h | h
    · simp only [latticeEndpoint₀] at h
      simp [h]
    · simp only [latticeEndpoint₁] at h
      obtain ⟨h1, h2⟩ := Prod.mk.injEq .. ▸ h
      have hb : b = v.2 - 1 := eq_sub_of_add_eq h2
      simp [hb, h1]

/-- 四本は逆にすべて接続辺である。出る二辺と入る二辺の所属をそのまま集めるだけでよい。 -/
theorem four_lattice_edges_subset_incidentEdges {n : ℕ} [NeZero n] (v : LatticeVertex n) :
    ({(v, 0), (v, 1), ((v.1 - 1, v.2), 0), ((v.1, v.2 - 1), 1)} :
        Finset (LatticeEdge n)) ⊆ latticeIncidentEdges v := by
  obtain ⟨h₀, h₁, -⟩ := outgoing_lattice_edges_mem_and_ne v
  obtain ⟨h₂, h₃, -⟩ := incoming_lattice_edges_mem_and_ne v
  intro e he
  simp only [Finset.mem_insert, Finset.mem_singleton] at he
  rcases he with rfl | rfl | rfl | rfl
  · exact h₀
  · exact h₁
  · exact h₂
  · exact h₃

/-- 一辺が二以上なら、各頂点の接続辺はちょうど四本である。
両包含で接続辺集合が四本の集合に一致し、四本が相異なることから個数が四になる。 -/
theorem card_latticeIncidentEdges_eq_four {n : ℕ} [NeZero n] (hn : 2 ≤ n)
    (v : LatticeVertex n) : (latticeIncidentEdges v).card = 4 := by
  have hset : latticeIncidentEdges v =
      ({(v, 0), (v, 1), ((v.1 - 1, v.2), 0), ((v.1, v.2 - 1), 1)} :
        Finset (LatticeEdge n)) :=
    Finset.Subset.antisymm (latticeIncidentEdges_subset_four v)
      (four_lattice_edges_subset_incidentEdges v)
  obtain ⟨h01, h02, h03, h12, h13, h23⟩ := four_incident_lattice_edges_pairwise_ne hn v
  rw [hset]
  rw [Finset.card_insert_of_notMem (by simp [h01, h02, h03]),
    Finset.card_insert_of_notMem (by simp [h12, h13]),
    Finset.card_insert_of_notMem (by simp [h23]), Finset.card_singleton]

end Ising3DCut.Prediction
