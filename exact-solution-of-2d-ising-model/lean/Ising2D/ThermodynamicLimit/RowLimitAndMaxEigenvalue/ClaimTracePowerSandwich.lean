/-
# `c(M_col)^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`（具体版）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008_claim_trace_power_sandwich`、ラベル **`trace_power_sandwich`**）

この証明はスペクトル定理（実対称行列の対角化可能性）を使っていない。上からの評価は `trace_power_upper_bound`
（`ClaimTracePowerUpperBound.lean`）、下からの評価は【単位ベクトルでの評価】（`ClaimTracePowerSandwichUnitVectorBound.lean`）と
本ファイルの【正の実数の冪の比較】・【上限への移行】による。上限への移行は極限・連続性を使わず、上限が最小の上界であることだけを使う。

必要十分版は置かない。【正の実数の冪の比較】は順序体の冪の初等的な不等式で、【上限への移行】は `def_rayleigh_sup` の上限と
`ℝ` の順序に固有である。各 `k` の評価・モーメントの評価の必要十分版は、兄弟のファイルの冒頭に書いた
（`NecSuf.IsPsdPair.moment_le_pow`・`NecSuf.IsPdPair.moment_ratio_le`・`moment_pow_le`。`Ising2D/NecSuf/RayleighMoments.lean`）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の `c ∈ ℝ_{>0}`・`𝓡 ⊆ ℝ_{>0}`（`def_rayleigh_sup`） | `rayleighSup_pos`・`hpd`（`DefinitionRayleighSup.lean`） |
| 【冪の実数の行列】〜【単位ベクトルでの評価】 | `ClaimTracePowerSandwichUnitVectorBound.lean` |
| 【正の実数の冪の比較】`p = 1` | `power_comparison_of_positive_reals` の帰納法の初段（(a) は `r^1 = r^0r = r`・`s^1 = s`、(b) は 1 段） |
| 同じ段の (a) の `r^{p+1} < s^{p+1}` の 4 行と `r^{p+1} > 0` | 同じ定理の帰納法の一歩の `calc` の 4 段と `mul_pos` |
| 同じ段の (b) の 5 行 | 同じ定理の帰納法の一歩の `calc` の 5 段 |
| 【上限への移行】`T ≥ m_n > 0`（`x = e_1`） | `trace_of_power_pos` |
| 同じ段の `c^{n-1} > 0`（`n = 1` と `n ≥ 2` の場合分け） | `pow_pred_pos_of_pos` |
| 同じ段の `δ < c` の 7 行 | `rayleighSup_pow_le_trace_of_power` の `δ` の `calc` の 7 段 |
| 同じ段の「`r` は `𝓡` の上界でない」 | 同じ定理の `exists_lt_of_lt_csSup` |
| 同じ段の `T > T` の 6 行 | 同じ定理の最後の `calc` の 6 段 |
| 主張（上からの評価 `trace_power_upper_bound` と合わせる） | `trace_power_sandwich` |

- 人手の `W ∈ Mat(d,ℂ)` は Lean の `W : TensorPow M`（添字 `Conf M`。`d = 2_ℤ^M` に当たるのは `ℕ` の等式 `card_conf_nat`、`d ∈ ℤ_{≥1}` は人手 `power_of_two_in_integers_is_at_least_one`）である。兄弟の具体版と同じく一般の `W` で述べ、
  人手が引く主張を仮定に置く: `hW` は `W_is_real_symmetric_positive_definite` の実対称性、`hWRsymm`・`hpd` は
  `W_real_is_symmetric`・`W_real_is_positive_definite`。本文の `W` への当てはめは `PhysicalPartitionFunctionSandwich.lean` の
  `trace_power_sandwich_physical`。
- 人手の `W_ℝ = ϱ(W)` は `realMatrixOfRealEntries W hW.1`、`c := c(M_col)` は `rayleighSup W_ℝ`、`𝓡` は `rayleighSet W_ℝ`、
  `T := Σ_k ((W_ℝ)^n)_kk` は `∑ k, (W_ℝ ^ n) k k` である。
- 人手の `e_1` は Lean の `Pi.single i 1`（`i` は値がすべて `0` の配位）である。
- 人手の実数の冪の定義 `def_power_of_real_number` の `a^{m+1} := a^ma` は mathlib の `pow_succ`、`a^0 := 1` は `pow_zero` で書く
  （Lean の `ℝ` の冪は mathlib の `Monoid.npow` で、この二つはその公理 `Monoid.npow_succ`・`Monoid.npow_zero` である）。人手の「`ℝ` の分配則」「乗法の交換則・結合則」
  「`ℝ` の加法」の行は `ring` で、`(n c^{n-1})^{-1} = n^{-1}(c^{n-1})^{-1}` は `mul_inv`、`c^{n-1}(c^{n-1})^{-1} = 1` は `mul_inv_cancel₀`、
  正の数を掛けても順序を保つ行は `mul_lt_mul_of_pos_*`・`mul_le_mul_of_nonneg_left`・`mul_le_mul_of_nonneg_right` で、移項は `linarith` で、
  `0 < n^{-1} ≤ 1` と `c > 0` から `cn^{-1} ≤ c` の行は `inv_le_one_of_one_le₀` と `nlinarith` で、`ℤ` の `n = (n−1)+1`・`p = (p+1)−1` は
  `Nat.sub_add_cancel`・`Nat.add_sub_cancel` で書く（人手のこれらの行には参照が無い）。
- 人手の「上限は最小の上界なので `r` は `𝓡` の上界でない」は mathlib の `exists_lt_of_lt_csSup` で書く（`c` は Lean の `sSup` で、
  `def_rayleigh_sup` の上限と同じものである）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerSandwichUnitVectorBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerUpperBound

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

/-- **人手【正の実数の冪の比較】**: `r, s ∈ ℝ_{>0}`、`r < s`、`p ∈ ℤ_{≥1}` について
(a) `0 < r^p < s^p`、(b) `s^p − r^p ≤ p s^{p−1}(s − r)`（`p` についての帰納法）。 -/
theorem power_comparison_of_positive_reals {r s : ℝ} (hr : 0 < r) (hs : 0 < s) (hrs : r < s)
    {p : ℕ} (hp : 1 ≤ p) :
    (0 < r ^ p ∧ r ^ p < s ^ p) ∧ s ^ p - r ^ p ≤ (p : ℝ) * s ^ (p - 1) * (s - r) := by
  induction p, hp using Nat.le_induction with
  | base =>
      have hr1 : r ^ 1 = r := by rw [pow_succ, pow_zero, one_mul]           -- `r^1 = r^0r = r`（`def_power_of_real_number`）
      have hs1 : s ^ 1 = s := by rw [pow_succ, pow_zero, one_mul]           -- `s^1 = s`（`def_power_of_real_number`）
      refine ⟨⟨?_, ?_⟩, ?_⟩
      · rw [hr1]; exact hr                                                  -- (a) は `0 < r`
      · rw [hr1, hs1]; exact hrs                                            -- (a) は `r < s`
      · rw [hr1, hs1]
        exact le_of_eq (by rw [Nat.sub_self, pow_zero, Nat.cast_one, one_mul, one_mul])
                                                                            -- (b) は `s − r = 1·s^0(s − r)`（`def_power_of_real_number` で `s^0 = 1`）
  | succ p hp ih =>
      obtain ⟨⟨hrp, hrsp⟩, hb⟩ := ih
      have hsp : 0 < s ^ p := lt_trans hrp hrsp                             -- (a) から `s^p > r^p > 0`
      have ha : r ^ (p + 1) < s ^ (p + 1) :=
        calc r ^ (p + 1)
            = r ^ p * r := pow_succ r p                                     -- `def_power_of_real_number` で `r^{p+1} = r^pr`
          _ < s ^ p * r := mul_lt_mul_of_pos_right hrsp hr                  -- (a) の `r^p < s^p` と `r > 0`
          _ < s ^ p * s := mul_lt_mul_of_pos_left hrs hsp                   -- `r < s` と、(a) から `s^p > r^p > 0`
          _ = s ^ (p + 1) := (pow_succ s p).symm                            -- `def_power_of_real_number` で `s^{p+1} = s^ps`
      have hpos : 0 < r ^ (p + 1) := by
        rw [pow_succ]; exact mul_pos hrp hr                                 -- `r^{p+1} = r^pr > 0`（`def_power_of_real_number`、`r^p > 0`、`r > 0`）
      refine ⟨⟨hpos, ha⟩, ?_⟩
      have hsr : 0 < s - r := sub_pos.mpr hrs
      have hss : s * s ^ (p - 1) = s ^ p := by                              -- `s s^{p−1} = s^{p−1}s = s^p`（乗法の交換則と、`def_power_of_real_number` で `s^{(p−1)+1} = s^{p−1}s`、`ℤ` で `(p−1)+1 = p`）
        rw [mul_comm, ← pow_succ, Nat.sub_add_cancel hp]
      calc s ^ (p + 1) - r ^ (p + 1)
          = s * (s ^ p - r ^ p) + r ^ p * (s - r) := by
            rw [pow_succ, pow_succ]; ring                                   -- `def_power_of_real_number` で `s^{p+1} = s^ps`, `r^{p+1} = r^pr` と `ℝ` の分配則・乗法の交換則（`−sr^p + r^ps = 0`）
        _ ≤ s * ((p : ℝ) * s ^ (p - 1) * (s - r)) + r ^ p * (s - r) := by
            have := mul_le_mul_of_nonneg_left hb hs.le
            linarith                                                        -- (b) と `s > 0`
        _ ≤ s * ((p : ℝ) * s ^ (p - 1) * (s - r)) + s ^ p * (s - r) := by
            have := mul_le_mul_of_nonneg_right hrsp.le hsr.le
            linarith                                                        -- (a) の `r^p < s^p` と `s − r > 0`
        _ = (p : ℝ) * s ^ p * (s - r) + s ^ p * (s - r) := by
            rw [← hss]; ring                                                -- `s s^{p−1} = s^p`（`def_power_of_real_number`）と乗法の交換則・結合則
        _ = ((p + 1 : ℕ) : ℝ) * s ^ (p + 1 - 1) * (s - r) := by
            rw [Nat.add_sub_cancel]; push_cast; ring                        -- `ℝ` の分配則と `ℤ` で `p = (p+1)−1`

variable {M : ℕ}

/-- 人手【上限への移行】の `c^{n-1} > 0`: `n = 1` なら `c^0 = 1`、`n ≥ 2` なら【正の実数の冪の比較】(a) を
`r → c, s → c+1, p → n−1` に当てる。 -/
theorem pow_pred_pos_of_pos {c : ℝ} (hc : 0 < c) {n : ℕ} (hn : 1 ≤ n) : 0 < c ^ (n - 1) := by
  rcases Nat.lt_or_ge n 2 with h | h
  · rw [show n - 1 = 0 by omega, pow_zero]; exact one_pos                    -- `n = 1` なら `c^0 = 1`（`def_power_of_real_number`）
  · exact ((power_comparison_of_positive_reals hc (by linarith) (by linarith : c < c + 1)
      (show 1 ≤ n - 1 by omega)).1).1                                       -- 【正の実数の冪の比較】(a)（`r → c, s → c+1, p → n−1`）

section General

variable (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
  (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
  (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)

include hWRsymm hpd

/-- 人手【上限への移行】の冒頭: `‖e_1‖ = 1` の `e_1` に【単位ベクトルでの評価】を当てて `T ≥ m_n > 0`
（`m_n` は `x = e_1` のもの。`m_n > 0` は `moment_log_convexity` の正値性）。 -/
theorem trace_of_power_pos (n : ℕ) : 0 < ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k := by
  set e : Conf M → ℝ := Pi.single (fun _ => 0) 1
  have he : vecNorm e = 1 := norm_of_standard_basis_vector _               -- `‖e_1‖ = 1`
  calc (0 : ℝ)
      < momentWReal W hW e n := (moment_log_convexity W hW hWRsymm hpd he).1 n
                                                                            -- `moment_log_convexity` の `m_k > 0`（`k → n`）
    _ ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k :=
        moment_le_trace_of_power W hW hWRsymm hpd he n                      -- 【単位ベクトルでの評価】の `m_n ≤ T`

/-- **人手【上限への移行】**: `n ≥ 1` について `c^n ≤ T`（`c := c(M_col)`、`T := Σ_k ((W_ℝ)^n)_kk`）を背理法で示す。 -/
theorem rayleighSup_pow_le_trace_of_power {n : ℕ} (hn : 1 ≤ n) :
    rayleighSup (realMatrixOfRealEntries W hW.1) ^ n
      ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k := by
  haveI : Nonempty (Conf M) := ⟨fun _ => 0⟩
  set WR := realMatrixOfRealEntries W hW.1 with hWR
  set c := rayleighSup WR with hcdef
  set T := ∑ k, (WR ^ n) k k with hT
  have hc : 0 < c := rayleighSup_pos hpd                                    -- `c ∈ ℝ_{>0}`（`def_rayleigh_sup`）
  have hTpos : 0 < T := trace_of_power_pos W hW hWRsymm hpd n               -- `T ≥ m_n > 0`
  by_contra hcon
  have hgt : T < c ^ n := lt_of_not_ge hcon                                 -- `c^n > T` と仮定する
  have hcn1 : 0 < c ^ (n - 1) := pow_pred_pos_of_pos hc hn                  -- `c^{n-1} > 0`
  have hn0 : (0 : ℝ) < n := by exact_mod_cast hn
  have hncn : 0 < (n : ℝ) * c ^ (n - 1) := mul_pos hn0 hcn1                 -- `n c^{n-1} > 0`
  set δ : ℝ := (c ^ n - T) * ((n : ℝ) * c ^ (n - 1))⁻¹ with hδ
  set r : ℝ := c - δ with hr
  have hδpos : 0 < δ := mul_pos (sub_pos.mpr hgt) (inv_pos.mpr hncn)        -- `δ ∈ ℝ_{>0}`
  have hrc : r < c := by rw [hr]; linarith                                  -- `r < c`
  have hδc : δ < c :=
    calc δ
        = (c ^ n - T) * ((n : ℝ) * c ^ (n - 1))⁻¹ := hδ                     -- `δ` の定義
      _ < c ^ n * ((n : ℝ) * c ^ (n - 1))⁻¹ :=
          mul_lt_mul_of_pos_right (by linarith) (inv_pos.mpr hncn)          -- `T > 0` と、正の `(n c^{n-1})^{-1}` を掛けても順序を保つ
      _ = c ^ (n - 1) * c * ((n : ℝ) * c ^ (n - 1))⁻¹ := by
          rw [← pow_succ, Nat.sub_add_cancel hn]                            -- `def_power_of_real_number` で `c^{(n−1)+1} = c^{n−1}c` と `ℤ` で `n = (n−1)+1`
      _ = c ^ (n - 1) * c * ((n : ℝ)⁻¹ * (c ^ (n - 1))⁻¹) := by
          rw [mul_inv]                                                      -- `n ≠ 0`, `c^{n-1} ≠ 0` なので `(n c^{n-1})^{-1} = n^{-1}(c^{n-1})^{-1}`
      _ = c * (n : ℝ)⁻¹ * (c ^ (n - 1) * (c ^ (n - 1))⁻¹) := by ring       -- `ℝ` の乗法の交換則・結合則
      _ = c * (n : ℝ)⁻¹ := by rw [mul_inv_cancel₀ hcn1.ne', mul_one]       -- `c^{n-1}(c^{n-1})^{-1} = 1`
      _ ≤ c := by
          have hn1 : (n : ℝ)⁻¹ ≤ 1 := inv_le_one_of_one_le₀ (by exact_mod_cast hn)
          nlinarith                                                         -- `n ≥ 1` なので `0 < n^{-1} ≤ 1` と `c > 0`
  have hrpos : 0 < r := by rw [hr]; linarith                                -- `r = c − δ > 0`
  obtain ⟨t, ⟨x, hx1, rfl⟩, hrt⟩ :=
    exists_lt_of_lt_csSup (rayleighSet_nonempty WR) hrc                     -- `r < c = sup 𝓡` で、上限は最小の上界なので `r` は `𝓡` の上界でない
  have htpos : 0 < x ⬝ᵥ WR *ᵥ x := hpd x (ne_zero_of_unit_norm hx1)         -- `t ∈ 𝓡 ⊆ ℝ_{>0}`
  have hcomp_t := power_comparison_of_positive_reals hrpos htpos hrt hn
  have hcomp_c := power_comparison_of_positive_reals hrpos hc hrc hn
  have hTT : T > T :=
    calc T
        ≥ (x ⬝ᵥ WR *ᵥ x) ^ n :=
          real_bilinear_value_pow_le_trace_of_power W hW hWRsymm hpd hx1 n  -- 【単位ベクトルでの評価】の `(x^⊤W_ℝx)^n ≤ T`
      _ > r ^ n := hcomp_t.1.2                                              -- 【正の実数の冪の比較】(a)（`r → r, s → t, p → n`）
      _ ≥ c ^ n - (n : ℝ) * c ^ (n - 1) * (c - r) := by
          have := hcomp_c.2; linarith                                       -- 【正の実数の冪の比較】(b)（`r → r, s → c, p → n`）の移項
      _ = c ^ n - (n : ℝ) * c ^ (n - 1) * δ := by
          rw [show c - r = δ by rw [hr]; ring]                              -- `r := c − δ` なので `c − r = δ`
      _ = c ^ n - (c ^ n - T) := by
          rw [hδ, mul_comm (c ^ n - T), ← mul_assoc, mul_inv_cancel₀ hncn.ne', one_mul]
                                                                            -- `δ` の定義と `n c^{n-1}(n c^{n-1})^{-1} = 1`
      _ = T := by ring                                                      -- `ℝ` の加法
  exact lt_irrefl T hTT                                                     -- `T > T` で矛盾

/-- **人手 `trace_power_sandwich`**: `n ≥ 1` について `c(M_col)^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`。
下からの評価は【上限への移行】、上からの評価は `trace_power_upper_bound`。 -/
theorem trace_power_sandwich {n : ℕ} (hn : 1 ≤ n) :
    rayleighSup (realMatrixOfRealEntries W hW.1) ^ n
        ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k
      ∧ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k
        ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries W hW.1) ^ n :=
  ⟨rayleighSup_pow_le_trace_of_power W hW hWRsymm hpd hn,                  -- 【上限への移行】の `c^n ≤ T`
    trace_power_upper_bound W hW hWRsymm hpd hn⟩                            -- `trace_power_upper_bound` の `T ≤ 2^{M_col}c^n`

end General

end Ising2D
