/-
# 2×2 の転送行列の恒等式

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_005_claim_two_by_two_transfer_identity`（ラベル **`two_by_two_transfer_identity`**）

原文の主張（`K_2 > 0`、`K_2^* = -(1/2) log(tanh K_2)`、`s_2 = sinh 2K_2`）:

  `A = !![e^{K_2}, e^{-K_2}; e^{-K_2}, e^{K_2}] = (2 s_2)^{1/2} exp(K_2^* σ^x)`

## 原文の Step との対応

* Step 1（`exp(t σ^x) = cosh t · I + sinh t · σ^x`）→ `exp_smul_pauliX`。
  原文は指数関数の級数を偶数項・奇数項に分けて `cosh`, `sinh` のテイラー級数と
  突き合わせているが、Lean では `σ^x` を対角化して
  `exp(t σ^x) = U exp(diag(t,-t)) U⁻¹` から計算する（`Matrix.exp_units_conj` と
  `Ising2D.matrixExp_diagonal`）。得られる行列は原文と同じ
  `!![cosh t, sinh t; sinh t, cosh t]` であり、`cosh`, `sinh` の定義
  `(e^t ± e^{-t})/2` を経由するので級数の分割は要らない。
* Step 2（`cosh K_2^*, sinh K_2^*` を `K_2` で書く）→ `exp_Kstar` / `exp_neg_Kstar`。
* Step 3（前因子 `(2s_2)^{1/2} = 2(sinh K_2 cosh K_2)^{1/2}`）と
  Step 4（結論）→ `sqrt_two_s2_mul_cosh_Kstar` / `sqrt_two_s2_mul_sinh_Kstar`。

## 双対関係が効いていること

原文が注意しているとおり、この等式が成り立つのは
`K_2^* = -(1/2) log(tanh K_2)`（双対関係）だからである。Lean では `Kstar` の定義に
その式をそのまま置いており、`exp_neg_Kstar : e^{-K_2^*} = √(tanh K_2)` が
双対関係を使う唯一の場所である。

必要十分版は置いていない（`Real.tanh`, `Real.sinh` の具体的な恒等式そのものであり、
取り払える構造が無い）。
-/
import Ising2D.Part010.Claim003_ExpDiagonal
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp

namespace Ising2D

open NormedSpace

/-! ## `exp(t σ^x)` の閉じた形 -/

/-- `σ^x` を対角化する行列 `U = !![1,1;1,-1]`（単元として）。 -/
noncomputable def hadU : (Matrix (Fin 2) (Fin 2) ℂ)ˣ where
  val := !![1, 1; 1, -1]
  inv := !![1/2, 1/2; 1/2, -1/2]
  val_inv := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.one_apply] <;> norm_num
  inv_val := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.one_apply] <;> norm_num

theorem hadU_val : (hadU : Matrix (Fin 2) (Fin 2) ℂ) = !![1, 1; 1, -1] := rfl

theorem hadU_inv_val : ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ)
    = !![1/2, 1/2; 1/2, -1/2] := rfl

/-- `diag(t, -t)` の明示形。 -/
theorem diagonal_two (t : ℂ) :
    (Matrix.diagonal ![t, -t] : Matrix (Fin 2) (Fin 2) ℂ) = !![t, 0; 0, -t] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.diagonal_apply]

/-- 上と同じ形（指数関数を取ったあとの対角行列）。 -/
theorem diagonal_two' (t : ℂ) :
    (Matrix.diagonal (fun I => Complex.exp ((![t, -t] : Fin 2 → ℂ) I))
      : Matrix (Fin 2) (Fin 2) ℂ)
      = !![Complex.exp t, 0; 0, Complex.exp (-t)] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.diagonal_apply]

/-- `t σ^x = U diag(t, -t) U⁻¹`（`σ^x` の固有値は `±1`）。 -/
theorem smul_pauliX_eq_conj (t : ℂ) :
    t • pauliX = (hadU : Matrix (Fin 2) (Fin 2) ℂ) * Matrix.diagonal ![t, -t] *
      ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ) := by
  rw [hadU_val, hadU_inv_val, diagonal_two]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, Matrix.mul_apply, Fin.sum_univ_two, Matrix.vecMul, dotProduct] <;> ring

/-- **原文 Step 1: `exp(t σ^x) = cosh(t) I + sinh(t) σ^x`**（成分で書いた形）。 -/
theorem exp_smul_pauliX (t : ℂ) :
    exp (t • pauliX) =
      !![Complex.cosh t, Complex.sinh t; Complex.sinh t, Complex.cosh t] := by
  rw [smul_pauliX_eq_conj, Matrix.exp_units_conj, matrixExp_diagonal, hadU_val, hadU_inv_val,
    diagonal_two']
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.vecMul, dotProduct,
      Complex.cosh, Complex.sinh] <;> ring

/-- 原文の書き方（`cosh(t) I + sinh(t) σ^x`）そのもの。 -/
theorem exp_smul_pauliX_eq_cosh_add_sinh (t : ℂ) :
    exp (t • pauliX) = Complex.cosh t • (1 : Matrix (Fin 2) (Fin 2) ℂ)
      + Complex.sinh t • pauliX := by
  rw [exp_smul_pauliX]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, Matrix.one_apply] <;> ring

/-! ## 双対変数 `K_2^*` -/

/-- 原文の `K_2^* = -(1/2) log(tanh K_2)`（双対関係）。 -/
noncomputable def Kstar (K2 : ℝ) : ℝ := -(1 / 2) * Real.log (Real.tanh K2)

theorem tanh_pos {K2 : ℝ} (h : 0 < K2) : 0 < Real.tanh K2 := by
  rw [Real.tanh_eq_sinh_div_cosh]
  exact div_pos (Real.sinh_pos_iff.mpr h) (Real.cosh_pos K2)

/-- 原文 Step 2 の `e^{-K_2^*} = (tanh K_2)^{1/2}`。 -/
theorem exp_neg_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (-(Kstar K2)) = Real.sqrt (Real.tanh K2) := by
  have ht := tanh_pos h
  rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos ht, Kstar]
  ring_nf

/-- 原文 Step 2 の `e^{K_2^*} = (tanh K_2)^{-1/2}`。 -/
theorem exp_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (Kstar K2) = 1 / Real.sqrt (Real.tanh K2) := by
  have h1 : Real.exp (Kstar K2) = (Real.exp (-(Kstar K2)))⁻¹ := by
    rw [Real.exp_neg, inv_inv]
  rw [h1, exp_neg_Kstar h, one_div]

/-! ## 前因子 `(2 s_2)^{1/2}` -/

/-- 原文 Step 3 の `(2 s_2)^{1/2} = 2 (sinh K_2 cosh K_2)^{1/2}`。 -/
theorem sqrt_two_s2_eq {K2 : ℝ} :
    Real.sqrt (2 * Real.sinh (2 * K2))
      = 2 * Real.sqrt (Real.sinh K2 * Real.cosh K2) := by
  rw [Real.sinh_two_mul]
  rw [show 2 * (2 * Real.sinh K2 * Real.cosh K2)
      = (2 : ℝ) ^ 2 * (Real.sinh K2 * Real.cosh K2) by ring]
  rw [Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

/-- 原文 Step 4 の第 1 式 `(2 s_2)^{1/2} cosh K_2^* = e^{K_2}`。 -/
theorem sqrt_two_s2_mul_cosh_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) = Real.exp K2 := by
  have hs : 0 < Real.sinh K2 := Real.sinh_pos_iff.mpr h
  have hc : 0 < Real.cosh K2 := Real.cosh_pos K2
  have ha : 0 < Real.sqrt (Real.sinh K2) := Real.sqrt_pos.mpr hs
  have hb : 0 < Real.sqrt (Real.cosh K2) := Real.sqrt_pos.mpr hc
  have ha2 : Real.sqrt (Real.sinh K2) ^ 2 = Real.sinh K2 := Real.sq_sqrt hs.le
  have hb2 : Real.sqrt (Real.cosh K2) ^ 2 = Real.cosh K2 := Real.sq_sqrt hc.le
  have hsq : Real.sqrt (Real.tanh K2)
      = Real.sqrt (Real.sinh K2) / Real.sqrt (Real.cosh K2) := by
    rw [Real.tanh_eq_sinh_div_cosh, Real.sqrt_div hs.le]
  have hmul : Real.sqrt (Real.sinh K2 * Real.cosh K2)
      = Real.sqrt (Real.sinh K2) * Real.sqrt (Real.cosh K2) := Real.sqrt_mul hs.le _
  rw [Real.cosh_eq (Kstar K2), exp_Kstar h, exp_neg_Kstar h, sqrt_two_s2_eq, hsq, hmul,
    ← Real.cosh_add_sinh K2]
  field_simp
  nlinarith [ha2, hb2, ha, hb]

/-- 原文 Step 4 の第 2 式 `(2 s_2)^{1/2} sinh K_2^* = e^{-K_2}`。 -/
theorem sqrt_two_s2_mul_sinh_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) = Real.exp (-K2) := by
  have hs : 0 < Real.sinh K2 := Real.sinh_pos_iff.mpr h
  have hc : 0 < Real.cosh K2 := Real.cosh_pos K2
  have ha : 0 < Real.sqrt (Real.sinh K2) := Real.sqrt_pos.mpr hs
  have hb : 0 < Real.sqrt (Real.cosh K2) := Real.sqrt_pos.mpr hc
  have ha2 : Real.sqrt (Real.sinh K2) ^ 2 = Real.sinh K2 := Real.sq_sqrt hs.le
  have hb2 : Real.sqrt (Real.cosh K2) ^ 2 = Real.cosh K2 := Real.sq_sqrt hc.le
  have hsq : Real.sqrt (Real.tanh K2)
      = Real.sqrt (Real.sinh K2) / Real.sqrt (Real.cosh K2) := by
    rw [Real.tanh_eq_sinh_div_cosh, Real.sqrt_div hs.le]
  have hmul : Real.sqrt (Real.sinh K2 * Real.cosh K2)
      = Real.sqrt (Real.sinh K2) * Real.sqrt (Real.cosh K2) := Real.sqrt_mul hs.le _
  rw [Real.sinh_eq (Kstar K2), exp_Kstar h, exp_neg_Kstar h, sqrt_two_s2_eq, hsq, hmul,
    ← Real.cosh_sub_sinh K2]
  field_simp
  nlinarith [ha2, hb2, ha, hb]

/-! ## 2×2 の転送行列 -/

/-- 原文の `A_{ij} = exp(K_2 ς_i ς_j)`（`ς_1 = +1, ς_2 = -1`）。 -/
noncomputable def twoByTwo (K2 : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  Matrix.of fun i j => Complex.exp (K2 * sgnC i * sgnC j)

theorem twoByTwo_eq (K2 : ℂ) :
    twoByTwo K2 = !![Complex.exp K2, Complex.exp (-K2); Complex.exp (-K2), Complex.exp K2] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [twoByTwo] <;> ring_nf

/-- **原文 `two_by_two_transfer_identity`。** -/
theorem two_by_two_transfer_identity {K2 : ℝ} (h : 0 < K2) :
    twoByTwo (K2 : ℂ)
      = ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) • exp (((Kstar K2 : ℝ) : ℂ) • pauliX) := by
  rw [twoByTwo_eq, exp_smul_pauliX]
  have hcosh : ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) *
      Complex.cosh ((Kstar K2 : ℝ) : ℂ) = Complex.exp (K2 : ℂ) := by
    rw [← Complex.ofReal_cosh, ← Complex.ofReal_mul, sqrt_two_s2_mul_cosh_Kstar h,
      Complex.ofReal_exp]
  have hsinh : ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) *
      Complex.sinh ((Kstar K2 : ℝ) : ℂ) = Complex.exp (-(K2 : ℂ)) := by
    rw [← Complex.ofReal_sinh, ← Complex.ofReal_mul, sqrt_two_s2_mul_sinh_Kstar h,
      Complex.ofReal_exp, Complex.ofReal_neg]
  have hsmul : ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) •
      (!![Complex.cosh ((Kstar K2 : ℝ) : ℂ), Complex.sinh ((Kstar K2 : ℝ) : ℂ);
          Complex.sinh ((Kstar K2 : ℝ) : ℂ), Complex.cosh ((Kstar K2 : ℝ) : ℂ)]
        : Matrix (Fin 2) (Fin 2) ℂ)
      = !![((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * Complex.cosh ((Kstar K2 : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * Complex.sinh ((Kstar K2 : ℝ) : ℂ);
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * Complex.sinh ((Kstar K2 : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * Complex.cosh ((Kstar K2 : ℝ) : ℂ)] := by
    ext i j
    fin_cases i <;> fin_cases j <;> simp
  rw [hsmul, hcosh, hsinh]

end Ising2D
