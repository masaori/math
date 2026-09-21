/-
# 離散 Fourier 変換で共有する複素位相因子

対応する人手本文:
`structured-latex/content/004_transfer_matrix.ts` の `<def_hatZ_pm>` と `<def_hatY>`、
および `<exp_sum>` に共通して現れる位相因子

  `exp(-√-1 · 2π k / M)` (`k ∈ ℤ`).

このファイルは `hat(Z)`、`hat(Y)` と指数和のどれにも依存しない先行定義だけを置く。
本文では複素指数関数そのものの先行定義が未整備なので、この Lean 上の分離だけで
本文の節境界が確定したとは扱わない。
-/
import Mathlib.RingTheory.RootsOfUnity.Complex

namespace Ising2D

/-- 原文 `<def_hatZ_pm>` と `<def_hatY>` に現れる位相因子 `exp(-√-1 · 2π k / M)`（`k ∈ ℤ`）。

`M = 0` のときは `ℂ` の規約 `x / 0 = 0` により `expPhase 0 k = 1` になるが、
以降の主張はすべて `M ≠ 0` を仮定するので影響しない。 -/
noncomputable def expPhase (M : ℕ) (k : ℤ) : ℂ :=
  Complex.exp (-(2 * (Real.pi : ℂ) * Complex.I * (k : ℂ)) / (M : ℂ))

@[simp]
theorem expPhase_zero (M : ℕ) : expPhase M 0 = 1 := by
  simp [expPhase]

/-- 指数法則 `exp(-2π√-1(k+l)/M) = exp(-2π√-1 k/M) exp(-2π√-1 l/M)`。 -/
theorem expPhase_add (M : ℕ) (k l : ℤ) :
    expPhase M (k + l) = expPhase M k * expPhase M l := by
  rw [expPhase, expPhase, expPhase, ← Complex.exp_add]
  congr 1
  push_cast
  ring

theorem expPhase_neg (M : ℕ) (k : ℤ) : expPhase M (-k) = (expPhase M k)⁻¹ := by
  rw [expPhase, expPhase, ← Complex.exp_neg]
  congr 1
  push_cast
  ring

/-- `expPhase M (n k) = (expPhase M k)^n`（`n : ℕ`）。 -/
theorem expPhase_natCast_mul (M : ℕ) (n : ℕ) (k : ℤ) :
    expPhase M ((n : ℤ) * k) = expPhase M k ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
      have h : ((n + 1 : ℕ) : ℤ) * k = (n : ℤ) * k + k := by push_cast; ring
      rw [h, expPhase_add, ih, pow_succ]

/-- `expPhase` を `M` 次の原始単位根のべきとして書く。 -/
theorem expPhase_eq_zpow (M : ℕ) (k : ℤ) :
    expPhase M k = (Complex.exp (2 * (Real.pi : ℂ) * Complex.I / (M : ℂ))) ^ (-k) := by
  rw [← Complex.exp_int_mul, expPhase]
  congr 1
  push_cast
  ring

/-- `exp(-2π√-1 k/M) = 1 ⟺ M ∣ k`。 -/
theorem expPhase_eq_one_iff {M : ℕ} (hM : M ≠ 0) (k : ℤ) :
    expPhase M k = 1 ↔ (M : ℤ) ∣ k := by
  rw [expPhase_eq_zpow, (Complex.isPrimitiveRoot_exp M hM).zpow_eq_one_iff_dvd, dvd_neg]

end Ising2D
