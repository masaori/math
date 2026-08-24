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

/-- city の内部辺に属する端子は、その city の元頂点に属する。 -/
theorem terminal_of_mem_internalEdgeAt {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V)
    (s : Finset (Σ _ : V, Edge)) (hs : s ∈ internalEdgesAt incidentEdges v)
    (t : Σ _ : V, Edge) (ht : t ∈ s) :
    t.1 = v ∧ t.2 ∈ incidentEdges t.1 := by
  have htAt : t ∈ terminalsAt incidentEdges v :=
    ((mem_internalEdgesAt_iff incidentEdges v s).mp hs).1 ht
  exact (mem_terminalsAt_iff incidentEdges v t).mp htAt

/-- 同じ city の内部辺に属する二端子は、同じ元頂点に属する。
内部辺が端子を頂点ごとの組へ分けることを、後続の偶数性の証明で直接使う形に束ねる。 -/
theorem terminals_of_internalEdgeAt_have_same_vertex {V Edge : Type*}
    [DecidableEq V] [DecidableEq Edge]
    (incidentEdges : V → Finset Edge) (v : V)
    (s : Finset (Σ _ : V, Edge)) (hs : s ∈ internalEdgesAt incidentEdges v)
    (t u : Σ _ : V, Edge) (ht : t ∈ s) (hu : u ∈ s) :
    t.1 = u.1 := by
  have htVertex := (terminal_of_mem_internalEdgeAt incidentEdges v s hs t ht).1
  have huVertex := (terminal_of_mem_internalEdgeAt incidentEdges v s hs u hu).1
  exact htVertex.trans huVertex.symm

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


/-- 元の辺から外部辺への対応は単射である。外部辺の各端子が元の辺そのものを第二成分として
持っているため、外部辺の集合から元の辺が読み取れる（端点の相異なりは要らない）。 -/
theorem externalEdge_injective {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (endpoint₀ endpoint₁ : Edge → V) :
    Function.Injective (externalEdge (V := V) endpoint₀ endpoint₁) := by
  intro e f hef
  have hmem : (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ externalEdge endpoint₀ endpoint₁ e := by
    simp [externalEdge]
  rw [hef] at hmem
  have hmem' :
      (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₀ f, f⟩ ∨
        (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₁ f, f⟩ := by
    simpa [externalEdge, Finset.mem_insert, Finset.mem_singleton] using hmem
  rcases hmem' with h | h
  · exact congrArg Sigma.snd h
  · exact congrArg Sigma.snd h

/-- 完全マッチングのうち外部辺として選ばれたものに対応する元の辺の集合。 -/
def selectedOriginalEdges {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge))) : Finset Edge :=
  edges.filter fun e => externalEdge endpoint₀ endpoint₁ e ∈ matching

/-- 選ばれた元の辺を外部辺へ写した像は、完全マッチングと全外部辺の共通部分に等しい。 -/
theorem selectedOriginalEdges_image_externalEdge {V Edge : Type*}
    [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge))) :
    (selectedOriginalEdges edges endpoint₀ endpoint₁ matching).image
        (externalEdge endpoint₀ endpoint₁) =
      matching ∩ externalEdges edges endpoint₀ endpoint₁ := by
  ext s
  simp only [selectedOriginalEdges, Finset.mem_image, Finset.mem_inter,
    Finset.mem_filter, mem_externalEdges_iff]
  constructor
  · rintro ⟨e, ⟨he, hem⟩, rfl⟩
    exact ⟨hem, ⟨e, he, rfl⟩⟩
  · rintro ⟨hsm, ⟨e, he, hes⟩⟩
    refine ⟨e, ⟨he, ?_⟩, hes⟩
    simpa [hes] using hsm

/-- 完全マッチングで外部辺として選ばれなかった元の辺 `e` の端子は、
同じ city の内部辺によって覆われる。ここでは端点 `endpoint₀ e` 側を述べる。
端子の第二成分が元の辺 `e` 自身なので、別の元の辺の外部辺がこの端子を覆うことはない。 -/
theorem unselected_terminal_zero_is_covered_by_internal_edge {V Edge : Type*}
    [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (edges : Finset Edge) (incidentEdges : V → Finset Edge)
    (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge)))
    (hMatching : IsPerfectMatching
      (terminalVertices vertices incidentEdges)
      (terminalEdges vertices edges incidentEdges endpoint₀ endpoint₁) matching)
    (e : Edge) (he : e ∈ edges)
    (ht : (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ terminalVertices vertices incidentEdges)
    (hUnselected : e ∉ selectedOriginalEdges edges endpoint₀ endpoint₁ matching) :
    ∃ s ∈ matching,
      (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ s ∧
        s ∈ internalEdges vertices incidentEdges := by
  obtain ⟨s, ⟨hsm, hts⟩, _⟩ := hMatching.2 _ ht
  refine ⟨s, hsm, hts, ?_⟩
  have hsTerminal := hMatching.1 hsm
  rcases (mem_terminalEdges_iff vertices edges incidentEdges endpoint₀ endpoint₁ s).mp
      hsTerminal with hsInternal | hsExternal
  · exact hsInternal
  · exfalso
    obtain ⟨f, hf, hfs⟩ :=
      (mem_externalEdges_iff edges endpoint₀ endpoint₁ s).mp hsExternal
    have htExternalF :
        (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ externalEdge endpoint₀ endpoint₁ f := by
      simpa [hfs] using hts
    have hTerminalEq :
        (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₀ f, f⟩ ∨
          (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₁ f, f⟩ := by
      simpa [externalEdge, Finset.mem_insert, Finset.mem_singleton] using htExternalF
    have hef : e = f := by
      rcases hTerminalEq with h | h
      · exact congrArg Sigma.snd h
      · exact congrArg Sigma.snd h
    apply hUnselected
    rw [selectedOriginalEdges, Finset.mem_filter]
    refine ⟨he, ?_⟩
    rw [hef, hfs]
    exact hsm

/-- 完全マッチングで外部辺として選ばれなかった元の辺 `e` の
`endpoint₁ e` 側の端子も、同じ city の内部辺によって覆われる。 -/
theorem unselected_terminal_one_is_covered_by_internal_edge {V Edge : Type*}
    [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (edges : Finset Edge) (incidentEdges : V → Finset Edge)
    (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge)))
    (hMatching : IsPerfectMatching
      (terminalVertices vertices incidentEdges)
      (terminalEdges vertices edges incidentEdges endpoint₀ endpoint₁) matching)
    (e : Edge) (he : e ∈ edges)
    (ht : (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) ∈ terminalVertices vertices incidentEdges)
    (hUnselected : e ∉ selectedOriginalEdges edges endpoint₀ endpoint₁ matching) :
    ∃ s ∈ matching,
      (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) ∈ s ∧
        s ∈ internalEdges vertices incidentEdges := by
  obtain ⟨s, ⟨hsm, hts⟩, _⟩ := hMatching.2 _ ht
  refine ⟨s, hsm, hts, ?_⟩
  have hsTerminal := hMatching.1 hsm
  rcases (mem_terminalEdges_iff vertices edges incidentEdges endpoint₀ endpoint₁ s).mp
      hsTerminal with hsInternal | hsExternal
  · exact hsInternal
  · exfalso
    obtain ⟨f, hf, hfs⟩ :=
      (mem_externalEdges_iff edges endpoint₀ endpoint₁ s).mp hsExternal
    have htExternalF :
        (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) ∈ externalEdge endpoint₀ endpoint₁ f := by
      simpa [hfs] using hts
    have hTerminalEq :
        (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₀ f, f⟩ ∨
          (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) = ⟨endpoint₁ f, f⟩ := by
      simpa [externalEdge, Finset.mem_insert, Finset.mem_singleton] using htExternalF
    have hef : e = f := by
      rcases hTerminalEq with h | h
      · exact congrArg Sigma.snd h
      · exact congrArg Sigma.snd h
    apply hUnselected
    rw [selectedOriginalEdges, Finset.mem_filter]
    refine ⟨he, ?_⟩
    rw [hef, hfs]
    exact hsm

/-- 完全マッチングで外部辺として選ばれなかった元の辺では、両端子がそれぞれ
同じ city の内部辺によって覆われる。 -/
theorem unselected_terminals_are_covered_by_internal_edges {V Edge : Type*}
    [DecidableEq V] [DecidableEq Edge]
    (vertices : Finset V) (edges : Finset Edge) (incidentEdges : V → Finset Edge)
    (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge)))
    (hMatching : IsPerfectMatching
      (terminalVertices vertices incidentEdges)
      (terminalEdges vertices edges incidentEdges endpoint₀ endpoint₁) matching)
    (e : Edge) (he : e ∈ edges)
    (ht₀ : (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ terminalVertices vertices incidentEdges)
    (ht₁ : (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) ∈ terminalVertices vertices incidentEdges)
    (hUnselected : e ∉ selectedOriginalEdges edges endpoint₀ endpoint₁ matching) :
    (∃ s₀ ∈ matching,
      (⟨endpoint₀ e, e⟩ : Σ _ : V, Edge) ∈ s₀ ∧
        s₀ ∈ internalEdges vertices incidentEdges) ∧
    (∃ s₁ ∈ matching,
      (⟨endpoint₁ e, e⟩ : Σ _ : V, Edge) ∈ s₁ ∧
        s₁ ∈ internalEdges vertices incidentEdges) := by
  constructor
  · exact unselected_terminal_zero_is_covered_by_internal_edge
      vertices edges incidentEdges endpoint₀ endpoint₁ matching hMatching e he ht₀ hUnselected
  · exact unselected_terminal_one_is_covered_by_internal_edge
      vertices edges incidentEdges endpoint₀ endpoint₁ matching hMatching e he ht₁ hUnselected

/-- 完全マッチングから読み取る元の偶部分グラフ候補は、外部辺として選ばれなかった元の辺の集合である。 -/
def encodedEvenSubgraph {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge))) : Finset Edge :=
  edges \ selectedOriginalEdges edges endpoint₀ endpoint₁ matching

/-- 元の辺が復号した偶部分グラフ候補に属することは、その外部辺が完全マッチングに選ばれないことと同値。 -/
theorem mem_encodedEvenSubgraph_iff {V Edge : Type*} [DecidableEq V] [DecidableEq Edge]
    (edges : Finset Edge) (endpoint₀ endpoint₁ : Edge → V)
    (matching : Finset (Finset (Σ _ : V, Edge))) (e : Edge) :
    e ∈ encodedEvenSubgraph edges endpoint₀ endpoint₁ matching ↔
      e ∈ edges ∧ externalEdge endpoint₀ endpoint₁ e ∉ matching := by
  constructor
  · intro he
    obtain ⟨heEdges, heNotSelected⟩ := Finset.mem_sdiff.mp he
    refine ⟨heEdges, ?_⟩
    intro heExternal
    apply heNotSelected
    exact Finset.mem_filter.mpr ⟨heEdges, heExternal⟩
  · rintro ⟨heEdges, heExternal⟩
    apply Finset.mem_sdiff.mpr
    refine ⟨heEdges, ?_⟩
    intro heSelected
    exact heExternal (Finset.mem_filter.mp heSelected).2


end Ising3DCut.Prediction
