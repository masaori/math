/-
# Onsager の厳密解から章 014–017 由来の仮定を落とした版

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**）

`Ising2D.onsager_exact_solution`（`Theorem010_OnsagerExactSolution.lean`）は、
`c(M) = Λ^{(1/2)}_M` を仮定 `hc` として受け取る。その `hc` を与える
`Ising2D.EvenSectorBridge.rayleighSup_eq_LambdaM` は、章 018 の形式化時点では
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

## 残った仮定（`Ising2D.EvenSectorClosureInput` に束ねた）

いずれも**章 018 の外側が Lean 未形式化**であることによる。数学的な穴ではない。

| 場 | 内容 | なぜ消せないか（一次情報） |
| --- | --- | --- |
| `hM` | `M ≠ 0` | 章 016・017 の主張自体が `M ≠ 0` を要求する（`CheckFermiSetup.hM`） |
| `hdual` | 双対関係 `c_2 s_2^* = c_2^*` | 章 016 の結論に残る唯一の仮定（`lean/docs/ch016-formalization.md` 3 章）。008 章以来 `det A(θ) = 1` に必要で、原文が置いている関係である |
| `bridge` | 章 011 の実行列 `W` と `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`、`V^{(+)}` が実行列であること） | 章 011 の `symmetrized_transfer_matrix_on_sectors` は Lean 未形式化。004 章の `V1_restriction_to_eigenspaces` に依存し、それも未形式化（`Part010/Claim011_SectorReplacement.lean` の `hres` が同じ仮定を置いている） |
| `htr` | `tr(εV^{(+)}) > 0` | 章 018 の `closing_004` / `closing_005` / `closing_006`（配置基底での 1 次元開鎖のスピン和）が未形式化 |
| `hWpos`, `hWcomm` | `W` の成分が正・`ε` と可換 | 章 010 の `V2_component_equals_pauli` / `epsilon_commutes_with_transfer_matrices` に依存する（章 011 も同じ形で仮定として受け取っている） |

`hZ1` / `hZ2`（`c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`）は章 011
`Ising2D.partition_function_sandwich` の内容であり、章 018 の仮定ではないのでそのまま残す。
-/
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

/-- **章 018 の結論 `c(M) = Λ^{(1/2)}_M` に、いま Lean 側で埋められない入力だけを束ねたもの。**

内訳と「なぜ埋められないか」はファイル冒頭の表を参照。 -/
structure EvenSectorClosureInput (P : IsingParam) (M : ℕ) where
  /-- 章 016・017 が要求する `M ≠ 0` -/
  hM : M ≠ 0
  /-- 双対関係 `c_2 s_2^* = c_2^*`（章 016 に残る唯一の仮定） -/
  hdual : P.const.c2 * P.const.s2star = P.const.c2star
  /-- 章 011 の `W` と章 017 の `V^{(+)}` の橋渡し（章 011 (2) は Lean 未形式化） -/
  bridge : EvenSectorBridge M (checkFermiOf P hM) (vPlusDataOf P hM hdual)
  /-- `tr(εV^{(+)}) > 0`（章 018 の `closing_006`。Lean 未形式化） -/
  htr : 0 < ((epsilon M * (vPlusDataOf P hM hdual).V).trace).re
  /-- `W` の成分はすべて正（章 010 の `V2_component_equals_pauli`） -/
  hWpos : ∀ k l, 0 < bridge.W k l
  /-- `ε` は `W` と可換（章 010 の `epsilon_commutes_with_transfer_matrices`） -/
  hWcomm : epsilonR M * bridge.W = bridge.W * epsilonR M

/-- **`c(M) = Λ^{(1/2)}_M`**（章 014–017 由来の仮定をすべて落とした版）。

もとの `Ising2D.EvenSectorBridge.rayleighSup_eq_LambdaM` は `F`, `D`, `hC`, `hgam` を
仮定として受け取っていたが、それらはすべて構成・証明済みになった。 -/
theorem rayleighSup_eq_LambdaM_of_input (P : IsingParam) (In : EvenSectorClosureInput P M) :
    rayleighSup In.bridge.W = LambdaM P (1 / 2) M :=
  In.bridge.rayleighSup_eq_LambdaM P In.htr In.hWpos In.hWcomm rfl (sum_checkGam P M)

/-! ## Onsager の厳密解 -/

/-- **`Ising2D.onsager_exact_solution` から章 014–017 由来の仮定を落とした版**。

残る入力は
* `In m hm`: ファイル冒頭の表の 5 つ（章 011・章 018 の未形式化部分と双対関係）、
* `hcM`: `c(M)` が `W` の Rayleigh 上限であること（`c(M)` の定義そのもの）、
* `hZ1` / `hZ2`: 章 011 の `partition_function_sandwich`

だけであり、**章 014・015・016・017 に由来する仮定は 1 つも残っていない**
（双対関係 `hdual` は章 008 以来の原文の前提であって、形式化の穴ではない）。 -/
theorem onsager_exact_solution_unconditional (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (In : ∀ m : ℕ, 2 ≤ m → EvenSectorClosureInput P m)
    (hcM : ∀ (m : ℕ) (hm : 2 ≤ m), cM m = rayleighSup (In m hm).bridge.W)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, Z m N ≤ 2 ^ m * cM m ^ N) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
          (𝓝 (1 / (m : ℝ) * Real.log (cM m))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  onsager_exact_solution P
    (fun m hm => by rw [hcM m hm, rayleighSup_eq_LambdaM_of_input P (In m hm)]) hZ1 hZ2

end Ising2D
