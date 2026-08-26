/-
章「近傍割り当ての包含順序と合成の単調性」の必要十分版。

具体版（CellularAutomata.OrderedNeighborhoodAssignmentMonoid）と同じ順序で、
点ごとの包含、部分順序三性質、合成の単調性、有限決定、順序モノイドを示す。

必要な構造の検査結果:
  - 反射律・推移律は、値が部分集合であることしか使わない。始域・終域の型に
    いかなるインスタンスも要らず、始域と終域が同じ型である必要も無い。
  - 反対称律に要るのは、値の集合の外延性と写像の外延性だけである。有限性も
    等号判定も要らない。
  - 合成の単調性も同様に、始域と終域が同じ型である必要が無い。
    `Finset` 版が要求する等号判定は合併 `Finset.biUnion` の側の要求であり、
    部分集合を `Set` で表せばインスタンスは一つも要らない。
    その対応は橋渡し定理で示す。
  - 有限性が要るのは、包含の走査表とその元数の段だけである。そこでも要るのは
    始域の有限性と終域の等号判定であり、始域の等号判定は要らない。
  - 順序モノイドになるのは、始域と終域を同じ型に取ったときだけである
    （積を取るために合成の型が閉じる必要がある）。
  - 状態集合、局所規則、時間、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid

open CellularAutomata.NecSuf.ComposedNeighborhoodClosure
open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

/-! ### 型をまたぐ点ごとの包含（有限性も等号判定も使わない段）

`def_neighborhood_assignment_pointwise_inclusion` の関係を、始域と終域が異なる型でも
書けることを確かめる。 -/

/-- 型をまたぐ点ごとの包含 N ≼ M :⟺ ∀ v, N(v) ⊆ M(v)。 -/
def HetInclusion {V W : Type} (N M : V → Finset W) : Prop :=
  ∀ v : V, N v ⊆ M v

/-- 反射律。値が部分集合であることしか使わない。 -/
theorem hetInclusion_refl {V W : Type} (N : V → Finset W) : HetInclusion N N := by
  intro v w hw
  exact hw

/-- 反対称律。要るのは値の集合の外延性と写像の外延性だけで、有限性も等号判定も要らない。 -/
theorem hetInclusion_antisymm {V W : Type} {N M : V → Finset W}
    (hNM : HetInclusion N M) (hMN : HetInclusion M N) : N = M := by
  funext v
  ext w
  constructor
  · exact fun hw => hNM v hw
  · exact fun hw => hMN v hw

/-- 推移律。人手証明どおり元 `w` を二つの包含へ順に通す。 -/
theorem hetInclusion_trans {V W : Type} {N M L : V → Finset W}
    (hNM : HetInclusion N M) (hML : HetInclusion M L) : HetInclusion N L := by
  intro v w hwN
  have hwM : w ∈ M v := hNM v hwN
  exact hML v hwM

/-- `claim_composed_neighborhood_monotone` の型をまたぐ版。
    始域と終域が同じ型である必要は無い。等号判定は合併の側の要求だけである。 -/
theorem hetComp_monotone {V W X : Type} [DecidableEq X]
    {N N' : V → Finset W} {M M' : W → Finset X}
    (hNN' : HetInclusion N N') (hMM' : HetInclusion M M') :
    HetInclusion (hetComp N M) (hetComp N' M') := by
  intro v w hw
  rw [hetComp, Finset.mem_biUnion] at hw ⊢
  obtain ⟨u, huN, hwM⟩ := hw
  have huN' : u ∈ N' v := hNN' v huN
  have hwM' : w ∈ M' u := hMM' u hwM
  exact ⟨u, huN', hwM'⟩

/-! ### 等号判定を落とす検査

部分集合を `Set` で表すと、包含順序も合成の単調性もインスタンスを一つも要求しない。
`Finset` 版の等号判定は有限表現のためだけに要る。 -/

/-- `Set` 値の近傍割り当ての点ごとの包含。型にインスタンスを一つも要求しない。 -/
def SetInclusion {V W : Type} (N M : V → Set W) : Prop :=
  ∀ v : V, N v ⊆ M v

theorem setInclusion_refl {V W : Type} (N : V → Set W) : SetInclusion N N := by
  intro v w hw
  exact hw

theorem setInclusion_antisymm {V W : Type} {N M : V → Set W}
    (hNM : SetInclusion N M) (hMN : SetInclusion M N) : N = M := by
  funext v
  ext w
  constructor
  · exact fun hw => hNM v hw
  · exact fun hw => hMN v hw

theorem setInclusion_trans {V W : Type} {N M L : V → Set W}
    (hNM : SetInclusion N M) (hML : SetInclusion M L) : SetInclusion N L := by
  intro v w hwN
  have hwM : w ∈ M v := hNM v hwN
  exact hML v hwM

/-- `Set` 版の合成の単調性。等号判定も有限性も使わない。 -/
theorem setComp_monotone {V W X : Type}
    {N N' : V → Set W} {M M' : W → Set X}
    (hNN' : SetInclusion N N') (hMM' : SetInclusion M M') :
    SetInclusion (setComp N M) (setComp N' M') := by
  intro v w hw
  obtain ⟨u, huN, hwM⟩ := hw
  have huN' : u ∈ N' v := hNN' v huN
  have hwM' : w ∈ M' u := hMM' u hwM
  exact ⟨u, huN', hwM'⟩

/-- 橋渡し: `Finset` 版の包含を集合として読むと `Set` 版の包含に一致する。
    すなわち等号判定は有限表現のためだけに要る。 -/
theorem hetInclusion_iff_setInclusion {V W : Type} (N M : V → Finset W) :
    HetInclusion N M ↔
      SetInclusion (fun v => ((N v : Finset W) : Set W))
        (fun v => ((M v : Finset W) : Set W)) := by
  constructor
  · intro h v w hw
    exact Finset.mem_coe.mpr (h v (Finset.mem_coe.mp hw))
  · intro h v w hw
    exact Finset.mem_coe.mp (h v (Finset.mem_coe.mpr hw))

/-- 既製の順序との一致を述べる橋渡し定理（自前の証明を置いたうえでの一本）。
    `Set` 値の点ごとの包含は、`V → Set W` の既定の順序 `≤` と同じ関係である。 -/
theorem setInclusion_iff_le {V W : Type} (N M : V → Set W) :
    SetInclusion N M ↔ N ≤ M := Iff.rfl

/-! ### 有限走査（有限性が要る段）

包含の判定を有限表で行う段で初めて始域の有限性が要る。始域の等号判定は要らず、
要るのは終域の等号判定（有限部分集合への所属判定）だけである。 -/

/-- 型をまたぐ有限走査表。始域と終域が異なっていてもよい。 -/
def hetScan (V W : Type) [Fintype V] [Fintype W] : Finset (V × W) :=
  Finset.univ ×ˢ Finset.univ

/-- 有限走査の各検査が真であることは、点ごとの包含と同値である。 -/
theorem hetInclusion_iff_scan {V W : Type} [Fintype V] [Fintype W]
    (N M : V → Finset W) :
    HetInclusion N M ↔
      ∀ p ∈ hetScan V W, p.2 ∈ N p.1 → p.2 ∈ M p.1 := by
  constructor
  · intro h p _ hw
    exact h p.1 hw
  · intro h v w hw
    exact h (v, w) (by simp [hetScan]) hw

/-- 有限走査で検査する組の個数は `|V| · |W|` である。 -/
theorem card_hetScan {V W : Type} [Fintype V] [Fintype W] :
    (hetScan V W).card = Fintype.card V * Fintype.card W := by
  simp [hetScan]

/-- 点ごとの包含の決定可能性。要るのは始域の有限性と終域の等号判定だけで、
    始域の等号判定は要らない。 -/
instance hetInclusionDecidable {V W : Type} [Fintype V] [DecidableEq W]
    (N M : V → Finset W) : Decidable (HetInclusion N M) := by
  unfold HetInclusion
  infer_instance

/-! ### 順序モノイド（始域と終域を同じ型に取る段）

積を取るには合成の型が閉じる必要があるため、ここで初めて始域と終域を同じ型にする。 -/

/-- `claim_finite_neighborhood_assignments_form_ordered_monoid` の必要十分版。
    既証明のモノイド構造、部分順序三性質、積の単調性を同時に記録する。
    舞台の有限性は要らず、要るのは合併先の等号判定だけである。 -/
theorem ordered_monoid_properties {V : Type} [DecidableEq V] :
    (∀ N : V → Finset V, HetInclusion N N) ∧
    (∀ N M : V → Finset V, HetInclusion N M → HetInclusion M N → N = M) ∧
    (∀ N M L : V → Finset V,
      HetInclusion N M → HetInclusion M L → HetInclusion N L) ∧
    (∀ N N' M M' : V → Finset V,
      HetInclusion N N' → HetInclusion M M' →
        HetInclusion (composedNeighborhood N M) (composedNeighborhood N' M')) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro N
    exact hetInclusion_refl N
  · intro N M hNM hMN
    exact hetInclusion_antisymm hNM hMN
  · intro N M L hNM hML
    exact hetInclusion_trans hNM hML
  intro N N' M M' hNN' hMM'
  rw [← hetComp_eq_composedNeighborhood, ← hetComp_eq_composedNeighborhood]
  exact hetComp_monotone hNN' hMM'

end CellularAutomata.NecSuf.OrderedNeighborhoodAssignmentMonoid
