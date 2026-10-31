/-
# Onsager の厳密解から章 014–017 由来の仮定を落とし、分配関数を具体的なものにした版

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

`Ising2D.onsager_exact_solution`（`Theorem010_OnsagerExactSolution.lean`）は、
挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` を仮定 `hc` として受け取る。その `hc` を与える
`Ising2D.EvenSectorBridge.rayleighSup_sandwich_LambdaM` は、章 018 の形式化時点では
`Ising2D.CheckFermi`（章 016）と `Ising2D.VPlusData`（章 015・017）を
**構成できないまま仮定として**受け取っていた。

章 014–017 が main に入ったので、それらは `Ising2D.checkFermiOf`
（`Claim011_CheckFermiFromPart016.lean`）と `Ising2D.vPlusDataOf`
（`ClaimVPlusDataFromEigenvaluesOfVPlus.lean`）で**実際に構成できる**。本ファイルはその
構成を差し込み、仮定を一つも取らない版（`Ising2D.onsager_exact_solution_unconditional`）を立てる。既存の条件つき版は残してある。

## 消えた仮定

| もとの仮定 | 何で埋めたか |
| --- | --- |
| `F : CheckFermi M`（`ψ̌` の CAR と `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | `Ising2D.checkFermiOf`（章 016 `checkPsi_car'` ＋ 本セッションの `checkPsiDag_conjTranspose`） |
| `D.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | `Ising2D.vPlusDataOf`（章 016 `VPlus_eq_smul_checkVprime_of_dual` ＋ 章 017 `constant_c_value_even_sector`） |
| `D.C > 0`、`D.C = (2 sinh 2K_2)^{M/2}` | 同上（`C` は構成で `(2 sinh 2K_2)^{M/2}` に確定する） |
| `D.gam μ > 0`（`γ(θ̃_μ) > 0`） | 章 017 `Ising2D.gammaFn_thetaTilde_pos`（無条件） |
| `∑_μ D.gam μ = ∑_{μ=1}^{M} γ(t^{(M)}_μ)`（`δ = 1/2`） | 本ファイルの `Ising2D.sum_checkGam`（章 017 `tagPoint_half_eq_thetaTilde` の系） |
| `hdual`（双対関係 `c_2 s_2^* = c_2^*`） | `IsingParam.K2star := Kstar K2`（人手 `def_second_dual_coupling_constant`）とし、`IsingParam.c2_mul_s2star_eq_c2star`（人手 `duality_c2_star_eq_s2_star_c2`、`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean`）で証明 |
| `htr`（`tr(εV^{(+)}) > 0`）と `hM`（`M ≠ 0`） | `Ising2D.trace_epsilon_vPlusDataOf_pos`（人手 `trace_of_epsilon_V_plus`、`ClaimTraceEpsilonVPlusClosedForm.lean`）。`M ≠ 0` は `2 ≤ M` から出す |
| `hWpos`（具体的な `W` の成分が正） | `Ising2D.physicalSymTransferR_pos`（人手 `W_has_positive_entries`、`Part011/ClaimPhysicalWHasPositiveEntries.lean`） |
| `hWcomm`（`ε` と具体的な `W` の可換性） | `Ising2D.epsilon_commutes_with_W`（人手 `epsilon_commutes_with_W`、`Part011/ClaimEpsilonCommutesWithW.lean`） |
| `bridge`（章 011 の実行列 `W` と `V^{(+)}` の橋渡し）と `hW`（`bridge.W` が具体的な `W` であること） | `Ising2D.physicalEvenSectorBridge`（`PhysicalEvenSectorBridge.lean`）。具体的な `W` について、章 011 の `W_is_real_symmetric_positive_definite` と、`c_plus_equals_Lambda_half_integer` の Step 0・Step 2 の実行列表示を組み合わせて構成する |

## 残った仮定

無い。`Ising2D.onsager_exact_solution_unconditional` の入力は結合定数の組 `P : IsingParam`
（`K_1, K_2` と `K_1 > 0`、`K_2 > 0`）だけである。

## 分配関数と `c(M)` は具体的なもの

`Z` は具体的な分配関数 `Ising2D.partitionFunction N_row M K_1 K_2`（人手 `def_partition_function_2d_ising`）、
`c(M)` は具体的な対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` の Rayleigh 上限
`rayleighSup (physicalSymTransferR M K_1 K_2)`（人手 `def_rayleigh_sup`）である。
`N_row ≥ 1` での挟み撃ち `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}` は、章 011 の
`Ising2D.partition_function_sandwich_physical`（`Part011/PhysicalPartitionFunctionSandwich.lean`）が与える。
Step 1 で `log c(M)` を定めるための `c(M) > 0` は、人手 `limit_of_log_Z_in_N_row` と同じく `def_rayleigh_sup` から
（`W` の正定値性と `rayleighSup_pos` で）出す（`onsager_limit_in_N_row_physical`）。挟み撃ち `Λ ≤ c(M)` からは出さない。
`c_+(M)` を経る挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` も、同じ具体的な `W` についての橋渡し
`Ising2D.physicalEvenSectorBridge` から得る。
-/
import Ising2D.Part011.PhysicalPartitionFunctionSandwich
import Ising2D.Part011.ClaimPhysicalWHasPositiveEntries
import Ising2D.Part011.ClaimEpsilonCommutesWithW
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.Part018.PhysicalEvenSectorBridge
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusClosedForm
import Ising2D.Part018.Theorem010_OnsagerExactSolution

namespace Ising2D

open Matrix Filter
open scoped Topology

variable {M : ℕ}

/-! ## `∑_μ γ(θ̃_μ)` と章 012 の代表点の和の一致 -/

/-- `∑_{μ∈𝓜̌} γ(θ̃_μ) = ∑_{μ=1}^{M} γ(t^{(M)}_μ)|_{δ=1/2}`。

`Ising2D.EvenSectorBridge.lamMax_eq_LambdaM` の仮定 `hgam` を埋める。 -/
theorem sum_checkGam (P : IsingParam) (M : ℕ) :
    ∑ j : Fin M, checkGam P M j
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ) := by
  rw [Ising2D.sum_Icc_one_eq_sum_range,
    ← Fin.sum_univ_eq_sum_range (fun k : ℕ => gammaFn P (tagPoint (1 / 2) M (k + 1))) M]
  exact Finset.sum_congr rfl fun j _ => by rw [tagPoint_half_eq_thetaTilde]; rfl

/-! ## 挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` -/

/-- **`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`**（人手 `c_between_Lambda_half_and_twice_Lambda_half`。
章 014–017 由来の仮定をすべて落とした版）。

もとの `Ising2D.EvenSectorBridge.rayleighSup_sandwich_LambdaM` は `F`, `D`, `hC`, `hgam` を
仮定として受け取っていたが、それらはすべて構成・証明済みになった。`W` は具体的な
`W = V_1^{1/2} V_2 V_1^{1/2}` で、その橋渡しは `Ising2D.physicalEvenSectorBridge`、
成分の正値性は `Ising2D.physicalSymTransferR_pos`、`ε` との可換性は `Ising2D.epsilon_commutes_with_W` が与える。 -/
theorem rayleighSup_sandwich_LambdaM_physical (P : IsingParam) (hM2 : 2 ≤ M) :
    LambdaM P (1 / 2) M ≤ rayleighSup (physicalSymTransferR M P.K1 P.K2)
      ∧ rayleighSup (physicalSymTransferR M P.K1 P.K2) ≤ 2 * LambdaM P (1 / 2) M :=
  have hM : M ≠ 0 := by omega
  (physicalEvenSectorBridge P hM2 hM).rayleighSup_sandwich_LambdaM P (trace_epsilon_vPlusDataOf_pos P hM2 hM)
    (physicalSymTransferR_pos P.K1 P.K2) (epsilon_commutes_with_W P.K1 P.K2_pos) rfl (sum_checkGam P M)

/-! ## Step 1: `N_row → ∞` の極限（`c(M) > 0` は `def_rayleigh_sup` から） -/

/-- **人手 `limit_of_log_Z_in_N_row` を具体的な `Z` と `c(M)` に適用したもの**（人手 `onsager_exact_solution` の Step 1）:

  `lim_{N_row→∞} (1/(M N_row)) log Z(K_1,K_2) = (1/M) log c(M)`

人手 `limit_of_log_Z_in_N_row` の証明冒頭の「`def_rayleigh_sup` より `c > 0`」は、
`W = physicalSymTransferR M K_1 K_2` が実対称（`physicalSymTransferR_isSymm`）かつ正定値
（`physicalSymTransferR_posDef`）であることから `rayleighSup_pos` で出す。
挟み込み `c^{N_row} ≤ Z ≤ 2^M c^{N_row}` は `partition_function_sandwich_physical`
（人手 `partition_function_sandwich`）が与える。 -/
theorem onsager_limit_in_N_row_physical (P : IsingParam) {m : ℕ} (hm : 2 ≤ m) :
    Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (partitionFunction N m P.K1 P.K2))
      atTop (𝓝 (1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))) :=
  limit_of_log_Z_in_N_row hm
    (rayleighSup_pos (physicalSymTransferR_isSymm P.K1 P.K2_pos)
      (physicalSymTransferR_posDef P.K1 P.K2_pos))
    (fun _ hN => (partition_function_sandwich_physical (M := m) P.K1 P.K2_pos hN).1)
    (fun _ hN => (partition_function_sandwich_physical (M := m) P.K1 P.K2_pos hN).2)

/-! ## Onsager の厳密解 -/

/-- **`Ising2D.onsager_exact_solution` から章 014–017 由来の仮定を落とし、分配関数を具体的なものにした版**。

  `lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z(K_1,K_2) = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

`Z` は `partitionFunction N_row M K_1 K_2`、`c(M)` は `rayleighSup (physicalSymTransferR M K_1 K_2)` である。
入力は結合定数の組 `P` だけであり、**章 014・015・016・017 に由来する仮定、双対関係、分配関数の挟み撃ち、
`W` と `V^{(+)}` の橋渡し、`W` の成分の正値性と `ε` との可換性は 1 つも残っていない**。 -/
theorem onsager_exact_solution_unconditional (P : IsingParam) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (partitionFunction N m P.K1 P.K2))
          atTop (𝓝 (1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))
          atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  ⟨fun _ hm => onsager_limit_in_N_row_physical P hm,
    onsager_limit_in_M P (cM := fun m => rayleighSup (physicalSymTransferR m P.K1 P.K2))
      (fun _ hm => rayleighSup_sandwich_LambdaM_physical P hm)⟩

end Ising2D
