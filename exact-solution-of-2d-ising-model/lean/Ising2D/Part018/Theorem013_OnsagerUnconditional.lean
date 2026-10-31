/-
# Onsager の厳密解から章 014–017 由来の仮定を落とし、分配関数を具体的なものにした版

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

`Ising2D.onsager_exact_solution`（`Theorem010_OnsagerExactSolution.lean`）は、
挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` を仮定 `hc` として受け取る。その `hc` を与える
`Ising2D.EvenSectorBridge.rayleighSup_sandwich_LambdaM` は、章 018 の形式化時点では
`Ising2D.CheckFermi`（章 016）と `Ising2D.VPlusData`（章 015・017）を
**構成できないまま仮定として**受け取っていた。

章 014–017 が main に入ったので、それらは `Ising2D.checkFermiOf`
（`Claim011_CheckFermiFromPart016.lean`）と `Ising2D.vPlusDataOf`
（`Claim012_VPlusDataFromPart017.lean`）で**実際に構成できる**。本ファイルはその
構成を差し込んで、残る仮定を明示的に束ねた版（`Ising2D.onsager_exact_solution_unconditional`）
を立てる。既存の条件つき版は残してある。

## 消えた仮定

| もとの仮定 | 何で埋めたか |
| --- | --- |
| `F : CheckFermi M`（`ψ̌` の CAR と `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | `Ising2D.checkFermiOf`（章 016 `checkPsi_car'` ＋ 本セッションの `checkPsiDag_conjTranspose`） |
| `D.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | `Ising2D.vPlusDataOf`（章 016 `VPlus_eq_smul_checkVprime_of_dual` ＋ 章 017 `constant_c_value_even_sector`） |
| `D.C > 0`、`D.C = (2 sinh 2K_2)^{M/2}` | 同上（`C` は構成で `(2 sinh 2K_2)^{M/2}` に確定する） |
| `D.gam μ > 0`（`γ(θ̃_μ) > 0`） | 章 017 `Ising2D.gammaFn_thetaTilde_pos`（無条件） |
| `∑_μ D.gam μ = ∑_{μ=1}^{M} γ(t^{(M)}_μ)`（`δ = 1/2`） | 本ファイルの `Ising2D.sum_checkGam`（章 017 `tagPoint_half_eq_thetaTilde` の系） |
| `hdual`（双対関係 `c_2 s_2^* = c_2^*`） | `IsingParam.K2star := Kstar K2`（人手 `def_second_dual_coupling_constant`）とし、`IsingParam.c2_mul_s2star_eq_c2star`（人手 `duality_c2_star_eq_s2_star_c2`、`Part008/ClaimDualityC2StarEqS2StarC2.lean`）で証明 |

## 残った仮定（`Ising2D.EvenSectorClosureInput` に束ねた）

いずれも**接続する Lean の補題がまだ無い**ことによる。数学的な穴ではない。

| 場 | 内容 | なぜ消せないか（一次情報） |
| --- | --- | --- |
| `hM` | `M ≠ 0` | 章 016・017 の主張自体が `M ≠ 0` を要求する（`CheckFermiSetup.hM`） |
| `bridge` | 章 011 の実行列 `W` と `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`、`V^{(+)}` が実行列であること） | 章 011 の射影後の複素行列等式は `symmetrized_transfer_matrix_on_sectors` で形式化済み。章 017 の `V^{(+)}` の実行列表示と組み合わせ、実ベクトル上の `EvenSectorBridge.hWV` へ変換する接続が残る |
| `htr` | `tr(εV^{(+)}) > 0` | 章 018 の `closing_004` / `closing_005` / `closing_006`（配置基底での 1 次元開鎖のスピン和）が未形式化 |
| `hWpos`, `hWcomm` | `W` の成分が正・`ε` と可換（`onsager_exact_solution` の Step 3 が使う） | `bridge.W` は抽象的な実行列として受け取っているので、具体的な `W`（`physicalSymTransferR`）についての `W_has_positive_entries` / `epsilon_commutes_with_W`（`Part011/ClaimEpsilonCommutesWithW.lean` で形式化済み）をここへ渡すには、上の `bridge` の接続が要る |

## 分配関数と `c(M)` は具体的なもの

`Z` は具体的な分配関数 `Ising2D.partitionFunction N_row M K_1 K_2`（人手 `def_partition_function_2d_ising`）、
`c(M)` は具体的な対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` の Rayleigh 上限
`rayleighSup (physicalSymTransferR M K_1 K_2)`（人手 `def_rayleigh_sup`）である。
`N_row ≥ 1` での挟み撃ち `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}` は、章 011 の
`Ising2D.partition_function_sandwich_physical`（`Part011/PhysicalPartitionFunctionSandwich.lean`）が与える。
`bridge.W` はまだ抽象的な実行列なので、それが具体的な `W` に一致すること（`hW`）を仮定に残す。
この仮定は `bridge` を具体的な `W` について構成したとき（runbook の項目 3）に消える。
-/
import Ising2D.Part011.PhysicalPartitionFunctionSandwich
import Ising2D.Part018.Claim012_VPlusDataFromPart017
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

/-! ## 残った仮定を束ねた構造 -/

/-- **章 018 の挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` に、いま Lean 側で埋められない入力だけを束ねたもの。**

内訳と「なぜ埋められないか」はファイル冒頭の表を参照。 -/
structure EvenSectorClosureInput (P : IsingParam) (M : ℕ) where
  /-- 章 016・017 が要求する `M ≠ 0` -/
  hM : M ≠ 0
  /-- 章 011 の `W` と章 017 の `V^{(+)}` の実行列上の橋渡し -/
  bridge : EvenSectorBridge M (checkFermiOf P hM) (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star)
  /-- `tr(εV^{(+)}) > 0`（章 018 の `closing_006`。Lean 未形式化） -/
  htr : 0 < ((epsilon M * (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star).V).trace).re
  /-- `W` の成分はすべて正（章 011 の `W_has_positive_entries`。Step 3 が使う） -/
  hWpos : ∀ k l, 0 < bridge.W k l
  /-- `ε` は `W` と可換（章 011 の `epsilon_commutes_with_W`。Step 3 が使う） -/
  hWcomm : epsilonR M * bridge.W = bridge.W * epsilonR M

/-- **`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`**（人手 `onsager_exact_solution` の Step 2・Step 3。
章 014–017 由来の仮定をすべて落とした版）。

もとの `Ising2D.EvenSectorBridge.rayleighSup_sandwich_LambdaM` は `F`, `D`, `hC`, `hgam` を
仮定として受け取っていたが、それらはすべて構成・証明済みになった。 -/
theorem rayleighSup_sandwich_LambdaM_of_input (P : IsingParam) (In : EvenSectorClosureInput P M) :
    LambdaM P (1 / 2) M ≤ rayleighSup In.bridge.W
      ∧ rayleighSup In.bridge.W ≤ 2 * LambdaM P (1 / 2) M :=
  In.bridge.rayleighSup_sandwich_LambdaM P In.htr In.hWpos In.hWcomm rfl (sum_checkGam P M)

/-! ## Onsager の厳密解 -/

/-- **`Ising2D.onsager_exact_solution` から章 014–017 由来の仮定を落とし、分配関数を具体的なものにした版**。

  `lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z(K_1,K_2) = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

`Z` は `partitionFunction N_row M K_1 K_2`、`c(M)` は `rayleighSup (physicalSymTransferR M K_1 K_2)` である。
残る入力は
* `In m hm`: ファイル冒頭の表の 4 つ（章 011・章 018 の未形式化部分）、
* `hW`: `bridge.W` が具体的な `W = V_1^{1/2} V_2 V_1^{1/2}` であること

だけであり、**章 014・015・016・017 に由来する仮定、双対関係、分配関数の挟み撃ちは 1 つも残っていない**。 -/
theorem onsager_exact_solution_unconditional (P : IsingParam)
    (In : ∀ m : ℕ, 2 ≤ m → EvenSectorClosureInput P m)
    (hW : ∀ (m : ℕ) (hm : 2 ≤ m), (In m hm).bridge.W = physicalSymTransferR m P.K1 P.K2) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (partitionFunction N m P.K1 P.K2))
          atTop (𝓝 (1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))
          atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  onsager_exact_solution P (Z := fun m N => partitionFunction N m P.K1 P.K2)
    (cM := fun m => rayleighSup (physicalSymTransferR m P.K1 P.K2))
    (fun m hm => by
      have h := rayleighSup_sandwich_LambdaM_of_input P (In m hm)
      rw [hW m hm] at h
      exact h)
    (fun m _ _ hN => (partition_function_sandwich_physical (M := m) P.K1 P.K2_pos hN).1)
    (fun m _ _ hN => (partition_function_sandwich_physical (M := m) P.K1 P.K2_pos hN).2)

end Ising2D
