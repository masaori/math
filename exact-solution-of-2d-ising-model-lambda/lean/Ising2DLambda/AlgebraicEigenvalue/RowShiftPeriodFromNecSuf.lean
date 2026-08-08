/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `iterLeft` / `minimalPeriod` に ι := RowConfig L、f := rowShift L を代入すると、
具体版の `rowShiftIterate` / `rowShiftMinimalPeriod` と同じものが出る。代入する仮定は次だけである。
  K(τ) が空でないこと ← S^[L](τ) = τ（`rowShiftIterate_period`）と L ≥ 1

このことは、具体版の 3 つの証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・シフトが巡回であること・
R_L が有限であること・S が全単射であること・相等が判定できること。
とくに **f の位数が L であることは使っておらず、その点が L 回で戻りさえすればよい**
（周期は点ごとの量であって、写像全体の量ではない）。

住処: ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftPeriod
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixOrderFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftPeriod

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

-- この対応そのものは `L ≥ 1` を使わない（反復の段を 1 つずつ照らし合わせるだけである）。
-- `L ≥ 1` が要るのは、この先で `K(τ)` が空でないことを言う箇所だけである。
omit [NeZero L] in
/-- 具体版の `S^[k]` が、必要十分版の左からの反復に写像 `rowShift L` を代入したものであること。 -/
theorem rowShiftIterate_eq_iterLeft (k : ℕ) (τ : RowConfig L) :
    rowShiftIterate L k τ = NecSuf.AlgebraicEigenvalue.iterLeft (rowShift L) k τ := by
  induction k generalizing τ with
  | zero => rfl
  | succ k ih => show rowShift L _ = rowShift L _; rw [ih τ]

/-- 反復の加法性を、必要十分版から導いたもの。 -/
theorem rowShiftIterate_add_from_necSuf (a b : ℕ) (τ : RowConfig L) :
    rowShiftIterate L (a + b) τ = rowShiftIterate L a (rowShiftIterate L b τ) := by
  rw [rowShiftIterate_eq_iterLeft, rowShiftIterate_eq_iterLeft,
    rowShiftIterate_eq_iterLeft b τ,
    NecSuf.AlgebraicEigenvalue.iterLeft_add (rowShift L) a b τ]

/-- 必要十分版へ渡す仮定（人手証明の「K(τ) は空でない」）。 -/
theorem iterLeft_period_exists (τ : RowConfig L) :
    ∃ k, 1 ≤ k ∧ NecSuf.AlgebraicEigenvalue.iterLeft (rowShift L) k τ = τ :=
  ⟨L, Nat.one_le_iff_ne_zero.mpr (NeZero.ne L), by
    rw [← rowShiftIterate_eq_iterLeft]; exact rowShiftIterate_period τ⟩

/-- 具体版の最小周期が、必要十分版の最小周期の特殊化であること。

どちらも「1 以上で戻る回数」の最小元なので、互いに相手以下であることから等しい。 -/
theorem rowShiftMinimalPeriod_eq_necSuf (τ : RowConfig L) :
    rowShiftMinimalPeriod L τ
      = NecSuf.AlgebraicEigenvalue.minimalPeriod (rowShift L) τ (iterLeft_period_exists τ) := by
  refine Nat.le_antisymm ?_ ?_
  · refine Nat.le_of_not_lt (fun hlt => ?_)
    refine not_rowShiftIterate_of_lt_minimalPeriod τ
      (NecSuf.AlgebraicEigenvalue.minimalPeriod_pos (rowShift L) τ (iterLeft_period_exists τ))
      hlt ?_
    rw [rowShiftIterate_eq_iterLeft]
    exact NecSuf.AlgebraicEigenvalue.iterLeft_minimalPeriod (rowShift L) τ
      (iterLeft_period_exists τ)
  · refine Nat.le_of_not_lt (fun hlt => ?_)
    refine NecSuf.AlgebraicEigenvalue.not_iterLeft_of_lt_minimalPeriod (rowShift L) τ
      (iterLeft_period_exists τ) (rowShiftMinimalPeriod_pos τ) hlt ?_
    rw [← rowShiftIterate_eq_iterLeft]
    exact rowShiftIterate_minimalPeriod τ

/-- 主張「もとへ戻る反復の回数は最小周期の倍数である」を、必要十分版から導いたもの。 -/
theorem rowShiftIterate_eq_self_iff_from_necSuf (τ : RowConfig L) (k : ℕ) :
    rowShiftIterate L k τ = τ ↔ rowShiftMinimalPeriod L τ ∣ k := by
  rw [rowShiftIterate_eq_iterLeft, rowShiftMinimalPeriod_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.iterLeft_eq_self_iff (rowShift L) τ
    (iterLeft_period_exists τ) k

/-- 主張「最小周期は格子の一辺を割り切る」を、必要十分版から導いたもの。
渡す仮定は `S^[L](τ) = τ` だけである。 -/
theorem rowShiftMinimalPeriod_dvd_L_from_necSuf (τ : RowConfig L) :
    rowShiftMinimalPeriod L τ ∣ L := by
  rw [rowShiftMinimalPeriod_eq_necSuf]
  refine NecSuf.AlgebraicEigenvalue.minimalPeriod_dvd_of_iterLeft_eq_self (rowShift L) τ
    (iterLeft_period_exists τ) ?_
  rw [← rowShiftIterate_eq_iterLeft]
  exact rowShiftIterate_period τ

end Ising2DLambda.AlgebraicEigenvalue
