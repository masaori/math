/-
# `check(Z)`, `check(Y)` の反交換関係（**具体版**）

対応する人手証明のラベル: `anticommutator_of_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_005_claim_anticommutator_check_Z_Y`）

**抽象版**は `Ising2D/Abstract/AntiperiodicFourier.lean` の
`Ising2D.Abstract.acomm_antiperiodic_fourier_clifford`（同じラベル）。
抽象版からの導出は `Ising2D/Part013/Claim005_AnticommutatorCheckZYAbstract.lean`。

## 原文の主張（`μ, ν ∈ 𝓜̌`）

  `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`
  `[check(Z)_μ, check(Y)_ν]₊ = 0`
  `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`

## 形式化の方針

* まず `μ, ν ∈ ℤ` 全体で `δ^M_{(μ+ν,1)}`（合同式の形）で述べ、
  そのあと `def_check_index_set` (5)（`Ising2D.deltaMod_add_one_eq`）で
  `μ, ν ∈ 𝓜̌` の場合の `δ_{ν, M+1-μ}` に落とす。原文の構成と同じ順序である。
* 対になる添字が `μ+ν ≡ 1` になるのは、奇数周波数の和
  `(2μ-1) + (2ν-1) = 2(μ+ν-1)` の `-1` に由来する（この 1 点だけ）。
-/
import Ising2D.Part013.Claim003b_ConjugateIndex
import Ising2D.Part007.Claim000_AnticommutatorHatZHatY

namespace Ising2D

variable {M : ℕ}

/-- 半整数運動量の位相因子の積: `e^{-ijθ~_μ} e^{-ijθ~_ν} = e^{-i j·2π(μ+ν-1)/M}`。

**奇数 + 奇数 = 偶数**（`(2μ-1)+(2ν-1) = 2(μ+ν-1)`）なので、積は整数運動量の位相に戻る。
`μ+ν ≡ 0` ではなく `μ+ν ≡ 1` が対の条件になるのは、この `-1` のためである。 -/
theorem checkPhase_site_mul (hM : M ≠ 0) (j : Fin M) (μ ν : ℤ) :
    checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν
      = expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) := by
  rw [checkPhase, checkPhase, ← expPhase_add,
    show (((j : ℕ) : ℤ) + 1) * (2 * μ - 1) + (((j : ℕ) : ℤ) + 1) * (2 * ν - 1)
      = 2 * ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) by ring,
    expPhase_two_mul hM]

/-- `δ^M_{(μ+ν-1, 0)} = δ^M_{(μ+ν, 1)}`（`deltaMod` の書き換え）。 -/
theorem deltaMod_sub_one (M : ℕ) (μ ν : ℤ) :
    deltaMod M (μ + ν - 1) 0 = deltaMod M (μ + ν) 1 := by
  rw [deltaMod, deltaMod, sub_zero]

/-! ## 原文の 3 つの反交換関係（`μ, ν ∈ ℤ` 版） -/

/-- **原文第 1 式（合同式版）**: `[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkZ_checkZ (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  rw [checkZ, checkZ, acomm_sum_smul_clifford _ _ _ _ acomm_Z_Z_clifford]
  congr 1
  have hterm : ∀ j : Fin M,
      checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν * 2
        = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) := by
    intro j
    rw [checkPhase_site_mul hM]
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.mul_sum, expPhase_sum hM,
    deltaMod_sub_one]
  ring

/-- **原文第 3 式（合同式版）**: `[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkY_checkY (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  rw [checkY, checkY, acomm_sum_smul_clifford _ _ _ _ acomm_Y_Y_clifford]
  congr 1
  have hterm : ∀ j : Fin M,
      checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν * 2
        = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) := by
    intro j
    rw [checkPhase_site_mul hM]
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.mul_sum, expPhase_sum hM,
    deltaMod_sub_one]
  ring

/-- **原文第 2 式**: `[check(Z)_μ, check(Y)_ν]₊ = 0`（二重和のすべての項が `0`）。 -/
theorem acomm_checkZ_checkY (μ ν : ℤ) : acomm (checkZ M μ) (checkY M ν) = 0 := by
  rw [checkZ, checkY]
  exact acomm_sum_smul_zero _ _ _ _ (fun a b => anticomm_Z_Y a b)

/-- `[check(Y)_μ, check(Z)_ν]₊ = 0`（上の左右を入れ替えた形）。 -/
theorem acomm_checkY_checkZ (μ ν : ℤ) : acomm (checkY M μ) (checkZ M ν) = 0 := by
  rw [acomm_comm]; exact acomm_checkZ_checkY ν μ

/-! ## `μ, ν ∈ 𝓜̌` に絞った形（原文の主張そのもの） -/

/-- **原文第 1 式**: `μ, ν ∈ 𝓜̌` では `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkZ_checkZ_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkZ_checkZ hM, deltaMod_add_one_eq hM hμ hν]

/-- **原文第 3 式**: `μ, ν ∈ 𝓜̌` では `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkY_checkY_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkY_checkY hM, deltaMod_add_one_eq hM hμ hν]

end Ising2D
