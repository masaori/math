/-
# 半整数運動量の指数和・添字周期性を**必要十分版から導出**する

対応する人手証明のラベル: `antiperiodic_exp_sum`, `def_half_integer_modes` (1)(2)
（`structured-latex/content/013_even_sector_modes.ts`）

具体版（直接証明）は `Ising2D/Part013/Claim002_AntiperiodicExpSum.lean` と
`Ising2D/Part013/Definition003_HalfIntegerModes.lean`、
必要十分版は `Ising2D/NecSuf/AntiperiodicFourier.lean` と
`Ising2D/NecSuf/DiscreteFourier.lean`。本ファイルは両者をつなぐ
（`exact-solution-of-2d-ising-model/README.md` 4 節「必要十分版から具体版が特殊化で
得られる場合は、具体版を必要十分版の系として導出する」）。

## 何が特殊化で得られるか

| 具体版 | 必要十分版 | 特殊化の中身 |
| --- | --- | --- |
| `antiperiodic_exp_sum` | `NecSuf.sum_zpow_antiperiodic` | `ξ := e^{-iπ/M}`（1 の原始 `2M` 乗根） |
| `def_half_integer_modes` (1) | `NecSuf.pow_half_eq_neg_one` | 同上 |
| `def_half_integer_modes` (2) | `NecSuf.transform_periodic`（**整数運動量と共通**） | 重み `w_j = ξ^{-j}`、周波数 `a_j = j`、`ζ = ξ^2` |

とくに (2) は**整数運動量版 `hatZ_hatY_M_periodicity` とまったく同じ必要十分版**の
別の特殊化である（重みの取り方が違うだけ）。
-/
import Ising2D.Part013.Definition003_HalfIntegerModes
import Ising2D.NecSuf.AntiperiodicFourier

namespace Ising2D

variable {M : ℕ}

/-! ## 橋渡し: `expPhase N 1` は 1 の原始 `N` 乗根 -/

/-- `expPhase N k = (expPhase N 1)^k`（`k : ℤ`）。 -/
theorem expPhase_eq_zpow_one (N : ℕ) (k : ℤ) : expPhase N k = (expPhase N 1) ^ k := by
  rw [← expPhase_zpow N k 1, mul_one]

/-- `expPhase N (-k) = (expPhase N (-1))^k`（`k : ℤ`）。 -/
theorem expPhase_neg_eq_zpow_neg_one (N : ℕ) (k : ℤ) :
    expPhase N (-k) = (expPhase N (-1)) ^ k := by
  rw [← expPhase_zpow N k (-1)]
  congr 1
  ring

/-- **`e^{-2π√-1/N}` は 1 の原始 `N` 乗根**（必要十分版へ渡すための橋）。 -/
theorem isPrimitiveRoot_expPhase_one {N : ℕ} (hN : N ≠ 0) :
    IsPrimitiveRoot (expPhase N 1) N where
  pow_eq_one := by
    rw [← expPhase_natCast_mul N N 1]
    exact (expPhase_eq_one_iff hN _).2 ⟨1, by ring⟩
  dvd_of_pow_eq_one := by
    intro l hl
    have hz : expPhase N ((l : ℤ) * 1) = 1 := by rw [expPhase_natCast_mul]; exact hl
    have hd : (N : ℤ) ∣ ((l : ℤ) * 1) := (expPhase_eq_one_iff hN _).1 hz
    rw [mul_one] at hd
    exact_mod_cast hd

/-- **`e^{+2π√-1/N}` も 1 の原始 `N` 乗根**（逆変換側で使う向き）。 -/
theorem isPrimitiveRoot_expPhase_neg_one {N : ℕ} (hN : N ≠ 0) :
    IsPrimitiveRoot (expPhase N (-1)) N where
  pow_eq_one := by
    rw [← expPhase_natCast_mul N N (-1)]
    exact (expPhase_eq_one_iff hN _).2 ⟨-1, by ring⟩
  dvd_of_pow_eq_one := by
    intro l hl
    have hz : expPhase N ((l : ℤ) * (-1)) = 1 := by rw [expPhase_natCast_mul]; exact hl
    have hd : (N : ℤ) ∣ ((l : ℤ) * (-1)) := (expPhase_eq_one_iff hN _).1 hz
    rw [mul_neg_one, dvd_neg] at hd
    exact_mod_cast hd

/-! ## `antiperiodic_exp_sum` を必要十分版から導く -/

/-- **`antiperiodic_exp_sum` を `NecSuf.sum_zpow_antiperiodic` の特殊化として導いたもの**
（`ξ := expPhase (2M) 1 = e^{-iπ/M}`）。 -/
theorem antiperiodic_exp_sum_of_necSuf (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, checkPhase M (-k) (((μ : ℕ) : ℤ) + 1)
      = expPhase (2 * M) (-k) * ((M : ℂ) * deltaMod M k 0) := by
  have hξ : IsPrimitiveRoot (expPhase (2 * M) 1) (2 * M) :=
    isPrimitiveRoot_expPhase_one (by omega)
  have hL : ∀ μ : Fin M,
      checkPhase M (-k) (((μ : ℕ) : ℤ) + 1)
        = (expPhase (2 * M) 1) ^ ((2 * ((μ : ℕ) : ℤ) + 1) * (-k)) := by
    intro μ
    rw [checkPhase, expPhase_eq_zpow_one]
    congr 1
    ring
  have hdelta : (if (M : ℤ) ∣ (-k) then (1 : ℂ) else 0) = deltaMod M k 0 := by
    rw [deltaMod, sub_zero]
    simp only [dvd_neg]
  rw [Finset.sum_congr rfl fun μ _ => hL μ,
    NecSuf.sum_zpow_antiperiodic (K := ℂ) hM hξ (-k), ← expPhase_eq_zpow_one, hdelta]

/-- **`def_half_integer_modes` (1)（反周期性）を `NecSuf.pow_half_eq_neg_one` から導いたもの**。 -/
theorem checkPhase_M_of_necSuf (hM : M ≠ 0) : (expPhase (2 * M) 1) ^ M = -1 :=
  NecSuf.pow_half_eq_neg_one hM (isPrimitiveRoot_expPhase_one (by omega))

/-! ## 添字の周期性を（整数運動量と共通の）必要十分版から導く -/

/-- 半整数運動量の位相因子を「重み × 整数運動量の位相」に分解する:

  `e^{-i b θ~_μ} = e^{iπ b/M} · (e^{-2π√-1/M})^{b μ}`

必要十分版 `NecSuf.transform_periodic`（重み `w_j` と周波数 `a_j` が任意）へ
渡すための形である。 -/
theorem checkPhase_eq_weight_mul (hM : M ≠ 0) (b μ : ℤ) :
    checkPhase M b μ = expPhase (2 * M) (-b) * (expPhase M 1) ^ (b * μ) := by
  rw [← expPhase_eq_zpow_one, checkPhase, ← expPhase_two_mul hM (b * μ), ← expPhase_add]
  congr 1
  ring

/-- **`def_half_integer_modes` (2) を `NecSuf.transform_periodic` の特殊化として導いたもの**。

整数運動量の `hatZ_hatY_M_periodicity`（`Part004/Claim012_HatPeriodicityFromNecSuf.lean`）と
**同じ必要十分版**を、重み `w_j = e^{iπ j/M}` に取り替えて使っているだけである。 -/
theorem checkZ_period_of_necSuf (hM : M ≠ 0) (μ : ℤ) :
    checkZ M (μ + (M : ℤ)) = checkZ M μ := by
  have hζ : IsPrimitiveRoot (expPhase M 1) M := isPrimitiveRoot_expPhase_one hM
  have h := NecSuf.transform_periodic (K := ℂ) (V := TensorPow M) hM hζ
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => expPhase (2 * M) (-(((j : ℕ) : ℤ) + 1)))
      (fun j : Fin M => Z j) μ
  have hL : ∀ ν : ℤ, checkZ M ν
      = ∑ j : Fin M, (expPhase (2 * M) (-(((j : ℕ) : ℤ) + 1)) *
          (expPhase M 1) ^ ((((j : ℕ) : ℤ) + 1) * ν)) • Z j := by
    intro ν
    rw [checkZ]
    exact Finset.sum_congr rfl fun j _ => by rw [checkPhase_eq_weight_mul hM]
  rw [hL (μ + (M : ℤ)), hL μ]
  exact h

/-- **`def_half_integer_modes` (2)（`check(Y)` 側）**を同じ必要十分版から導いたもの。 -/
theorem checkY_period_of_necSuf (hM : M ≠ 0) (μ : ℤ) :
    checkY M (μ + (M : ℤ)) = checkY M μ := by
  have hζ : IsPrimitiveRoot (expPhase M 1) M := isPrimitiveRoot_expPhase_one hM
  have h := NecSuf.transform_periodic (K := ℂ) (V := TensorPow M) hM hζ
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => expPhase (2 * M) (-(((j : ℕ) : ℤ) + 1)))
      (fun j : Fin M => Y j) μ
  have hL : ∀ ν : ℤ, checkY M ν
      = ∑ j : Fin M, (expPhase (2 * M) (-(((j : ℕ) : ℤ) + 1)) *
          (expPhase M 1) ^ ((((j : ℕ) : ℤ) + 1) * ν)) • Y j := by
    intro ν
    rw [checkY]
    exact Finset.sum_congr rfl fun j _ => by rw [checkPhase_eq_weight_mul hM]
  rw [hL (μ + (M : ℤ)), hL μ]
  exact h

end Ising2D
