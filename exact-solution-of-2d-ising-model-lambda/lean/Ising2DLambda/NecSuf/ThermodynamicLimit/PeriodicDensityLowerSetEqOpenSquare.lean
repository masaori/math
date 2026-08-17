/-
「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」の必要十分版。

具体版が使うのは、二つの包含（それぞれの必要十分版 `lowerSetOfSequence_subset_of_pointwise_le_necSuf`・
`lowerSetOfSequence_subset_of_eventually_le_add_error_necSuf`）と、集合の外延性（両向きの所属から等号）だけである。
したがって仮定は二つの包含の必要十分版の仮定の和集合そのものであり、新しい構造は要らない。
列 `a`（周期境界の密度）と `b`（開境界正方形の密度）について、
`L ≥ 1` で `a L ≤ b L`（右の比較）と `b L + e L ≤ a L`（左の比較・誤差付き）から下組が一致する。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.PeriodicDensityLowerSetSubsetOpenSquare
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensityLowerSetSubsetPeriodic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommGroup X]

/-- 列 `a` が `L ≥ 1` で項ごとに列 `b` 以下、かつ `b` が誤差 `e` 込みで `L ≥ 1` で項ごとに `a` 以下で、
誤差が正の元の逆元をやがて下回らず、証人を半分にできるなら、`a` の下組と `b` の下組は等しい。 -/
theorem lowerSetOfSequence_eq_of_pointwise_le_and_eventually_le_add_error_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hhalf : ∀ ε : X, le 0 ε → ε ≠ 0 → ∃ ε' : X, le 0 ε' ∧ ε' ≠ 0 ∧ ε' + ε' = ε)
    (a b e : ℕ → X)
    (hsmall : ∀ ε' : X, le 0 ε' → ε' ≠ 0 → ∃ n : ℕ, ∀ L : ℕ, n ≤ L → 1 ≤ L → le (-ε') (e L))
    (hab : ∀ L : ℕ, 1 ≤ L → le (a L) (b L))
    (hba : ∀ L : ℕ, 1 ≤ L → le (b L + e L) (a L)) :
    lowerSetOfSequence le a = lowerSetOfSequence le b := by
  -- 外延性: 任意の μ について両向きの所属を示す
  ext μ
  constructor
  · -- 一方の包含（項ごとの比較と推移律）
    intro hμ
    exact lowerSetOfSequence_subset_of_pointwise_le_necSuf le htrans a b hab hμ
  · -- 逆の包含（誤差付きの比較・証人の半分・誤差の評価）
    intro hμ
    exact lowerSetOfSequence_subset_of_eventually_le_add_error_necSuf le htrans hadd hhalf b a e hsmall hba hμ

end Ising2DLambda.NecSuf.ThermodynamicLimit
