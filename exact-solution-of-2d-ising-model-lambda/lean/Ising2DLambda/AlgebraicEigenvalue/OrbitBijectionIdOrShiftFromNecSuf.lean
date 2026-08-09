/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に ι := RowConfig L、f := rowShift L、O := 軌道 を代入すると、具体版の 2 主張が出る。
代入する仮定は次の 4 つだけである。

  ψ が O の上の全単射                    ← 𝔅_O の元であること（使うのは単射性だけ）
  O の各点が 1 回以上の反復で戻ること      ← 最小周期の存在（最小性は渡していない）
  O の 2 点が反復で行き来できること        ← 軌道の元の軌道がもとの軌道に等しいこと
  O が反復で閉じていること                ← 同上

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・シフトが巡回であること・**S が単射（全単射）であること**・
最小周期の最小性・S の位数が L であること。

住処: ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitBijectionIdOrShift
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitBijectionIdOrShift

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「巡回シフトは軌道を保つ置換である」を、必要十分版から導いたもの。 -/
theorem rowShift_orbitPreserving_from_necSuf : OrbitPreserving L (rowShiftEquiv L) := by
  intro τ
  rw [rowShiftOrbit_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.self_apply_mem_orbit (rowShift L) τ

/-- 主張「各行配位をそれ自身かその像へ送る軌道の上の全単射は、恒等写像か巡回シフトの制限で
ある」を、必要十分版から導いたもの。

必要十分版の結論は各点の等式なので、ここで `Equiv` の等号へ直す（`S↾_O` が `𝔅_O` の元で
あることは具体版の側が持っている）。 -/
theorem orbitBij_eq_id_or_shift_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L)
    (ψ : {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O})
    (h : ∀ τ : {τ : RowConfig L // τ ∈ O}, (ψ τ).1 = τ.1 ∨ (ψ τ).1 = rowShift L τ.1) :
    ψ = Equiv.refl {τ : RowConfig L // τ ∈ O} ∨ ψ = shiftOrbitRestriction ⟨O, hO⟩ := by
  classical
  obtain ⟨τ₁, hτ₁⟩ := mem_rowShiftOrbitSet.mp hO
  -- O の各点の軌道は O 自身である
  have horb : ∀ i : RowConfig L, i ∈ O → rowShiftOrbit L i = O := by
    intro i hi
    have hmem : i ∈ rowShiftOrbit L τ₁ := by rw [hτ₁]; exact hi
    rw [rowShiftOrbit_eq_of_mem τ₁ hmem, hτ₁]
  have hperiod : ∀ i : RowConfig L, i ∈ O →
      ∃ e : ℕ, 1 ≤ e ∧ NecSuf.AlgebraicEigenvalue.iterLeft (rowShift L) e i = i := by
    intro i _
    refine ⟨rowShiftMinimalPeriod L i, rowShiftMinimalPeriod_pos i, ?_⟩
    rw [← rowShiftIterate_eq_iterLeft]
    exact rowShiftIterate_minimalPeriod i
  have hcover : ∀ i : RowConfig L, i ∈ O → ∀ i' : RowConfig L, i' ∈ O →
      ∃ k : ℕ, i' = NecSuf.AlgebraicEigenvalue.iterLeft (rowShift L) k i := by
    intro i hi i' hi'
    have hmem : i' ∈ rowShiftOrbit L i := by rw [horb i hi]; exact hi'
    obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hmem
    exact ⟨k, by rw [hk, rowShiftIterate_eq_iterLeft]⟩
  have hmem : ∀ i : RowConfig L, i ∈ O → ∀ k : ℕ,
      NecSuf.AlgebraicEigenvalue.iterLeft (rowShift L) k i ∈ O := by
    intro i hi k
    rw [← horb i hi]
    exact mem_rowShiftOrbit.mpr ⟨k, by rw [rowShiftIterate_eq_iterLeft]⟩
  rcases NecSuf.AlgebraicEigenvalue.eq_id_or_apply_of_fixed_or_apply (rowShift L) ψ h
    hperiod hcover hmem with h1 | h2
  · left
    exact Equiv.ext fun τ => Subtype.ext (h1 τ)
  · right
    refine Equiv.ext fun τ => Subtype.ext ?_
    rw [shiftOrbitRestriction_val]
    exact h2 τ

end Ising2DLambda.AlgebraicEigenvalue
