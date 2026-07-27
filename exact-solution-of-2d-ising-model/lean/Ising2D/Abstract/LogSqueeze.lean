/-
# `log` の単調性による挟み撃ちと、`log` の分解（抽象版）

対応する人手証明のラベル: `limit_of_log_Z_in_N_row`, `onsager_free_energy_expression`
具体版: `Ising2D/Part012/Claim003_LimitInNRow.lean`,
`Ising2D/Part012/Theorem005_OnsagerFreeEnergy.lean`

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 `limit_of_log_Z_in_N_row` は「分配関数 `Z`」「Rayleigh 上限 `c(M)`」「鎖の長さ `M`」
「行数 `N_row`」という Ising 模型の言葉で書かれているが、証明に効いているのは次だけである。

* 挟み撃ちが `c^N ≤ Z ≤ B c^N` の形（`c > 0`, `B ≥ 1`）であること。
  **`B = 2^M` という具体形は効いていない**（`M` も `2` も出てこない）。
* `log` が `ℝ_{>0}` 上で単調増加であること、`log(xy) = log x + log y`、`log(x^N) = N log x`。
* **行列も、転送行列も、跡も、固有値も一切効いていない。** 主張は実数列についてのものである。
* さらに `M` で割る操作は**線型な後処理**にすぎず、人手証明が得ている評価
  `|log Z/(MN) - log c/M| ≤ log 2/N` は、抽象版の `|log Z/N - log c| ≤ log B/N` の両辺を
  `M` で割り、`log B = log 2^M = M log 2` が約分された結果にすぎない。

`onsager_free_energy_expression` の側で効いているのは
`log(A^{M/2} e^{S}) = (M/2) log A + S`（`A > 0`）という分解と、
収束列の定数倍・定数加算が収束することだけである。**Ising 模型の構造は何も効いていない。**
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.Algebra.Order.Field

namespace Ising2D.Abstract

open Filter
open scoped Topology

/-- **抽象版の挟み撃ち評価**: `c^N ≤ Z ≤ B c^N`（`c > 0`, `B ≥ 1`, `N ≥ 1`）なら
`|log Z / N - log c| ≤ log B / N`。 -/
theorem abs_log_div_sub_log_le_of_sandwich {c B Z : ℝ} {N : ℕ} (hN : 0 < N)
    (hc : 0 < c) (hB : 1 ≤ B) (h1 : c ^ N ≤ Z) (h2 : Z ≤ B * c ^ N) :
    |Real.log Z / N - Real.log c| ≤ Real.log B / N := by
  have hNR : (0 : ℝ) < N := by exact_mod_cast hN
  have hcN : (0 : ℝ) < c ^ N := pow_pos hc N
  have hZ : 0 < Z := lt_of_lt_of_le hcN h1
  have hBpos : (0 : ℝ) < B := lt_of_lt_of_le one_pos hB
  have hlogB : 0 ≤ Real.log B := Real.log_nonneg hB
  -- `log` の単調性（下から）
  have hlow : (N : ℝ) * Real.log c ≤ Real.log Z := by
    have h := Real.log_le_log hcN h1
    rwa [Real.log_pow] at h
  -- `log` の単調性（上から）と `log(ab) = log a + log b`
  have hhigh : Real.log Z ≤ Real.log B + (N : ℝ) * Real.log c := by
    have h := Real.log_le_log hZ h2
    rwa [Real.log_mul (ne_of_gt hBpos) (ne_of_gt hcN), Real.log_pow] at h
  have hd1 : Real.log c ≤ Real.log Z / N := by
    rw [le_div_iff₀ hNR]
    linarith
  have hd2 : Real.log Z / N ≤ Real.log B / N + Real.log c := by
    have hkey : (Real.log B / N + Real.log c) * N = Real.log B + (N : ℝ) * Real.log c := by
      field_simp
    rw [div_le_iff₀ hNR, hkey]
    linarith
  have hBdiv : 0 ≤ Real.log B / N := by positivity
  rw [abs_le]
  exact ⟨by linarith, by linarith⟩

/-- `A > 0` のとき `log (A^{r} e^{S}) = r log A + S`。 -/
theorem log_rpow_mul_exp {A : ℝ} (hA : 0 < A) (r S : ℝ) :
    Real.log (A ^ r * Real.exp S) = r * Real.log A + S := by
  rw [Real.log_mul (by positivity) (Real.exp_ne_zero S), Real.log_rpow hA, Real.log_exp]

/-- **抽象版の後処理**: 収束列のアフィン変換は収束する。
人手証明の「収束する実数列の定数倍・定数加算はそれぞれ収束する」に対応。 -/
theorem tendsto_affine {u : ℕ → ℝ} {L : ℝ} (α β : ℝ) (hu : Tendsto u atTop (𝓝 L)) :
    Tendsto (fun n => α + β * u n) atTop (𝓝 (α + β * L)) :=
  (hu.const_mul β).const_add α

end Ising2D.Abstract
