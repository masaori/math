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
import Ising3DCut.Prediction.TerminalVertexDecomposition

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

/-- 一辺が二以上の周期正方格子では、terminal graph の完全マッチングから復号した
辺集合は各頂点で偶数本の接続辺を持つ。接続辺数四の具体計算を、一般の
完全マッチングからの偶部分グラフ定理へ接続したもの。 -/
theorem periodic_square_selected_edges_even
    {n : ℕ} [NeZero n] (hn : 2 ≤ n)
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (hMatching : IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁) matching)
    (hsub : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      matchingCoveredTerminalsAt latticeIncidentEdges v matching ⊆
        terminalsAt latticeIncidentEdges v)
    (hcard : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching, s.card = 2)
    (hdisj : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
      ∀ t ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
        s ≠ t → Disjoint s t) :
    ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      Even (selectedIncidentEdgesAt Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁ matching v).card := by
  apply forall_even_card_selected_of_card_incidentEdges_eq_four
    Finset.univ Finset.univ latticeIncidentEdges latticeEndpoint₀ latticeEndpoint₁
    matching hMatching
  · intro w f hf
    exact (Finset.mem_filter.mp hf).2
  · exact hsub
  · exact hcard
  · exact hdisj
  · intro v _
    exact card_latticeIncidentEdges_eq_four hn v

/-- 復号された辺集合のうち、周期正方格子の頂点 `v` に接続する辺。 -/
def periodicSquareEncodedIncidentEdgesAt
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (v : LatticeVertex n) : Finset (LatticeEdge n) :=
  latticeIncidentEdges v ∩
    encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching

/-- 一辺が二以上の周期正方格子では、完全マッチングから復号した辺集合そのものが
各頂点で偶数本の辺を持つ。選ばれなかった辺は全接続辺から選ばれた辺を除いた集合であり、
全接続辺数四と選ばれた辺数がともに偶数なので、その差も偶数である。 -/
theorem periodic_square_encoded_even_subgraph
    {n : ℕ} [NeZero n] (hn : 2 ≤ n)
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (hSelected : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      Even (selectedIncidentEdgesAt Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁ matching v).card) :
    ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      Even (periodicSquareEncodedIncidentEdgesAt matching v).card := by
  intro v hv
  have hset : periodicSquareEncodedIncidentEdgesAt matching v =
      latticeIncidentEdges v \
        selectedIncidentEdgesAt Finset.univ latticeIncidentEdges
          latticeEndpoint₀ latticeEndpoint₁ matching v := by
    ext e
    simp [periodicSquareEncodedIncidentEdgesAt, encodedEvenSubgraph,
      selectedIncidentEdgesAt, selectedOriginalEdges]
  have hsub : selectedIncidentEdgesAt Finset.univ latticeIncidentEdges
      latticeEndpoint₀ latticeEndpoint₁ matching v ⊆ latticeIncidentEdges v := by
    intro e he
    exact (Finset.mem_inter.mp he).1
  rw [hset, Finset.card_sdiff, Finset.inter_eq_left.mpr hsub,
    Nat.even_sub (Finset.card_le_card hsub)]
  rw [card_latticeIncidentEdges_eq_four hn v]
  norm_num [hSelected v hv]

/-- 周期正方格子の terminal graph の完全マッチングを、選ばれなかった外部辺として復号すると、
得られる元辺集合は偶部分グラフである。 -/
theorem periodic_square_matching_decodes_even_subgraph
    {n : ℕ} [NeZero n] (hn : 2 ≤ n)
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (hMatching : IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁) matching)
    (hsub : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      matchingCoveredTerminalsAt latticeIncidentEdges v matching ⊆
        terminalsAt latticeIncidentEdges v)
    (hcard : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching, s.card = 2)
    (hdisj : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
      ∀ t ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
        s ≠ t → Disjoint s t) :
    ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      Even (periodicSquareEncodedIncidentEdgesAt matching v).card :=
  periodic_square_encoded_even_subgraph hn matching
    (periodic_square_selected_edges_even hn matching hMatching hsub hcard hdisj)

/-- 周期正方格子の偶部分グラフ。元の辺集合と、各頂点での偶次数条件を一つの型に束ねる。 -/
def PeriodicSquareEvenSubgraph (n : ℕ) [NeZero n] :=
  {subgraph : Finset (LatticeEdge n) //
    ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      Even (latticeIncidentEdges v ∩ subgraph).card}

/-- terminal graph の完全マッチングを、周期正方格子の偶部分グラフへ復号する写像。 -/
noncomputable def decodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (hn : 2 ≤ n)
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (hMatching : IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁) matching)
    (hsub : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      matchingCoveredTerminalsAt latticeIncidentEdges v matching ⊆
        terminalsAt latticeIncidentEdges v)
    (hcard : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching, s.card = 2)
    (hdisj : ∀ v ∈ (Finset.univ : Finset (LatticeVertex n)),
      ∀ s ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
      ∀ t ∈ matchingInternalEdgesAt latticeIncidentEdges v matching,
        s ≠ t → Disjoint s t) :
    PeriodicSquareEvenSubgraph n :=
  ⟨encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching,
    periodic_square_matching_decodes_even_subgraph hn matching hMatching hsub hcard hdisj⟩

/-- 偶部分グラフから完全マッチングを復元するときに選ぶ外部辺の集合。
polygon に属さない元の辺だけを terminal graph の外部辺へ送る。 -/
noncomputable def encodePeriodicSquareExternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  (Finset.univ \ subgraph.1).image (externalEdge latticeEndpoint₀ latticeEndpoint₁)

/-- 復元用の外部辺に属することは、元の辺が偶部分グラフに属さないことと同値である。 -/
theorem mem_encodePeriodicSquareExternalEdges_iff
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (s : Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :
    s ∈ encodePeriodicSquareExternalEdges subgraph ↔
      ∃ e : LatticeEdge n, e ∉ subgraph.1 ∧
        externalEdge latticeEndpoint₀ latticeEndpoint₁ e = s := by
  simp [encodePeriodicSquareExternalEdges]

/-- 復元用の外部辺に覆われず、各 city で内部辺により覆うべき端子の集合。
端子に対応する元の辺が polygon に属する場合だけ残す。 -/
def encodePeriodicSquareRemainingTerminalsAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) : Finset (Σ _ : LatticeVertex n, LatticeEdge n) :=
  (terminalsAt latticeIncidentEdges v).filter (fun t => t.2 ∈ subgraph.1)

/-- city に残る端子であることは、その city に属し、対応する元の辺が polygon に
属することと同値である。 -/
theorem mem_encodePeriodicSquareRemainingTerminalsAt_iff
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) (t : Σ _ : LatticeVertex n, LatticeEdge n) :
    t ∈ encodePeriodicSquareRemainingTerminalsAt subgraph v ↔
      t ∈ terminalsAt latticeIncidentEdges v ∧ t.2 ∈ subgraph.1 := by
  simp [encodePeriodicSquareRemainingTerminalsAt]

/-- city に残る端子の個数は、その city の接続辺のうち polygon に属するものの個数に等しい。
端子の第二成分を取る対応が両向きに定まるので、個数はそのまま移る。 -/
theorem card_encodePeriodicSquareRemainingTerminalsAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    (encodePeriodicSquareRemainingTerminalsAt subgraph v).card
      = (latticeIncidentEdges v ∩ subgraph.1).card := by
  refine Finset.card_nbij' (fun t => t.2) (fun e => (⟨v, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n))
    ?_ ?_ ?_ ?_ <;>
    intro x hx <;>
    simp only [encodePeriodicSquareRemainingTerminalsAt, Finset.mem_filter, terminalsAt,
      Finset.mem_sigma, Finset.mem_singleton, Finset.mem_inter] at hx ⊢ <;>
    aesop

/-- 各 city に残る端子の個数は偶数である。偶部分グラフの偶次数条件をそのまま移したもの。 -/
theorem even_card_encodePeriodicSquareRemainingTerminalsAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    Even (encodePeriodicSquareRemainingTerminalsAt subgraph v).card := by
  rw [card_encodePeriodicSquareRemainingTerminalsAt]
  exact subgraph.2 v (Finset.mem_univ v)

/-- 偶部分グラフから内部辺を復元するとき、各 city で候補となる内部辺。
残存端子の二元部分集合だけを候補とする。次の段で、この候補から互いに
交わらず全端子を一度ずつ覆う集合を構成する。 -/
def encodePeriodicSquareCandidateInternalEdgesAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  (encodePeriodicSquareRemainingTerminalsAt subgraph v).powersetCard 2

/-- 復元用の候補内部辺であることは、残存端子だけからなる二元集合であることと同値である。
完全被覆の構成では、この特徴づけを使って各対が terminal graph の内部辺であることを確認する。 -/
theorem mem_encodePeriodicSquareCandidateInternalEdgesAt_iff
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) (s : Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :
    s ∈ encodePeriodicSquareCandidateInternalEdgesAt subgraph v ↔
      s ⊆ encodePeriodicSquareRemainingTerminalsAt subgraph v ∧ s.card = 2 := by
  simp [encodePeriodicSquareCandidateInternalEdgesAt]

end Ising3DCut.Prediction
