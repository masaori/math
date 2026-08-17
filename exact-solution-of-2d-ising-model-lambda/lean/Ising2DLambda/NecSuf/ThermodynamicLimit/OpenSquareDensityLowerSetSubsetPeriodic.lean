/-
「開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性。q は 1 以下）」の必要十分版。

具体版が使うのは次だけである。
- 加法群の等式（結合則・単位元・逆元・可換則）: 八段の鎖の前半五段と、七段目で `add_monotone` の
  結果を並べ替えるために要る。したがって `AddCommGroup X`（可換則は七段目の並べ替えで要る。
  順序を左右どちらにも足せる形にすれば落とせるが、具体版は右加法と可換則で書いているので揃える）。
- 関係 `le` の推移律と右加法単調性（`claim_rational_log_order_group_add_monotone`）。
- 証人の半分の存在（`ε` から `0 ≤ ε'`、`ε' ≠ 0`、`ε' + ε' = ε` を満たす `ε'`）: 具体版では有理数倍 `1/2`
  で作るが、使うのはこの三性質だけなので仮定として渡す（有理数倍そのものは要らない）。
- 誤差の列 `e` が「正の元の逆元をやがて下回らない」こと（`∀ ε' > 0, ∃ n, ∀ L ≥ n, L ≥ 1 → −ε' ≤ e L`）:
  具体版では Archimedes 性と倍率以上の自然数で割る評価から出るが、下組の包含に要るのはこの形だけ。
- `L ≥ 1` での項ごとの比較 `l L + e L ≤ l' L`（`claim_periodic_open_boundary_comparison_density_le_one` の左）。
順序の線形性・有理数倍・`Λ_ℚ`・密度の中身は使わない。
下組は「列が定める下組は下に閉じている」の必要十分版の `lowerSetOfSequence` を共有する。
-/
import Mathlib.Algebra.Group.Basic
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [AddCommGroup X]

/-- 列 `l` が誤差 `e` 込みで `L ≥ 1` で項ごとに列 `l'` 以下（`l L + e L ≤ l' L`）で、誤差が正の元の逆元を
やがて下回らず、証人を半分にできるなら、`l` の下組は `l'` の下組に含まれる。
新しい証人は `ε'`（`ε` の半分）と `N' := N + n`。 -/
theorem lowerSetOfSequence_subset_of_eventually_le_add_error_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (hhalf : ∀ ε : X, le 0 ε → ε ≠ 0 → ∃ ε' : X, le 0 ε' ∧ ε' ≠ 0 ∧ ε' + ε' = ε)
    (l l' e : ℕ → X)
    (hsmall : ∀ ε' : X, le 0 ε' → ε' ≠ 0 → ∃ n : ℕ, ∀ L : ℕ, n ≤ L → 1 ≤ L → le (-ε') (e L))
    (hle : ∀ L : ℕ, 1 ≤ L → le (l L + e L) (l' L)) :
    lowerSetOfSequence le l ⊆ lowerSetOfSequence le l' := by
  intro μ hμ
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  -- 準備の第一: 証人の半分
  obtain ⟨ε', hε'0, hε'ne, hsum⟩ := hhalf ε hε0 hεne
  -- 準備の第三・第四: 誤差が −ε' を下回らなくなる下限 n、N' := N + n
  obtain ⟨n, hn⟩ := hsmall ε' hε'0 hε'ne
  refine ⟨ε', hε'0, hε'ne, N + n, Nat.le_add_right_of_le hN1, ?_⟩
  intro L hL
  have hLN : N ≤ L := Nat.le_trans (Nat.le_add_right N n) hL
  have hLn : n ≤ L := Nat.le_trans (Nat.le_add_left n N) hL
  have hL1 : 1 ≤ L := Nat.le_trans hN1 hLN
  -- 一〜五段目（加法群の等式）
  have heq : μ + ε' = (μ + ε) + (-ε') := by
    calc μ + ε' = (μ + ε') + 0 := (add_zero _).symm
      _ = (μ + ε') + (ε' + (-ε')) := by rw [add_neg_cancel]
      _ = ((μ + ε') + ε') + (-ε') := (add_assoc _ _ _).symm
      _ = (μ + (ε' + ε')) + (-ε') := by rw [add_assoc μ ε' ε']
      _ = (μ + ε) + (-ε') := by rw [hsum]
  -- 六段目: 証人の性質に右加法単調性
  have h6 : le ((μ + ε) + (-ε')) (l L + (-ε')) := hadd (-ε') (hN L hLN)
  -- 七段目: 誤差の評価に右加法単調性、可換則で並べ替える
  have h7 : le (l L + (-ε')) (l L + e L) := by
    have h := hadd (l L) (hn L hLn hL1)
    rw [add_comm (-ε'), add_comm (e L)] at h
    exact h
  -- 八段目: 項ごとの比較
  have h8 : le (l L + e L) (l' L) := hle L hL1
  rw [heq]
  exact htrans h6 (htrans h7 h8)

end Ising2DLambda.NecSuf.ThermodynamicLimit
