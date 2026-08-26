/-
章「近傍割り当ての包含順序と合成の単調性」の Lean 具体版。
人手証明の正本は
structured-latex/content/ordered-neighborhood-assignment-monoid.ts。

対応表（人手証明 → この file）
  def_neighborhood_assignment_pointwise_inclusion
    `PointwiseInclusion`
  claim_neighborhood_assignment_pointwise_inclusion_partial_order
    `pointwiseInclusion_refl`, `pointwiseInclusion_antisymm`,
    `pointwiseInclusion_trans`
  claim_composed_neighborhood_monotone
    `composedNeighborhood_monotone`
  claim_neighborhood_assignment_pointwise_inclusion_finite_decidable
    `inclusionScan`, `pointwiseInclusion_iff_scan`, `card_inclusionScan`
  claim_finite_neighborhood_assignments_form_ordered_monoid
    `finite_ordered_monoid_properties`

必要十分版は NecSuf/OrderedNeighborhoodAssignmentMonoid.lean、そこからの導出は
このファイル末尾の `Derivation` 名前空間に置く。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.FiniteNeighborhoodAssignmentMonoid
import CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid

namespace CellularAutomata.OrderedNeighborhoodAssignmentMonoid

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_assignment_pointwise_inclusion` の点ごとの包含順序。 -/
def PointwiseInclusion (N M : NeighborhoodAssignment V) : Prop :=
  ∀ v : V, N v ⊆ M v

/-- 点ごとの包含順序は反射的である。 -/
theorem pointwiseInclusion_refl (N : NeighborhoodAssignment V) :
    PointwiseInclusion N N := by
  intro v w hw
  exact hw

/-- 点ごとの両包含から、有限集合の外延性と写像の外延性により割り当てが一致する。 -/
theorem pointwiseInclusion_antisymm {N M : NeighborhoodAssignment V}
    (hNM : PointwiseInclusion N M) (hMN : PointwiseInclusion M N) : N = M := by
  funext v
  ext w
  constructor
  · exact fun hw => hNM v hw
  · exact fun hw => hMN v hw

/-- 点ごとの包含順序は推移的である。人手証明どおり元 `w` を二つの包含へ順に通す。 -/
theorem pointwiseInclusion_trans {N M L : NeighborhoodAssignment V}
    (hNM : PointwiseInclusion N M) (hML : PointwiseInclusion M L) :
    PointwiseInclusion N L := by
  intro v w hwN
  have hwM : w ∈ M v := hNM v hwN
  exact hML v hwM

/-- `claim_composed_neighborhood_monotone`。
    合成近傍の証人 `u` を外側の包含、所属 `w ∈ M u` を内側の包含へ順に通す。 -/
theorem composedNeighborhood_monotone {N N' M M' : NeighborhoodAssignment V}
    (hNN' : PointwiseInclusion N N') (hMM' : PointwiseInclusion M M') :
    PointwiseInclusion (composedNeighborhood N M) (composedNeighborhood N' M') := by
  intro v w hw
  rw [composedNeighborhood, Finset.mem_biUnion] at hw ⊢
  obtain ⟨u, huN, hwM⟩ := hw
  have huN' : u ∈ N' v := hNN' v huN
  have hwM' : w ∈ M' u := hMM' u hwM
  exact ⟨u, huN', hwM'⟩

/-- 有限決定手続きが走査する全ての組 `(v,w) ∈ V × V`。 -/
def inclusionScan : Finset (V × V) := Finset.univ ×ˢ Finset.univ

/-- 有限走査の各検査が真であることは、点ごとの包含と同値である。 -/
theorem pointwiseInclusion_iff_scan (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N M ↔
      ∀ p ∈ inclusionScan (V := V), p.2 ∈ N p.1 → p.2 ∈ M p.1 := by
  constructor
  · intro h p hp hw
    exact h p.1 hw
  · intro h v w hw
    exact h (v, w) (by simp [inclusionScan]) hw

omit [DecidableEq V] in
/-- 有限走査で検査する組の個数は `|V|²` である。 -/
theorem card_inclusionScan :
    (inclusionScan (V := V)).card = Fintype.card V * Fintype.card V := by
  simp [inclusionScan]

/-- 点ごとの包含は、有限表から決定可能である。 -/
instance pointwiseInclusionDecidable (N M : NeighborhoodAssignment V) :
    Decidable (PointwiseInclusion N M) := by
  unfold PointwiseInclusion
  infer_instance

/-- `claim_finite_neighborhood_assignments_form_ordered_monoid`。
    既証明の有限モノイド構造、上の部分順序三性質、積の単調性を同時に記録する。 -/
theorem finite_ordered_monoid_properties :
    (∀ N : NeighborhoodAssignment V, PointwiseInclusion N N) ∧
    (∀ N M : NeighborhoodAssignment V,
      PointwiseInclusion N M → PointwiseInclusion M N → N = M) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion N M → PointwiseInclusion M L → PointwiseInclusion N L) ∧
    (∀ N N' M M' : NeighborhoodAssignment V,
      PointwiseInclusion N N' → PointwiseInclusion M M' →
        PointwiseInclusion (N * M) (N' * M')) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro N
    exact pointwiseInclusion_refl N
  · intro N M hNM hMN
    exact pointwiseInclusion_antisymm hNM hMN
  · intro N M L hNM hML
    exact pointwiseInclusion_trans hNM hML
  intro N N' M M' hNN' hMM'
  exact composedNeighborhood_monotone hNN' hMM'

/-! ### 必要十分版からの導出

必要十分版は、部分順序の三性質と合成の単調性から舞台の有限性を外し、
始域と終域が同じ型である必要も外している。要るのは合併先の型の等号判定だけであり、
部分集合を `Set` で表せばそれすら要らない。有限性は走査表と元数の段だけで要る。
順序モノイドになるのは、積を取るために型を同じに閉じたときだけである。 -/

namespace Derivation

open CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid

omit [Fintype V] in
/-- 具体版の点ごとの包含は、必要十分版の型をまたぐ包含を同じ型に取ったものである。 -/
theorem pointwiseInclusion_eq_necSuf (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N M ↔ HetInclusion N M := Iff.rfl

omit [Fintype V] in
/-- 具体版の反射律は、必要十分版の反射律の特殊化である。 -/
theorem pointwiseInclusion_refl_of_necSuf (N : NeighborhoodAssignment V) :
    PointwiseInclusion N N :=
  hetInclusion_refl N

omit [Fintype V] in
/-- 具体版の反対称律は、必要十分版の反対称律の特殊化である。 -/
theorem pointwiseInclusion_antisymm_of_necSuf {N M : NeighborhoodAssignment V}
    (hNM : PointwiseInclusion N M) (hMN : PointwiseInclusion M N) : N = M :=
  hetInclusion_antisymm hNM hMN

omit [Fintype V] in
/-- 具体版の推移律は、必要十分版の推移律の特殊化である。 -/
theorem pointwiseInclusion_trans_of_necSuf {N M L : NeighborhoodAssignment V}
    (hNM : PointwiseInclusion N M) (hML : PointwiseInclusion M L) :
    PointwiseInclusion N L :=
  hetInclusion_trans hNM hML

omit [Fintype V] in
/-- 具体版の合成の単調性は、必要十分版の型をまたぐ単調性を同じ型に取ったものである。 -/
theorem composedNeighborhood_monotone_of_necSuf
    {N N' M M' : NeighborhoodAssignment V}
    (hNN' : PointwiseInclusion N N') (hMM' : PointwiseInclusion M M') :
    PointwiseInclusion (composedNeighborhood N M) (composedNeighborhood N' M') :=
  hetComp_monotone hNN' hMM'

omit [DecidableEq V] in
/-- 具体版の走査表は、必要十分版の型をまたぐ走査表を同じ型に取ったものである。
    始域の等号判定は走査に要らない。 -/
theorem inclusionScan_eq_necSuf :
    inclusionScan (V := V) = hetScan V V := rfl

omit [DecidableEq V] in
/-- 具体版の走査組数は、必要十分版の組数を始域と終域が同じ場合に取ったものである。 -/
theorem card_inclusionScan_of_necSuf :
    (inclusionScan (V := V)).card = Fintype.card V * Fintype.card V :=
  card_hetScan (V := V) (W := V)

omit [Fintype V] in
/-- 具体版の順序モノイドの四性質は、必要十分版の四性質の特殊化である。 -/
theorem finite_ordered_monoid_properties_of_necSuf :
    (∀ N : NeighborhoodAssignment V, PointwiseInclusion N N) ∧
    (∀ N M : NeighborhoodAssignment V,
      PointwiseInclusion N M → PointwiseInclusion M N → N = M) ∧
    (∀ N M L : NeighborhoodAssignment V,
      PointwiseInclusion N M → PointwiseInclusion M L → PointwiseInclusion N L) ∧
    (∀ N N' M M' : NeighborhoodAssignment V,
      PointwiseInclusion N N' → PointwiseInclusion M M' →
        PointwiseInclusion (N * M) (N' * M')) :=
  ordered_monoid_properties (V := V)

omit [Fintype V] in
/-- 具体版が `Finset` で要求する等号判定は有限表現のためだけであり、
    包含順序そのものは集合として読んでも同じ関係である。 -/
theorem pointwiseInclusion_iff_setInclusion (N M : NeighborhoodAssignment V) :
    PointwiseInclusion N M ↔
      SetInclusion (fun v => ((N v : Finset V) : Set V))
        (fun v => ((M v : Finset V) : Set V)) :=
  hetInclusion_iff_setInclusion N M

end Derivation

end CellularAutomata.OrderedNeighborhoodAssignmentMonoid
