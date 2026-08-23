/-
本文 `claim_two_dimensional_boundary_response_pfaffian_prediction` の証明にある
「Fisher の terminal graph は、元のグラフの各頂点をそこに接続する辺の本数だけの
端子へ分解して作る」という段の Lean 具体版のうち、**頂点分解だけ**を置く段である。

これまでの段（`TerminalMatchingInternalWeight.lean`）は terminal graph の具体的な形を
使わず、重みの置き方だけで完全マッチングの重みを計算していた。完全マッチングと
偶部分グラフの全単射そのものを書くには、terminal graph の頂点集合が実際に
どう分解されているかが要る。ここではその分解を、元の頂点と「そこに接続する辺」の
組の集合として定義し、分解が交わりを持たないこと、および端子がどの頂点に属するかが第一成分だけで決まることを示す。
端子の総数が各頂点の接続辺の本数の有限和に等しいことも、この分解の濃度として示す。

内部辺の張り方は、同じ頂点に属する相異なる二端子の組として定義する。
向き付けはここでは扱わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
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

/-- 端子の総数は、各頂点に接続する辺の本数の有限和に等しい。 -/
theorem card_terminalVertices {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (incidentEdges : V → Finset Edge) :
    (terminalVertices vertices incidentEdges).card = ∑ v ∈ vertices, (incidentEdges v).card := by
  exact Finset.card_sigma vertices incidentEdges

/-- 頂点 `v` に属する端子の集合。頂点分解の `v` 成分である。 -/
def terminalsAt {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V) : Finset (Σ _ : V, Edge) :=
  ({v} : Finset V).sigma incidentEdges

/-- 頂点 `v` に属する端子であることは、第一成分が `v` で第二成分が `v` の接続辺であることと同値。 -/
theorem mem_terminalsAt_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V) (t : Σ _ : V, Edge) :
    t ∈ terminalsAt incidentEdges v ↔ t.1 = v ∧ t.2 ∈ incidentEdges t.1 := by
  simp [terminalsAt, Finset.mem_sigma]

/-- 頂点 `v` に属する端子の個数は、`v` に接続する辺の本数に等しい。 -/
theorem card_terminalsAt {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V) :
    (terminalsAt incidentEdges v).card = (incidentEdges v).card := by
  simp [terminalsAt, Finset.card_sigma]

/-- 頂点 `v` の city の内部辺は、`v` に属する相異なる二端子の組である。 -/
def internalEdgesAt {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V) : Finset (Finset (Σ _ : V, Edge)) :=
  (terminalsAt incidentEdges v).powersetCard 2

/-- 二端子の組が頂点 `v` の city の内部辺であるための条件。 -/
theorem mem_internalEdgesAt_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V) (s : Finset (Σ _ : V, Edge)) :
    s ∈ internalEdgesAt incidentEdges v ↔
      s ⊆ terminalsAt incidentEdges v ∧ s.card = 2 := by
  simp [internalEdgesAt]

/-- Terminal graph 全体の内部辺は、元の各頂点の city の内部辺を束ねた集合である。 -/
def internalEdges {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (incidentEdges : V → Finset Edge) :
    Finset (Finset (Σ _ : V, Edge)) :=
  vertices.biUnion (internalEdgesAt incidentEdges)

/-- 二端子の組が terminal graph の内部辺であることは、ある元頂点の city の内部辺であることと同値。 -/
theorem mem_internalEdges_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (incidentEdges : V → Finset Edge)
    (s : Finset (Σ _ : V, Edge)) :
    s ∈ internalEdges vertices incidentEdges ↔
      ∃ v ∈ vertices, s ∈ internalEdgesAt incidentEdges v := by
  simp [internalEdges]

/-- 元の辺 `e` に対応する外部辺は、`e` の二端点に属する二つの端子を結ぶ。 -/
def externalEdge {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (endpoint₀ endpoint₁ : Edge → V) (e : Edge) : Finset (Σ _ : V, Edge) :=
  {⟨endpoint₀ e, e⟩, ⟨endpoint₁ e, e⟩}

/-- Terminal graph 全体の外部辺は、元の各辺に対応する外部辺の像である。 -/
def externalEdges {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V) :
    Finset (Finset (Σ _ : V, Edge)) :=
  edges.image (externalEdge endpoint₀ endpoint₁)

/-- 二端子の組が外部辺であることは、ある元の辺に対応することと同値。 -/
theorem mem_externalEdges_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V)
    (s : Finset (Σ _ : V, Edge)) :
    s ∈ externalEdges edges endpoint₀ endpoint₁ ↔
      ∃ e ∈ edges, externalEdge endpoint₀ endpoint₁ e = s := by
  simp [externalEdges]

/-- Terminal graph の辺集合は、内部辺と外部辺の和である。 -/
def terminalEdges {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (edges : Finset Edge) (incidentEdges : V → Finset Edge)
    (endpoint₀ endpoint₁ : Edge → V) : Finset (Finset (Σ _ : V, Edge)) :=
  internalEdges vertices incidentEdges ∪ externalEdges edges endpoint₀ endpoint₁

/-- 二端子の組が terminal graph の辺であることは、内部辺であるか外部辺であることと同値。 -/
theorem mem_terminalEdges_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (edges : Finset Edge) (incidentEdges : V → Finset Edge)
    (endpoint₀ endpoint₁ : Edge → V) (s : Finset (Σ _ : V, Edge)) :
    s ∈ terminalEdges vertices edges incidentEdges endpoint₀ endpoint₁ ↔
      s ∈ internalEdges vertices incidentEdges ∨
        s ∈ externalEdges edges endpoint₀ endpoint₁ := by
  simp [terminalEdges]

/-- Terminal graph の完全マッチングは、辺集合の部分集合であって、
各端子をちょうど一つの選んだ辺が覆うものである。 -/
def IsPerfectMatching {Terminal : Type*} [DecidableEq Terminal]
    (vertices : Finset Terminal) (edges matching : Finset (Finset Terminal)) : Prop :=
  matching ⊆ edges ∧
    ∀ t ∈ vertices, ∃! e, e ∈ matching ∧ t ∈ e

/-- 完全マッチングに選ばれた相異なる二つの辺は、端子を共有しない。
端子がどちらにも属すると、その端子を覆う辺の一意性からその二つの辺が一致してしまう。
覆われる端子が `vertices` に属することは仮定として与える（一意性はそこでしか言えないため）。 -/
theorem IsPerfectMatching.not_mem_of_mem_of_ne {Terminal : Type*} [DecidableEq Terminal]
    (vertices : Finset Terminal) (edges matching : Finset (Finset Terminal))
    (hMatching : IsPerfectMatching vertices edges matching)
    {e f : Finset Terminal} (he : e ∈ matching) (hf : f ∈ matching) (hne : e ≠ f)
    {t : Terminal} (ht : t ∈ vertices) (hte : t ∈ e) : t ∉ f := by
  intro htf
  obtain ⟨_, hUnique⟩ := hMatching
  obtain ⟨_, _, hEq⟩ := hUnique t ht
  exact hne ((hEq e ⟨he, hte⟩).trans (hEq f ⟨hf, htf⟩).symm)

/-- 上と同じことを、二つの選んだ辺の共通部分が `vertices` の外にしか無い形で述べる。 -/
theorem IsPerfectMatching.disjoint_within_vertices {Terminal : Type*} [DecidableEq Terminal]
    (vertices : Finset Terminal) (edges matching : Finset (Finset Terminal))
    (hMatching : IsPerfectMatching vertices edges matching)
    {e f : Finset Terminal} (he : e ∈ matching) (hf : f ∈ matching) (hne : e ≠ f) :
    ∀ t ∈ vertices, t ∈ e → t ∉ f :=
  fun _ ht hte => hMatching.not_mem_of_mem_of_ne vertices edges matching he hf hne ht hte


end Ising3DCut.Prediction
