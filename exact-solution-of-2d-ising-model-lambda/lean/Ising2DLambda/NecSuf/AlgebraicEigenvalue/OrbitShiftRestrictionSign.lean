/-
主張「軌道の上の巡回シフトの制限の符号は `(-1)^{|O|-1}` である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionSign`）の証明は、
既に示した 2 つの主張（`claim_orbit_transposition_composite_is_shift` と
`claim_orbit_transposition_composite_sign`）を、番号 `|O|-1` の場所でつなぐ段である。
この段が新しく行っているのは、番号が上界の中に収まることの確認と、
写像としての等式を符号の等式へ移すことだけである。そこで必要十分版はそれだけを述べる。

  使っている性質                なぜ削れないか
  `hw`                          上界 `e` より下で列の符号が `u ^ k` であること
                                （`claim_orbit_transposition_composite_sign` に当たる）。
  `hc`                          着目する元の符号が列の第 `n-1` 項の符号に等しいこと
                                （`claim_orbit_transposition_composite_is_shift` を符号へ移した形。
                                写像としての等式そのものではなく、符号が一致することしか使わない）。
  `hne`                         `n = e`（人手証明の `|O| = e(τ₀)`）。
  `hpos`                        `1 ≤ e`。これが無いと `n = e = 0` のとき `n-1 = 0` が
                                上界 `e` の中に入らず、`hw` を当てられない。
  `Monoid M`                    `u ^ k` を書くための積と単位元。

削れたもの: 行配位、巡回シフト、軌道、最小周期、互換、順序 `≺`、符号が `(-1)` の冪であること、
写像であること（`α` は勝手な型でよい）、型の有限性。すなわちこの段は
「上界より下で値が `u ^ k` である列の、`n = e` と取った直前の項を読むこと」でしかない。

住処: ここに ℝ / ℂ は現れない（現れるのは番号（ℕ）とモノイドの元だけである）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 人手証明のこの段の必要十分版。上界 `e` より下で `sgn (w k) = u ^ k` である列について、
`n = e` かつ `1 ≤ e` ならば、`sgn` が列の第 `n-1` 項と一致する元の値は `u ^ (n-1)` である。 -/
theorem value_at_top_of_iterated {M : Type*} [Monoid M] {α : Type*}
    (sgn : α → M) (w : ℕ → α) (u : M) (n e : ℕ)
    (hw : ∀ k : ℕ, k < e → sgn (w k) = u ^ k)
    (c : α) (hc : sgn c = sgn (w (n - 1)))
    (hne : n = e) (hpos : 1 ≤ e) :
    sgn c = u ^ (n - 1) := by
  rw [hc]
  exact hw (n - 1) (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
