/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `iterLeft` / `orbit` / `minimalPeriod` に ι := RowConfig L、f := rowShift L を
代入すると、具体版の `rowShiftIterate` / `rowShiftOrbit` / `rowShiftMinimalPeriod` と
同じものが出る。代入する仮定は次の 3 つだけである。

  S が単射             ← claim_row_config_shift_bijective の単射性の半分だけ
  R_L が有限で相等が判定できること
  K(τ) が空でないこと   ← S^[L](τ) = τ（`rowShiftIterate_period`）と L ≥ 1

このことは、具体版の 2 つの証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・シフトが巡回であること・
**S が全射であること**・S の位数が L であること。
とくに軌道の個数を数える段は、写像が単射であることと点ごとの周期の存在だけで通る。

住処: ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbit
import Ising2DLambda.AlgebraicEigenvalue.RowShiftPeriodFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbit

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「反復した巡回シフトは単射である」を、必要十分版から導いたもの。
渡す仮定は `S` が単射であることだけである（全射性は渡していない）。 -/
theorem rowShiftIterate_injective_from_necSuf (k : ℕ) :
    Function.Injective (rowShiftIterate L k) := by
  have h := NecSuf.AlgebraicEigenvalue.iterLeft_injective (rowShift L)
    (rowShiftEquiv L).injective k
  intro τ₁ τ₂ heq
  refine h ?_
  rw [← rowShiftIterate_eq_iterLeft, ← rowShiftIterate_eq_iterLeft]
  exact heq

/-- 具体版の軌道が、必要十分版の軌道の特殊化であること。 -/
theorem rowShiftOrbit_eq_necSuf (τ : RowConfig L) :
    rowShiftOrbit L τ = NecSuf.AlgebraicEigenvalue.orbit (rowShift L) τ := by
  classical
  ext τ'
  rw [mem_rowShiftOrbit, NecSuf.AlgebraicEigenvalue.mem_orbit]
  constructor
  · rintro ⟨k, hk⟩
    exact ⟨k, by rw [hk, rowShiftIterate_eq_iterLeft]⟩
  · rintro ⟨k, hk⟩
    exact ⟨k, by rw [hk, ← rowShiftIterate_eq_iterLeft]⟩

/-- 主張「軌道の元の個数は最小周期に等しい」を、必要十分版から導いたもの。 -/
theorem card_rowShiftOrbit_from_necSuf (τ : RowConfig L) :
    (rowShiftOrbit L τ).card = rowShiftMinimalPeriod L τ := by
  rw [rowShiftOrbit_eq_necSuf, rowShiftMinimalPeriod_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.card_orbit (rowShift L) (rowShiftEquiv L).injective τ
    (iterLeft_period_exists τ)

end Ising2DLambda.AlgebraicEigenvalue
