/-
# 2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

**本プロジェクトの結論である。**

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`N_row → ∞`） | `onsager_limit_in_N_row`（章 012 の `Ising2D.limit_of_log_Z_in_N_row`） |
| Step 2（`c(M) ≥ c_+(M) = Λ^{(1/2)}_M`） | `EvenSectorBridge.LambdaM_le_rayleighSup`（`c_plus_le_c` と `c_plus_equals_Lambda_half_integer`（`EvenSectorBridge.c_plus_equals_lamMax`）） |
| Step 3（`c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M`） | `onsager_step3_c_le_two_c_plus`（必要十分版 `NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup` の特殊化）と `EvenSectorBridge.rayleighSup_le_two_mul_LambdaM` |
| Step 4（挟み撃ち、`M → ∞`） | `onsager_limit_in_M`（`log` の単調性、`(log 2)/M → 0`、章 012 の `Ising2D.onsager_free_energy_expression` を `δ = 1/2` で適用） |
| 主張 | `onsager_exact_solution` |

Step 3 が使う `ε` の性質は `epsilon_is_real_symmetric`（`εᵀ = ε`）、`epsilon_square_and_eigenvalues`
（`ε² = I`）、`ε` が置換行列であること（`trace_of_epsilon_V_plus` の Step 3 (b)。Lean では
`epsilonR M = permMat flipConf`）で、`W` の性質は `epsilon_commutes_with_W`（`εW = Wε`）と
`W_has_positive_entries`（成分が正。使うのは非負だけ）である。

以前の形式化は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避した
章 019 の `c_equals_c_plus`（`c(M) = max(c_+, c_-) = c_+(M)`）を使って挟み撃ちなしに
`c(M) = Λ^{(1/2)}_M` を出していた。いまは人手の本文と同じく、`c_-(M)` に触れない
`Λ ≤ c(M) ≤ 2Λ` の挟み撃ちで述べる。章 019 の Lean（`Part019/`）は形式化の記録として残してあり、
本ファイルはそれに依存しない。

必要十分版は Step 3 の不等式だけに置く（`NecSuf/EvenSectorUpperBound.lean`）。Step 1・Step 4 は
既存の必要十分版（`NecSuf/LogSqueeze.lean` の `abs_log_div_sub_log_le_of_sandwich`、
`NecSuf/RiemannSum.lean` の `tendsto_riemann_sum`）を章 012 が既に系として使っており、本ファイルは
それらの具体版を接続するだけだからである。
-/
import Ising2D.Part018.Theorem009_CPlusEqualsLambda
import Ising2D.Part011.ClaimCPlusLeC
import Ising2D.NecSuf.EvenSectorUpperBound
import Ising2D.Part012.Claim003_LimitInNRow
import Ising2D.Part012.Theorem005_OnsagerFreeEnergy

namespace Ising2D

open Matrix Filter
open scoped Topology

variable {M : ℕ}

/-! ## Step 3 の不等式 `c(M) ≤ 2c_+(M)` -/

/-- **人手証明 `onsager_exact_solution` Step 3**: 成分が正で `ε` と可換な実対称半正定値行列 `W` について
`c(M) ≤ 2c_+(M)`（必要十分版 `NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup` を
`ε = epsilonR M = permMat flipConf` で特殊化したもの）。 -/
theorem onsager_step3_c_le_two_c_plus {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) :
    rayleighSup W ≤ 2 * evenSectorRayleighSup W (epsilonR M) :=
  NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup hW hpsd (fun k l => (hpos k l).le)
    flipConf_involutive hcomm

namespace EvenSectorBridge

variable {F : CheckFermi M} {D : VPlusData M F} (B : EvenSectorBridge M F D)

/-- `Λ̌_max = Λ^{(1/2)}_M`（章 012 の記法との突き合わせ）。 -/
theorem lamMax_eq_LambdaM (P : IsingParam)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    D.lamMax = LambdaM P (1 / 2) M := by
  unfold VPlusData.lamMax checkLambda LambdaM
  rw [hC]
  congr 1
  congr 1
  rw [← hgam, Finset.mul_sum]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [if_pos (Finset.mem_univ μ)]; ring

/-- **人手証明 Step 2**: `c(M) ≥ c_+(M) = Λ^{(1/2)}_M`
（`c_plus_le_c` と `c_plus_equals_Lambda_half_integer`）。 -/
theorem LambdaM_le_rayleighSup (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    LambdaM P (1 / 2) M ≤ rayleighSup B.W :=
  calc LambdaM P (1 / 2) M
      = evenSectorRayleighSup B.W (epsilonR M) := by
        rw [B.c_plus_equals_lamMax htr, lamMax_eq_LambdaM P hC hgam]
    _ ≤ rayleighSup B.W := c_plus_le_c B.hWsymm B.hWpsd

/-- **人手証明 Step 3**: `c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M`。 -/
theorem rayleighSup_le_two_mul_LambdaM (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hpos : ∀ k l, 0 < B.W k l)
    (hcomm : epsilonR M * B.W = B.W * epsilonR M)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    rayleighSup B.W ≤ 2 * LambdaM P (1 / 2) M :=
  calc rayleighSup B.W
      ≤ 2 * evenSectorRayleighSup B.W (epsilonR M) :=
        onsager_step3_c_le_two_c_plus B.hWsymm B.hWpsd hpos hcomm
    _ = 2 * LambdaM P (1 / 2) M := by
        rw [B.c_plus_equals_lamMax htr, lamMax_eq_LambdaM P hC hgam]

/-- **人手証明 Step 2・Step 3 を合わせた挟み撃ち**: `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`。 -/
theorem rayleighSup_sandwich_LambdaM (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hpos : ∀ k l, 0 < B.W k l)
    (hcomm : epsilonR M * B.W = B.W * epsilonR M)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    LambdaM P (1 / 2) M ≤ rayleighSup B.W ∧ rayleighSup B.W ≤ 2 * LambdaM P (1 / 2) M :=
  ⟨B.LambdaM_le_rayleighSup P htr hC hgam, B.rayleighSup_le_two_mul_LambdaM P htr hpos hcomm hC hgam⟩

end EvenSectorBridge

/-! ## 2 重極限（人手証明 `onsager_exact_solution`） -/

/-- **人手証明 `onsager_exact_solution` Step 1**（章 012 の再掲）:
`M` を固定したときの `N_row → ∞` の極限は `(1/M) log c(M)`。 -/
theorem onsager_limit_in_N_row (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, Z m N ≤ 2 ^ m * cM m ^ N)
    {m : ℕ} (hm : 2 ≤ m) :
    Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
      (𝓝 (1 / (m : ℝ) * Real.log (cM m))) := by
  have hpos : 0 < cM m := lt_of_lt_of_le (LambdaM_pos P (1 / 2) m) (hc m hm).1
  exact limit_of_log_Z_in_N_row hm hpos (hZ1 m hm) (hZ2 m hm)

/-- **人手証明 `onsager_exact_solution` Step 4**: `Λ ≤ c(M) ≤ 2Λ` と `log` の単調性から
`(1/M)log Λ ≤ (1/M)log c(M) ≤ (1/M)log Λ + (log 2)/M`。`(log 2)/M → 0` と
`onsager_free_energy_expression`（`δ = 1/2`）で挟み撃ちにして、`M → ∞` の極限が Onsager の表式になる。 -/
theorem onsager_limit_in_M (P : IsingParam) {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m) :
    Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) := by
  have hbase := onsager_free_energy_expression P (δ := 1 / 2) (by norm_num) (by norm_num)
  have hupper := hbase.add (tendsto_const_div_atTop_nhds_zero_nat (Real.log 2))
  rw [add_zero] at hupper
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hbase hupper ?_ ?_
  · filter_upwards [Filter.eventually_ge_atTop 2] with m hm
    have hΛ : 0 < LambdaM P (1 / 2) m := LambdaM_pos P (1 / 2) m
    have hm0 : (0 : ℝ) ≤ 1 / (m : ℝ) := by positivity
    exact mul_le_mul_of_nonneg_left (Real.log_le_log hΛ (hc m hm).1) hm0
  · filter_upwards [Filter.eventually_ge_atTop 2] with m hm
    have hΛ : 0 < LambdaM P (1 / 2) m := LambdaM_pos P (1 / 2) m
    have hcpos : 0 < cM m := lt_of_lt_of_le hΛ (hc m hm).1
    have hm0 : (0 : ℝ) ≤ 1 / (m : ℝ) := by positivity
    have hlog : Real.log (cM m) ≤ Real.log 2 + Real.log (LambdaM P (1 / 2) m) := by
      rw [← Real.log_mul two_ne_zero hΛ.ne']
      exact Real.log_le_log hcpos (hc m hm).2
    calc 1 / (m : ℝ) * Real.log (cM m)
        ≤ 1 / (m : ℝ) * (Real.log 2 + Real.log (LambdaM P (1 / 2) m)) :=
          mul_le_mul_of_nonneg_left hlog hm0
      _ = 1 / (m : ℝ) * Real.log (LambdaM P (1 / 2) m) + Real.log 2 / (m : ℝ) := by ring

/-- **人手証明 `onsager_exact_solution` そのもの**:

  `lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

**仮定は次の 3 つだけである。**

* `hZ1`, `hZ2`: 章 011 の `partition_function_sandwich`
  （`c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`）
* `hc`: Step 2・Step 3 の挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`
  （`Ising2D.EvenSectorBridge.rayleighSup_sandwich_LambdaM` で与えられる）

**実数解析（Riemann 積分）を使うのは `Ising2D.riemann_sum_to_integral` を経由する
最後の等号だけである**（人手証明の最終段落と同じ）。 -/
theorem onsager_exact_solution (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, Z m N ≤ 2 ^ m * cM m ^ N) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
          (𝓝 (1 / (m : ℝ) * Real.log (cM m))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  ⟨fun m hm => onsager_limit_in_N_row P hc hZ1 hZ2 hm, onsager_limit_in_M P hc⟩

end Ising2D
