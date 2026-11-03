/-
# 行列乗算の左右の因子についての連続性と、収束する数の列によるスカラー倍の収束（必要十分版）

具体版: `Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimMatrixMultiplicationContinuity.lean`
（人手 `matrix_multiplication_continuity`）、
`Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimMatrixMultiplicationContinuityInRightFactor.lean`
（人手 `matrix_multiplication_continuity_in_right_factor`）と
`Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimScalarSequenceTimesMatrixConverges.lean`
（人手 `scalar_sequence_times_matrix_converges`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_mul_right_tendsto`（右分配則 → 劣乗法性 → 定数倍の極限と挟み撃ち） | `mul_right_tendsto'`（同じ並び） |
| `matrix_mul_left_tendsto`（左分配則 → 劣乗法性 → 定数倍の極限と挟み撃ち） | `mul_left_tendsto'`（同じ並び） |
| `smul_matrix_tendsto`（係数の差のくくり出し → `‖cA‖ = |c|‖A‖` → 定数倍の極限） | `smul_tendsto'`（同じ並び） |

## 何が効いているか / 効いていないか

- 左の因子が動く乗算の連続性（`mul_right_tendsto'`）で効いているのは、差に対する右分配則 `xb − yb = (x − y)b`（仮定 `hdist`）、
  劣乗法性（仮定 `hmul`）、ノルムの非負性（仮定 `hnn`）だけである。左分配則は効いていない。右分配則と左分配則の役割が入れ替わるほかは、効いていない構造は下の右の因子の場合と同じである。
- 右の因子が動く乗算の連続性（`mul_left_tendsto'`）で効いているのは、差に対する左分配則 `bx − by = b(x − y)`（仮定 `hdist`）、
  劣乗法性 `‖ab‖ ≤ ‖a‖‖b‖`（仮定 `hmul`）、ノルムが非負であること（仮定 `hnn`。挟み撃ちに要る）だけである。
  元の集合には `Norm`・`Sub`・`Mul` だけを置いた。**加法そのもの（結合則・交換則・零・逆元）、三角不等式、距離の構造、
  乗法の結合則・単位元・可換則、右分配則、行列であること、係数が `ℂ` であることは効いていない。**
  分配則と劣乗法性は `NonUnitalSeminormedRing` の一部だが、そのクラスはこれらの効いていない構造を連れてくるので、型クラスにせず仮定にした。
- スカラー倍の収束で効いているのは、係数の差のくくり出し `ax − bx = (a − b)x`（仮定 `hsub`）と、
  `‖ax‖ = ‖a‖‖x‖`（仮定 `hnorm`）だけである。係数の集合にも元の集合にも `Norm`・`Sub` だけを置いた。
  **ノルムの非負性（等号の列なので挟み撃ちが要らない）、加法、三角不等式、加群の公理、係数の乗法は効いていない。**
  極限の段だけなら `‖ax‖ ≤ ‖a‖‖x‖` で足りるが、人手の 2 行目は等号なので、手順を揃えるため等号を仮定に置いた。
-/
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Analysis.SpecificLimits.Basic

namespace Ising2D.NecSuf

open Filter Topology

/-- **`‖A_N − A‖ → 0` なら `‖A_NB − AB‖ → 0`**（具体版 `matrix_mul_right_tendsto`）。 -/
theorem mul_right_tendsto' {R : Type*} [Norm R] [Sub R] [Mul R]
    (hnn : ∀ x : R, 0 ≤ ‖x‖)
    (hdist : ∀ b x y : R, x * b - y * b = (x - y) * b)
    (hmul : ∀ a b : R, ‖a * b‖ ≤ ‖a‖ * ‖b‖)
    (B : R) (A : ℕ → R) (Alim : R) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖A N * B - Alim * B‖) atTop (𝓝 0) := by
  have hle : ∀ N, ‖A N * B - Alim * B‖ ≤ ‖A N - Alim‖ * ‖B‖ := fun N =>
    calc ‖A N * B - Alim * B‖
        = ‖(A N - Alim) * B‖ := by rw [hdist]           -- 右分配則
      _ ≤ ‖A N - Alim‖ * ‖B‖ := hmul _ _                -- 劣乗法性
  -- 収束する実数列に定数を掛けた列の極限
  have h0 : Tendsto (fun N => ‖A N - Alim‖ * ‖B‖) atTop (𝓝 0) := by
    simpa using h.mul_const ‖B‖
  exact squeeze_zero (fun _ => hnn _) hle h0

/-- **`‖A_N − A‖ → 0` なら `‖BA_N − BA‖ → 0`**（具体版 `matrix_mul_left_tendsto`）。 -/
theorem mul_left_tendsto' {R : Type*} [Norm R] [Sub R] [Mul R]
    (hnn : ∀ x : R, 0 ≤ ‖x‖)
    (hdist : ∀ b x y : R, b * x - b * y = b * (x - y))
    (hmul : ∀ a b : R, ‖a * b‖ ≤ ‖a‖ * ‖b‖)
    (B : R) (A : ℕ → R) (Alim : R) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖B * A N - B * Alim‖) atTop (𝓝 0) := by
  have hle : ∀ N, ‖B * A N - B * Alim‖ ≤ ‖B‖ * ‖A N - Alim‖ := fun N =>
    calc ‖B * A N - B * Alim‖
        = ‖B * (A N - Alim)‖ := by rw [hdist]           -- 左分配則
      _ ≤ ‖B‖ * ‖A N - Alim‖ := hmul _ _                -- 劣乗法性
  -- 収束する実数列に定数を掛けた列の極限
  have h0 : Tendsto (fun N => ‖B‖ * ‖A N - Alim‖) atTop (𝓝 0) := by
    simpa using h.const_mul ‖B‖
  exact squeeze_zero (fun _ => hnn _) hle h0

/-- **`|c_N − c| → 0` なら `‖c_NA − cA‖ → 0`**（具体版 `smul_matrix_tendsto`）。 -/
theorem smul_tendsto' {𝕜 E : Type*} [Norm 𝕜] [Sub 𝕜] [Norm E] [Sub E] [SMul 𝕜 E]
    (hsub : ∀ (a b : 𝕜) (x : E), a • x - b • x = (a - b) • x)
    (hnorm : ∀ (a : 𝕜) (x : E), ‖a • x‖ = ‖a‖ * ‖x‖)
    (c : ℕ → 𝕜) (clim : 𝕜) (A : E) (h : Tendsto (fun N => ‖c N - clim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖c N • A - clim • A‖) atTop (𝓝 0) := by
  have heq : ∀ N, ‖c N • A - clim • A‖ = ‖c N - clim‖ * ‖A‖ := fun N =>
    calc ‖c N • A - clim • A‖
        = ‖(c N - clim) • A‖ := by rw [hsub]            -- 係数の差のくくり出し
      _ = ‖c N - clim‖ * ‖A‖ := hnorm _ _               -- `‖ax‖ = ‖a‖‖x‖`
  -- 収束する実数列に定数を掛けた列の極限
  simp_rw [heq]
  simpa using h.mul_const ‖A‖

end Ising2D.NecSuf
