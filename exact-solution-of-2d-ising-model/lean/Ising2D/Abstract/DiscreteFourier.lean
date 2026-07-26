/-
# 抽象版: 離散フーリエ変換の周期性と逆変換

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `hatZ_hatY_M_periodicity` | `Ising2D/Part004/Claim012_HatPeriodicity.lean` |
| `recover_Z_Y_from_hatZ_hatY` | `Ising2D/Part004/Claim013_RecoverZY.lean` |

具体版を本ファイルの抽象版の特殊化として導出したものは
`Ising2D/Part004/Claim012_HatPeriodicityAbstract.lean` と
`Ising2D/Part004/Claim013_RecoverZYAbstract.lean` にある。

## 抽象版が何を明らかにするか

原文の 2 つの主張に効いているのは、次だけである。

* **周期性** `hat(Z)_{μ+M} = hat(Z)_μ`, `hat(Y)_{μ+M} = hat(Y)_μ`:
  効いているのは `ζ^M = 1` の 1 点のみ。原始根であることすら要らず、
  変換される対象（`Z_j`, `Y_j`）の代数的性質も、重み `w_j`（`hat(Z)^{(±)}` の符号）も一切効かない。
* **逆変換** `∑_μ hat(x)_μ ζ^{…} = M x_m`:
  効いているのは **`ζ` が 1 の原始 `M` 乗根であること**（直交性 `sum_zpow_primitiveRoot`）と、
  対象が**係数体上の加群であること**だけ。行列であること・積があること・
  `Z, Y` の反交換関係は一切使わない。

したがって具体版の「`hat(Z)^{(-)}` でしか逆変換が言えない」という制限は、
`hat(Z)^{(+)}` の重み `w_1 = -1` が一様でない（`w ≡ 1` でない）ことだけに由来する。
-/
import Ising2D.Abstract.RootOfUnitySum
import Mathlib.Algebra.Module.Defs

namespace Ising2D.Abstract

variable {K : Type*} [Field K] {V : Type*} [AddCommGroup V] [Module K V]

/-- `Fin M` の 2 元 `j, m` について `M ∣ (j - m) ⟺ j = m`
（`|j - m| < M` だから）。抽象版を複素数側から独立させるために本ファイルにも置く。 -/
theorem fin_dvd_sub_iff_eq {M : ℕ} (j m : Fin M) :
    ((M : ℤ) ∣ ((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) ↔ j = m := by
  constructor
  · intro h
    have hj : ((j : ℕ) : ℤ) < (M : ℤ) := by exact_mod_cast j.isLt
    have hm : ((m : ℕ) : ℤ) < (M : ℤ) := by exact_mod_cast m.isLt
    have hj0 : (0 : ℤ) ≤ ((j : ℕ) : ℤ) := Int.natCast_nonneg _
    have hm0 : (0 : ℤ) ≤ ((m : ℕ) : ℤ) := Int.natCast_nonneg _
    have habs : |((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)| < (M : ℤ) := by
      rw [abs_lt]; constructor <;> omega
    have := Int.eq_zero_of_abs_lt_dvd h habs
    exact Fin.val_injective (by omega)
  · rintro rfl; simp

/-! ## 周期性 -/

/-- **周期性の核（`hatZ_hatY_M_periodicity` の中身）**: `ζ^M = 1` なら
`ζ^{a(μ+M)} = ζ^{aμ}`。効いているのは `ζ^M = 1` だけである。 -/
theorem zpow_mul_add_natCast {M : ℕ} (hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M)
    (a μ : ℤ) : ζ ^ (a * (μ + M)) = ζ ^ (a * μ) := by
  have hζ0 : ζ ≠ 0 := hζ.ne_zero hM
  have hMone : ζ ^ ((M : ℕ) : ℤ) = 1 := by rw [zpow_natCast, hζ.pow_eq_one]
  have hsplit : a * (μ + M) = a * μ + (M : ℤ) * a := by ring
  have hone : ζ ^ ((M : ℤ) * a) = 1 := by rw [zpow_mul, hMone, one_zpow]
  rw [hsplit, zpow_add₀ hζ0, hone, mul_one]

/-- **抽象版の周期性**: 重み `w : Fin M → K` と周波数 `a : Fin M → ℤ` をもつ変換
`hat(x)_μ = ∑_j w_j ζ^{a_j μ} x_j` は `μ` について `M` 周期である。

重み `w` も周波数 `a` も任意でよい（原文の `hat(Z)^{(±)}` の符号も、
指数の符号の取り方も、ここでは効かない）し、`x_j` の代数的性質も使わない。 -/
theorem transform_periodic {M : ℕ} (hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M)
    (a : Fin M → ℤ) (w : Fin M → K) (x : Fin M → V) (μ : ℤ) :
    ∑ j : Fin M, (w j * ζ ^ (a j * (μ + M))) • x j
      = ∑ j : Fin M, (w j * ζ ^ (a j * μ)) • x j :=
  Finset.sum_congr rfl fun j _ => by rw [zpow_mul_add_natCast hM hζ (a j) μ]

/-! ## 逆変換 -/

/-- **抽象版の離散フーリエ逆変換（`recover_Z_Y_from_hatZ_hatY` の骨格）**。

`ζ` を体 `K` の中の 1 の原始 `M` 乗根とし、`V` を `K`-加群とする。
族 `x : Fin M → V` の変換 `hat(x)_μ = ∑_j ζ^{-(j+1)(μ+1)} x_j` に対し

  `∑_{μ} ζ^{(m+1)(μ+1)} hat(x)_μ = M x_m`。

証明は原文どおりの 3 段: 指数法則で位相をまとめる → 二重和の順序交換 →
直交性 `sum_zpow_primitiveRoot` で `j = m` の項だけ残す。 -/
theorem inverse_dft_abstract {M : ℕ} (hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M)
    (x : Fin M → V) (m : Fin M) :
    ∑ μ : Fin M, ζ ^ ((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) •
        (∑ j : Fin M, ζ ^ (-((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) • x j)
      = (M : K) • x m := by
  classical
  have hζ0 : ζ ≠ 0 := hζ.ne_zero hM
  -- Step 0: 指数法則で位相をまとめる
  have step1 : ∀ μ : Fin M,
      ζ ^ ((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) •
          (∑ j : Fin M, ζ ^ (-((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) • x j)
        = ∑ j : Fin M,
            ζ ^ (((((μ : ℕ)) : ℤ) + 1) * (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ))) • x j := by
    intro μ
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    have hexp : (((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)
        + -((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))
        = ((((μ : ℕ)) : ℤ) + 1) * ((((m : ℕ) : ℤ)) - ((j : ℕ) : ℤ)) := by ring
    rw [smul_smul, ← zpow_add₀ hζ0, hexp]
  simp_rw [step1]
  -- Step 1: 有限二重和の順序交換
  rw [Finset.sum_comm]
  -- Step 2: `μ` についての直交性
  have step2 : ∀ j : Fin M,
      (∑ μ : Fin M, ζ ^ (((((μ : ℕ)) : ℤ) + 1) * (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ))) • x j)
        = ((M : K) * (if (M : ℤ) ∣ (((m : ℕ) : ℤ) - ((j : ℕ) : ℤ)) then 1 else 0)) • x j := by
    intro j
    rw [← Finset.sum_smul, sum_zpow_primitiveRoot hM hζ]
  simp_rw [step2]
  -- Step 3: `j = m` の項だけ残る
  rw [Finset.sum_eq_single_of_mem m (Finset.mem_univ m)]
  · rw [sub_self, if_pos (dvd_zero _), mul_one]
  · intro j _ hj
    rw [if_neg (fun h => hj ((fin_dvd_sub_iff_eq m j).1 h).symm), mul_zero, zero_smul]

end Ising2D.Abstract
