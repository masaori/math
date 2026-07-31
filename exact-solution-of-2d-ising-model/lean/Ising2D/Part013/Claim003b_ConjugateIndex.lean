/-
# `𝓜̌` の内側で共役添字を取る（**具体版**）

対応する人手証明のラベル: `conjugate_index_of_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_003b_claim_conjugate_index_of_check_Z_Y`）

**必要十分版は無い。** (1)(3) は `θ~` の定義と添字の周期性（既存の必要十分版
`Ising2D.NecSuf.transform_periodic` の特殊化）から出る書き換えで、
新たに取り払える構造が無い。(2) は「`2M` 乗根の周期 `ξ^{2M} = 1`」だけで、
これは `NecSuf.sum_zpow_antiperiodic` で既に使っている性質そのものである。

## 原文の主張（`μ ∈ 𝓜̌`）

  (1) `θ~_{M+1-μ} = 2π - θ~_μ`
  (2) `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`  (`j ∈ ℤ`)
  (3) `check(Z)_{M+1-μ} = check(Z)_{1-μ}`,  `check(Y)_{M+1-μ} = check(Y)_{1-μ}`

(1)(2) は `μ ∈ ℤ` 全体で成り立つので、Lean でも `μ : ℤ` のまま述べる
（`𝓜̌` への制限は必要ない）。
-/
import Ising2D.Part013.Definition003a_CheckIndexSet

namespace Ising2D

variable {M : ℕ}

/-- **(1)**: `θ~_{M+1-μ} = 2π - θ~_μ`。 -/
theorem thetaTilde_conj (hM : M ≠ 0) (μ : ℤ) :
    thetaTilde M ((M : ℤ) + 1 - μ) = 2 * Real.pi - thetaTilde M μ := by
  have hMR : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [thetaTilde, thetaTilde]
  push_cast
  field_simp
  ring

/-- **(2)**: `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`。

`(M+1-μ)` の奇数周波数は `2(M+1-μ) - 1 = 2M - (2μ-1)` で、
`2M` の分は `2M` 乗根の周期で消える。 -/
theorem checkPhase_conj (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = expPhase (2 * M) (-(k * (2 * μ - 1))) := by
  have hone : expPhase (2 * M) (k * (2 * (M : ℤ))) = 1 := by
    rw [expPhase_zpow]
    have h1 : expPhase (2 * M) (2 * (M : ℤ)) = 1 := by
      have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) := by push_cast; ring
      exact (expPhase_eq_one_iff (by omega) _).2 (by rw [h2M])
    rw [h1, one_zpow]
  rw [checkPhase,
    show k * (2 * ((M : ℤ) + 1 - μ) - 1) = k * (2 * (M : ℤ)) + -(k * (2 * μ - 1)) by ring,
    expPhase_add, hone, one_mul]

/-- (2) の言い換え（原文の右辺の形）: `e^{-ij θ~_{M+1-μ}} = e^{-i(-j) θ~_μ}`。 -/
theorem checkPhase_conj' (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = checkPhase M (-k) μ := by
  rw [checkPhase_conj hM, checkPhase]
  congr 1
  ring

/-- **(3)**: `check(Z)_{M+1-μ} = check(Z)_{1-μ}`。 -/
theorem checkZ_conj (hM : M ≠ 0) (μ : ℤ) : checkZ M ((M : ℤ) + 1 - μ) = checkZ M (1 - μ) :=
  checkZ_congr hM ⟨1, by ring⟩

/-- **(3)**: `check(Y)_{M+1-μ} = check(Y)_{1-μ}`。 -/
theorem checkY_conj (hM : M ≠ 0) (μ : ℤ) : checkY M ((M : ℤ) + 1 - μ) = checkY M (1 - μ) :=
  checkY_congr hM ⟨1, by ring⟩

/-- 共役添字での `check(Z)` の展開（`H1_H2_via_check_Z_Y` の証明の 1 行目）:
`check(Z)_{M+1-μ} = ∑_{k=1}^{M} Z_k e^{ik θ~_μ}`。 -/
theorem checkZ_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkZ M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Z k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

/-- 共役添字での `check(Y)` の展開。 -/
theorem checkY_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkY M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Y k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

end Ising2D
