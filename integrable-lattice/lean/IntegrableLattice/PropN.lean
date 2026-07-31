/-
# 命題 N（線形成長率は Newton 多角形で決まる）

対応する人手証明:
`integrable-lattice/structured-latex/content/004_lambda_finite.ts` の
`paper_044_theorem_newton`（ラベル `paper_prop_N`）、
`outputs/paper-plans/002_R_Lambda_duality.md` §2 命題 N、
根拠 report は `outputs/reports/cycle3_T1_D-U2_rigorous.md` の「命題 B」節
（**注意**: 同 report の「命題 B」は論文本文の命題 N のことである。論文本文の命題 B は別物）。

## 人手証明のステートメント

> $v_p(Z_N)$ の $N$ 線形成長率は $\mu_{\min}(p)=\min_i v_p(\lambda_i)$ に等しく、これは
> $\chi_T$ の $p$ 進 Newton 多角形の最小傾きとして決まる。Newton 多角形は係数の $p$ 進付値の
> 点集合の下方凸包であり、有限組合せ的に求まる。固有値を個別に構成する必要も $\mathbb{Q}_p$ を
> 構成する必要もない。
> ただし Skolem–Mahler–Lech 型の相殺により、**有限個の $N$ で例外が生じうる**。

ここで $Z_N=\operatorname{Tr}(T^N)$、$\lambda_i$ は $T$ の固有値である。

## 本ファイルで形式化した主張と、形式化の過程で見つかった食い違い

### (1) 下界方向（＝命題 N の実効的な内容）は係数だけから証明できる

人手証明が強調するとおり「固有値を構成する必要はない」。実際、**固有値も $\mathbb{Q}_p$ も
Newton 多角形も使わずに**、Cayley–Hamilton だけで次が出る（`trace_pow_dvd_of_charpoly_coeff_dvd`）。

> $\chi_T$ の係数が $p^{m\,(d-i)}\mid[\text{$x^i$ の係数}]$（$0\le i<d$）を満たすなら、
> すべての $N$ で $p^{mN}\mid p^{md}\,Z_N$、すなわち $v_p(Z_N)\ge mN-md$。

仮定「$p^{m(d-i)}\mid c_i$」は「Newton 多角形の傾きがすべて $m$ 以上」＝「$\mu_{\min}\ge m$」を
**係数の有限チェックで書いたもの**であり、命題 N の決定可能性の主張そのものである。
結論のオフセット $md$ は $N$ に依らない定数なので、$\liminf_N v_p(Z_N)/N\ge m$（＝線形成長率の下界）を与える。

### (2) 「有限個の $N$ で例外」は**誤り**である。例外集合は無限になりうる

これが本 step で見つかった食い違いである。根拠 report（`cycle3_T1_D-U2_rigorous.md`）は
例外を「**算術級数の有限和**」と正しく書いているが、論文本文では「**有限個の $N$**」に変わっている。
Skolem–Mahler–Lech の零点集合は算術級数の有限和であり、一般に**無限集合**である。

反例（本ファイルで形式化した）: $T=\begin{pmatrix}0&1\\2&0\end{pmatrix}\in M_2(\mathbb{Z})$、$p=2$。
$\chi_T=x^2-2$ なので固有値は $\pm\sqrt2$、$\mu_{\min}=1/2$。

* $N$ が奇数のとき $Z_N=0$（`trace_cexN_pow_odd`）。すなわち $v_2(Z_N)=\infty$ で、
  「$v_2(Z_N)=\mu_{\min}N$」は**すべての奇数 $N$ で破れる**（`cexN_exceptional_unbounded`）。
* $N=2k$ のとき $Z_N=2^{k+1}$（`trace_cexN_pow_even`）で $v_2(Z_N)=N/2+1$、成長率は $1/2=\mu_{\min}$。

したがって「線形成長率 $=\mu_{\min}$」は**例外集合を除いた $N$ について**の主張としてのみ正しく、
例外集合は有限とは限らない。

### (3) 形式化していない段（正直に）

* **Newton 多角形の最小傾きが $\min_i v_p(\lambda_i)$ に一致する段は形式化していない。**
  本ファイルは「係数の付値条件 ⟹ トレース列の付値の下界」だけを閉じている。
  固有値側との接続には代数閉体上の付値（$\overline{\mathbb{Q}_p}$）が要る。
* **上界方向（成長率が $\mu_{\min}$ を超えないこと）も形式化していない。** これは (2) のとおり
  例外集合の構造（Skolem–Mahler–Lech / Strassmann）を要し、mathlib には無い
  （`scripts/mathlib-gap-survey.sh` の cycle 18 実行ログ `logs/mathlib-gap-survey-cycle18.log`）。
* 各 $N$ ごとの鋭い形 $v_p(Z_N)\ge \mu_{\min}N$（オフセット $md$ 無し）は、Newton 恒等式で
  $N<d$ の初期値を評価すれば出るが、mathlib の Newton 恒等式は `MvPolynomial` 版
  （`MvPolynomial.psum_eq_mul_esymm_sub_sum`）しかなく、行列のトレース冪との接続は自前で
  作る必要がある（companion 行列も mathlib に無い。両者とも本 step で grep 確認済み）。
  本ファイルは定数オフセット付きの形で閉じている。

**新規性は主張しない。** Cayley–Hamilton から線形漸化式を出す議論も Newton 多角形も古典である。
-/
import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace IntegrableLattice

open Matrix Polynomial Finset

section Recurrence

variable {d : ℕ} (M : Matrix (Fin d) (Fin d) ℤ)

/-- Cayley–Hamilton から出るトレース列の線形漸化式。
$Z_N=\operatorname{Tr}(T^N)$ と置くと $Z_{d+k}=-\sum_{i<d}c_i Z_{i+k}$（$c_i$ は $\chi_T$ の $x^i$ の係数）。 -/
theorem trace_pow_add_eq_neg_sum (k : ℕ) :
    (M ^ (d + k)).trace = -∑ i ∈ range d, M.charpoly.coeff i * (M ^ (i + k)).trace := by
  have hdeg : M.charpoly.natDegree = d := by
    simpa using M.charpoly_natDegree_eq_dim
  have h0 : (aeval M) M.charpoly = 0 := M.aeval_self_charpoly
  rw [aeval_eq_sum_range, hdeg] at h0
  have h1 : (∑ i ∈ range (d + 1), M.charpoly.coeff i • M ^ i) * M ^ k = 0 := by
    rw [h0, zero_mul]
  rw [Finset.sum_mul] at h1
  have h2 : ∑ i ∈ range (d + 1), M.charpoly.coeff i • M ^ (i + k) = 0 := by
    rw [← h1]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [smul_mul_assoc, ← pow_add]
  have h3 : ∑ i ∈ range (d + 1), M.charpoly.coeff i * (M ^ (i + k)).trace = 0 := by
    have h := congrArg Matrix.trace h2
    rw [Matrix.trace_sum, Matrix.trace_zero] at h
    rw [← h]
    exact Finset.sum_congr rfl fun i _ => by rw [Matrix.trace_smul, smul_eq_mul]
  rw [Finset.sum_range_succ] at h3
  have hlead : M.charpoly.coeff d = 1 := by
    have := M.charpoly_monic.coeff_natDegree
    rwa [hdeg] at this
  rw [hlead, one_mul] at h3
  linarith [h3]

end Recurrence

/-- **命題 N の下界方向**（Newton 多角形の最小傾きが $m$ 以上という係数条件からの結論）。

$\chi_T=\sum_{i\le d}c_ix^i$ が $p^{m(d-i)}\mid c_i$（$i<d$）を満たすなら、すべての $N$ で
$$q^{mN}\ \Big|\ q^{md}\,\operatorname{Tr}(T^N).$$
オフセット $q^{md}$ は $N$ に依らないので、これは $v_p(Z_N)\ge mN-md$、
したがって線形成長率が $m$ 以上であることを与える。

証明に使うのは Cayley–Hamilton から出る漸化式だけで、**固有値も Newton 多角形も $\mathbb{Q}_p$ も
使っていない**（人手証明が主張する「有限組合せ的に決まる」に対応する）。 -/
theorem trace_pow_dvd_of_charpoly_coeff_dvd {d : ℕ} (M : Matrix (Fin d) (Fin d) ℤ)
    (q : ℤ) (m : ℕ) (hc : ∀ i < d, q ^ (m * (d - i)) ∣ M.charpoly.coeff i) (N : ℕ) :
    q ^ (m * N) ∣ q ^ (m * d) * (M ^ N).trace := by
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    rcases lt_or_ge N d with hN | hN
    · exact Dvd.dvd.mul_right (pow_dvd_pow q (Nat.mul_le_mul_left m hN.le)) _
    · obtain ⟨k, rfl⟩ : ∃ k, N = d + k := ⟨N - d, by omega⟩
      rw [trace_pow_add_eq_neg_sum, mul_neg, dvd_neg, Finset.mul_sum]
      refine Finset.dvd_sum fun i hi => ?_
      have hid : i < d := Finset.mem_range.mp hi
      have h1 : q ^ (m * (i + k)) ∣ q ^ (m * d) * (M ^ (i + k)).trace := ih _ (by omega)
      have h2 : q ^ (m * (d - i)) ∣ M.charpoly.coeff i := hc i hid
      have hpow : q ^ (m * (d + k)) = q ^ (m * (d - i)) * q ^ (m * (i + k)) := by
        rw [← pow_add, ← Nat.mul_add]
        congr 2
        omega
      have h4 : M.charpoly.coeff i * (q ^ (m * d) * (M ^ (i + k)).trace)
          = q ^ (m * d) * (M.charpoly.coeff i * (M ^ (i + k)).trace) := by ring
      rw [hpow, ← h4]
      exact mul_dvd_mul h2 h1

/-- 上の系を付値で述べた形: $v_p(Z_N)\ge mN-md$。 -/
theorem le_padicValInt_trace_pow {d : ℕ} (M : Matrix (Fin d) (Fin d) ℤ) (p : ℕ) [hp : Fact p.Prime]
    (m : ℕ) (hc : ∀ i < d, (p : ℤ) ^ (m * (d - i)) ∣ M.charpoly.coeff i) (N : ℕ)
    (hZ : (M ^ N).trace ≠ 0) :
    m * N ≤ m * d + padicValInt p ((M ^ N).trace) := by
  have hdvd := trace_pow_dvd_of_charpoly_coeff_dvd M (p : ℤ) m hc N
  have hppos : (0 : ℤ) < (p : ℤ) := by exact_mod_cast hp.out.pos
  have hpne : ((p : ℤ)) ^ (m * d) ≠ 0 := pow_ne_zero _ (ne_of_gt hppos)
  have hne : ((p : ℤ) ^ (m * d) * (M ^ N).trace) ≠ 0 := mul_ne_zero hpne hZ
  have hval : padicValInt p ((p : ℤ) ^ (m * d) * (M ^ N).trace)
      = m * d + padicValInt p ((M ^ N).trace) := by
    rw [padicValInt.mul hpne hZ]
    congr 1
    have : ((p : ℤ) ^ (m * d)).natAbs = p ^ (m * d) := by
      simp [Int.natAbs_pow]
    simp [padicValInt, this]
  have := (padicValInt_dvd_iff (p := p) (m * N) ((p : ℤ) ^ (m * d) * (M ^ N).trace)).mp hdvd
  rcases this with h | h
  · exact absurd h hne
  · omega

/-! ## 反例: 例外集合は無限になりうる（人手証明の「有限個の $N$」は誤り） -/

/-- 反例行列 $T=\begin{pmatrix}0&1\\2&0\end{pmatrix}$。$\chi_T=x^2-2$、$\mu_{\min}(2)=1/2$。 -/
def cexN : Matrix (Fin 2) (Fin 2) ℤ := !![0, 1; 2, 0]

theorem cexN_sq : cexN ^ 2 = (2 : ℤ) • (1 : Matrix (Fin 2) (Fin 2) ℤ) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [cexN, pow_two, Matrix.mul_apply, Fin.sum_univ_two]

theorem cexN_pow_add_two (k : ℕ) : cexN ^ (k + 2) = (2 : ℤ) • cexN ^ k := by
  rw [pow_add, cexN_sq, mul_smul_comm, mul_one]

theorem trace_cexN_pow_add_two (k : ℕ) :
    (cexN ^ (k + 2)).trace = 2 * (cexN ^ k).trace := by
  rw [cexN_pow_add_two, Matrix.trace_smul, smul_eq_mul]

/-- $N$ が偶数のとき $Z_N=2^{N/2+1}$。付値は $N/2+1$ で、成長率は $\mu_{\min}=1/2$ に一致する。 -/
theorem trace_cexN_pow_even (k : ℕ) : (cexN ^ (2 * k)).trace = 2 ^ (k + 1) := by
  induction k with
  | zero => simp [Matrix.trace, Matrix.diag]
  | succ k ih =>
    have h : 2 * (k + 1) = 2 * k + 2 := by ring
    rw [h, trace_cexN_pow_add_two, ih]
    ring

/-- **$N$ が奇数のとき $Z_N=0$。** すなわち $v_2(Z_N)=\infty$ で、
「$v_2(Z_N)$ が $\mu_{\min}N$ に沿って伸びる」は**すべての奇数 $N$ で破れる**。 -/
theorem trace_cexN_pow_odd (k : ℕ) : (cexN ^ (2 * k + 1)).trace = 0 := by
  induction k with
  | zero => simp [cexN, Matrix.trace, Matrix.diag, Fin.sum_univ_two]
  | succ k ih =>
    have h : 2 * (k + 1) + 1 = (2 * k + 1) + 2 := by ring
    rw [h, trace_cexN_pow_add_two, ih, mul_zero]

/-- **例外集合は非有界**（したがって無限）。人手証明の「有限個の $N$ で例外が生じうる」は誤りで、
根拠 report の「算術級数の有限和」が正しい。 -/
theorem cexN_exceptional_unbounded (n : ℕ) : ∃ N, n ≤ N ∧ (cexN ^ N).trace = 0 :=
  ⟨2 * n + 1, by omega, trace_cexN_pow_odd n⟩

end IntegrableLattice
