/-
本文 `claim_two_dimensional_boundary_response_pfaffian_prediction` の証明にある
「Fisher の terminal graph は、元のグラフの各頂点をそこに接続する辺の本数だけの
端子へ分解して作る」という段の Lean 具体版のうち、**頂点分解だけ**を置く段である。

これまでの段（`TerminalMatchingInternalWeight.lean`）は terminal graph の具体的な形を
使わず、重みの置き方だけで完全マッチングの重みを計算していた。完全マッチングと
偶部分グラフの全単射そのものを書くには、terminal graph の頂点集合が実際に
どう分解されているかが要る。ここではその分解を、元の頂点と「そこに接続する辺」の
組の集合として定義し、分解が交わりを持たないこと、および端子がどの頂点に属するかが第一成分だけで決まることを示す。
端子の総数が各頂点の接続辺の本数の有限和に等しいことは次の tick で足す（mathlib の
`Finset.sigma` の濃度の補題の名前が特定できず、この tick では閉じられなかった）。

内部辺の張り方（同じ頂点から出た端子どうしをどう結ぶか）と向き付けはここでは扱わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Finset.Sigma

namespace Ising3DCut.Prediction

open scoped BigOperators

/-- 元の頂点 `v` と、そこに接続する辺 `e` の組を端子と呼ぶ。
`incidentEdges v` は頂点 `v` に接続する辺の有限集合である。 -/
def terminalVertices {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (incidentEdges : V → Finset Edge) : Finset (Σ _ : V, Edge) :=
  vertices.sigma incidentEdges

/-- 端子が属する頂点は、その端子の第一成分である（分解は頂点ごとに交わらない）。 -/
theorem mem_terminalVertices_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (incidentEdges : V → Finset Edge) (t : Σ _ : V, Edge) :
    t ∈ terminalVertices vertices incidentEdges ↔
      t.1 ∈ vertices ∧ t.2 ∈ incidentEdges t.1 := by
  simp [terminalVertices, Finset.mem_sigma]

/-- 相異なる二つの頂点から出た端子は一致しない（頂点分解の交わりの無さ）。 -/
theorem terminalVertex_vertex_ne {V Edge : Type*}
    (v v' : V) (e e' : Edge) (hne : v ≠ v') :
    (⟨v, e⟩ : Σ _ : V, Edge) ≠ ⟨v', e'⟩ := by
  intro hEq
  exact hne (congrArg Sigma.fst hEq)

end Ising3DCut.Prediction
