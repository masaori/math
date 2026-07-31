/-
# 2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

**本プロジェクトの結論である。**

必要十分版は置かない。本定理は既存の必要十分版（`NecSuf/LogSqueeze.lean` の
`abs_log_div_sub_log_le_of_sandwich`、`NecSuf/RiemannSum.lean` の
`tendsto_riemann_sum`）を章 012 が既に系として使っており、本ファイルはそれらの
具体版（`Ising2D.limit_of_log_Z_in_N_row` / `Ising2D.onsager_free_energy_expression`）を
章 018・019 の結果と接続するだけだからである。

## 人手証明との対応（および意図的な相違点）

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`N_row → ∞`） | `Ising2D.limit_of_log_Z_in_N_row`（章 012、形式化済み） |
| Step 2・Step 3（`Λ ≤ c(M) ≤ 2Λ` の挟み撃ち） | **使わない**。章 019 の `Ising2D.c_equals_c_plus`（無条件）が `c(M) = c_+(M)` を与えるので、本ファイルの `rayleighSup_eq_LambdaM` は挟み撃ちなしに `c(M) = Λ^{(1/2)}_M` を出す |
| Step 4（`M → ∞`） | `Ising2D.onsager_free_energy_expression`（章 012、形式化済み）を `δ = 1/2` で適用 |

**相違点の根拠**: 人手証明が粗い挟み撃ちを採ったのは `c_-(M)` の値に依存しないためだが
（原文 `conversion.notes`）、章 019 の `c_minus_le_c_plus` は `c_-(M) ≤ c_+(M)` を
**無条件に**与えるので、`c_-(M)` の値を知らなくても `c(M) = c_+(M)` が言える。
得られる結論は同じ（挟み撃ち版の `log 2 / M → 0` が不要になるだけ）である。
-/
import Ising2D.Part018.Theorem009_CPlusEqualsLambda
import Ising2D.Part019.Theorem004_CEqualsCPlus
import Ising2D.Part012.Claim003_LimitInNRow
import Ising2D.Part012.Theorem005_OnsagerFreeEnergy

namespace Ising2D

open Matrix Filter
open scoped Topology

variable {M : ℕ}

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

/-- **章 018 の結論を章 019 と合わせた形**: `c(M) = Λ^{(1/2)}_M`。 -/
theorem rayleighSup_eq_LambdaM (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hpos : ∀ k l, 0 < B.W k l)
    (hcomm : epsilonR M * B.W = B.W * epsilonR M)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    rayleighSup B.W = LambdaM P (1 / 2) M := by
  rw [c_equals_c_plus B.hWsymm B.hWpsd hpos hcomm, B.c_plus_equals_lamMax htr,
    lamMax_eq_LambdaM P hC hgam]

end EvenSectorBridge

/-! ## 2 重極限（人手証明 `onsager_exact_solution`） -/

/-- **人手証明 `onsager_exact_solution` Step 1**（章 012 の再掲）:
`M` を固定したときの `N_row → ∞` の極限は `(1/M) log c(M)`。 -/
theorem onsager_limit_in_N_row (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → cM m = LambdaM P (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, Z m N ≤ 2 ^ m * cM m ^ N)
    {m : ℕ} (hm : 2 ≤ m) :
    Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
      (𝓝 (1 / (m : ℝ) * Real.log (cM m))) := by
  have hpos : 0 < cM m := by rw [hc m hm]; exact LambdaM_pos P (1 / 2) m
  exact limit_of_log_Z_in_N_row hm hpos (hZ1 m hm) (hZ2 m hm)

/-- **人手証明 `onsager_exact_solution` Step 4**: `M → ∞` の極限が Onsager の表式になる。 -/
theorem onsager_limit_in_M (P : IsingParam) {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → cM m = LambdaM P (1 / 2) m) :
    Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) := by
  have hbase := onsager_free_energy_expression P (δ := 1 / 2) (by norm_num) (by norm_num)
  refine hbase.congr' ?_
  filter_upwards [Filter.eventually_ge_atTop 2] with m hm
  rw [hc m hm]

/-- **人手証明 `onsager_exact_solution` そのもの**:

  `lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

**仮定は次の 3 つだけである。**

* `hZ1`, `hZ2`: 章 011 の `partition_function_sandwich`
  （`c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`）
* `hc`: 章 018 の結論 `c(M) = Λ^{(1/2)}_M`
  （`Ising2D.EvenSectorBridge.rayleighSup_eq_LambdaM` で与えられる）

**実数解析（Riemann 積分）を使うのは `Ising2D.riemann_sum_to_integral` を経由する
最後の等号だけである**（人手証明の最終段落と同じ）。 -/
theorem onsager_exact_solution (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → cM m = LambdaM P (1 / 2) m)
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
