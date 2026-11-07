/-
# `log` の単調性による挟み撃ちと、`log` の分解（必要十分版）

対応する人手証明のラベル: `limit_of_log_Z_in_N_row`, `onsager_free_energy_expression`
具体版: `Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimLimitInNRow.lean`,
`Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/TheoremOnsagerFreeEnergy.lean`
（`limit_of_log_Z_in_N_row` の具体版をこのファイルの系として導くのは `ClaimLimitInNRowFromNecSuf.lean`）

## `limit_of_log_Z_in_N_row` に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 `limit_of_log_Z_in_N_row` は「分配関数 `Z`」「Rayleigh 上限 `c(M)`」「鎖の長さ `M`」
「行数 `N_row`」という Ising 模型の言葉で書かれている。具体版と同じ段で、対象だけを取り替えて書き直すと、
効いているのは次だけである。

| 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- |
| 挟み撃ち `c^N ≤ Z ≤ 2^M c^N` に `log` を当てる（`u < v` は `real_log_strictly_increasing`、`u = v` は値が一つに定まること） | `abs_div_sub_le_of_sandwich` の `s2` | 写像 `L : D → K` が「`0 < u` かつ `u < v` なら `L u ≤ L v`」を満たすこと（結論の `<` は `≤` でよい） |
| `log(c^N) = N log c`、`log(2^M c^N) = log(2^M) + log(c^N)`、`log(2^M) = M log 2` | `s3`〜`s6` | `L(ab) = L a + L b`（`a, b > 0`）。冪の法則は `NecSuf.inv_map_pow` でここから出す |
| 各辺を `MN > 0` で割り、約し、`(1/M) log c` を引き、絶対値を外す | `s7`〜`s10` | `M ≥ 1`、`N ≥ 1`（割る数が正であること） |
| 準備 `log 2 > 0`、アルキメデス性で `N_0ε > log 2` の `N_0 ≥ 1`、`|a_N − a| ≤ log 2/N ≤ log 2/N_0 < ε` | `tendsto_of_abs_sub_le_div` | `ℝ` のアルキメデス性と、距離が `|x − y|` であること。定数 `C` は `C ≥ 0` でよい（正である必要はない） |

* **`2` という底は効いていない**: 挟み撃ちの上側の係数は `b^M`（`b > 0`）でよい。`b ≥ 1` も要らない
  （`|…| ≤ L b/N` の右辺の非負性は、左辺の差の非負性から出る）。
* **`log` が `exp` の逆写像であること、`exp` の性質は効いていない。** 使うのは「`0 < u` かつ `u < v` なら `L u ≤ L v`」の形の単調性と、積の法則だけである。
* **誤差評価の段に `ℝ` は効いていない。** `L` の定義域では順序半環（`Semiring`・`PartialOrder`・`IsStrictOrderedRing`）の
  正の元の積・冪・`≤` だけを、値域では順序体（`Field`・`LinearOrder`・`IsStrictOrderedRing`）の四則・大小・絶対値だけを使うので、
  `abs_div_sub_le_of_sandwich` は定義域 `D` と値域 `K` を分けて述べる。`ℝ` の完備性は効いていない。
* **極限の段は `ℝ` に留める。** 主張の収束は `ℝ` の距離 `|x − y|` による `Metric.tendsto_atTop` で述べており、一般の順序体へ持ち上げると
  収束の意味（位相）を別に与える必要があって手順が変わるからである。効いているのはアルキメデス性と距離の形だけで、完備性は効いていない。
* `C ≥ 0` の仮定は主張そのものには要らない（`C < 0` なら仮定 `|u_N − a| ≤ C/N < 0` が偽になり、結論は空虚に従う）。
  具体版と同じ手順（`C/ε ≥ 0` から `N_0 > 0`、`C/N ≤ C/N_0`）を保つために残す。
* **行列も、転送行列も、跡も、固有値も一切効いていない。** 誤差評価は順序半環 `D` と順序体 `K` の元についての主張、極限の段は実数列についての主張である。

`onsager_free_energy_expression` の側で効いているのは
`log(A^{M/2} e^{S}) = (M/2) log A + S`（`A > 0`）という分解と、
収束列の定数倍・定数加算が収束することだけである。**Ising 模型の構造は何も効いていない。**
-/
import Ising2D.NecSuf.InverseOfAdditiveToMultiplicativeMap
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas

namespace Ising2D.NecSuf

open Filter
open scoped Topology

/-- **必要十分版の `limit_of_log_Z_in_N_row` の誤差評価**: 順序半環 `D` から順序体 `K` への写像 `L : D → K` が「`0 < u` かつ `u < v` なら `L u ≤ L v`」、
`a, b > 0` で `L(ab) = L a + L b` を満たすとき、`c^N ≤ Z ≤ b^M c^N`（`b, c > 0`、`M, N ≥ 1`）なら
`|(1/(MN)) L Z − (1/M) L c| ≤ L b / N`。具体版 `abs_log_Z_sub_log_c_le` と同じ 10 行の含意の鎖で示す。 -/
theorem abs_div_sub_le_of_sandwich {D K : Type*} [Semiring D] [PartialOrder D] [IsStrictOrderedRing D]
    [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    {L : D → K}
    (hle : ∀ u v : D, 0 < u → u < v → L u ≤ L v)
    (hmul : ∀ a b : D, 0 < a → 0 < b → L (a * b) = L a + L b)
    {b c Z : D} {M N : ℕ} (hM : 1 ≤ M) (hN : 1 ≤ N) (hb : 0 < b) (hc : 0 < c)
    (h1 : c ^ N ≤ Z) (h2 : Z ≤ b ^ M * c ^ N) :
    |1 / ((M : K) * N) * L Z - 1 / (M : K) * L c| ≤ L b / N := by
  have hmulPos : ∀ a b : D, 0 < a → 0 < b → 0 < a * b := fun _ _ ha hb => mul_pos ha hb
  have hcN := inv_map_pow L (fun y : D => 0 < y) hmul hmulPos hc N hN
  have hbM := inv_map_pow L (fun y : D => 0 < y) hmul hmulPos hb M hM
  have hmono : ∀ u v : D, 0 < u → u ≤ v → L u ≤ L v := fun u v hu huv => by
    rcases huv.lt_or_eq with h | h
    · exact hle u v hu h                                          -- `u < v` の場合
    · rw [h]                                                      -- `u = v` の場合
  have hZ : 0 < Z := lt_of_lt_of_le hcN.1 h1
  have hMR : (0 : K) < M := by exact_mod_cast hM
  have hNR : (0 : K) < N := by exact_mod_cast hN
  have hMN : (0 : K) < (M : K) * N := mul_pos hMR hNR
  -- s1: 挟み撃ち（仮定 h1, h2）
  -- s2: `L` を当てる
  have s2 : L (c ^ N) ≤ L Z ∧ L Z ≤ L (b ^ M * c ^ N) :=
    ⟨hmono _ _ hcN.1 h1, hmono _ _ hZ h2⟩
  -- s3: 冪の法則を `c, N` で（左）
  have s3 : (N : K) * L c ≤ L Z ∧ L Z ≤ L (b ^ M * c ^ N) :=
    ⟨(by rw [hcN.2, nsmul_eq_mul] : (N : K) * L c = L (c ^ N)).trans_le s2.1, s2.2⟩
  -- s4: 積の法則を `b^M, c^N` で
  have s4 : (N : K) * L c ≤ L Z ∧ L Z ≤ L (b ^ M) + L (c ^ N) :=
    ⟨s3.1, s3.2.trans_eq (hmul _ _ hbM.1 hcN.1)⟩
  -- s5: 冪の法則を `b, M` で
  have s5 : (N : K) * L c ≤ L Z ∧ L Z ≤ (M : K) * L b + L (c ^ N) :=
    ⟨s4.1, s4.2.trans_eq (by rw [hbM.2, nsmul_eq_mul])⟩
  -- s6: 冪の法則を `c, N` で（右）
  have s6 : (N : K) * L c ≤ L Z ∧ L Z ≤ (M : K) * L b + (N : K) * L c :=
    ⟨s5.1, s5.2.trans_eq (by rw [hcN.2, nsmul_eq_mul])⟩
  -- s7: 各辺を `MN > 0` で割る
  have s7 : (N : K) * L c / ((M : K) * N) ≤ L Z / ((M : K) * N)
      ∧ L Z / ((M : K) * N) ≤ ((M : K) * L b + (N : K) * L c) / ((M : K) * N) :=
    ⟨div_le_div_of_nonneg_right s6.1 hMN.le, div_le_div_of_nonneg_right s6.2 hMN.le⟩
  -- s8: `K` の四則（共通の因子 `N`、`M` を約す）
  have e1 : (N : K) * L c / ((M : K) * N) = 1 / (M : K) * L c := by field_simp
  have e2 : L Z / ((M : K) * N) = 1 / ((M : K) * N) * L Z := by rw [one_div_mul_eq_div]
  have e3 : ((M : K) * L b + (N : K) * L c) / ((M : K) * N) = 1 / (M : K) * L c + L b / N := by
    field_simp; ring
  have s8 : 1 / (M : K) * L c ≤ 1 / ((M : K) * N) * L Z
      ∧ 1 / ((M : K) * N) * L Z ≤ 1 / (M : K) * L c + L b / N :=
    ⟨e1.symm.trans_le (s7.1.trans_eq e2), e2.symm.trans_le (s7.2.trans_eq e3)⟩
  -- s9: 各辺から `(1/M) L c` を引く
  have s9 : 0 ≤ 1 / ((M : K) * N) * L Z - 1 / (M : K) * L c
      ∧ 1 / ((M : K) * N) * L Z - 1 / (M : K) * L c ≤ L b / N :=
    ⟨sub_nonneg.2 s8.1, sub_le_iff_le_add'.2 s8.2⟩
  -- s10: `K` の非負の元の絶対値はそれ自身
  rw [abs_of_nonneg s9.1]
  exact s9.2

/-- **必要十分版の `limit_of_log_Z_in_N_row` の極限の段**: `C ≥ 0` で、`N ≥ 1` について `|u_N − a| ≤ C/N` なら
`u_N → a`。具体版と同じく、`ε > 0` に対してアルキメデス性で `N_0ε > C` の `N_0 ≥ 1` を取り、
`|u_N − a| ≤ C/N ≤ C/N_0 < ε` とする。 -/
theorem tendsto_of_abs_sub_le_div {u : ℕ → ℝ} {a C : ℝ} (hC : 0 ≤ C)
    (h : ∀ N : ℕ, 1 ≤ N → |u N - a| ≤ C / N) : Tendsto u atTop (𝓝 a) := by
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨n, hn⟩ := exists_nat_gt (C / ε)                         -- ℝ のアルキメデス性
  have hN0pos : (0 : ℝ) < n := lt_of_le_of_lt (div_nonneg hC hε.le) hn
  have hN0 : 1 ≤ n := Nat.one_le_iff_ne_zero.2 (by rintro rfl; simp at hN0pos)
  have hN0eps : C < n * ε := (div_lt_iff₀ hε).1 hn
  refine ⟨n, fun N hN => ?_⟩
  have hNR : (n : ℝ) ≤ N := by exact_mod_cast hN
  rw [Real.dist_eq]
  calc |u N - a| ≤ C / N := h N (le_trans hN0 hN)                 -- 誤差評価
    _ ≤ C / n := div_le_div_of_nonneg_left hC hN0pos hNR          -- `C ≥ 0` かつ `0 < N_0 ≤ N`
    _ < ε := (div_lt_iff₀ hN0pos).2 (by rw [mul_comm]; exact hN0eps)
                                                                  -- `N_0ε > C` の両辺を `N_0 > 0` で割る

/-- `A > 0` のとき `log (A^{r} e^{S}) = r log A + S`。 -/
theorem log_rpow_mul_exp {A : ℝ} (hA : 0 < A) (r S : ℝ) :
    Real.log (A ^ r * Real.exp S) = r * Real.log A + S := by
  rw [Real.log_mul (by positivity) (Real.exp_ne_zero S), Real.log_rpow hA, Real.log_exp]

/-- **必要十分版の後処理**: 収束列のアフィン変換は収束する。
人手証明の「収束する実数列の定数倍・定数加算はそれぞれ収束する」に対応。 -/
theorem tendsto_affine {u : ℕ → ℝ} {L : ℝ} (α β : ℝ) (hu : Tendsto u atTop (𝓝 L)) :
    Tendsto (fun n => α + β * u n) atTop (𝓝 (α + β * L)) :=
  (hu.const_mul β).const_add α

end Ising2D.NecSuf
