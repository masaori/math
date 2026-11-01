/-
# 2×2 の転送行列の恒等式

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `bridge_005_claim_two_by_two_transfer_identity`（ラベル **`two_by_two_transfer_identity`**）

原文の主張（`K_2 > 0`、`K_2^* = -(1/2) log(tanh K_2)`、`s_2 = sinh 2K_2`）:

  `A = !![e^{K_2}, e^{-K_2}; e^{-K_2}, e^{K_2}] = (2 s_2)^{1/2} exp(K_2^* σ^x)`

## 人手証明の中間目標との対応

* 中間目標「`exp(tσ^x)` の閉じた形」:
  * `(σ^x)^2 = I`（`pauli_matrix_products`）→ `pauliX_sq`、
    `(σ^x)^{2p} = I` → `pauliX_pow_two_mul`、`(σ^x)^{2p+1} = σ^x` → `pauliX_pow_two_mul_add_one`。
  * `def_exp` の級数 `exp(tσ^x) = ∑_k (k!)^{-1}(tσ^x)^k` → `exp_smul_pauliX_hasSum`。
  * 級数を偶数項と奇数項に分けて `(σ^x)^{2p} = I`, `(σ^x)^{2p+1} = σ^x` を適用し、
    `cosh`, `sinh` のテイラー展開を代入する式変形
    `exp(tσ^x) = (∑_p t^{2p}/(2p)!) I + (∑_p t^{2p+1}/(2p+1)!) σ^x = cosh(t) I + sinh(t) σ^x`
    → `exp_smul_pauliX_eq_cosh_add_sinh`。偶数項の和が `cosh(t) I`、奇数項の和が `sinh(t) σ^x` であることを
    `Complex.hasSum_cosh`・`Complex.hasSum_sinh` で示し、`HasSum.even_add_odd` で足し直す。
    最後に、`def_exp` の部分和の極限が一つに決まることで `exp(tσ^x)` と足し直した和を等しいとする。
  * `I, σ^x` の成分を書き下した形 `!![cosh t, sinh t; sinh t, cosh t]` → `exp_smul_pauliX`。
  人手は `t ∈ ℝ` で述べるが、上の手順は `t ∈ ℂ` でそのまま通るので、Lean は `t : ℂ` で述べる。
* 中間目標「`cosh K_2^*, sinh K_2^*` を `K_2` で書く」→ `exp_Kstar` / `exp_neg_Kstar`。
* 中間目標「前因子」（`(2s_2)^{1/2} = 2(sinh K_2 cosh K_2)^{1/2}`）→ `sqrt_two_s2_eq`、
  中間目標「結論」→ `sqrt_two_s2_mul_cosh_Kstar` / `sqrt_two_s2_mul_sinh_Kstar`。

## 双対関係が効いていること

原文が注意しているとおり、この等式が成り立つのは
`K_2^* = -(1/2) log(tanh K_2)`（双対関係）だからである。Lean では `Kstar` の定義に
その式をそのまま置いており、`exp_neg_Kstar : e^{-K_2^*} = √(tanh K_2)` が
双対関係を使う唯一の場所である。

`exp(tσ^x)` の偶奇分解が使うのは `(σ^x)^2 = I` と、スカラー倍・和と極限の交換だけなので、
必要十分版 `NecSuf/ExpOfInvolution.lean` の `NecSuf.exp_series_sum_of_sq_eq_one` を使い、
`exp_smul_pauliX_eq_cosh_add_sinh` をその系として `ClaimTwoByTwoTransferIdentityFromNecSuf.lean` で導く。
残りの段（`cosh K_2^*, sinh K_2^*` を `K_2` で書く・前因子・結論）は `Real.tanh`, `Real.sinh` の
具体的な恒等式そのものであり、取り払える構造が無いので必要十分版を置かない。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionSecondDualCouplingConstant
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open NormedSpace

/-! ## `exp(t σ^x)` の閉じた形 -/

/-- 人手の `(σ^x)^2 = I`（`pauli_matrix_products`）。 -/
theorem pauliX_sq : pauliX ^ 2 = 1 := by
  rw [sq, pauliX_mul_pauliX]

/-- 人手の `(σ^x)^{2p} = ((σ^x)^2)^p = I^p = I`（必要十分版の `NecSuf.pow_two_mul_of_sq_eq_one` に当たる）。 -/
theorem pauliX_pow_two_mul (p : ℕ) : pauliX ^ (2 * p) = 1 := by
  rw [pow_mul, pauliX_sq, one_pow]

/-- 人手の `(σ^x)^{2p+1} = (σ^x)^{2p}σ^x = Iσ^x = σ^x`（必要十分版の `NecSuf.pow_two_mul_add_one_of_sq_eq_one` に当たる）。 -/
theorem pauliX_pow_two_mul_add_one (p : ℕ) : pauliX ^ (2 * p + 1) = pauliX := by
  rw [pow_succ, pauliX_pow_two_mul p, one_mul]

/-- 人手 `def_exp`: `exp(tσ^x) = ∑_k (k!)^{-1}(tσ^x)^k`（級数の和として）。
収束は `def_matrix_norm` の行列ノルムで述べられているので、`matExp_hasSum` と同じノルムを入れて引く。 -/
theorem exp_smul_pauliX_hasSum (t : ℂ) :
    HasSum (fun k : ℕ => ((k.factorial : ℂ))⁻¹ • (t • pauliX) ^ k) (exp (t • pauliX)) := by
  letI : NormedRing (Matrix (Fin 2) (Fin 2) ℂ) := Matrix.frobeniusNormedRing
  letI : NormedAlgebra ℂ (Matrix (Fin 2) (Fin 2) ℂ) := Matrix.frobeniusNormedAlgebra
  exact exp_series_hasSum_exp' (𝕂 := ℂ) (t • pauliX)

/-- **人手の中間目標「`exp(tσ^x)` の閉じた形」: `exp(t σ^x) = cosh(t) I + sinh(t) σ^x`。**

人手の式変形どおり、指数級数を偶数次の項 `t^{2p}/(2p)! · I` と奇数次の項 `t^{2p+1}/(2p+1)! · σ^x` に分け、
それぞれの和が `cosh t`・`sinh t` であることを代入する。偶数次の項・奇数次の項・足し直しと極限の一意性の 3 段は、
必要十分版 `NecSuf.exp_series_sum_of_sq_eq_one` の手順 1・手順 2・手順 3 に当たる。 -/
theorem exp_smul_pauliX_eq_cosh_add_sinh (t : ℂ) :
    exp (t • pauliX) = Complex.cosh t • (1 : Matrix (Fin 2) (Fin 2) ℂ)
      + Complex.sinh t • pauliX := by
  -- 偶数次の項: `((2p)!)^{-1}(tσ^x)^{2p} = (t^{2p}/(2p)!) I`
  have heven : HasSum (fun p : ℕ => (((2 * p).factorial : ℂ))⁻¹ • (t • pauliX) ^ (2 * p))
      (Complex.cosh t • (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by
    refine ((Complex.hasSum_cosh t).smul_const (1 : Matrix (Fin 2) (Fin 2) ℂ)).congr_fun
      fun p => ?_
    rw [smul_pow, pauliX_pow_two_mul p, smul_smul, div_eq_inv_mul]
  -- 奇数次の項: `((2p+1)!)^{-1}(tσ^x)^{2p+1} = (t^{2p+1}/(2p+1)!) σ^x`
  have hodd : HasSum (fun p : ℕ => (((2 * p + 1).factorial : ℂ))⁻¹ • (t • pauliX) ^ (2 * p + 1))
      (Complex.sinh t • pauliX) := by
    refine ((Complex.hasSum_sinh t).smul_const pauliX).congr_fun fun p => ?_
    rw [smul_pow, pauliX_pow_two_mul_add_one p, smul_smul, div_eq_inv_mul]
  -- 偶数次と奇数次を足し直す
  have hall := HasSum.even_add_odd
    (f := fun k : ℕ => ((k.factorial : ℂ))⁻¹ • (t • pauliX) ^ k) heven hodd
  -- 部分和の極限は一つに決まる
  exact tendsto_nhds_unique (exp_smul_pauliX_hasSum t).tendsto_sum_nat hall.tendsto_sum_nat

/-- 人手の「`I, σ^x` の成分を書き下す」段: `exp(t σ^x) = !![cosh t, sinh t; sinh t, cosh t]`。 -/
theorem exp_smul_pauliX (t : ℂ) :
    exp (t • pauliX) =
      !![Complex.cosh t, Complex.sinh t; Complex.sinh t, Complex.cosh t] := by
  rw [exp_smul_pauliX_eq_cosh_add_sinh]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX]

/-! ## `cosh K_2^*, sinh K_2^*` を `K_2` で書く -/

/-- 人手の中間目標「`cosh K_2^*, sinh K_2^*` を `K_2` で書く」の `e^{-K_2^*} = (tanh K_2)^{1/2}`。 -/
theorem exp_neg_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (-(Kstar K2)) = Real.sqrt (Real.tanh K2) := by
  have ht := tanh_pos h
  rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos ht, Kstar]
  ring_nf

/-- 同じ中間目標の `e^{K_2^*} = (tanh K_2)^{-1/2}`。 -/
theorem exp_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (Kstar K2) = 1 / Real.sqrt (Real.tanh K2) := by
  have h1 : Real.exp (Kstar K2) = (Real.exp (-(Kstar K2)))⁻¹ := by
    rw [Real.exp_neg, inv_inv]
  rw [h1, exp_neg_Kstar h, one_div]

/-! ## 前因子 `(2 s_2)^{1/2}` -/

/-- 人手の中間目標「前因子」の `(2 s_2)^{1/2} = 2 (sinh K_2 cosh K_2)^{1/2}`。 -/
theorem sqrt_two_s2_eq {K2 : ℝ} :
    Real.sqrt (2 * Real.sinh (2 * K2))
      = 2 * Real.sqrt (Real.sinh K2 * Real.cosh K2) := by
  rw [Real.sinh_two_mul]
  rw [show 2 * (2 * Real.sinh K2 * Real.cosh K2)
      = (2 : ℝ) ^ 2 * (Real.sinh K2 * Real.cosh K2) by ring]
  rw [Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

/-- 人手の中間目標「結論」の第 1 式 `(2 s_2)^{1/2} cosh K_2^* = e^{K_2}`。 -/
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

/-- 人手の中間目標「結論」の第 2 式 `(2 s_2)^{1/2} sinh K_2^* = e^{-K_2}`。 -/
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
