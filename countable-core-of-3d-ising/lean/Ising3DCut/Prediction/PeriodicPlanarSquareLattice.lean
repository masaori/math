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

end Ising3DCut.Prediction
