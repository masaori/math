/-
# 指数関数の和とクロネッカーのデルタの関係（`<exp_sum>`）

対応する人手証明:
`parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ` (`<exp_sum>`)
および `parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ`（`δ^M`）

原文の主張: `M ∈ ℕ`、`M ≥ 1`、`k ∈ ℤ` について

  `∑_{j=1}^{M} exp(2π√-1 j k / M) = M δ^M_{(k, 0)}`

## 形式化の方針

原文の `exp(-√-1 · 2π k / M)`（`<def_hatZ_pm>` と `<def_hatY>` の位相因子）は
`DefinitionExpPhase.lean` の中立な先行定義 `expPhase M k` を使う。
原文の `exp_sum` は `k ↦ -k` の読み替えで `expPhase` の和として述べられる
（両辺とも `k` と `-k` で同じ値なので、主張として同値）。

サイトの添字は `parts/**` が `1, …, M`、Lean が `Fin M`（`0, …, M-1`）なので、
原文の `j` は Lean の `(j : Fin M)` に対して `(j : ℕ) + 1` である。
本ファイルの和はその読み替えに合わせて `∑ j : Fin M, expPhase M (((j : ℕ) + 1) * k)` と書く
（原文の `∑_{j=1}^{M}` と 1 対 1 に対応する）。

## 使う mathlib の道具

* `Complex.isPrimitiveRoot_exp M hM : IsPrimitiveRoot (exp (2π√-1/M)) M`
* `IsPrimitiveRoot.zpow_eq_one_iff_dvd`（`ζ^l = 1 ↔ M ∣ l`）── 原文 (a)(b) の場合分けの根拠
* `geom_sum_eq`（等比数列の和 `∑_{i<n} r^i = (r^n - 1)/(r - 1)`）── 原文 (b) そのもの
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Field.GeomSum
import Ising2D.Part004.DefinitionExpPhase

namespace Ising2D

/-- 原文 `parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ` の
`δ^M : ℤ × ℤ → ℂ`（`μ ≡ ν (mod M)` なら `1`、そうでなければ `0`）。

原文の `M ∈ ℕ`, `M ≥ 1` は本ファイルの `M : ℕ`, `hM : M ≠ 0` に直接対応する。

`parts/006_...` 側では添字を `Fin M` の代表元にとって `Ising2D.deltaM` として定義したが、
`hatZ, hatY` の添字 `μ ∈ ℳ = {-M, …, -1, 1, …, M}` は `Fin M` に収まらないので、
ここでは整数添字のまま合同で定義する。 -/
noncomputable def deltaMod (M : ℕ) (μ ν : ℤ) : ℂ := if (M : ℤ) ∣ (μ - ν) then 1 else 0

theorem deltaMod_self (M : ℕ) (μ : ℤ) : deltaMod M μ μ = 1 := by
  simp [deltaMod]

/-! ## `<exp_sum>` 本体 -/

/-- **`<exp_sum>` の形式化**:

  `∑_{j=1}^{M} exp(-√-1 · 2π j k / M) = M δ^M_{(k,0)}`

原文は `exp(+√-1 · 2π j k / M)` で述べているが、両辺とも `k` を `-k` に替えても不変なので
（`M ∣ k ⟺ M ∣ -k`）主張としては同じである。

証明も原文どおり (a) `M ∣ k` のとき各項が `1` で和が `M`、
(b) そうでないとき公比 `r = expPhase M k ≠ 1`、`r^M = 1` の等比和で `0`。 -/
theorem expPhase_sum {M : ℕ} (hM : M ≠ 0) (k : ℤ) :
    ∑ j : Fin M, expPhase M (((j : ℕ) + 1 : ℤ) * k) = (M : ℂ) * deltaMod M k 0 := by
  have hpow : ∀ j : Fin M,
      expPhase M (((j : ℕ) + 1 : ℤ) * k) = expPhase M k ^ ((j : ℕ) + 1) := by
    intro j
    have h : (((j : ℕ) + 1 : ℤ)) = ((((j : ℕ) + 1 : ℕ)) : ℤ) := by push_cast; ring
    rw [h, expPhase_natCast_mul]
  simp_rw [hpow]
  rw [deltaMod, sub_zero]
  by_cases hdvd : (M : ℤ) ∣ k
  · -- (a) `M ∣ k`: 各項が `1`
    rw [if_pos hdvd, mul_one, (expPhase_eq_one_iff hM k).2 hdvd]
    simp
  · -- (b) その他: 等比数列の和
    rw [if_neg hdvd, mul_zero]
    have hr1 : expPhase M k ≠ 1 := fun h => hdvd ((expPhase_eq_one_iff hM k).1 h)
    have hrM : expPhase M k ^ M = 1 := by
      rw [← expPhase_natCast_mul]
      exact (expPhase_eq_one_iff hM _).2 ⟨k, rfl⟩
    have hsplit : ∑ j : Fin M, expPhase M k ^ ((j : ℕ) + 1)
        = expPhase M k * ∑ j ∈ Finset.range M, expPhase M k ^ j := by
      rw [Finset.mul_sum, Fin.sum_univ_eq_sum_range (fun j => expPhase M k ^ (j + 1)) M]
      exact Finset.sum_congr rfl fun j _ => by rw [pow_succ, mul_comm]
    rw [hsplit, geom_sum_eq hr1, hrM, sub_self, zero_div, mul_zero]

/-- `Fin M` の 2 元 `j, m` について `M ∣ (j - m) ⟺ j = m`
（原文の「`|m - j| < M` だから `m ≡ j (mod M)` と `m = j` は同値」）。 -/
theorem dvd_sub_iff_eq {M : ℕ} (j m : Fin M) :
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
  · rintro rfl
    simp

end Ising2D
