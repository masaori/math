/-
具体版が必要十分版の特殊化として得られることを示す（導出）。

具体版 `orbitTranspositionComposite_eq_rowShiftRestriction` は、必要十分版
`composite_eq_of_values` の型 `α` に軌道 `O`（部分型として持つ）、点の族 `pt` に
`r ↦ S^[r](τ₀)`、上界 `n` に軌道の元の個数 `|O|`、写像 `F` に `Ψ^{O,τ₀}_{|O|-1}`、
一歩の写像 `s` に `S↾_O` を取ったものである。

* `hn`（`1 ≤ n`）は `|O| = e(τ₀)` と `e(τ₀) ≥ 1` による。
* `hstep`（`s (pt r) = pt (r+1)`）は `S^[k+1] = S ∘ S^[k]` そのもの。
* `hper`（`pt n = pt 0`）は `S^[e(τ₀)](τ₀) = τ₀` による。
* `hval` は前のセクションの `orbitTranspositionComposite_apply_rowShiftIterate`。
* `hx`（点が `n` 未満の番号で書けること）は、軌道の元を `k % e` の番号へ直す段である。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeIsShift
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionCompositeIsShift

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の主張が、必要十分版の特殊化として得られること。 -/
theorem orbitTranspositionComposite_eq_rowShiftRestriction_from_necSuf
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    orbitTranspositionComposite hO hτ₀ (O.card - 1)
      = fun τ => shiftOrbitRestriction ⟨O, hO⟩ τ := by
  classical
  have hOorb : rowShiftOrbit L τ₀ = O := rowShiftOrbit_eq_of_mem_orbitSet hO hτ₀
  have hcard : O.card = rowShiftMinimalPeriod L τ₀ := by
    rw [← hOorb]; exact card_rowShiftOrbit L τ₀
  have hepos : 1 ≤ rowShiftMinimalPeriod L τ₀ := rowShiftMinimalPeriod_pos τ₀
  funext τ
  refine NecSuf.AlgebraicEigenvalue.composite_eq_of_values
    (pt := fun r => (⟨rowShiftIterate L r τ₀,
      rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ r⟩ : {t : RowConfig L // t ∈ O}))
    (n := O.card) (by omega) ?_ ?_ ?_ ?_
  · -- hstep: S↾_O (S^[r](τ₀)) = S^[r+1](τ₀)
    intro r
    exact Subtype.ext rfl
  · -- hper: S^[|O|](τ₀) = τ₀ = S^[0](τ₀)
    refine Subtype.ext ?_
    show rowShiftIterate L O.card τ₀ = rowShiftIterate L 0 τ₀
    rw [hcard, rowShiftIterate_minimalPeriod]
    rfl
  · -- hval: 前のセクションの値の記述
    intro r hr
    refine Subtype.ext ?_
    rw [hcard] at hr ⊢
    rw [orbitTranspositionComposite_apply_rowShiftIterate hO hτ₀ (by omega) hr]
    split_ifs <;> rfl
  · -- hx: τ を r < |O| の番号の点として書く（k を e で割った余りを取る）
    have hτmem : τ.1 ∈ rowShiftOrbit L τ₀ := by rw [hOorb]; exact τ.2
    obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hτmem
    have hmul : rowShiftIterate L
        (rowShiftMinimalPeriod L τ₀ * (k / rowShiftMinimalPeriod L τ₀)) τ₀ = τ₀ :=
      rowShiftIterate_mul τ₀ (rowShiftIterate_minimalPeriod τ₀) _
    have hkr : rowShiftIterate L (k % rowShiftMinimalPeriod L τ₀) τ₀ = rowShiftIterate L k τ₀ := by
      conv_rhs => rw [← Nat.mod_add_div k (rowShiftMinimalPeriod L τ₀)]
      rw [rowShiftIterate_add, hmul]
    refine ⟨k % rowShiftMinimalPeriod L τ₀, ?_, ?_⟩
    · rw [hcard]; exact Nat.mod_lt k hepos
    · exact Subtype.ext (hkr.trans hk.symm)

end Ising2DLambda.AlgebraicEigenvalue
