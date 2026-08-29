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



/-- 偶数個の端子は、互いに交わらない二元集合の族でちょうど一度ずつ覆える。
個数についての強い帰納法で、二つ取り除いては残りへ戻るだけの構成であり、
有限集合の外へ出る道具は使わない。次の段で、この族を各 city の内部辺として
terminal graph の完全マッチングへ組み上げる。 -/
theorem exists_pairing_of_even_card {α : Type*} [DecidableEq α]
    (s : Finset α) (hs : Even s.card) :
    ∃ P : Finset (Finset α),
      (∀ e ∈ P, e.card = 2) ∧ (P : Set (Finset α)).PairwiseDisjoint id ∧
        P.biUnion id = s := by
  classical
  induction s using Finset.strongInduction with
  | _ s ih =>
    rcases Finset.eq_empty_or_nonempty s with rfl | ⟨a, ha⟩
    · exact ⟨∅, by simp, by simp, by simp⟩
    · have hcard : 2 ≤ s.card := by
        rcases hs with ⟨k, hk⟩
        have : 0 < s.card := Finset.card_pos.mpr ⟨a, ha⟩
        omega
      have hb : (s.erase a).Nonempty := by
        rw [← Finset.card_pos, Finset.card_erase_of_mem ha]; omega
      obtain ⟨b, hbmem⟩ := hb
      set t := (s.erase a).erase b with ht
      have hts : t ⊂ s :=
        lt_of_le_of_lt (Finset.erase_subset _ _) (Finset.erase_ssubset ha)
      have hcardt : t.card = s.card - 2 := by
        rw [ht, Finset.card_erase_of_mem hbmem, Finset.card_erase_of_mem ha]
        omega
      have hte : Even t.card := by
        rcases hs with ⟨k, hk⟩; rw [hcardt]; exact ⟨k - 1, by omega⟩
      obtain ⟨P, hP2, hPd, hPu⟩ := ih t hts hte
      have hab : a ≠ b := fun h => (Finset.ne_of_mem_erase hbmem) h.symm
      have hanot : a ∉ t := by simp [ht, Finset.mem_erase]
      have hbnot : b ∉ t := by simp [ht, Finset.mem_erase]
      have hpairnot : ({a, b} : Finset α) ∉ P := by
        intro hmem
        have : a ∈ P.biUnion id := Finset.mem_biUnion.mpr ⟨_, hmem, by simp⟩
        rw [hPu] at this; exact hanot this
      refine ⟨insert {a, b} P, ?_, ?_, ?_⟩
      · intro e he
        rcases Finset.mem_insert.mp he with rfl | he
        · rw [Finset.card_insert_of_notMem (by simpa using hab)]; simp
        · exact hP2 e he
      · rw [Finset.coe_insert]
        refine Set.PairwiseDisjoint.insert hPd ?_
        intro e he _
        refine Finset.disjoint_left.mpr ?_
        intro x hx hxe
        have : x ∈ P.biUnion id := Finset.mem_biUnion.mpr ⟨e, he, hxe⟩
        rw [hPu] at this
        obtain h | h := Finset.mem_insert.mp hx
        · exact hanot (h ▸ this)
        · simp only [Finset.mem_singleton] at h; exact hbnot (h ▸ this)
      · rw [Finset.biUnion_insert, hPu, ht]
        ext x
        simp only [Finset.mem_union, Finset.mem_insert, Finset.mem_singleton,
          Finset.mem_erase, id]
        constructor
        · rintro ((rfl | rfl) | ⟨_, _, hx⟩)
          · exact ha
          · exact Finset.mem_of_mem_erase hbmem
          · exact hx
        · intro hx
          by_cases hxa : x = a
          · exact Or.inl (Or.inl hxa)
          by_cases hxb : x = b
          · exact Or.inl (Or.inr hxb)
          · exact Or.inr ⟨hxb, hxa, hx⟩

/-- 各 city の残存端子は、候補内部辺に属する互いに交わらない二元集合で
ちょうど一度ずつ覆える。一般の偶数有限集合の対分けを残存端子へ適用したもの。 -/
theorem exists_candidate_internal_edge_cover_at
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    ∃ P : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)),
      P ⊆ encodePeriodicSquareCandidateInternalEdgesAt subgraph v ∧
        (P : Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id ∧
          P.biUnion id = encodePeriodicSquareRemainingTerminalsAt subgraph v := by
  obtain ⟨P, hP2, hPd, hPu⟩ := exists_pairing_of_even_card
    (encodePeriodicSquareRemainingTerminalsAt subgraph v)
    (even_card_encodePeriodicSquareRemainingTerminalsAt subgraph v)
  refine ⟨P, ?_, hPd, hPu⟩
  intro e he
  rw [mem_encodePeriodicSquareCandidateInternalEdgesAt_iff]
  constructor
  · intro x hx
    have : x ∈ P.biUnion id := Finset.mem_biUnion.mpr ⟨e, he, hx⟩
    simpa [hPu] using this
  · exact hP2 e he

/-- 各 city について選んだ残存端子の完全被覆。存在定理から一つを選ぶ。 -/
noncomputable def encodePeriodicSquareInternalEdgesAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  Classical.choose (exists_candidate_internal_edge_cover_at subgraph v)

/-- 選んだ city 内被覆は候補内部辺だけからなる。 -/
theorem encodePeriodicSquareInternalEdgesAt_subset_candidates
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    encodePeriodicSquareInternalEdgesAt subgraph v ⊆
      encodePeriodicSquareCandidateInternalEdgesAt subgraph v :=
  (Classical.choose_spec (exists_candidate_internal_edge_cover_at subgraph v)).1

/-- 選んだ city 内被覆の相異なる二辺は端子を共有しない。
各端子をただ一度だけ覆うことの一意性側を、存在定理から取り出したもの。 -/
theorem pairwiseDisjoint_encodePeriodicSquareInternalEdgesAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    (encodePeriodicSquareInternalEdgesAt subgraph v :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id :=
  (Classical.choose_spec (exists_candidate_internal_edge_cover_at subgraph v)).2.1

/-- 選んだ city 内被覆は、その city の残存端子をちょうど覆う。 -/
theorem biUnion_encodePeriodicSquareInternalEdgesAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    (encodePeriodicSquareInternalEdgesAt subgraph v).biUnion id =
      encodePeriodicSquareRemainingTerminalsAt subgraph v :=
  (Classical.choose_spec (exists_candidate_internal_edge_cover_at subgraph v)).2.2

/-- 各 city で選んだ内部辺被覆を、terminal graph 全体の一つの内部辺集合へ束ねる。 -/
noncomputable def encodePeriodicSquareInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  Finset.univ.biUnion (encodePeriodicSquareInternalEdgesAt subgraph)

/-- 束ねた辺はすべて terminal graph の内部辺である。 -/
theorem encodePeriodicSquareInternalEdges_subset_internalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    encodePeriodicSquareInternalEdges subgraph ⊆
      internalEdges Finset.univ latticeIncidentEdges := by
  intro s hs
  obtain ⟨v, _, hsv⟩ := Finset.mem_biUnion.mp hs
  rw [mem_internalEdges_iff]
  refine ⟨v, Finset.mem_univ v, ?_⟩
  rw [mem_internalEdgesAt_iff]
  have hcand := encodePeriodicSquareInternalEdgesAt_subset_candidates subgraph v hsv
  rw [mem_encodePeriodicSquareCandidateInternalEdgesAt_iff] at hcand
  refine ⟨?_, hcand.2⟩
  intro t ht
  have hremaining := hcand.1 ht
  exact (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mp hremaining |>.1

/-- 束ねた内部辺の合併は、各 city に残る端子を全ての city にわたって集めたものに一致する。
city ごとの完全被覆を合併しただけなので、束ねても覆う端子は増減しない。 -/
theorem biUnion_encodePeriodicSquareInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    (encodePeriodicSquareInternalEdges subgraph).biUnion id =
      Finset.univ.biUnion (encodePeriodicSquareRemainingTerminalsAt subgraph) := by
  ext t
  constructor
  · intro ht
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp ht
    obtain ⟨v, hv, hsv⟩ := Finset.mem_biUnion.mp hs
    refine Finset.mem_biUnion.mpr ⟨v, hv, ?_⟩
    rw [← biUnion_encodePeriodicSquareInternalEdgesAt subgraph v]
    exact Finset.mem_biUnion.mpr ⟨s, hsv, hts⟩
  · intro ht
    obtain ⟨v, hv, htv⟩ := Finset.mem_biUnion.mp ht
    rw [← biUnion_encodePeriodicSquareInternalEdgesAt subgraph v] at htv
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp htv
    exact Finset.mem_biUnion.mpr
      ⟨s, Finset.mem_biUnion.mpr ⟨v, hv, hs⟩, hts⟩

/-- 束ねた内部辺の相異なる二辺は、異なる city に由来する場合も端子を共有しない。
共通端子があればその第一成分から二つの city が一致し、city 内の排他性へ戻る。 -/
theorem pairwiseDisjoint_encodePeriodicSquareInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    (encodePeriodicSquareInternalEdges subgraph :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id := by
  intro s₁ hs₁ s₂ hs₂ hne
  obtain ⟨v₁, _, hs₁v⟩ := Finset.mem_biUnion.mp hs₁
  obtain ⟨v₂, _, hs₂v⟩ := Finset.mem_biUnion.mp hs₂
  refine Finset.disjoint_left.mpr ?_
  intro t ht₁ ht₂
  have hcand₁ := encodePeriodicSquareInternalEdgesAt_subset_candidates subgraph v₁ hs₁v
  have hcand₂ := encodePeriodicSquareInternalEdgesAt_subset_candidates subgraph v₂ hs₂v
  rw [mem_encodePeriodicSquareCandidateInternalEdgesAt_iff] at hcand₁ hcand₂
  have hv₁ : t.1 = v₁ := by
    have ht := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v₁ t).mp
      (hcand₁.1 ht₁)
    have htcity : t.1 = v₁ ∧ t.2 ∈ latticeIncidentEdges t.1 := by
      simpa [terminalsAt] using ht.1
    exact htcity.1
  have hv₂ : t.1 = v₂ := by
    have ht := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v₂ t).mp
      (hcand₂.1 ht₂)
    have htcity : t.1 = v₂ ∧ t.2 ∈ latticeIncidentEdges t.1 := by
      simpa [terminalsAt] using ht.1
    exact htcity.1
  have hv : v₁ = v₂ := hv₁.symm.trans hv₂
  rw [← hv] at hs₂v
  have hd := pairwiseDisjoint_encodePeriodicSquareInternalEdgesAt subgraph v₁ hs₁v hs₂v hne
  exact Finset.disjoint_left.mp hd ht₁ ht₂

/-- 束ねた内部辺と復元用の外部辺は端子を共有しない。
内部辺の端子に対応する元の辺は polygon に属し、外部辺に対応する元の辺は
polygon の補集に属するので、共通端子があれば矛盾する。 -/
theorem disjoint_encodePeriodicSquareInternalEdges_externalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (s t : Finset (Σ _ : LatticeVertex n, LatticeEdge n))
    (hs : s ∈ encodePeriodicSquareInternalEdges subgraph)
    (ht : t ∈ encodePeriodicSquareExternalEdges subgraph) :
    Disjoint s t := by
  obtain ⟨v, _, hsv⟩ := Finset.mem_biUnion.mp hs
  obtain ⟨e, he, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph t).mp ht
  refine Finset.disjoint_left.mpr ?_
  intro x hxs hxe
  have hcand := encodePeriodicSquareInternalEdgesAt_subset_candidates subgraph v hsv
  rw [mem_encodePeriodicSquareCandidateInternalEdgesAt_iff] at hcand
  have hxsub : x.2 ∈ subgraph.1 :=
    (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v x).mp (hcand.1 hxs) |>.2
  have hx : x = ⟨latticeEndpoint₀ e, e⟩ ∨ x = ⟨latticeEndpoint₁ e, e⟩ := by
    simpa [externalEdge] using hxe
  rcases hx with rfl | rfl <;> exact he hxsub

/-- 偶部分グラフから復元する terminal graph の辺集合。各 city で選んだ内部辺と、
polygon に属さない元の辺に対応する外部辺を合わせる。 -/
noncomputable def encodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  encodePeriodicSquareInternalEdges subgraph ∪ encodePeriodicSquareExternalEdges subgraph

/-- 復元用に選んだ辺はすべて terminal graph の辺である。完全マッチング性のうち、
辺集合への包含だけを先に閉じる。 -/
theorem encodePeriodicSquareMatching_subset_terminalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    encodePeriodicSquareMatching subgraph ⊆
      terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁ := by
  intro s hs
  rw [encodePeriodicSquareMatching, Finset.mem_union] at hs
  rw [mem_terminalEdges_iff]
  rcases hs with hs | hs
  · exact Or.inl (encodePeriodicSquareInternalEdges_subset_internalEdges subgraph hs)
  · exact Or.inr (by
      obtain ⟨e, he, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s).mp hs
      rw [mem_externalEdges_iff]
      exact ⟨e, Finset.mem_univ e, rfl⟩)

/-- 復元した内部辺と外部辺を合わせると、terminal graph の全端子を覆う。
元の辺が polygon に属する端子は city 内部辺に、属さない端子は対応する
外部辺に覆われる。 -/
theorem biUnion_encodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    (encodePeriodicSquareMatching subgraph).biUnion id =
      terminalVertices Finset.univ latticeIncidentEdges := by
  ext t
  constructor
  · intro ht
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp ht
    rw [encodePeriodicSquareMatching, Finset.mem_union] at hs
    rcases hs with hs | hs
    · have htInternal : t ∈ (encodePeriodicSquareInternalEdges subgraph).biUnion id :=
        Finset.mem_biUnion.mpr ⟨s, hs, hts⟩
      rw [biUnion_encodePeriodicSquareInternalEdges] at htInternal
      obtain ⟨v, _, htv⟩ := Finset.mem_biUnion.mp htInternal
      have hrem := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mp htv
      rw [mem_terminalVertices_iff]
      have htcity : t.1 = v ∧ t.2 ∈ latticeIncidentEdges t.1 := by
        simpa [terminalsAt] using hrem.1
      exact ⟨Finset.mem_univ _, htcity.2⟩
    ·
      obtain ⟨e, _, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s).mp hs
      rw [mem_terminalVertices_iff]
      simp only [Finset.mem_univ, true_and]
      have htendpoint : t = ⟨latticeEndpoint₀ e, e⟩ ∨
          t = ⟨latticeEndpoint₁ e, e⟩ := by
        simpa [externalEdge] using hts
      rcases htendpoint with rfl | rfl <;> simp [latticeIncidentEdges]
  · intro ht
    rw [mem_terminalVertices_iff] at ht
    by_cases he : t.2 ∈ subgraph.1
    · rw [Finset.mem_biUnion]
      have htInternal : t ∈ (encodePeriodicSquareInternalEdges subgraph).biUnion id := by
        rw [biUnion_encodePeriodicSquareInternalEdges, Finset.mem_biUnion]
        refine ⟨t.1, Finset.mem_univ _, ?_⟩
        rw [mem_encodePeriodicSquareRemainingTerminalsAt_iff]
        exact ⟨by simpa [terminalsAt] using ht.2, he⟩
      obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp htInternal
      refine ⟨s, ?_, hts⟩
      rw [encodePeriodicSquareMatching, Finset.mem_union]
      exact Or.inl hs
    · rw [Finset.mem_biUnion]
      refine ⟨externalEdge latticeEndpoint₀ latticeEndpoint₁ t.2, ?_, ?_⟩
      · rw [encodePeriodicSquareMatching, Finset.mem_union]
        exact Or.inr ((mem_encodePeriodicSquareExternalEdges_iff subgraph _).mpr
          ⟨t.2, he, rfl⟩)
      · have hendpoint := latticeIncident t.1 t.2 ht.2
        rcases hendpoint with hendpoint | hendpoint <;>
          simp [externalEdge, hendpoint]

/-- 復元用の外部辺どうしは端子を共有しない。外部辺の端子は第二成分に元の辺そのものを
持つので、共通端子があれば元の辺が一致し、二つの外部辺も一致する。 -/
theorem pairwiseDisjoint_encodePeriodicSquareExternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    (encodePeriodicSquareExternalEdges subgraph :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id := by
  intro s₁ hs₁ s₂ hs₂ hne
  obtain ⟨e₁, _, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s₁).mp hs₁
  obtain ⟨e₂, _, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s₂).mp hs₂
  refine Finset.disjoint_left.mpr ?_
  intro x hx₁ hx₂
  have h₁ : x.2 = e₁ := by
    have hx : x = ⟨latticeEndpoint₀ e₁, e₁⟩ ∨ x = ⟨latticeEndpoint₁ e₁, e₁⟩ := by
      simpa [externalEdge] using hx₁
    rcases hx with rfl | rfl <;> rfl
  have h₂ : x.2 = e₂ := by
    have hx : x = ⟨latticeEndpoint₀ e₂, e₂⟩ ∨ x = ⟨latticeEndpoint₁ e₂, e₂⟩ := by
      simpa [externalEdge] using hx₂
    rcases hx with rfl | rfl <;> rfl
  exact hne (by rw [h₁.symm.trans h₂])

/-- 復元した辺集合全体の相異なる二辺は端子を共有しない。内部辺どうし・外部辺どうし・
内部辺と外部辺の三つの場合に分け、それぞれ既に示した排他性へ帰着する。 -/
theorem pairwiseDisjoint_encodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    (encodePeriodicSquareMatching subgraph :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id := by
  intro s₁ hs₁ s₂ hs₂ hne
  rw [Finset.mem_coe, encodePeriodicSquareMatching, Finset.mem_union] at hs₁ hs₂
  rcases hs₁ with hs₁ | hs₁ <;> rcases hs₂ with hs₂ | hs₂
  · exact pairwiseDisjoint_encodePeriodicSquareInternalEdges subgraph hs₁ hs₂ hne
  · exact disjoint_encodePeriodicSquareInternalEdges_externalEdges subgraph s₁ s₂ hs₁ hs₂
  · exact (disjoint_encodePeriodicSquareInternalEdges_externalEdges subgraph s₂ s₁
      hs₂ hs₁).symm
  · exact pairwiseDisjoint_encodePeriodicSquareExternalEdges subgraph hs₁ hs₂ hne

/-- 偶部分グラフから復元した辺集合は terminal graph の完全マッチングである。
辺集合への包含、全端子の被覆、相異なる辺の端子非共有を直前の三定理から束ねる。 -/
theorem encodePeriodicSquareMatching_isPerfectMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁)
      (encodePeriodicSquareMatching subgraph) := by
  constructor
  · exact encodePeriodicSquareMatching_subset_terminalEdges subgraph
  · intro t ht
    have htCovered : t ∈ (encodePeriodicSquareMatching subgraph).biUnion id := by
      rw [biUnion_encodePeriodicSquareMatching]
      exact ht
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp htCovered
    refine ⟨s, ⟨hs, hts⟩, ?_⟩
    intro u hu
    by_contra hne
    have hdisjoint := pairwiseDisjoint_encodePeriodicSquareMatching subgraph hs hu.1
      (fun hsu ↦ hne hsu.symm)
    exact (Finset.disjoint_left.mp hdisjoint hts hu.2)

/-- 復元した完全マッチングを復号すると、得られる辺集合は元の偶部分グラフに含まれる。
復号は外部辺がマッチングに選ばれない元の辺だけを残すのに対し、偶部分グラフに
属さない元の辺の外部辺は復元でそのまま選ばれているので、復号後には残らない。
逆向きの包含（元の偶部分グラフの辺が復号後にも残ること）は、外部辺が city 内部辺に
なりえないことを要するので、ここでは示さない。 -/
theorem encodedEvenSubgraph_encodePeriodicSquareMatching_subset
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁
        (encodePeriodicSquareMatching subgraph) ⊆ subgraph.1 := by
  intro e he
  have hnot := (mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
    (encodePeriodicSquareMatching subgraph) e).mp he |>.2
  by_contra hsub
  refine hnot ?_
  rw [encodePeriodicSquareMatching, Finset.mem_union]
  exact Or.inr ((mem_encodePeriodicSquareExternalEdges_iff subgraph _).mpr ⟨e, hsub, rfl⟩)

/-- 格子の辺には自己ループが無い（$n\ge2$）。第二の端点はどちらの向きでも
座標を一つ進めるので、第一の端点と一致すれば `Fin n` で `1 = 0` になる。 -/
theorem latticeEndpoint₀_ne_latticeEndpoint₁
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (e : LatticeEdge n) :
    latticeEndpoint₀ e ≠ latticeEndpoint₁ e := by
  have hone : (1 : Fin n) ≠ 0 := by
    intro h
    have : ((1 : Fin n) : ℕ) = ((0 : Fin n) : ℕ) := by rw [h]
    rw [Fin.val_one', Fin.val_zero, Nat.mod_eq_of_lt hn] at this
    exact one_ne_zero this
  intro h
  rw [latticeEndpoint₀, latticeEndpoint₁] at h
  by_cases h0 : e.2 = 0
  · rw [if_pos h0, Prod.ext_iff] at h
    exact hone (by simpa using (add_eq_left.mp h.1.symm))
  · rw [if_neg h0, Prod.ext_iff] at h
    exact hone (by simpa using (add_eq_left.mp h.2.symm))

/-- 復元用の外部辺は city 内部辺になりえない。内部辺の端子は第一成分がその city に
等しいので、外部辺が内部辺なら二つの端点が一致し、自己ループが無いことに反する。
これが復号の逆向きの包含で要る排他性である。 -/
theorem encodePeriodicSquareExternalEdges_not_mem_internalEdges
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    {s : Finset (Σ _ : LatticeVertex n, LatticeEdge n)}
    (hs : s ∈ encodePeriodicSquareExternalEdges subgraph) :
    s ∉ internalEdges Finset.univ latticeIncidentEdges := by
  obtain ⟨e, _, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s).mp hs
  intro hmem
  obtain ⟨v, _, hv⟩ := (mem_internalEdges_iff Finset.univ latticeIncidentEdges _).mp hmem
  have hsub := (mem_internalEdgesAt_iff latticeIncidentEdges v _).mp hv |>.1
  have h₀ : (⟨latticeEndpoint₀ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∈
      terminalsAt latticeIncidentEdges v := hsub (by simp [externalEdge])
  have h₁ : (⟨latticeEndpoint₁ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∈
      terminalsAt latticeIncidentEdges v := hsub (by simp [externalEdge])
  have e₀ : latticeEndpoint₀ e = v := (mem_terminalsAt_iff latticeIncidentEdges v _).mp h₀ |>.1
  have e₁ : latticeEndpoint₁ e = v := (mem_terminalsAt_iff latticeIncidentEdges v _).mp h₁ |>.1
  exact latticeEndpoint₀_ne_latticeEndpoint₁ hn e (e₀.trans e₁.symm)

/-- 外部辺は元の辺を第二成分に持つので、外部辺の一致は元の辺の一致を与える。 -/
theorem externalEdge_injective_lattice
    {n : ℕ} [NeZero n] {e f : LatticeEdge n}
    (h : externalEdge latticeEndpoint₀ latticeEndpoint₁ e =
      externalEdge latticeEndpoint₀ latticeEndpoint₁ f) : e = f := by
  have hmem : (⟨latticeEndpoint₀ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∈
      externalEdge latticeEndpoint₀ latticeEndpoint₁ f := by
    rw [← h]; simp [externalEdge]
  simp only [externalEdge, Finset.mem_insert, Finset.mem_singleton] at hmem
  rcases hmem with h₀ | h₁
  · exact congrArg Sigma.snd h₀
  · exact congrArg Sigma.snd h₁

/-- 元の辺に対応する外部辺は、どの city の内部辺にもなりえない。内部辺の端子は
第一成分がその city に等しいので、内部辺であれば辺の二端点が一致し、
自己ループが無いことに反する。 -/
theorem externalEdge_not_mem_internalEdges
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (e : LatticeEdge n) :
    externalEdge latticeEndpoint₀ latticeEndpoint₁ e ∉
      internalEdges Finset.univ latticeIncidentEdges := by
  intro hmem
  obtain ⟨v, _, hv⟩ := (mem_internalEdges_iff Finset.univ latticeIncidentEdges _).mp hmem
  have hsub := (mem_internalEdgesAt_iff latticeIncidentEdges v _).mp hv |>.1
  have h₀ : (⟨latticeEndpoint₀ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∈
      terminalsAt latticeIncidentEdges v := hsub (by simp [externalEdge])
  have h₁ : (⟨latticeEndpoint₁ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∈
      terminalsAt latticeIncidentEdges v := hsub (by simp [externalEdge])
  have e₀ : latticeEndpoint₀ e = v := (mem_terminalsAt_iff latticeIncidentEdges v _).mp h₀ |>.1
  have e₁ : latticeEndpoint₁ e = v := (mem_terminalsAt_iff latticeIncidentEdges v _).mp h₁ |>.1
  exact latticeEndpoint₀_ne_latticeEndpoint₁ hn e (e₀.trans e₁.symm)

/-- 復元した完全マッチングを復号すると、元の偶部分グラフの辺はすべて残る。
偶部分グラフの辺の外部辺は、復元の外部辺（偶部分グラフに属さない辺の像）には
外部辺の単射性から入らず、city の内部辺にもなりえないからである。 -/
theorem subset_encodedEvenSubgraph_encodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    subgraph.1 ⊆ encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁
      (encodePeriodicSquareMatching subgraph) := by
  intro e he
  refine (mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
    (encodePeriodicSquareMatching subgraph) e).mpr ⟨Finset.mem_univ e, ?_⟩
  intro hmem
  rw [encodePeriodicSquareMatching, Finset.mem_union] at hmem
  rcases hmem with hint | hext
  · exact externalEdge_not_mem_internalEdges hn e
      (encodePeriodicSquareInternalEdges_subset_internalEdges subgraph hint)
  · obtain ⟨f, hf, hfe⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph _).mp hext
    exact hf (externalEdge_injective_lattice hfe ▸ he)

/-- 偶部分グラフから完全マッチングを復元して辺集合を復号すると、元の辺集合に戻る。
直前の二つの包含を束ねた、全単射の片側の逆写像等式である。 -/
theorem encodedEvenSubgraph_encodePeriodicSquareMatching
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁
        (encodePeriodicSquareMatching subgraph) = subgraph.1 := by
  apply Finset.Subset.antisymm
  · exact encodedEvenSubgraph_encodePeriodicSquareMatching_subset subgraph
  · exact subset_encodedEvenSubgraph_encodePeriodicSquareMatching hn subgraph

/-- 復号写像の各偶部分グラフ上の繊維は空でない。復元した完全マッチングを証人に取り、
完全マッチング性と復号後の等式を直前の二定理から束ねる。繊維の個数を数える前段である。 -/
theorem exists_perfectMatching_decoding_to_subgraph
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    ∃ matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)),
      IsPerfectMatching
        (terminalVertices Finset.univ latticeIncidentEdges)
        (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
          latticeEndpoint₀ latticeEndpoint₁)
        matching ∧
      encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching = subgraph.1 := by
  exact ⟨encodePeriodicSquareMatching subgraph,
    encodePeriodicSquareMatching_isPerfectMatching subgraph,
    encodedEvenSubgraph_encodePeriodicSquareMatching hn subgraph⟩

/-- 偶部分グラフへ復号される完全マッチングの有限集合。繊維の個数公式の左辺を定める。 -/
noncomputable def periodicSquareDecodingFiber
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n) :
    Finset (Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))) := by
  classical
  exact Finset.univ.filter fun matching ↦
    IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁)
      matching ∧
    encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching = subgraph.1

/-- 復元した完全マッチングは、対応する復号繊維の元である。 -/
theorem encodePeriodicSquareMatching_mem_decodingFiber
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    encodePeriodicSquareMatching subgraph ∈ periodicSquareDecodingFiber subgraph := by
  simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ, true_and]
  exact ⟨encodePeriodicSquareMatching_isPerfectMatching subgraph,
    encodedEvenSubgraph_encodePeriodicSquareMatching hn subgraph⟩

/-- 復号繊維の完全マッチングから、一つの city に属する内部辺だけを取り出す。
繊維の元を city ごとの内部完全被覆の族へ分解する写像の各成分である。 -/
noncomputable def periodicSquareFiberInternalEdgesAt
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (v : LatticeVertex n) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) := by
  classical
  exact matching.filter fun s ↦ s ∈ internalEdgesAt latticeIncidentEdges v

/-- city ごとに取り出した辺は、元の完全マッチングとその city の内部辺集合の双方に属する。 -/
theorem mem_periodicSquareFiberInternalEdgesAt_iff
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (v : LatticeVertex n)
    (s : Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :
    s ∈ periodicSquareFiberInternalEdgesAt matching v ↔
      s ∈ matching ∧ s ∈ internalEdgesAt latticeIncidentEdges v := by
  simp [periodicSquareFiberInternalEdgesAt]

/-- 相異なる二つの city について、取り出した内部辺の集合は互いに素である。
内部辺は空でなく、その端子の第一成分が属する city を一意に定めるためである。
繊維の元を city ごとの族へ分解する写像が、辺を重複して数えないことを保証する。 -/
theorem disjoint_periodicSquareFiberInternalEdgesAt
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    {v w : LatticeVertex n} (hvw : v ≠ w) :
    Disjoint (periodicSquareFiberInternalEdgesAt matching v)
      (periodicSquareFiberInternalEdgesAt matching w) := by
  classical
  refine Finset.disjoint_left.mpr ?_
  intro s hsv hsw
  have hv := ((mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hsv).2
  have hw := ((mem_periodicSquareFiberInternalEdgesAt_iff matching w s).mp hsw).2
  have hcard : s.card = 2 :=
    ((mem_internalEdgesAt_iff latticeIncidentEdges v s).mp hv).2
  obtain ⟨t, ht⟩ : ∃ t, t ∈ s := Finset.card_pos.mp (by omega) |>.imp fun _ h ↦ h
  have htv : t.1 = v :=
    (terminal_of_mem_internalEdgeAt latticeIncidentEdges v s hv t ht).1
  have htw : t.1 = w :=
    (terminal_of_mem_internalEdgeAt latticeIncidentEdges w s hw t ht).1
  exact hvw (htv.symm.trans htw)

/-- city ごとに取り出した内部辺が覆う端子は、すべてその city の端子である。
完全被覆の主張のうち、覆う側が city の外へはみ出さないことを述べる一方の包含である。
内部辺の端子はその city の端子だけからなることによる。 -/
theorem biUnion_periodicSquareFiberInternalEdgesAt_subset_terminalsAt
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)))
    (v : LatticeVertex n) :
    (periodicSquareFiberInternalEdgesAt matching v).biUnion id ⊆
      terminalsAt latticeIncidentEdges v := by
  classical
  intro t ht
  obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp ht
  have hsInternal := ((mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hs).2
  exact ((mem_internalEdgesAt_iff latticeIncidentEdges v s).mp hsInternal).1 hts

/-- 復号繊維の完全マッチングでは、その city の残存端子がすべて city 内部辺に覆われる。
残存端子に対応する元の辺は復号後の偶部分グラフに属するため、その端子を覆う
マッチング辺は外部辺ではありえず、同じ city の内部辺でなければならない。 -/
theorem remainingTerminalsAt_subset_biUnion_periodicSquareFiberInternalEdgesAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    {matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching : matching ∈ periodicSquareDecodingFiber subgraph)
    (v : LatticeVertex n) :
    encodePeriodicSquareRemainingTerminalsAt subgraph v ⊆
      (periodicSquareFiberInternalEdgesAt matching v).biUnion id := by
  classical
  simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ,
    true_and] at hmatching
  intro t ht
  have htData := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mp ht
  have htVertex : t ∈ terminalVertices Finset.univ latticeIncidentEdges := by
    rw [mem_terminalVertices_iff]
    have htCity : t.1 = v ∧ t.2 ∈ latticeIncidentEdges t.1 := by
      simpa [terminalsAt] using htData.1
    exact ⟨Finset.mem_univ _, htCity.2⟩
  obtain ⟨s, hs, _⟩ := hmatching.1.2 t htVertex
  have hsTerminal := hmatching.1.1 hs.1
  rw [mem_terminalEdges_iff] at hsTerminal
  rcases hsTerminal with hsInternal | hsExternal
  · obtain ⟨w, _, hsw⟩ :=
      (mem_internalEdges_iff Finset.univ latticeIncidentEdges s).mp hsInternal
    have htw : t.1 = w :=
      (terminal_of_mem_internalEdgeAt latticeIncidentEdges w s hsw t hs.2).1
    have htv : t.1 = v :=
      (mem_terminalsAt_iff latticeIncidentEdges v t).mp htData.1 |>.1
    have hwv : w = v := htw.symm.trans htv
    rw [hwv] at hsw
    exact Finset.mem_biUnion.mpr
      ⟨s, (mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mpr
        ⟨hs.1, hsw⟩, hs.2⟩
  · obtain ⟨e, _, hse⟩ :=
      (mem_externalEdges_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁ s).mp hsExternal
    have hte : t.2 = e := by
      have htendpoint :
          t = (⟨latticeEndpoint₀ e, e⟩ : Σ _ : LatticeVertex n, LatticeEdge n) ∨
            t = ⟨latticeEndpoint₁ e, e⟩ := by
        rw [← hse] at hs
        simpa [externalEdge] using hs.2
      rcases htendpoint with h | h
      · exact congrArg Sigma.snd h
      · exact congrArg Sigma.snd h
    have heDecoded : e ∈ encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching := by
      rw [hmatching.2]
      simpa [hte] using htData.2
    exact False.elim (((mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
      matching e).mp heDecoded).2 (hse ▸ hs.1))

/-- 復号繊維の完全マッチングから city ごとに取り出した内部辺が覆う端子は、
その city の残存端子である。内部辺と同じ端子を覆う外部辺は完全マッチングの
一意性により選ばれず、したがって対応する元の辺は復号後の偶部分グラフに属する。 -/
theorem biUnion_periodicSquareFiberInternalEdgesAt_subset_remainingTerminalsAt
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    {matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching : matching ∈ periodicSquareDecodingFiber subgraph)
    (v : LatticeVertex n) :
    (periodicSquareFiberInternalEdgesAt matching v).biUnion id ⊆
      encodePeriodicSquareRemainingTerminalsAt subgraph v := by
  classical
  simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ,
    true_and] at hmatching
  intro t ht
  have htCity := biUnion_periodicSquareFiberInternalEdgesAt_subset_terminalsAt matching v ht
  refine (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mpr ⟨htCity, ?_⟩
  rw [← hmatching.2]
  refine (mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
    matching t.2).mpr ⟨Finset.mem_univ _, ?_⟩
  intro hExternal
  obtain ⟨s, hsComponent, hts⟩ := Finset.mem_biUnion.mp ht
  have hsData := (mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hsComponent
  have htVertex : t ∈ terminalVertices Finset.univ latticeIncidentEdges := by
    rw [mem_terminalVertices_iff]
    exact ⟨Finset.mem_univ _, (mem_terminalsAt_iff latticeIncidentEdges v t).mp htCity |>.2⟩
  have htExternal : t ∈ externalEdge latticeEndpoint₀ latticeEndpoint₁ t.2 := by
    have hIncident := (mem_terminalsAt_iff latticeIncidentEdges v t).mp htCity |>.2
    simp only [latticeIncidentEdges, Finset.mem_filter, Finset.mem_univ, true_and] at hIncident
    rcases hIncident with h₀ | h₁
    · exact Finset.mem_insert.mpr (Or.inl (Sigma.ext h₀.symm (by simp)))
    · exact Finset.mem_insert.mpr
        (Or.inr (Finset.mem_singleton.mpr (Sigma.ext h₁.symm (by simp))))
  have hne : s ≠ externalEdge latticeEndpoint₀ latticeEndpoint₁ t.2 := by
    have hsInternalGlobal : s ∈ internalEdges Finset.univ latticeIncidentEdges :=
      (mem_internalEdges_iff Finset.univ latticeIncidentEdges s).mpr
        ⟨v, Finset.mem_univ _, hsData.2⟩
    intro heq
    exact externalEdge_not_mem_internalEdges hn t.2 (heq ▸ hsInternalGlobal)
  exact hmatching.1.not_mem_of_mem_of_ne
    (terminalVertices Finset.univ latticeIncidentEdges)
    (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
      latticeEndpoint₀ latticeEndpoint₁)
    matching hsData.1 hExternal hne htVertex hts htExternal

/-- 復号繊維の完全マッチングから city ごとに取り出した内部辺が覆う端子の全体は、
その city の残存端子の全体にちょうど一致する。両向きの包含
（`biUnion_periodicSquareFiberInternalEdgesAt_subset_remainingTerminalsAt` と
`remainingTerminalsAt_subset_biUnion_periodicSquareFiberInternalEdgesAt`）を束ねる。 -/
theorem biUnion_periodicSquareFiberInternalEdgesAt_eq_remainingTerminalsAt
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    {matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching : matching ∈ periodicSquareDecodingFiber subgraph)
    (v : LatticeVertex n) :
    (periodicSquareFiberInternalEdgesAt matching v).biUnion id =
      encodePeriodicSquareRemainingTerminalsAt subgraph v :=
  Finset.Subset.antisymm
    (biUnion_periodicSquareFiberInternalEdgesAt_subset_remainingTerminalsAt
      hn subgraph hmatching v)
    (remainingTerminalsAt_subset_biUnion_periodicSquareFiberInternalEdgesAt
      subgraph hmatching v)

/-- 復号繊維の完全マッチングを一つの city へ制限すると、残存端子を二元集合で
重なりなくちょうど覆う対分けになる。繊維を city ごとの対分けの直積へ写す前段である。 -/
theorem periodicSquareFiberInternalEdgesAt_isPairing
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    {matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching : matching ∈ periodicSquareDecodingFiber subgraph)
    (v : LatticeVertex n) :
    (∀ s ∈ periodicSquareFiberInternalEdgesAt matching v, s.card = 2) ∧
      (periodicSquareFiberInternalEdgesAt matching v :
        Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id ∧
      (periodicSquareFiberInternalEdgesAt matching v).biUnion id =
        encodePeriodicSquareRemainingTerminalsAt subgraph v := by
  classical
  have hperfect : IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁)
      matching := by
    have hm := hmatching
    simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ,
      true_and] at hm
    exact hm.1
  refine ⟨?_, ?_,
    biUnion_periodicSquareFiberInternalEdgesAt_eq_remainingTerminalsAt
      hn subgraph hmatching v⟩
  · intro s hs
    exact ((mem_internalEdgesAt_iff latticeIncidentEdges v s).mp
      ((mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hs).2).2
  · intro s hs t ht hst
    refine Finset.disjoint_left.mpr ?_
    intro x hxs hxt
    have hsData := (mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hs
    have htData := (mem_periodicSquareFiberInternalEdgesAt_iff matching v t).mp ht
    have hxTerminal : x ∈ terminalVertices Finset.univ latticeIncidentEdges := by
      rw [mem_terminalVertices_iff]
      have hxCity := terminal_of_mem_internalEdgeAt latticeIncidentEdges v s
        hsData.2 x hxs
      exact ⟨Finset.mem_univ _, hxCity.2⟩
    exact hperfect.not_mem_of_mem_of_ne
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁)
      matching hsData.1 htData.1 hst hxTerminal hxs hxt

/-- city `v` の残存端子の対分けの全体。二元集合からなり、互いに素で、合併が
残存端子全体に一致するような有限族を集めた有限集合である。繊維を city ごとの
対分けの直積へ写す際の、行き先の側を与える。 -/
noncomputable def periodicSquarePairingsAt
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n) :
    Finset (Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))) := by
  classical
  exact Finset.univ.filter fun pairing ↦
    (∀ s ∈ pairing, s.card = 2) ∧
      (pairing : Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id ∧
      pairing.biUnion id = encodePeriodicSquareRemainingTerminalsAt subgraph v

/-- 対分けの全体に属することの言い換え。 -/
theorem mem_periodicSquarePairingsAt_iff
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (v : LatticeVertex n)
    (pairing : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))) :
    pairing ∈ periodicSquarePairingsAt subgraph v ↔
      (∀ s ∈ pairing, s.card = 2) ∧
        (pairing : Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id ∧
        pairing.biUnion id = encodePeriodicSquareRemainingTerminalsAt subgraph v := by
  classical
  simp [periodicSquarePairingsAt]

/-- 復号繊維の完全マッチングを city `v` へ制限したものは、その city の対分けの
全体に属する。`periodicSquareFiberInternalEdgesAt_isPairing` の三条件を、
対分けの全体の定義へそのまま移したものである。 -/
theorem periodicSquareFiberInternalEdgesAt_mem_pairingsAt
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    {matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching : matching ∈ periodicSquareDecodingFiber subgraph)
    (v : LatticeVertex n) :
    periodicSquareFiberInternalEdgesAt matching v ∈
      periodicSquarePairingsAt subgraph v :=
  (mem_periodicSquarePairingsAt_iff subgraph v _).mpr
    (periodicSquareFiberInternalEdgesAt_isPairing hn subgraph hmatching v)

/-- 復号繊維の一つの完全マッチングを、各 city の残存端子の対分けへ送る写像。
値が各 city の対分けの全体に属することは、直前の定理が保証する。 -/
noncomputable def periodicSquareFiberToPairingsProduct
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    {matching // matching ∈ periodicSquareDecodingFiber subgraph} →
      (v : LatticeVertex n) →
        {pairing // pairing ∈ periodicSquarePairingsAt subgraph v} :=
  fun matching v ↦
    ⟨periodicSquareFiberInternalEdgesAt matching.1 v,
      periodicSquareFiberInternalEdgesAt_mem_pairingsAt hn subgraph matching.2 v⟩

/-- 復号繊維から city ごとの対分けへの写像の `v` 成分は、元の完全マッチングを
city `v` の内部辺へ制限したものである。 -/
theorem periodicSquareFiberToPairingsProduct_apply
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n)
    (matching : {matching // matching ∈ periodicSquareDecodingFiber subgraph})
    (v : LatticeVertex n) :
    (periodicSquareFiberToPairingsProduct hn subgraph matching v).1 =
      periodicSquareFiberInternalEdgesAt matching.1 v :=
  rfl

/-- city ごとに指定した残存端子の対分けを、terminal graph 全体の内部辺集合へ束ねる。
復号繊維から対分けの直積への写像の全射性を示すため、像として指定された対分け族から
逆向きに完全マッチングを構成する最初の段である。 -/
noncomputable def periodicSquarePairingsProductInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  Finset.univ.biUnion fun v ↦ (pairings v).1

/-- city ごとに指定した対分けを束ねた各辺は、terminal graph の内部辺である。
対分けの被覆等式から各端子がその city の残存端子に属することを取り出し、
二元性と合わせて `internalEdgesAt` の二条件へ移す。 -/
theorem periodicSquarePairingsProductInternalEdges_subset_internalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    periodicSquarePairingsProductInternalEdges subgraph pairings ⊆
      internalEdges Finset.univ latticeIncidentEdges := by
  intro s hs
  obtain ⟨v, -, hsv⟩ := Finset.mem_biUnion.mp hs
  have hv := (mem_periodicSquarePairingsAt_iff subgraph v (pairings v).1).mp
    (pairings v).2
  rw [mem_internalEdges_iff]
  refine ⟨v, Finset.mem_univ v, ?_⟩
  rw [mem_internalEdgesAt_iff]
  refine ⟨?_, hv.1 s hsv⟩
  intro t hts
  have ht : t ∈ (pairings v).1.biUnion id :=
    Finset.mem_biUnion.mpr ⟨s, hsv, hts⟩
  rw [hv.2.2] at ht
  exact (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mp ht |>.1


/-- 完全マッチングのうち内部辺であるものの全体は、city ごとの制限を全 city にわたって
束ねたものにちょうど一致する。左から右は、内部辺が属する city を取り出して
その city の制限へ入れることによる。右から左は、city の制限が元の完全マッチングと
その city の内部辺の双方に属することによる。繊維から city ごとの対分けの直積への
写像が単射であることを示す第一段であり、内部辺の側が像から復元できることを述べる。 -/
theorem filter_internalEdges_eq_biUnion_periodicSquareFiberInternalEdgesAt
    {n : ℕ} [NeZero n]
    (matching : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))) :
    matching.filter (fun s ↦ s ∈ internalEdges Finset.univ latticeIncidentEdges) =
      Finset.univ.biUnion (fun v ↦ periodicSquareFiberInternalEdgesAt matching v) := by
  classical
  ext s
  constructor
  · intro hs
    obtain ⟨hsMatching, hsInternal⟩ := Finset.mem_filter.mp hs
    obtain ⟨v, -, hsv⟩ :=
      (mem_internalEdges_iff Finset.univ latticeIncidentEdges s).mp hsInternal
    exact Finset.mem_biUnion.mpr ⟨v, Finset.mem_univ v,
      (mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mpr ⟨hsMatching, hsv⟩⟩
  · intro hs
    obtain ⟨v, -, hsv⟩ := Finset.mem_biUnion.mp hs
    obtain ⟨hsMatching, hsAt⟩ :=
      (mem_periodicSquareFiberInternalEdgesAt_iff matching v s).mp hsv
    exact Finset.mem_filter.mpr ⟨hsMatching,
      (mem_internalEdges_iff Finset.univ latticeIncidentEdges s).mpr
        ⟨v, Finset.mem_univ v, hsAt⟩⟩

/-- 同じ偶部分グラフへ復号される二つの完全マッチングでは、外部辺の部分が一致する。
外部辺がマッチングに選ばれないことと、対応する元の辺が復号後の偶部分グラフに
属することが同値なので、共通の復号値が外部辺の側を一意に定める。繊維から city
ごとの対分けの直積への写像が単射であることを示す第二段である。 -/
theorem filter_externalEdges_eq_of_mem_periodicSquareDecodingFiber
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    {matching₁ matching₂ : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))}
    (hmatching₁ : matching₁ ∈ periodicSquareDecodingFiber subgraph)
    (hmatching₂ : matching₂ ∈ periodicSquareDecodingFiber subgraph) :
    matching₁.filter (fun s ↦ s ∈ externalEdges Finset.univ latticeEndpoint₀ latticeEndpoint₁) =
      matching₂.filter (fun s ↦ s ∈ externalEdges Finset.univ latticeEndpoint₀ latticeEndpoint₁) := by
  classical
  simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ,
    true_and] at hmatching₁ hmatching₂
  ext s
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨hsMatching₁, hsExternal⟩
    obtain ⟨e, -, rfl⟩ :=
      (mem_externalEdges_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁ s).mp hsExternal
    have heDecoded : e ∉ subgraph.1 := by
      rw [← hmatching₁.2]
      exact fun he ↦ ((mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀
        latticeEndpoint₁ matching₁ e).mp he).2 hsMatching₁
    have hsMatching₂ : externalEdge latticeEndpoint₀ latticeEndpoint₁ e ∈ matching₂ := by
      by_contra hnot
      have he : e ∈ encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching₂ :=
        (mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
          matching₂ e).mpr ⟨Finset.mem_univ e, hnot⟩
      exact heDecoded (hmatching₂.2 ▸ he)
    exact ⟨hsMatching₂,
      (mem_externalEdges_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁ _).mpr
        ⟨e, Finset.mem_univ e, rfl⟩⟩
  · rintro ⟨hsMatching₂, hsExternal⟩
    obtain ⟨e, -, rfl⟩ :=
      (mem_externalEdges_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁ s).mp hsExternal
    have heDecoded : e ∉ subgraph.1 := by
      rw [← hmatching₂.2]
      exact fun he ↦ ((mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀
        latticeEndpoint₁ matching₂ e).mp he).2 hsMatching₂
    have hsMatching₁ : externalEdge latticeEndpoint₀ latticeEndpoint₁ e ∈ matching₁ := by
      by_contra hnot
      have he : e ∈ encodedEvenSubgraph Finset.univ latticeEndpoint₀ latticeEndpoint₁ matching₁ :=
        (mem_encodedEvenSubgraph_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁
          matching₁ e).mpr ⟨Finset.mem_univ e, hnot⟩
      exact heDecoded (hmatching₁.2 ▸ he)
    exact ⟨hsMatching₁,
      (mem_externalEdges_iff Finset.univ latticeEndpoint₀ latticeEndpoint₁ _).mpr
        ⟨e, Finset.mem_univ e, rfl⟩⟩

/-- 復号繊維から city ごとの対分けの直積への写像は単射である。像が一致すれば、
内部辺の側は各 city の制限の合併として復元でき（第一段）、外部辺の側は共通の
復号値から一意に定まる（第二段）。完全マッチングの辺はいずれか一方なので、
二つの完全マッチングは一致する。全単射性の主張のうち単射性を閉じたものである。 -/
theorem periodicSquareFiberToPairingsProduct_injective
    {n : ℕ} [NeZero n] (hn : 2 ≤ n) (subgraph : PeriodicSquareEvenSubgraph n) :
    Function.Injective (periodicSquareFiberToPairingsProduct hn subgraph) := by
  classical
  rintro ⟨m₁, hm₁⟩ ⟨m₂, hm₂⟩ h
  have hInternalAt : ∀ v : LatticeVertex n,
      periodicSquareFiberInternalEdgesAt m₁ v = periodicSquareFiberInternalEdgesAt m₂ v := by
    intro v
    have hv := congrFun h v
    simpa [periodicSquareFiberToPairingsProduct, Subtype.ext_iff] using hv
  have hIn : m₁.filter (fun s ↦ s ∈ internalEdges Finset.univ latticeIncidentEdges)
      = m₂.filter (fun s ↦ s ∈ internalEdges Finset.univ latticeIncidentEdges) := by
    rw [filter_internalEdges_eq_biUnion_periodicSquareFiberInternalEdgesAt,
      filter_internalEdges_eq_biUnion_periodicSquareFiberInternalEdgesAt]
    exact Finset.biUnion_congr rfl (fun v _ => hInternalAt v)
  have hOut := filter_externalEdges_eq_of_mem_periodicSquareDecodingFiber subgraph hm₁ hm₂
  have hsub : ∀ {m : Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n))},
      m ∈ periodicSquareDecodingFiber subgraph → ∀ s ∈ m,
        s ∈ internalEdges Finset.univ latticeIncidentEdges ∨
          s ∈ externalEdges Finset.univ latticeEndpoint₀ latticeEndpoint₁ := by
    intro m hm s hs
    simp only [periodicSquareDecodingFiber, Finset.mem_filter, Finset.mem_univ,
      true_and] at hm
    exact (mem_terminalEdges_iff Finset.univ Finset.univ latticeIncidentEdges
      latticeEndpoint₀ latticeEndpoint₁ s).mp (hm.1.1 hs)
  refine Subtype.ext ?_
  ext s
  constructor
  · intro hs
    rcases hsub hm₁ s hs with hint | hext
    · have : s ∈ m₂.filter (fun s ↦ s ∈ internalEdges Finset.univ latticeIncidentEdges) := by
        rw [← hIn]; exact Finset.mem_filter.mpr ⟨hs, hint⟩
      exact (Finset.mem_filter.mp this).1
    · have : s ∈ m₂.filter
          (fun s ↦ s ∈ externalEdges Finset.univ latticeEndpoint₀ latticeEndpoint₁) := by
        rw [← hOut]; exact Finset.mem_filter.mpr ⟨hs, hext⟩
      exact (Finset.mem_filter.mp this).1
  · intro hs
    rcases hsub hm₂ s hs with hint | hext
    · have : s ∈ m₁.filter (fun s ↦ s ∈ internalEdges Finset.univ latticeIncidentEdges) := by
        rw [hIn]; exact Finset.mem_filter.mpr ⟨hs, hint⟩
      exact (Finset.mem_filter.mp this).1
    · have : s ∈ m₁.filter
          (fun s ↦ s ∈ externalEdges Finset.univ latticeEndpoint₀ latticeEndpoint₁) := by
        rw [hOut]; exact Finset.mem_filter.mpr ⟨hs, hext⟩
      exact (Finset.mem_filter.mp this).1

/-- city ごとに指定した対分けを束ねた内部辺集合に、偶部分グラフの polygon に属さない辺の
外部辺を合わせた terminal graph の辺集合。復号繊維から対分けの直積への写像の全射性を
示すため、指定された対分け族から逆向きに完全マッチングの候補を構成する第二段である。 -/
noncomputable def periodicSquarePairingsProductMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    Finset (Finset (Σ _ : LatticeVertex n, LatticeEdge n)) :=
  periodicSquarePairingsProductInternalEdges subgraph pairings ∪
    encodePeriodicSquareExternalEdges subgraph

/-- 指定された対分け族から構成した候補の辺は、すべて terminal graph の辺である。
内部辺の側は直前の包含から、外部辺の側は外部辺の定義から従う。完全マッチング性のうち、
辺集合への包含だけを先に閉じる。 -/
theorem periodicSquarePairingsProductMatching_subset_terminalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    periodicSquarePairingsProductMatching subgraph pairings ⊆
      terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁ := by
  intro s hs
  rw [periodicSquarePairingsProductMatching, Finset.mem_union] at hs
  rw [mem_terminalEdges_iff]
  rcases hs with hs | hs
  · exact Or.inl
      (periodicSquarePairingsProductInternalEdges_subset_internalEdges subgraph pairings hs)
  · refine Or.inr ?_
    obtain ⟨e, he, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s).mp hs
    rw [mem_externalEdges_iff]
    exact ⟨e, Finset.mem_univ e, rfl⟩

/-- 指定した対分けを束ねた内部辺は、全 city の残存端子をちょうど覆う。 -/
theorem biUnion_periodicSquarePairingsProductInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    (periodicSquarePairingsProductInternalEdges subgraph pairings).biUnion id =
      Finset.univ.biUnion (encodePeriodicSquareRemainingTerminalsAt subgraph) := by
  ext t
  simp only [periodicSquarePairingsProductInternalEdges, Finset.mem_biUnion]
  constructor
  · rintro ⟨s, ⟨v, hv, hsv⟩, hts⟩
    refine ⟨v, hv, ?_⟩
    have hp := (mem_periodicSquarePairingsAt_iff subgraph v (pairings v).1).mp
      (pairings v).2
    rw [← hp.2.2]
    exact Finset.mem_biUnion.mpr ⟨s, hsv, hts⟩
  · rintro ⟨v, hv, htv⟩
    have hp := (mem_periodicSquarePairingsAt_iff subgraph v (pairings v).1).mp
      (pairings v).2
    rw [← hp.2.2] at htv
    obtain ⟨s, hsv, hts⟩ := Finset.mem_biUnion.mp htv
    exact ⟨s, ⟨v, hv, hsv⟩, hts⟩

/-- 指定した対分けを全 city にわたって束ねても、相異なる内部辺は端子を共有しない。 -/
theorem pairwiseDisjoint_periodicSquarePairingsProductInternalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    (periodicSquarePairingsProductInternalEdges subgraph pairings :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id := by
  intro s₁ hs₁ s₂ hs₂ hne
  obtain ⟨v₁, _, hs₁v⟩ := Finset.mem_biUnion.mp hs₁
  obtain ⟨v₂, _, hs₂v⟩ := Finset.mem_biUnion.mp hs₂
  refine Finset.disjoint_left.mpr ?_
  intro t ht₁ ht₂
  have hp₁ := (mem_periodicSquarePairingsAt_iff subgraph v₁ (pairings v₁).1).mp
    (pairings v₁).2
  have hp₂ := (mem_periodicSquarePairingsAt_iff subgraph v₂ (pairings v₂).1).mp
    (pairings v₂).2
  have htRem₁ : t ∈ encodePeriodicSquareRemainingTerminalsAt subgraph v₁ := by
    rw [← hp₁.2.2]
    exact Finset.mem_biUnion.mpr ⟨s₁, hs₁v, ht₁⟩
  have htRem₂ : t ∈ encodePeriodicSquareRemainingTerminalsAt subgraph v₂ := by
    rw [← hp₂.2.2]
    exact Finset.mem_biUnion.mpr ⟨s₂, hs₂v, ht₂⟩
  have hv₁ : t.1 = v₁ := by
    have hcity := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v₁ t).mp
      htRem₁ |>.1
    have hcity' : t.1 = v₁ ∧ t.2 ∈ latticeIncidentEdges t.1 := by
      simpa [terminalsAt] using hcity
    exact hcity'.1
  have hv₂ : t.1 = v₂ := by
    have hcity := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v₂ t).mp
      htRem₂ |>.1
    have hcity' : t.1 = v₂ ∧ t.2 ∈ latticeIncidentEdges t.1 := by
      simpa [terminalsAt] using hcity
    exact hcity'.1
  have hv : v₁ = v₂ := hv₁.symm.trans hv₂
  rw [← hv] at hs₂v
  exact Finset.disjoint_left.mp (hp₁.2.1 hs₁v hs₂v hne) ht₁ ht₂

/-- 指定対分けの内部辺と、polygon に属さない辺の外部辺は端子を共有しない。 -/
theorem disjoint_periodicSquarePairingsProductInternalEdges_externalEdges
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v})
    (s t : Finset (Σ _ : LatticeVertex n, LatticeEdge n))
    (hs : s ∈ periodicSquarePairingsProductInternalEdges subgraph pairings)
    (ht : t ∈ encodePeriodicSquareExternalEdges subgraph) :
    Disjoint s t := by
  obtain ⟨v, _, hsv⟩ := Finset.mem_biUnion.mp hs
  obtain ⟨e, he, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph t).mp ht
  refine Finset.disjoint_left.mpr ?_
  intro x hxs hxe
  have hp := (mem_periodicSquarePairingsAt_iff subgraph v (pairings v).1).mp
    (pairings v).2
  have hxRem : x ∈ encodePeriodicSquareRemainingTerminalsAt subgraph v := by
    rw [← hp.2.2]
    exact Finset.mem_biUnion.mpr ⟨s, hsv, hxs⟩
  have hxsub : x.2 ∈ subgraph.1 :=
    (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v x).mp hxRem |>.2
  have hx : x = ⟨latticeEndpoint₀ e, e⟩ ∨ x = ⟨latticeEndpoint₁ e, e⟩ := by
    simpa [externalEdge] using hxe
  rcases hx with rfl | rfl <;> exact he hxsub

/-- 指定対分けから構成した候補の相異なる二辺は端子を共有しない。 -/
theorem pairwiseDisjoint_periodicSquarePairingsProductMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    (periodicSquarePairingsProductMatching subgraph pairings :
      Set (Finset (Σ _ : LatticeVertex n, LatticeEdge n))).PairwiseDisjoint id := by
  intro s₁ hs₁ s₂ hs₂ hne
  rw [Finset.mem_coe, periodicSquarePairingsProductMatching, Finset.mem_union] at hs₁ hs₂
  rcases hs₁ with hs₁ | hs₁ <;> rcases hs₂ with hs₂ | hs₂
  · exact pairwiseDisjoint_periodicSquarePairingsProductInternalEdges subgraph pairings
      hs₁ hs₂ hne
  · exact disjoint_periodicSquarePairingsProductInternalEdges_externalEdges subgraph
      pairings s₁ s₂ hs₁ hs₂
  · exact (disjoint_periodicSquarePairingsProductInternalEdges_externalEdges subgraph
      pairings s₂ s₁ hs₂ hs₁).symm
  · exact pairwiseDisjoint_encodePeriodicSquareExternalEdges subgraph hs₁ hs₂ hne

/-- 指定対分けから構成した候補は terminal graph の全端子を覆う。 -/
theorem biUnion_periodicSquarePairingsProductMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    (periodicSquarePairingsProductMatching subgraph pairings).biUnion id =
      terminalVertices Finset.univ latticeIncidentEdges := by
  ext t
  constructor
  · intro ht
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp ht
    rw [periodicSquarePairingsProductMatching, Finset.mem_union] at hs
    rcases hs with hs | hs
    · have htInternal :
          t ∈ (periodicSquarePairingsProductInternalEdges subgraph pairings).biUnion id :=
        Finset.mem_biUnion.mpr ⟨s, hs, hts⟩
      rw [biUnion_periodicSquarePairingsProductInternalEdges] at htInternal
      obtain ⟨v, _, htv⟩ := Finset.mem_biUnion.mp htInternal
      rw [mem_terminalVertices_iff]
      have hrem := (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph v t).mp htv
      have htcity : t.1 = v ∧ t.2 ∈ latticeIncidentEdges t.1 := by
        simpa [terminalsAt] using hrem.1
      exact ⟨Finset.mem_univ _, htcity.2⟩
    · obtain ⟨e, _, rfl⟩ := (mem_encodePeriodicSquareExternalEdges_iff subgraph s).mp hs
      rw [mem_terminalVertices_iff]
      simp only [Finset.mem_univ, true_and]
      have htendpoint : t = ⟨latticeEndpoint₀ e, e⟩ ∨
          t = ⟨latticeEndpoint₁ e, e⟩ := by
        simpa [externalEdge] using hts
      rcases htendpoint with rfl | rfl <;> simp [latticeIncidentEdges]
  · intro ht
    rw [mem_terminalVertices_iff] at ht
    by_cases he : t.2 ∈ subgraph.1
    · have htInternal :
          t ∈ (periodicSquarePairingsProductInternalEdges subgraph pairings).biUnion id := by
        rw [biUnion_periodicSquarePairingsProductInternalEdges, Finset.mem_biUnion]
        exact ⟨t.1, Finset.mem_univ _,
          (mem_encodePeriodicSquareRemainingTerminalsAt_iff subgraph t.1 t).mpr
            ⟨by simpa [terminalsAt] using ht.2, he⟩⟩
      obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp htInternal
      exact Finset.mem_biUnion.mpr ⟨s,
        Finset.mem_union.mpr (Or.inl hs), hts⟩
    · refine Finset.mem_biUnion.mpr
        ⟨externalEdge latticeEndpoint₀ latticeEndpoint₁ t.2, ?_, ?_⟩
      · exact Finset.mem_union.mpr (Or.inr
          ((mem_encodePeriodicSquareExternalEdges_iff subgraph _).mpr ⟨t.2, he, rfl⟩))
      · have hendpoint := latticeIncident t.1 t.2 ht.2
        rcases hendpoint with hendpoint | hendpoint <;>
          simp [externalEdge, hendpoint]

/-- city ごとの指定対分けから構成した候補は terminal graph の完全マッチングである。 -/
theorem periodicSquarePairingsProductMatching_isPerfectMatching
    {n : ℕ} [NeZero n] (subgraph : PeriodicSquareEvenSubgraph n)
    (pairings : (v : LatticeVertex n) →
      {pairing // pairing ∈ periodicSquarePairingsAt subgraph v}) :
    IsPerfectMatching
      (terminalVertices Finset.univ latticeIncidentEdges)
      (terminalEdges Finset.univ Finset.univ latticeIncidentEdges
        latticeEndpoint₀ latticeEndpoint₁)
      (periodicSquarePairingsProductMatching subgraph pairings) := by
  constructor
  · exact periodicSquarePairingsProductMatching_subset_terminalEdges subgraph pairings
  · intro t ht
    have htCovered : t ∈ (periodicSquarePairingsProductMatching subgraph pairings).biUnion id := by
      rw [biUnion_periodicSquarePairingsProductMatching]
      exact ht
    obtain ⟨s, hs, hts⟩ := Finset.mem_biUnion.mp htCovered
    refine ⟨s, ⟨hs, hts⟩, ?_⟩
    intro u hu
    by_contra hne
    have hdisjoint := pairwiseDisjoint_periodicSquarePairingsProductMatching subgraph
      pairings hs hu.1 (fun hsu ↦ hne hsu.symm)
    exact (Finset.disjoint_left.mp hdisjoint hts hu.2)

end Ising3DCut.Prediction
