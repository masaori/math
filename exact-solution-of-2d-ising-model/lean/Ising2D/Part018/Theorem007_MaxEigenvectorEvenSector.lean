/-
# `ε` の固有値は `+1`（最大固有ベクトルは偶セクター）（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_007_theorem_max_eigenvector_in_even_sector`、
ラベル **`max_eigenvector_in_even_sector`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）。本ファイルの内容は
`Claim002`（符号の反転則）と `Claim003`（トレースの符号）の組み合わせであり、
新しい抽象構造は現れない。

## 仮定として残っているもの（一次情報）

人手証明 (1) は `trace_of_epsilon_V_plus`（`tr(εV^{(+)}) > 0` の**直接計算**）を使う。
その直接計算は「1次元開鎖の二つのスピン和」（原文 `def_open_chain_spin_energy`、`open_chain_partition_sum`、
`open_chain_endpoint_product_sum`、`open_chain_spin_sums_positive` と
`H1_plus_in_sigma_z_form`）を要し、本セッションでは形式化していない
（理由は `docs/tasks/2026-07_lean-ch009-013/015_ch018-formalization-findings.md`）。
したがって本ファイルの定理は **`0 < (tr(εV^{(+)})).re` を仮定として受け取る**。
-/
import Ising2D.Part018.Claim003_TraceEpsilonVPlus
import Ising2D.Part019.Claim001_EpsilonSignFlipPermutation

namespace Ising2D

open Matrix

variable {M : ℕ}

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- **人手証明 (1)**: `η_{(1,…,1)} = +1`。 -/
theorem eta_univ_eq_one (htr : 0 < ((epsilon M * D.V).trace).re) :
    F.eta (Finset.univ : Finset (Fin M)) = 1 :=
  D.eta_univ_eq_one_of_trace_pos htr

/-- **人手証明 (2)**: `η_ε = (-1)^{M-|ε|}`。 -/
theorem eta_eq_sign (htr : 0 < ((epsilon M * D.V).trace).re) (T : Finset (Fin M)) :
    F.eta T = (-1 : ℂ) ^ (M - T.card) := by
  rw [F.eta_eq_eta_univ_mul T, D.eta_univ_eq_one htr, one_mul]

/-- **人手証明 (3)**: `ε = (-1)^M ∏_μ (I - 2ň_μ)`。 -/
theorem epsilon_eq_parityProd_of_trace_pos (htr : 0 < ((epsilon M * D.V).trace).re) :
    epsilon M = ((-1 : ℂ) ^ M) • F.parityProd := by
  rw [F.epsilon_eq_parityProd, D.eta_univ_eq_one htr, one_mul]

/-- **人手証明 (4)**: `ε Q̌_{(1,…,1)} = Q̌_{(1,…,1)}`。 -/
theorem epsilon_mul_Qproj_univ (htr : 0 < ((epsilon M * D.V).trace).re) :
    epsilon M * F.Qproj (Finset.univ : Finset (Fin M)) = F.Qproj Finset.univ := by
  rw [F.epsilon_mul_Qproj, D.eta_univ_eq_one htr, one_smul]

/-- **人手証明 (4)**: `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`。 -/
theorem mem_evenSector_of_mem_range_univ (htr : 0 < ((epsilon M * D.V).trace).re)
    {y : Conf M → ℂ} (hy : F.Qproj (Finset.univ : Finset (Fin M)) *ᵥ y = y) :
    epsilon M *ᵥ y = y := by
  calc epsilon M *ᵥ y = epsilon M *ᵥ (F.Qproj Finset.univ *ᵥ y) := by rw [hy]
    _ = (epsilon M * F.Qproj Finset.univ) *ᵥ y := by rw [Matrix.mulVec_mulVec]
    _ = F.Qproj Finset.univ *ᵥ y := by rw [D.epsilon_mul_Qproj_univ htr]
    _ = y := hy

end VPlusData

end Ising2D
