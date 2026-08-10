/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `step_eq_self_iff_period_eq_one` に α := RowConfig L、f := S、
it := S^[·]、τ := τ、e := e(τ) を代入すると具体版が出る。渡す仮定は次の 3 つだけである。

  S^[1](τ) = S(τ)                        ← 準備の第二（定義の展開）
  1 ≤ e(τ)                               ← 既出の `rowShiftMinimalPeriod_pos`
  S^[1](τ) = τ ↔ ∃ q, 1 = e(τ)·q         ← 既出の `rowShiftIterate_eq_self_iff`

**軌道であること・S が全単射であること・反復の再帰 2 式・型の有限性・順序 ≺ は渡していない。**
このことは、具体版の証明が（準備の第一 `|O| = e(τ)` を除いて）それらを使っていないという
主張の裏取りになっている。準備の第一だけはここでも具体版と同じく
`card_eq_period_of_mem` で与える（軌道と個数を結ぶ段は必要十分版の外にある）。

住処: ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFixedIffCardOne
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFixedIffCardOne

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることは
同値である」を、必要十分版から導いたもの。 -/
theorem rowShift_eq_self_iff_card_orbit_eq_one_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) :
    rowShift L τ = τ ↔ O.card = 1 := by
  have hcard : O.card = rowShiftMinimalPeriod L τ := card_eq_period_of_mem hO hmem
  rw [hcard]
  refine NecSuf.AlgebraicEigenvalue.step_eq_self_iff_period_eq_one
    (f := rowShift L) (it := rowShiftIterate L) (τ := τ)
    (rowShiftIterate_one τ) (rowShiftMinimalPeriod_pos τ) ?_
  constructor
  · intro h
    obtain ⟨q, hq⟩ := (rowShiftIterate_eq_self_iff τ 1).mp h
    exact ⟨q, hq⟩
  · rintro ⟨q, hq⟩
    exact (rowShiftIterate_eq_self_iff τ 1).mpr ⟨q, hq⟩

end Ising2DLambda.AlgebraicEigenvalue
