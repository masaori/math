/-
# 008 章の議論が `(-)` セクター専用である理由（**具体版**）

対応する人手証明のラベル: `why_008_applies_only_to_minus_sector`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_001_claim_why_minus_only`）

**抽象版**は既存の `Ising2D/Abstract/CommutatorClifford.lean`
（`Ising2D.Abstract.CliffordTriple.lie_sum_zy_z` / `lie_sum_zy_z'`）。
2 本の交換子の差は、抽象版では**スカラー関数 `Dz` と `Dz'` の差**として現れる:

  `Dz (μ,ν)  = 2M δ^M_{μ+ν,0}`（`hat(Z)^{(±)}` どうし）
  `Dz'(μ,ν)  = 2M δ^M_{μ+ν,0} - 4 e^{-i2π(μ+ν)/M}`（`hat(Z)^{(±)}` と `hat(Z)^{(∓)}`）

余分な項 `-4 e^{…}` がそのまま `4 e^{-iθ_μ} Y_1` になる。
すなわち**「`(+)` セクターで壊れる」の中身は、`Dz ≠ Dz'` のただ 1 点**である。
（013 章の `check(Z)` では `Dz = Dz'` になる。`Part013/Claim004_CommutatorHCheckZY.lean` 参照。）

## 原文の主張（`μ ∈ ℳ`）

  `[H_2, hat(Z)_μ^{(-)}] = -2 hat(Y)_μ`
  `[H_2, hat(Z)_μ^{(+)}] = -2 hat(Y)_μ + 4 e^{-i2πμ/M} Y_1`

とくに `Y_1 ≠ 0` なので `[H_2, hat(Z)_μ^{(+)}] ≠ -2 hat(Y)_μ`。

## 形式化の状況

2 つの等式は**すでに `Part008/Claim001_CommutatorHZY.lean` で証明済み**である
（`Ising2D.lie_H2_hatZMinus`, `Ising2D.lie_H2_hatZPlus`）。013 章の
`why_008_applies_only_to_minus_sector` は、これに「2 つは一致しない」という
不等式を足したものなので、本ファイルではその不等式だけを新たに証明する。

なお `lie_H2_hatZPlus` の右辺（`+4 e^{-iθ_μ} Y_1`）は、008 章の原文 (5) の
**訂正版**である（原文 (5) は符号と係数を誤っている。`Part008/Claim001_CommutatorHZY.lean`
の冒頭コメント参照）。013 章の本文はこの訂正後の値を採用しており、Lean と一致する。
-/
import Ising2D.Part008.Claim001_CommutatorHZY

namespace Ising2D

variable {M : ℕ}

/-- **原文第 1 式**: `[H_2, hat(Z)_μ^{(-)}] = -2 hat(Y)_μ`（`Part008` の再掲）。 -/
theorem lie_H2_hatZMinus_eq (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZMinus M μ⁆ = (-2 : ℂ) • hatY M μ :=
  lie_H2_hatZMinus hM μ

/-- **原文第 2 式**: `[H_2, hat(Z)_μ^{(+)}] = -2 hat(Y)_μ + 4 e^{-i2πμ/M} Y_1`（`Part008` の再掲）。 -/
theorem lie_H2_hatZPlus_eq (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZPlus M μ⁆
      = (-2 : ℂ) • hatY M μ + (4 * expPhase M μ) • Y (firstSite M hM) :=
  lie_H2_hatZPlus hM μ

/-- **原文の結論**: `[H_2, hat(Z)_μ^{(+)}] ≠ -2 hat(Y)_μ`。

差は `4 e^{-iθ_μ} Y_1` で、`Y_1` は `Y_1^2 = I` より `0` でなく、
位相因子 `e^{-iθ_μ}` も `0` でないので消えない。
したがって `commutator_of_H_and_Z_Y` (C) を土台にする 008 章以降の議論は
`(-)` セクター専用であり、`V^{(+)}` にはそのまま適用できない。 -/
theorem lie_H2_hatZPlus_ne_lie_H2_hatZMinus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZPlus M μ⁆ ≠ (-2 : ℂ) • hatY M μ := by
  rw [lie_H2_hatZPlus hM μ]
  intro h
  have hz : (4 * expPhase M μ) • Y (firstSite M hM) = 0 := by
    refine add_left_cancel (a := (-2 : ℂ) • hatY M μ) ?_
    rw [add_zero]
    exact h
  rcases smul_eq_zero.1 hz with hc | hy
  · exact (mul_ne_zero (by norm_num) (expPhase_ne_zero M μ)) hc
  · exact Y_ne_zero _ hy

/-- 同じことを「2 つの交換子が一致しない」形で述べたもの。 -/
theorem lie_H2_hatZPlus_ne_hatZMinus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZPlus M μ⁆ ≠ ⁅H2 M, hatZMinus M μ⁆ := by
  rw [lie_H2_hatZMinus hM μ]
  exact lie_H2_hatZPlus_ne_lie_H2_hatZMinus hM μ

end Ising2D
