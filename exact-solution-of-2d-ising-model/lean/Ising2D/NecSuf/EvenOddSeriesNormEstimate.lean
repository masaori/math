/-
# 偶数番目と奇数番目が数の冪のスカラー倍である行列の列の指数級数: ノルムの評価と `ε` の鎖（必要十分版）

具体版: `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimExponentialSeriesOfEvenOddPowerTerms.lean`
（人手 `exponential_series_of_even_odd_power_terms`）。具体版をこのファイルの系として導くのは
`Ising2D/EigenvalueProblem/ReductionToATheta/ClaimExponentialSeriesOfEvenOddPowerTermsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `evenOddPartialSum_sub_limit_norm_le`（ノルムの評価の 8 段: 差の中間目標 → 三角不等式 → 斉次性 → `|zw| = |z||w|` → `|ι(r)| = |r|` → 実数の評価 → 実数の四則 → `κ` の定義） | `evenOdd_norm_le'`（同じ 8 段） |
| `evenOddPartialSum_sub_limit_norm_tendsto`（`ε` の 3 段: ノルムの評価 → `(u_N+v_N)/2 < ε/(κ+1)` と `κ ≥ 0` → `κ < κ+1` と `ε > 0`） | `evenOdd_err_tendsto'`（同じ 3 段） |

中間目標「各項」「部分和」「差」は行列の成分の鎖なので、同じ手順のまま対象を上げられない。必要十分版はその後の、
ノルムだけを使う段に置く（具体版の差の中間目標は、ここでは仮定 `hD` に置く）。

## 何が効いているか / 効いていないか

- ノルムの評価（`evenOdd_norm_le'`）で効いているのは、元の集合 `V` の加法とスカラー倍、`V` のノルムの三角不等式（仮定 `htri`。
  人手 `matrix_norm_triangle_inequality` (3)）と斉次性 `‖k y‖ = ‖k‖‖y‖`（仮定 `hsmul`。同 (2)）、係数の集合 `K` の
  `‖kl‖ = ‖k‖‖l‖`（仮定 `hmul`。人手 `abs_basic_properties` (4)）、実数から係数への写像 `ι` が絶対値を保つこと
  `‖ι(r)‖ = |r|`（仮定 `hι`。同 (6)）、`‖A‖`・`‖c‖`・`‖B‖` が非負であること（仮定 `hA`・`hc`・`hB`。人手 6 行目の不等号の向きに要る）だけである。
  **行列であること、成分、`V` の加法の結合則・交換則・零・逆元、加群の公理、`K` の加法、`K` が体であること、`ι` が環準同型であること、
  ノルムの非退化性は効いていない。** 係数の集合は ℂ である必要がなく、実数を絶対値を保って送る写像を持つ集合ならよい。
- `ε` の鎖（`evenOdd_err_tendsto'`）で効いているのは、`e_N ≤ ((u_N+v_N)/2)κ`（仮定 `hle`）、`κ ≥ 0`（仮定 `hκ`）、
  `e_N ≥ 0`（仮定 `he0`。`|e_N − 0| = e_N` に要る）と、任意の `δ > 0` に対し十分先で `u_N < δ`・`v_N < δ` となること（仮定 `hsmall`）だけである。
  **`u_N`・`v_N` が指数級数の部分和の誤差であること、`e_N` がノルムであること、元の集合の構造は効いていない。**
  `u_N`・`v_N` の非負性も効いていない（人手 2 行目は `(u_N+v_N)/2 < ε/(κ+1)` だけを使う）。
-/
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Order.Filter.AtTopBot.Basic
import Mathlib.Topology.MetricSpace.Pseudo.Defs
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.GCongr

namespace Ising2D.NecSuf

open Filter Topology

/-- **ノルムの評価**（具体版 `evenOddPartialSum_sub_limit_norm_le`）: `D = ι(a) A + (c ι(b)) B`、`|a| ≤ w`、`|b| ≤ w` なら
`‖D‖ ≤ w κ`（`κ = ‖A‖ + ‖c‖‖B‖`）。具体版の 8 段と同じ並びの calc。 -/
theorem evenOdd_norm_le' {K V : Type*} [Norm K] [Mul K] [Norm V] [Add V] [SMul K V] (ι : ℝ → K)
    (htri : ∀ y z : V, ‖y + z‖ ≤ ‖y‖ + ‖z‖)
    (hsmul : ∀ (k : K) (y : V), ‖k • y‖ = ‖k‖ * ‖y‖)
    (hmul : ∀ k l : K, ‖k * l‖ = ‖k‖ * ‖l‖)
    (hι : ∀ r : ℝ, ‖ι r‖ = |r|)
    (A B D : V) (c : K) (hA : 0 ≤ ‖A‖) (hc : 0 ≤ ‖c‖) (hB : 0 ≤ ‖B‖)
    (a b w κ : ℝ) (hD : D = ι a • A + (c * ι b) • B) (ha : |a| ≤ w) (hb : |b| ≤ w)
    (hκ : κ = ‖A‖ + ‖c‖ * ‖B‖) :
    ‖D‖ ≤ w * κ :=
  calc ‖D‖
      = ‖ι a • A + (c * ι b) • B‖ := by rw [hD]               -- 1: 差の中間目標
    _ ≤ ‖ι a • A‖ + ‖(c * ι b) • B‖ := htri _ _                -- 2: 三角不等式
    _ = ‖ι a‖ * ‖A‖ + ‖c * ι b‖ * ‖B‖ := by
        rw [hsmul, hsmul]                                     -- 3: 斉次性を 2 項へ
    _ = ‖ι a‖ * ‖A‖ + (‖c‖ * ‖ι b‖) * ‖B‖ := by rw [hmul]     -- 4: `‖kl‖ = ‖k‖‖l‖`
    _ = |a| * ‖A‖ + (‖c‖ * |b|) * ‖B‖ := by rw [hι, hι]       -- 5: `‖ι(r)‖ = |r|` を 2 箇所へ
    _ ≤ w * ‖A‖ + (‖c‖ * w) * ‖B‖ := by gcongr               -- 6: `|a| ≤ w`・`|b| ≤ w` と `‖A‖, ‖c‖, ‖B‖ ≥ 0`
    _ = w * (‖A‖ + ‖c‖ * ‖B‖) := by ring                      -- 7: 実数の四則
    _ = w * κ := by rw [hκ]                                   -- 8: `κ` の定義

/-- **`ε` の鎖**（具体版 `evenOddPartialSum_sub_limit_norm_tendsto`）: `0 ≤ e_N ≤ ((u_N+v_N)/2)κ`、`κ ≥ 0` で、
任意の `δ > 0` に対し十分先で `u_N < δ`・`v_N < δ` なら `e_N → 0`。具体版の 3 段と同じ並びの calc。 -/
theorem evenOdd_err_tendsto' (e u v : ℕ → ℝ) (κ : ℝ) (hκ : 0 ≤ κ) (he0 : ∀ N, 0 ≤ e N)
    (hle : ∀ N, e N ≤ (u N + v N) / 2 * κ)
    (hsmall : ∀ δ > 0, ∃ N0 : ℕ, ∀ N ≥ N0, u N < δ ∧ v N < δ) :
    Tendsto e atTop (𝓝 0) := by
  refine Metric.tendsto_atTop.2 fun ε hε => ?_
  have hδ : 0 < ε / (κ + 1) := by positivity
  obtain ⟨N0, hN0⟩ := hsmall _ hδ
  refine ⟨N0, fun N hN => ?_⟩
  obtain ⟨hu, hv⟩ := hN0 N hN
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (he0 N)]
  calc e N
      ≤ (u N + v N) / 2 * κ := hle N                          -- 1: ノルムの評価
    _ ≤ ε / (κ + 1) * κ := by
        have : (u N + v N) / 2 < ε / (κ + 1) := by linarith
        exact mul_le_mul_of_nonneg_right this.le hκ          -- 2: `(u_N+v_N)/2 < ε/(κ+1)` と `κ ≥ 0`
    _ < ε := by
        rw [div_mul_eq_mul_div, div_lt_iff₀ (by linarith)]
        nlinarith                                             -- 3: `κ < κ + 1` と `ε > 0`

end Ising2D.NecSuf
