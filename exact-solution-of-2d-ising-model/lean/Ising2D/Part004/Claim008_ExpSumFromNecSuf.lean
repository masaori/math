/-
# `<exp_sum>` — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ` (`<exp_sum>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.expPhase_sum`（`Claim008_ExpSum.lean`） | 複素指数関数 `exp(-2π√-1 k/M)` |
| **必要十分版** | `NecSuf.sum_zpow_primitiveRoot`（`NecSuf/RootOfUnitySum.lean`） | 任意の体 `K` と、その中の 1 の原始 `M` 乗根 `ζ` |

本ファイルは、**具体版が必要十分版の特殊化にすぎないこと**を導出として書く
（`expPhase_sum_of_necSuf`）。特殊化で埋めるべきなのは

* `zetaM M := exp(2π√-1/M)` が 1 の原始 `M` 乗根であること（`isPrimitiveRoot_zetaM`、
  mathlib の `Complex.isPrimitiveRoot_exp`）
* 原文の位相因子が `zetaM M` の整数べきであること（`expPhase_eq_zetaM_zpow`）

の 2 点だけである。したがって原文 `exp_sum` に効いているのは
「1 の原始 `M` 乗根であること」と「割り算ができること」だけで、
指数関数・円周率の解析的性質は効いていない。
-/
import Ising2D.NecSuf.RootOfUnitySum
import Ising2D.Part004.Claim008_ExpSum

namespace Ising2D

/-- 原文の位相因子の底 `exp(2π√-1/M)`（`expPhase M k = zetaM M ^ (-k)`）。 -/
noncomputable def zetaM (M : ℕ) : ℂ := Complex.exp (2 * (Real.pi : ℂ) * Complex.I / (M : ℂ))

theorem isPrimitiveRoot_zetaM {M : ℕ} (hM : M ≠ 0) : IsPrimitiveRoot (zetaM M) M :=
  Complex.isPrimitiveRoot_exp M hM

theorem zetaM_ne_zero {M : ℕ} (hM : M ≠ 0) : zetaM M ≠ 0 :=
  (isPrimitiveRoot_zetaM hM).ne_zero hM

/-- 原文の位相因子は `zetaM M` の整数べき: `exp(-2π√-1 k/M) = zetaM M ^ (-k)`。 -/
theorem expPhase_eq_zetaM_zpow (M : ℕ) (k : ℤ) : expPhase M k = zetaM M ^ (-k) :=
  expPhase_eq_zpow M k

/-- 原文の位相因子を、添字の符号を反転した形の整数べきで書く（必要十分版へ渡す形）。 -/
theorem expPhase_eq_zetaM_zpow_neg (M : ℕ) (a k : ℤ) :
    expPhase M (a * k) = zetaM M ^ (a * (-k)) := by
  rw [expPhase_eq_zetaM_zpow]
  congr 1
  ring

/-- **具体版 `expPhase_sum` を必要十分版の特殊化として導出した形**。

必要十分版 `NecSuf.sum_zpow_primitiveRoot` に `K := ℂ`, `ζ := zetaM M`, `k := -k` を代入し、
`M ∣ -k ⟺ M ∣ k` で整理すると、原文 `exp_sum` の主張がそのまま出る。 -/
theorem expPhase_sum_of_necSuf {M : ℕ} (hM : M ≠ 0) (k : ℤ) :
    ∑ j : Fin M, expPhase M (((j : ℕ) + 1 : ℤ) * k) = (M : ℂ) * deltaMod M k 0 := by
  have hrw : ∀ j : Fin M, expPhase M (((j : ℕ) + 1 : ℤ) * k)
      = zetaM M ^ ((((j : ℕ) : ℤ) + 1) * (-k)) := fun j =>
    expPhase_eq_zetaM_zpow_neg M (((j : ℕ) : ℤ) + 1) k
  rw [Finset.sum_congr rfl fun j _ => hrw j,
    NecSuf.sum_zpow_primitiveRoot hM (isPrimitiveRoot_zetaM hM) (-k), deltaMod, sub_zero]
  congr 1
  simp only [dvd_neg]

end Ising2D
