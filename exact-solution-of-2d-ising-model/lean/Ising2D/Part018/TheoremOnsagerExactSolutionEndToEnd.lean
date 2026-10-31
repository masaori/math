/-
# 2 次元 Ising 模型の厳密解: 具体的な分配関数から閉形式までの通しの定理

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

`scripts/check-end-to-end.sh` が固定する主張の型をそのまま持つ定理である。入力は結合定数
`K_1, K_2 ∈ ℝ` とその正値性だけで、型は `partitionFunction`（人手 `def_partition_function_2d_ising`）、
`Kstar`（人手 `def_second_dual_coupling_constant`）と mathlib の関数だけで書かれている。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| 結合定数 `K_1, K_2 ∈ ℝ_{>0}`（`def_partition_function_2d_ising`） | `IsingParam` の組 `⟨K1, K2, hK1, hK2⟩` |
| 主張の内側の極限の値 `(1/M) log c(M)` | 存在を主張する `f`（`c(M)` は具体的な `W` の Rayleigh 上限、人手 `def_rayleigh_sup`） |
| Step 1〜Step 3 | `Ising2D.onsager_exact_solution_unconditional`（`Theorem013_OnsagerUnconditional.lean`） |
| `γ(θ) = arccosh(cosh 2K_1 cosh 2K_2^* - sinh 2K_1 sinh 2K_2^* cos θ)`（人手 `def_gamma_theta`） | `gammaFn_eq` と `IsingParam.K2star := Kstar K2` で、閉形式の被積分関数を `gammaFn` を経ない形へ書き直す |

必要十分版は置かない。本ファイルは証明済みの具体版を結合定数の組へ当てはめ、被積分関数を定義どおりに
書き直すだけで、新しい計算を含まないからである。
-/
import Ising2D.Part018.Theorem013_OnsagerUnconditional

namespace Ising2D

open Filter
open scoped Topology

/-- `γ(θ)` を `gammaFn` を経ずに書いた形（`gammaFn_eq` と `IsingParam.K2star := Kstar K2` から）。 -/
theorem gammaFn_eq_arcosh_Kstar (K1 K2 : ℝ) (hK1 : 0 < K1) (hK2 : 0 < K2) (θ : ℝ) :
    gammaFn ⟨K1, K2, hK1, hK2⟩ θ
      = Real.arcosh (Real.cosh (2 * K1) * Real.cosh (2 * Kstar K2)
          - Real.sinh (2 * K1) * Real.sinh (2 * Kstar K2) * Real.cos θ) := by
  rw [gammaFn_eq]
  rfl

/-- **2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）の通しの定理**:
結合定数 `K_1, K_2 > 0` について、`f(M) := (1/M) log c(M)` とおくと

  `lim_{N_row→∞} (1/(M N_row)) log Z(K_1,K_2) = f(M)`（`M ≥ 2`）、
  `lim_{M→∞} f(M) = (1/2) log(2 sinh 2K_2) + (1/4π) ∫₀^{2π} arccosh(cosh 2K_1 cosh 2K_2^* - sinh 2K_1 sinh 2K_2^* cos θ) dθ`。

`Z` は具体的な分配関数 `partitionFunction N M K1 K2`、`K_2^*` は `Kstar K2` である。
結合定数の正値性のほかに仮定を取らない。 -/
theorem onsager_exact_solution_end_to_end (K1 K2 : ℝ) (hK1 : 0 < K1) (hK2 : 0 < K2) :
    ∃ f : ℕ → ℝ,
      (∀ M : ℕ, 2 ≤ M →
        Tendsto (fun N : ℕ => 1 / ((M : ℝ) * N) * Real.log (partitionFunction N M K1 K2))
          atTop (𝓝 (f M)))
      ∧ Tendsto f atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi),
                Real.arcosh (Real.cosh (2 * K1) * Real.cosh (2 * Kstar K2)
                  - Real.sinh (2 * K1) * Real.sinh (2 * Kstar K2) * Real.cos θ))) := by
  obtain ⟨hN, hM⟩ := onsager_exact_solution_unconditional ⟨K1, K2, hK1, hK2⟩
  refine ⟨fun M => 1 / (M : ℝ) * Real.log (rayleighSup (physicalSymTransferR M K1 K2)), hN, ?_⟩
  simpa only [gammaFn_eq_arcosh_Kstar K1 K2 hK1 hK2] using hM

end Ising2D
