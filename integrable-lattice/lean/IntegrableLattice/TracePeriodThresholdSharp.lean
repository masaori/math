/-
# 命題 C″ (1) のしきい値 $w^*+1$ の最良性 — cycle 40 step 3

対応する人手証明:

* 本文ブロック `paper_045_theorem_trace_ladder`（命題 C″）の (1)
  「しきい値 $w^*+1$ は最良である（$k\le w^*$ では偽）」

## このファイルが埋めるもの

本文は最良性を主張するだけで、**反例を 1 つも挙げていない。**
そのため cycle 38 以降、この 1 件は「反例の族を作る主張である」として残っていた。

**本サイクルの着手時に反例を探したところ、$2\times2$ の整数行列の中に在った。**
（探索は $-4$ から $4$ までの成分をもつ $2\times2$ 行列と $p\in\{2,3,5\}$ の総当たりで、
条件を満たす組は 394 件見つかった。以下はそのうち成分が最も小さいものである。）

$$
S=\begin{pmatrix}-2&-1\\-1&0\end{pmatrix},\qquad p=2,\qquad r=2.
$$

このとき $w^*=2$ であり、$k=2\le w^*$ で階段が破れる——
$t_2=1$、$t_3=4$ であって $t_3\nmid p\,t_2=2$ である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。扱うのは $\mathbb{Z}$ 上の $2\times2$ 行列と整数の整除だけである。

## 書いたこと（3 段）

1. **トレース列の漸化式**（`a_succ_succ`）。$S$ は自分の特性多項式
   $x^2+2x-1$ を満たすので、$a_N=\operatorname{Tr}S^N$ は $a_{N+2}=-2a_{N+1}+a_N$ に従う。
2. **周期の判定は有限の計算に落ちる**（`isPeriodMod_of_two`）。
   $u_N=\operatorname{Tr}(S^N(S^t-1))=a_{N+t}-a_N$ も同じ漸化式に従うので、
   **$N=0,1$ の 2 つを確かめれば全ての $N$ で割り切れる。** ここが $r=2$ であることの効きどころである。
3. **$w^*=2$ の証拠**（`gram_smith`）。Gram 行列 $G=\begin{pmatrix}2&-2\\-2&6\end{pmatrix}$ について、
   行列式 $1$ の行列で挟むと $\mathrm{diag}(2,4)$ になる。$2\mid4$ なので単因子は $2,4$ であり、
   最大単因子の $2$ 進付値は $2$ である。

仕上げ（`ladder_fails_at_two`）で、$k=2$ において $t_{k+1}\mid p\,t_k$ が偽であることを述べる。

## 本文の側にも手を入れた理由

本文は反例を挙げずに最良性を主張していた。**主張を形式化するには反例が要る**ので、
上の $S$ と $p$ を本文へ書き足した。**主張の内容は変えていない**——
最良であるという主張はそのままで、その witness を明示しただけである。

## 形式化しなかったもの

* **$k\le w^*$ の全ての $k$ で破れる、という形にはしていない。** 反例が示すのは
  「$w^*+1$ より小さいしきい値では成り立たない」ことであり、本文の主張もそれである。
  $k$ ごとに破れるかどうかは $S$ に依る（この $S$ では $k=1$ では破れていない。$t_2=1\mid p\,t_1=2$）。
* **一般の $T$ についての配線**は書いていない。$w^*$ が本当に $2$ であることは、上の挟み込みで
  単因子が $2,4$ であることまでで、Gram 行列そのものが 命題 W\* の $G$ であること
  （$G=(\operatorname{Tr}T^{i+j})$）は、この file の中で数値として与えている。
-/
import Mathlib
import IntegrableLattice.TracePeriodAssembly

namespace IntegrableLattice
namespace TracePeriodThresholdSharp

open Matrix

/-- 反例の行列 $S=\begin{pmatrix}-2&-1\\-1&0\end{pmatrix}$。 -/
def S : Matrix (Fin 2) (Fin 2) ℤ := !![-2, -1; -1, 0]

/-- トレース列 $a_N=\operatorname{Tr}S^N$。 -/
noncomputable def a (N : ℕ) : ℤ := Matrix.trace (S ^ N)

/-! ## 1. 漸化式

$S$ は特性多項式 $x^2+2x-1$ を満たす（`S_sq`）。トレースは加法的なので、
$a$ も同じ漸化式に従う。 -/

theorem S_sq : S ^ 2 = -2 • S + 1 := by
  simp only [S, pow_two]
  norm_num [Matrix.mul_fin_two, Matrix.smul_of, Matrix.one_fin_two]
  decide

theorem a_succ_succ (N : ℕ) : a (N + 2) = -2 * a (N + 1) + a N := by
  have hpow : S ^ (N + 2) = S ^ N * S ^ 2 := by rw [pow_add]
  rw [a, a, a, hpow, S_sq, Matrix.mul_add, Matrix.trace_add, mul_smul_comm, Matrix.trace_smul,
    mul_one, pow_succ]
  push_cast
  ring

theorem a_zero : a 0 = 2 := by simp [a]
theorem a_one : a 1 = -2 := by norm_num [a, S, Matrix.trace_fin_two]

/-! ## 2. 周期の判定は 2 つの値に落ちる

$u_N=a_{N+t}-a_N$ も同じ漸化式に従うので、$u_0$ と $u_1$ が割り切れれば全ての $N$ で割り切れる。
**ここが $r=2$（$\mathbb{Z}[S]$ が $1,S$ で張られること）の効きどころである。**

周期の言葉は `TracePeriodAssembly.lean` の `IsPeriodMod`（数列の側）を使う。
**行列の側の `IsTracePeriodAt` は係数環が可換であることを要求するので、行列環では当たらない。**
本文の $\operatorname{Tr}(S^N(S^t-I))$ は $a_{N+t}-a_N$ そのものなので、数列の言葉で述べても内容は同じである。 -/

/-- 同じ漸化式に従う列は、初めの 2 項が割り切れれば全項が割り切れる。 -/
theorem dvd_of_two (m : ℤ) (u : ℕ → ℤ) (hrec : ∀ N, u (N + 2) = -2 * u (N + 1) + u N)
    (h0 : m ∣ u 0) (h1 : m ∣ u 1) : ∀ N, m ∣ u N := by
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    match N with
    | 0 => exact h0
    | 1 => exact h1
    | (n + 2) =>
      rw [hrec n]
      exact dvd_add (Dvd.dvd.mul_left (ih (n + 1) (by omega)) _) (ih n (by omega))

/-- $u_N=a_{N+t}-a_N$ は同じ漸化式に従う。 -/
theorem traceDiff_rec (t : ℕ) (N : ℕ) :
    (a (N + 2 + t) - a (N + 2)) = -2 * (a (N + 1 + t) - a (N + 1)) + (a (N + t) - a N) := by
  have h1 : a (N + 2 + t) = -2 * a (N + 1 + t) + a (N + t) := by
    have hidx : N + 2 + t = (N + t) + 2 := by omega
    have hidx' : N + 1 + t = (N + t) + 1 := by omega
    rw [hidx, hidx', a_succ_succ]
  rw [h1, a_succ_succ]
  ring

/-- 2 つの値だけ確かめれば周期であることが出る。 -/
theorem isPeriodMod_of_two {m : ℤ} {t : ℕ}
    (h0 : m ∣ (a (0 + t) - a 0)) (h1 : m ∣ (a (1 + t) - a 1)) : IsPeriodMod m a t :=
  dvd_of_two m (fun N => a (N + t) - a N) (traceDiff_rec t) h0 h1

/-! ## 3. 値の計算

$a_0,\dots,a_5=2,-2,6,-14,34,-82$。 -/

theorem a_two : a 2 = 6 := by rw [a_succ_succ 0, a_one, a_zero]; ring
theorem a_three : a 3 = -14 := by rw [a_succ_succ 1, a_two, a_one]; ring
theorem a_four : a 4 = 34 := by rw [a_succ_succ 2, a_three, a_two]; ring
theorem a_five : a 5 = -82 := by rw [a_succ_succ 3, a_four, a_three]; ring

/-! ## 4. $t_2=1$ と $t_3=4$ -/

/-- $t_2=1$。レベル $2$（法 $4$）では $t=1$ が周期である。 -/
theorem isLeast_period_two : IsLeast {u : ℕ | 0 < u ∧ IsPeriodMod 4 a u} 1 := by
  refine ⟨⟨Nat.one_pos, isPeriodMod_of_two ?_ ?_⟩, ?_⟩
  · norm_num [a_one, a_zero]
  · norm_num [a_two, a_one]
  · intro u hu
    exact hu.1

/-- レベル $3$（法 $8$）では $t=4$ が周期である。 -/
theorem isPeriodMod_eight_four : IsPeriodMod 8 a 4 := by
  refine isPeriodMod_of_two ?_ ?_
  · norm_num [a_four, a_zero]
  · norm_num [a_five, a_one]

/-- $t_3=4$。$t=1,2,3$ はいずれもレベル $3$ の周期ではない。 -/
theorem isLeast_period_three : IsLeast {u : ℕ | 0 < u ∧ IsPeriodMod 8 a u} 4 := by
  refine ⟨⟨by norm_num, isPeriodMod_eight_four⟩, ?_⟩
  intro u hu
  rcases hu with ⟨hpos, hper⟩
  by_contra hlt
  push_neg at hlt
  interval_cases u
  · -- $t=1$: $a_1-a_0=-4$ は $8$ で割れない。
    have := hper 0
    norm_num [a_one, a_zero] at this
  · -- $t=2$: $a_2-a_0=4$ は $8$ で割れない。
    have := hper 0
    norm_num [a_two, a_zero] at this
  · -- $t=3$: $a_4-a_1=36$ は $8$ で割れない。
    have := hper 1
    norm_num [a_four, a_one] at this

/-! ## 5. $w^*=2$ の証拠と、階段が破れること

Gram 行列 $G=(\operatorname{Tr}S^{i+j})_{0\le i,j<2}=\begin{pmatrix}2&-2\\-2&6\end{pmatrix}$ を、
行列式 $1$ の行列で挟むと $\mathrm{diag}(2,4)$ になる。$2\mid4$ なので単因子は $2,4$ であり、
最大単因子の $2$ 進付値は $2$、すなわち $w^*=2$ である。 -/

/-- 本文の $G=(\operatorname{Tr}S^{i+j})$ の値。 -/
def gram : Matrix (Fin 2) (Fin 2) ℤ := !![2, -2; -2, 6]

theorem gram_eq : gram = Matrix.of fun i j : Fin 2 => a ((i : ℕ) + (j : ℕ)) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [gram, a_zero, a_one, a_two]

/-- **単因子が $2,4$ であることの証拠。** 行列式 $1$ の行列で挟むと対角形になる。 -/
theorem gram_smith :
    (!![1, 0; 1, 1] : Matrix (Fin 2) (Fin 2) ℤ) * gram * !![1, 1; 0, 1] = !![2, 0; 0, 4] := by
  simp only [gram]
  norm_num [Matrix.mul_fin_two]

theorem det_left : (!![1, 0; 1, 1] : Matrix (Fin 2) (Fin 2) ℤ).det = 1 := by
  norm_num [Matrix.det_fin_two]

theorem det_right : (!![1, 1; 0, 1] : Matrix (Fin 2) (Fin 2) ℤ).det = 1 := by
  norm_num [Matrix.det_fin_two]

/-- **しきい値 $w^*+1$ の最良性の witness。**

$w^*=2$ のこの例で、$k=2\le w^*$ では階段 $t_{k+1}\mid p\,t_k$ が成り立たない——
$t_2=1$、$t_3=4$ であって $4\nmid 2\cdot1$ である。
したがって階段のしきい値を $w^*+1$ より小さく取ることはできない。 -/
theorem ladder_fails_at_two :
    IsLeast {u : ℕ | 0 < u ∧ IsPeriodMod 4 a u} 1 ∧
    IsLeast {u : ℕ | 0 < u ∧ IsPeriodMod 8 a u} 4 ∧
    ¬ (4 ∣ 2 * 1) :=
  ⟨isLeast_period_two, isLeast_period_three, by norm_num⟩

end TracePeriodThresholdSharp
end IntegrableLattice
