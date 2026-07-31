/-
# 必要十分版: 1 の原始 `M` 乗根のべきの和（直交性）

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素数） |
| --- | --- |
| `exp_sum` | `Ising2D/Part004/Claim008_ExpSum.lean` の `Ising2D.expPhase_sum` |

具体版を本ファイルの必要十分版の特殊化として導出したものは
`Ising2D/Part004/Claim008_ExpSumFromNecSuf.lean` にある。

## 必要十分版が何を明らかにするか

原文 `exp_sum`（`∑_{j=1}^{M} exp(2π√-1 j k/M) = M δ^M_{(k,0)}`）に効いているのは

* **`exp(2π√-1/M)` が 1 の原始 `M` 乗根であること**（`ζ^l = 1 ⟺ M ∣ l`）
* **係数の住む場所で割り算ができること**（等比数列の和の公式に必要）

だけである。指数関数・円周率・複素数であること・絶対値・偏角は一切効いていない。
したがって主張は「任意の体 `K` と、その中の 1 の原始 `M` 乗根 `ζ`」で成り立つ。

逆にこれは、具体版が `exp` の解析的性質に依存していないことの検査になっている。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Field.GeomSum
import Mathlib.RingTheory.RootsOfUnity.PrimitiveRoots

namespace Ising2D.NecSuf

variable {K : Type*} [Field K]

/-- **必要十分版の本体（`exp_sum` の骨格）**: `ζ` が体 `K` の中の 1 の原始 `M` 乗根なら

  `∑_{j=1}^{M} ζ^{j k} = M · (M ∣ k なら 1、そうでなければ 0)`。

（`Fin M` の添字 `j` に対して原文の `j` は `(j : ℕ) + 1` である。）

証明は原文どおりの場合分け:
(a) `M ∣ k` のとき `ζ^k = 1` なので各項が `1` で和は `M`、
(b) そうでないとき公比 `r = ζ^k ≠ 1` かつ `r^M = 1` の等比和なので `0`。

仮定 `M ≠ 0` は**証明では使わない**（`M = 0` なら左辺は空和 `0`、右辺も `0 · … = 0`）。
原文が `M ≥ 1` を前提にしていることに対応させるため、引数としては残してある。 -/
theorem sum_zpow_primitiveRoot {M : ℕ} (_hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M) (k : ℤ) :
    ∑ j : Fin M, ζ ^ ((((j : ℕ) : ℤ) + 1) * k)
      = (M : K) * (if (M : ℤ) ∣ k then 1 else 0) := by
  have hpow : ∀ j : Fin M, ζ ^ ((((j : ℕ) : ℤ) + 1) * k) = (ζ ^ k) ^ ((j : ℕ) + 1) := by
    intro j
    have hexp : (((j : ℕ) : ℤ) + 1) * k = k * ((((j : ℕ) + 1 : ℕ)) : ℤ) := by push_cast; ring
    rw [hexp, zpow_mul, zpow_natCast]
  simp_rw [hpow]
  by_cases hdvd : (M : ℤ) ∣ k
  · -- (a) `M ∣ k`: 各項が `1`
    rw [if_pos hdvd, mul_one, (hζ.zpow_eq_one_iff_dvd k).2 hdvd]
    simp
  · -- (b) その他: 等比数列の和
    rw [if_neg hdvd, mul_zero]
    have hr1 : ζ ^ k ≠ 1 := fun h => hdvd ((hζ.zpow_eq_one_iff_dvd k).1 h)
    have hrM : (ζ ^ k) ^ M = 1 := by
      rw [← zpow_natCast (ζ ^ k) M, ← zpow_mul, mul_comm k ((M : ℕ) : ℤ), zpow_mul,
        zpow_natCast, hζ.pow_eq_one, one_zpow]
    have hsplit : ∑ j : Fin M, (ζ ^ k) ^ ((j : ℕ) + 1)
        = ζ ^ k * ∑ j ∈ Finset.range M, (ζ ^ k) ^ j := by
      rw [Finset.mul_sum, Fin.sum_univ_eq_sum_range (fun j => (ζ ^ k) ^ (j + 1)) M]
      exact Finset.sum_congr rfl fun j _ => by rw [pow_succ, mul_comm]
    rw [hsplit, geom_sum_eq hr1, hrM, sub_self, zero_div, mul_zero]

end Ising2D.NecSuf
