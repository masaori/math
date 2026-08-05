/-
# Newton の公式の初期値（対数微分の道）— 余因子行列を段ごとに開く

対応する人手証明: 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明が
「Newton の公式より」と引いている段——**同じ特性多項式をもつ 2 つの行列は、
トレースの冪がすべて一致する。** cycle 43 step 5 が漸化式の側を書き
（`TracePowerRecurrence`）、残っていたのが初期値 $\operatorname{Tr}(M^{k})$（$k<r$）の側である。

## 道の選択（cycle 44 step 3 で決めた道をそのまま進む）

分解体で根を取り出す道（$\overline{\mathbb{Q}}$ へ出る）は採らない。採るのは対数微分の道で、
cycle 44 step 3 が書いた Jacobi の公式（`JacobiFormula.derivative_det_eq_trace_adjugate`）を
$A=1-X\widetilde M$ に当てる。

## 台帳が「形式冪級数へ開く段」と書いていたものは、多項式のままで済む

台帳は残りを「$\operatorname{adj}(1-XM)$ を形式冪級数へ開く段」と書いていた。
**開かなくてよい。** 余因子行列の定義式 $\operatorname{adj}(A)\,A=(\det A)\,I$ に
$A=1-X\widetilde M$ を入れると

$$\operatorname{adj}(A)=(\det A)\,I+X\,\operatorname{adj}(A)\,\widetilde M$$

という**多項式の中の漸化式**になる。これを $\widetilde M^{k}$ と組んでトレースを取ると

$$T_k=(\det A)\,\operatorname{Tr}(M^{k})+X\,T_{k+1},\qquad
T_k:=\operatorname{Tr}\bigl(\operatorname{adj}(A)\,\widetilde M^{k}\bigr)$$

となり、$K$ 回展開すれば

$$-\,\frac{\mathrm{d}}{\mathrm{d}X}\det A
=\Bigl(\det A\Bigr)\sum_{k=1}^{K}\operatorname{Tr}(M^{k})\,X^{k-1}+X^{K}\,T_{K+1}$$

が**$R[X]$ の中の等式として**出る。無限和も収束も要らない。
形式冪級数へ開くのは、この等式の剰余を落とす言い方にすぎなかった。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。係数環は任意の可換環で、
根も分解体も出てこない。$K$ は $\mathbb{N}$ である。
-/
import Mathlib
import IntegrableLattice.JacobiFormula

namespace IntegrableLattice
namespace NewtonInitialValues

open Finset Matrix Polynomial

variable {n R : Type*} [Fintype n] [DecidableEq n] [CommRing R]

/-- 係数を $R[X]$ へ移した行列 $\widetilde M$。 -/
noncomputable abbrev lift (M : Matrix n n R) : Matrix n n R[X] := M.map (C : R →+* R[X])

/-- `Matrix.charpolyRev` の中身そのもの、$A=1-X\widetilde M$。 -/
noncomputable abbrev oneSubX (M : Matrix n n R) : Matrix n n R[X] :=
  1 - (X : R[X]) • lift M

theorem det_oneSubX (M : Matrix n n R) : (oneSubX M).det = M.charpolyRev := rfl

/-! ## 段 1: $A'=-\widetilde M$ -/

/-- $A=1-X\widetilde M$ の各成分を微分すると $-\widetilde M$ になる。 -/
theorem map_derivative_oneSubX (M : Matrix n n R) :
    (oneSubX M).map derivative = - lift M := by
  ext i j
  by_cases hij : i = j <;>
    simp [oneSubX, Matrix.map_apply, Matrix.one_apply, hij, Matrix.sub_apply,
      Matrix.smul_apply, Matrix.neg_apply, smul_eq_mul]

/-! ## 段 2: Jacobi の公式を当てる -/

/-- **対数微分の左辺**。$\dfrac{\mathrm{d}}{\mathrm{d}X}\det(1-X\widetilde M)
=-\operatorname{Tr}\bigl(\operatorname{adj}(A)\,\widetilde M\bigr)$。 -/
theorem derivative_charpolyRev (M : Matrix n n R) :
    derivative M.charpolyRev = - trace (adjugate (oneSubX M) * lift M) := by
  rw [← det_oneSubX, JacobiFormula.derivative_det_eq_trace_adjugate,
    map_derivative_oneSubX, Matrix.mul_neg, Matrix.trace_neg]

/-! ## 段 3: 余因子行列の漸化式（多項式のまま） -/

/-- **開かなくてよい**という段。$\operatorname{adj}(A)=(\det A)I+X\operatorname{adj}(A)\widetilde M$。 -/
theorem adjugate_recursion (M : Matrix n n R) :
    adjugate (oneSubX M)
      = (oneSubX M).det • (1 : Matrix n n R[X]) + (X : R[X]) • (adjugate (oneSubX M) * lift M) := by
  have h := Matrix.adjugate_mul (oneSubX M)
  rw [oneSubX, Matrix.mul_sub, Matrix.mul_one, Matrix.mul_smul] at h
  rw [← h]
  abel

/-- 係数を $R[X]$ へ移してもトレースは対応する（環準同型は和と積を保つ）。 -/
theorem trace_lift_pow (M : Matrix n n R) (k : ℕ) :
    trace (lift M ^ k) = C (trace (M ^ k)) := by
  rw [← Matrix.map_pow]
  simp [Matrix.trace, Matrix.diag, Matrix.map_apply, map_sum]

/-- **段 3 をトレースへ渡した形**。
$T_k=(\det A)\operatorname{Tr}(M^{k})+X\,T_{k+1}$。 -/
theorem trace_adjugate_step (M : Matrix n n R) (k : ℕ) :
    trace (adjugate (oneSubX M) * lift M ^ k)
      = M.charpolyRev * C (trace (M ^ k))
        + (X : R[X]) * trace (adjugate (oneSubX M) * lift M ^ (k + 1)) := by
  conv_lhs => rw [adjugate_recursion M]
  rw [Matrix.add_mul, Matrix.trace_add, Matrix.smul_mul, Matrix.one_mul, Matrix.trace_smul,
    Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul, smul_eq_mul, det_oneSubX,
    Matrix.mul_assoc, ← pow_succ', trace_lift_pow]

/-! ## 段 4: $K$ 回展開する -/

/-- **本段の主定理**。$K$ 回展開した対数微分の等式。

$$-\,\frac{\mathrm{d}}{\mathrm{d}X}\det A
=\Bigl(\det A\Bigr)\sum_{k=1}^{K}\operatorname{Tr}(M^{k})\,X^{k-1}+X^{K}\,T_{K+1}.$$

**$R[X]$ の中の等式であり、無限和も収束も要らない。** -/
theorem neg_derivative_charpolyRev_expand (M : Matrix n n R) (K : ℕ) :
    - derivative M.charpolyRev
      = M.charpolyRev * (∑ k ∈ range K, C (trace (M ^ (k + 1))) * (X : R[X]) ^ k)
        + (X : R[X]) ^ K * trace (adjugate (oneSubX M) * lift M ^ (K + 1)) := by
  induction K with
  | zero => simp [derivative_charpolyRev M]
  | succ K ih =>
      rw [ih, Finset.sum_range_succ, trace_adjugate_step M (K + 1)]
      ring

/-! ## 段 5: 初期値が特性多項式だけで決まること -/

/-- **本文が「Newton の公式より」と引いている事柄の初期値の側**。

同じ `charpolyRev` をもつ 2 つの行列は、展開の左辺も右辺の第 1 因子も等しいので、
$K$ 次までのトレース冪の母多項式が $X^{K}$ を法として一致する。

**残っているのは、この合同から係数ごとの一致を読む段だけである。** -/
theorem sum_trace_pow_congr_of_charpolyRev_eq {M N : Matrix n n R} (K : ℕ)
    (h : M.charpolyRev = N.charpolyRev) :
    M.charpolyRev * (∑ k ∈ range K, C (trace (M ^ (k + 1))) * (X : R[X]) ^ k)
        - N.charpolyRev * (∑ k ∈ range K, C (trace (N ^ (k + 1))) * (X : R[X]) ^ k)
      = (X : R[X]) ^ K
          * (trace (adjugate (oneSubX N) * lift N ^ (K + 1))
              - trace (adjugate (oneSubX M) * lift M ^ (K + 1))) := by
  have hM := neg_derivative_charpolyRev_expand M K
  have hN := neg_derivative_charpolyRev_expand N K
  have hd : derivative M.charpolyRev = derivative N.charpolyRev := by rw [h]
  rw [hd] at hM
  have key := hM.symm.trans hN
  linear_combination key

/-! ## 段 6: 合同から係数ごとの一致を読む -/

/-- 定数項が $1$ の多項式を掛けても、低次の係数の消滅は移る。 -/
theorem coeff_eq_zero_of_mul {P D : R[X]} {K : ℕ} (hP : P.coeff 0 = 1)
    (h : ∀ j < K, (P * D).coeff j = 0) : ∀ j < K, D.coeff j = 0 := by
  intro j
  induction j using Nat.strong_induction_on with
  | _ j ih =>
    intro hjK
    have hc := h j hjK
    rw [Polynomial.coeff_mul] at hc
    rw [Finset.sum_eq_single (0, j)] at hc
    · simpa [hP] using hc
    · rintro ⟨a, b⟩ hmem hne
      have hab : a + b = j := by simpa using hmem
      have hb : b < j := by
        rcases Nat.eq_zero_or_pos a with rfl | ha
        · have hbj : b = j := by omega
          exact absurd (by rw [hbj]) hne
        · omega
      rw [ih b hb (hb.trans hjK), mul_zero]
    · intro hmem
      exact (hmem (by simp)).elim

/-- 母多項式の係数はトレース冪そのものである（$j<K$ のとき）。 -/
theorem coeff_sum_trace (M : Matrix n n R) {K j : ℕ} (hj : j < K) :
    (∑ k ∈ range K, C (trace (M ^ (k + 1))) * (X : R[X]) ^ k).coeff j
      = trace (M ^ (j + 1)) := by
  classical
  rw [Polynomial.finsetSum_coeff]
  rw [Finset.sum_eq_single j]
  · simp
  · intro k _ hk
    simp [Polynomial.coeff_C_mul, Polynomial.coeff_X_pow, Ne.symm hk]
  · intro hmem
    exact absurd (Finset.mem_range.mpr hj) hmem

/-- **初期値の側の結論**。特性多項式が同じ 2 つの行列は、トレース冪がすべて一致する。

$K$ を任意に取れるので、**すべての $k\ge1$ について一致する。**
これが本文が「Newton の公式より」と引いている事柄そのものである。 -/
theorem trace_pow_eq_of_charpolyRev_eq {M N : Matrix n n R} (h : M.charpolyRev = N.charpolyRev)
    (k : ℕ) : trace (M ^ (k + 1)) = trace (N ^ (k + 1)) := by
  classical
  set K := k + 1 with hK
  have hdiff := sum_trace_pow_congr_of_charpolyRev_eq (M := M) (N := N) K h
  set D : R[X] := (∑ i ∈ range K, C (trace (M ^ (i + 1))) * (X : R[X]) ^ i)
      - (∑ i ∈ range K, C (trace (N ^ (i + 1))) * (X : R[X]) ^ i) with hD
  have hmul : M.charpolyRev * D
      = (X : R[X]) ^ K
        * (trace (adjugate (oneSubX N) * lift N ^ (K + 1))
            - trace (adjugate (oneSubX M) * lift M ^ (K + 1))) := by
    rw [hD, mul_sub, ← hdiff, h]
  have hzero : ∀ j < K, (M.charpolyRev * D).coeff j = 0 := by
    intro j hj
    rw [hmul, Polynomial.coeff_X_pow_mul']
    simp [Nat.not_le.mpr hj]
  have hP : M.charpolyRev.coeff 0 = 1 := by
    simpa [Polynomial.coeff_zero_eq_eval_zero] using Matrix.eval_charpolyRev (M := M)
  have := coeff_eq_zero_of_mul hP hzero k (by omega)
  rw [hD] at this
  rw [Polynomial.coeff_sub, coeff_sum_trace M (by omega), coeff_sum_trace N (by omega)] at this
  exact sub_eq_zero.mp this

/-- **本文の形**。特性多項式が同じ 2 つの行列は、トレース冪がすべて一致する。

`Matrix.reverse_charpoly` で `charpolyRev` へ移すだけである。
**cycle 43 step 5 の `TracePowerRecurrence.trace_pow_eq_of_charpoly_eq_of_initial` が
仮定として受け取っていた初期値の一致が、これで落ちる。** -/
theorem trace_pow_eq_of_charpoly_eq {M N : Matrix n n R} (h : M.charpoly = N.charpoly) (k : ℕ) :
    trace (M ^ (k + 1)) = trace (N ^ (k + 1)) :=
  trace_pow_eq_of_charpolyRev_eq
    (by rw [← Matrix.reverse_charpoly, ← Matrix.reverse_charpoly, h]) k

end NewtonInitialValues
end IntegrableLattice
