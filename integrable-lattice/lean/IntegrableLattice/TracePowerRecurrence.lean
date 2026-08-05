/-
# 「同じ特性多項式なら同じトレース冪」への道を測り、可算側で閉じる分を書く — cycle 43 step 5

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明が
  「Newton の公式より」と引いている 1 文
  （本文の整数行列 $G=(\operatorname{Tr}T^{i+j})$ と代数側の Gram 行列の同定に要る）

## この step が何を埋めるか

cycle 42 step 3 は代数側の橋（代数のトレースを行列のトレースへ移すこと）を書き、
残りを**「同じ特性多項式をもつ 2 つの行列のトレース冪が一致すること」**という 1 文に絞った。
cycle 42 総括はその書き方に 2 つの道を挙げていた——
分解体で根を取り出す道と、逆特性多項式の対数微分（形式冪級数）を経由する道である。
**後者は $\overline{\mathbb{Q}}$ へ出ないので、そちらを測ることを焦点に置いた。**

## 2026-08-05 実測（道を選ぶ前に測る）

* **逆特性多項式は在る**（`Matrix.charpolyRev`、`Mathlib/LinearAlgebra/Matrix/Charpoly/Coeff.lean` 292 行）。
  定数項が $1$ であること（`eval_charpolyRev`）と、1 次の係数がトレースの符号違いであること
  （`coeff_charpolyRev_eq_neg_trace`）も在る。
* **対数微分の段は無い。** $P'(t)=-P(t)\sum_k\operatorname{Tr}(M^{k+1})t^{k}$ を出すには
  行列式の微分（Jacobi の公式 $\mathrm{d}\log\det A=\operatorname{tr}(A^{-1}\mathrm{d}A)$）が要るが、
  **mathlib に Jacobi の公式は無い**（`Jacobi` で当たるのは Legendre 記号と Jacobi 記号だけである）。
  **したがってこの道は素材が足りない。そう書く。**
* **Cayley–Hamilton は在る**（`Matrix.aeval_self_charpoly`）。
  **こちらは配線だけで閉じる。**

**そこで、対数微分の道の代わりに Cayley–Hamilton の道で書けるところまでを書く。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。
係数環は任意の可換環で、根も分解体も出てこない。
**これが対数微分の道を選んだ理由であり、Cayley–Hamilton の道も同じ性質をもつ。**
本文が当てる先は $\mathbb{Z}$ である。

## 書いたこと

1. **トレース冪は特性多項式の与える線形漸化式に従う**（`sum_coeff_smul_trace_pow`）。
   すべての $k$ について
   $\sum_{i=0}^{r}\chi_i\operatorname{Tr}(M^{k+i})=0$（$\chi_i$ は特性多項式の係数）。
   **芯は 2 行である**——Cayley–Hamilton の等式に $M^{k}$ を掛けてトレースを取り、
   トレースの線形性で和の外へ出すだけである。
2. **モニックなので最高次を分離した形**（`trace_pow_add_natDegree`）。
   $\operatorname{Tr}(M^{k+r})=-\sum_{i<r}\chi_i\operatorname{Tr}(M^{k+i})$。
   **$r$ 個の初期値が決まれば、以降のトレース冪は特性多項式だけで決まる。**
3. **したがって「同じ特性多項式 ＋ 最初の $r$ 個が一致」なら全部一致する**
   （`trace_pow_eq_of_charpoly_eq_of_initial`）。

## 形式化しなかったもの

* **初期値の側（$k<r$ での $\operatorname{Tr}(M^{k})$ が特性多項式だけで決まること）。**
  **ここが Newton の公式そのものであり、この step で閉じなかった当のものである。そう書く。**
  $\operatorname{Tr}(M^{0})=r$ と $\operatorname{Tr}(M^{1})=-\chi_{r-1}$ は係数から読めるが、
  $2\le k<r$ は読めない。閉じるには上に測った対数微分の段（Jacobi の公式）か、
  分解体で根を取り出す道（$\overline{\mathbb{Q}}$ へ出る）のどちらかが要る。
-/
import Mathlib

namespace IntegrableLattice
namespace TracePowerRecurrence

open Matrix Polynomial

section Recurrence

variable {R : Type*} [CommRing R] {n : Type*} [DecidableEq n] [Fintype n]

/-- **トレース冪は特性多項式の与える線形漸化式に従う。**

すべての $k$ について $\sum_{i=0}^{r}\chi_i\operatorname{Tr}(M^{k+i})=0$ である
（$\chi$ は特性多項式、$r=\deg\chi$）。

Cayley–Hamilton の等式 $\chi(M)=0$ に $M^{k}$ を掛けてトレースを取るだけである。
**根も分解体も出てこない。** -/
theorem sum_coeff_smul_trace_pow (M : Matrix n n R) (k : ℕ) :
    ∑ i ∈ Finset.range (M.charpoly.natDegree + 1),
        M.charpoly.coeff i • trace (M ^ (k + i)) = 0 := by
  have h : M ^ k * (Polynomial.aeval M) M.charpoly = 0 := by
    rw [M.aeval_self_charpoly, mul_zero]
  have h2 : trace (M ^ k * (Polynomial.aeval M) M.charpoly) = 0 := by rw [h, trace_zero]
  rw [Polynomial.aeval_eq_sum_range, Finset.mul_sum, trace_sum] at h2
  refine Eq.trans (Finset.sum_congr rfl fun i _ => ?_) h2
  rw [mul_smul_comm, ← pow_add, trace_smul]

/-- **最高次を分離した形。**

$\operatorname{Tr}(M^{k+r})=-\sum_{i<r}\chi_i\operatorname{Tr}(M^{k+i})$（$r=\deg\chi$）。

特性多項式がモニックであること（`Matrix.charpoly_monic`）から最高次の係数が $1$ になる。
**$r$ 個の初期値が決まれば、以降のトレース冪は特性多項式だけで決まる。** -/
theorem trace_pow_add_natDegree (M : Matrix n n R) (k : ℕ) :
    trace (M ^ (k + M.charpoly.natDegree))
      = -∑ i ∈ Finset.range M.charpoly.natDegree,
          M.charpoly.coeff i • trace (M ^ (k + i)) := by
  have h := sum_coeff_smul_trace_pow M k
  rw [Finset.sum_range_succ, M.charpoly_monic.coeff_natDegree, one_smul] at h
  linear_combination h

end Recurrence

section Determined

variable {R : Type*} [CommRing R] {n m : Type*}
variable [DecidableEq n] [Fintype n] [DecidableEq m] [Fintype m]

/-- **同じ特性多項式をもち、最初の $r$ 個のトレース冪が一致する 2 つの行列は、
すべてのトレース冪が一致する。**

漸化式（段 2）が同じで初期値が同じなので、帰納法で出る。

**初期値が特性多項式だけで決まることはここでは言っていない。そう書く**——
それが Newton の公式であり、本 step が閉じなかった側である。 -/
theorem trace_pow_eq_of_charpoly_eq_of_initial (M : Matrix n n R) (N : Matrix m m R)
    (hchar : M.charpoly = N.charpoly)
    (hinit : ∀ i < M.charpoly.natDegree, trace (M ^ i) = trace (N ^ i)) (k : ℕ) :
    trace (M ^ k) = trace (N ^ k) := by
  have hrN : N.charpoly.natDegree = M.charpoly.natDegree := by rw [← hchar]
  induction k using Nat.strong_induction_on with
  | _ k ih =>
    by_cases hk : k < M.charpoly.natDegree
    · exact hinit k hk
    · -- $k\ge r$ なら段 2 の漸化式で $r$ 段前へ降りる
      obtain ⟨j, rfl⟩ : ∃ j, k = j + M.charpoly.natDegree :=
        ⟨k - M.charpoly.natDegree, by omega⟩
      rw [trace_pow_add_natDegree M j, ← hrN, trace_pow_add_natDegree N j, hrN, ← hchar]
      refine congrArg Neg.neg (Finset.sum_congr rfl fun i hi => ?_)
      rw [ih (j + i) (by have := Finset.mem_range.mp hi; omega)]

end Determined

end TracePowerRecurrence
end IntegrableLattice
