/-
章「固有値の代数性」の主張「最小周期より小さい反復の回数は、行く先で見分けられる」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_row_shift_iterate_distinct_below_period`）に対応する。

  人手証明                                          このファイル
  準備（a ≤ b の場合）                              eq_of_rowShiftIterate_eq_of_le
                                                    （`RowShiftOrbit.lean` に既にある。
                                                      人手証明の準備の段と同じ議論）
  一般の場合（a ≤ b と b ≤ a に分ける）             rowShiftIterate_index_eq_of_lt_period

住処: 人手証明のこのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその上の写像、および ℕ だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionComposite

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`a < e(τ)`、`b < e(τ)`、`S^[a](τ) = S^[b](τ) `ならば `a = b` である。

人手証明どおり、自然数の大小が全順序であることで `a ≤ b` と `b ≤ a` の 2 つの場合に分け、
各場合で準備（`eq_of_rowShiftIterate_eq_of_le`）を当てる。
`b ≤ a` の場合は `a` と `b` を入れ替えて当て、得られた `b = a` を `a = b` へ直す。 -/
theorem rowShiftIterate_index_eq_of_lt_period {τ : RowConfig L} {a b : ℕ}
    (ha : a < rowShiftMinimalPeriod L τ) (hb : b < rowShiftMinimalPeriod L τ)
    (h : rowShiftIterate L a τ = rowShiftIterate L b τ) : a = b := by
  rcases Nat.le_total a b with hab | hba
  · -- a ≤ b の場合。仮定 b < e(τ) と S^[a](τ) = S^[b](τ) に準備を当てる。
    exact eq_of_rowShiftIterate_eq_of_le hab hb h
  · -- b ≤ a の場合。仮定 a < e(τ) と S^[b](τ) = S^[a](τ) に、a と b を入れ替えて当てる。
    exact (eq_of_rowShiftIterate_eq_of_le hba ha h.symm).symm

end Ising2DLambda.AlgebraicEigenvalue
