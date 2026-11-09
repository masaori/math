/-
# 2×2 の転送行列の恒等式

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `bridge_005_claim_two_by_two_transfer_identity`（ラベル **`two_by_two_transfer_identity`**）

原文の主張（`K_2 > 0`、`K_2^* = -(1/2) log(tanh K_2)`、`s_2 = sinh 2K_2`）:

  `A = !![e^{K_2}, e^{-K_2}; e^{-K_2}, e^{K_2}] = (2 s_2)^{1/2} exp(K_2^* σ^x)`

## 人手証明の中間目標との対応

人手の中間目標は「`B_τ` の冪」「指数級数の各項の成分」「部分和の成分」「部分和の成分の極限」（ここまでで
`exp(τσ^x) = !![(cosh τ)_ℂ, (sinh τ)_ℂ; (sinh τ)_ℂ, (cosh τ)_ℂ]`）、「`τ = K_2^*` として」の鎖、
「`exp(±K_2^*)` を `r` で書く」「前因子 `q/(2r) = cosh K_2`」「示すべき 2 つの等式」「結論」である
（`q := (2s_2)^{1/2}`、`r := (tanh K_2)^{1/2}`）。

人手と 1 対 1 の段:

* 「`τ = K_2^*` として」の鎖の 2〜4 行（`q_ℂ exp(B_{K_2^*})` の成分を `(q cosh K_2^*)_ℂ` などにする）→
  `sqrt_two_s2_smul_exp_Kstar_pauliX` の `calc` の 3 段。1 行目（`q` の定義と主張の記法の約束）は Lean では書き方そのもので段は無い。
  `q_ℂ(cosh K_2^*)_ℂ = (q cosh K_2^*)_ℂ` は `real_inclusion_preserves_product` の具体版 `real_inclusion_mul`。
* 「結論」の 3 行 → `two_by_two_transfer_identity` の `calc` の 3 段。1 行目の `A` の成分の読み方
  `A_{ij} = (exp(K_2(ς_iς_j)))_ℂ` は `twoByTwo_apply_eq_real_inclusion`、行列の形は `twoByTwo_eq_real_inclusion`。

人手と 1 対 1 でない段（Lean 独自の手順。状態台帳の残りの件）:

* `exp(τσ^x)` の成分の形（人手の「`B_τ` の冪」から「部分和の成分の極限」まで）→ `exp_real_smul_pauliX`。
  Lean は `t ∈ ℂ` について、`(σ^x)^2 = I` から `(σ^x)^{2p} = I`・`(σ^x)^{2p+1} = σ^x`（`pauliX_sq`・`pauliX_pow_two_mul`・
  `pauliX_pow_two_mul_add_one`）、`def_exp` の級数（`exp_smul_pauliX_hasSum`）、級数を偶数項と奇数項に分けて
  `cosh`・`sinh` の級数（`Complex.hasSum_cosh`・`Complex.hasSum_sinh`）と比べ `HasSum.even_add_odd` で足し直す段
  （`exp_smul_pauliX_eq_cosh_add_sinh`）、成分の書き下し（`exp_smul_pauliX`）を経て、`t = τ_ℂ` を代入し
  `Complex.ofReal_cosh`・`Complex.ofReal_sinh` で読み替える。
* 「`exp(±K_2^*)` を `r` で書く」→ `exp_neg_Kstar`（`e^{-K_2^*} = r`）・`exp_Kstar`（`e^{K_2^*} = 1/r`）。
  人手の `exp(-2K_2^*) = t` と平方根の一意性の段ではなく、`Real.rpow_def_of_pos` と `ring_nf` で閉じる。
  人手の `cosh K_2^* = (1+t)/(2r)`・`sinh K_2^* = (1-t)/(2r)`・`1 ± t = exp(±K_2)/cosh K_2` に当たる補題は無い。
* 「前因子」と「示すべき 2 つの等式」`q cosh K_2^* = exp(K_2)`・`q sinh K_2^* = exp(-K_2)` →
  `sqrt_two_s2_eq`（`q = 2(sinh K_2 cosh K_2)^{1/2}`。人手の `q/(2r) = cosh K_2` とは別の式）・
  `sqrt_two_s2_mul_cosh_Kstar` / `sqrt_two_s2_mul_sinh_Kstar`（`field_simp`・`nlinarith` で閉じる）。

## 双対関係が効いていること

原文が注意しているとおり、この等式が成り立つのは
`K_2^* = -(1/2) log(tanh K_2)`（双対関係）だからである。Lean では `Kstar` の定義に
その式をそのまま置いており、`exp_neg_Kstar : e^{-K_2^*} = √(tanh K_2)` が
双対関係を使う唯一の場所である。

`exp(tσ^x)` の偶奇分解が使うのは `(σ^x)^2 = I` と、スカラー倍・和と極限の交換だけなので、
必要十分版 `NecSuf/ExpOfInvolution.lean` の `NecSuf.exp_series_sum_of_sq_eq_one` を使い、
`exp_smul_pauliX_eq_cosh_add_sinh` をその系として `ClaimTwoByTwoTransferIdentityFromNecSuf.lean` で導く。
残りの段（「`exp(±K_2^*)` を `r` で書く」・前因子・示すべき 2 つの等式・「`τ = K_2^*` として」・結論）は `Real.tanh`, `Real.sinh` の
具体的な恒等式そのものであり、取り払える構造が無いので必要十分版を置かない。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionSecondDualCouplingConstant
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
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

/-- `(σ^x)^{2p} = ((σ^x)^2)^p = I^p = I`（Lean 独自の手順の段。必要十分版の `NecSuf.pow_two_mul_of_sq_eq_one` に当たる）。 -/
theorem pauliX_pow_two_mul (p : ℕ) : pauliX ^ (2 * p) = 1 := by
  rw [pow_mul, pauliX_sq, one_pow]

/-- `(σ^x)^{2p+1} = (σ^x)^{2p}σ^x = Iσ^x = σ^x`（Lean 独自の手順の段。必要十分版の `NecSuf.pow_two_mul_add_one_of_sq_eq_one` に当たる）。 -/
theorem pauliX_pow_two_mul_add_one (p : ℕ) : pauliX ^ (2 * p + 1) = pauliX := by
  rw [pow_succ, pauliX_pow_two_mul p, one_mul]

/-- 人手 `def_exp`: `exp(tσ^x) = ∑_k (k!)^{-1}(tσ^x)^k`（級数の和として。Lean 独自の手順の段）。
収束は `def_matrix_norm` の行列ノルムで述べられているので、`matExp_hasSum` と同じノルムを入れて引く。 -/
theorem exp_smul_pauliX_hasSum (t : ℂ) :
    HasSum (fun k : ℕ => ((k.factorial : ℂ))⁻¹ • (t • pauliX) ^ k) (exp (t • pauliX)) := by
  letI : NormedRing (Matrix (Fin 2) (Fin 2) ℂ) := Matrix.frobeniusNormedRing
  letI : NormedAlgebra ℂ (Matrix (Fin 2) (Fin 2) ℂ) := Matrix.frobeniusNormedAlgebra
  exact exp_series_hasSum_exp' (𝕂 := ℂ) (t • pauliX)

/-- **`exp(t σ^x) = cosh(t) I + sinh(t) σ^x`（Lean 独自の手順。人手の「`B_τ` の冪」〜「部分和の成分の極限」と 1 対 1 でない）。**

指数級数を偶数次の項 `t^{2p}/(2p)! · I` と奇数次の項 `t^{2p+1}/(2p+1)! · σ^x` に分け、
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

/-- `exp(t σ^x) = !![cosh t, sinh t; sinh t, cosh t]`（`I, σ^x` の成分を書き下す。Lean 独自の手順の段）。 -/
theorem exp_smul_pauliX (t : ℂ) :
    exp (t • pauliX) =
      !![Complex.cosh t, Complex.sinh t; Complex.sinh t, Complex.cosh t] := by
  rw [exp_smul_pauliX_eq_cosh_add_sinh]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX]

/-! ## `cosh K_2^*, sinh K_2^*` を `K_2` で書く -/

/-- 人手の中間目標「`exp(±K_2^*)` を `r` で書く」の `e^{-K_2^*} = r = (tanh K_2)^{1/2}`（人手の段と 1 対 1 でない）。 -/
theorem exp_neg_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (-(Kstar K2)) = Real.sqrt (Real.tanh K2) := by
  have ht := tanh_pos h
  rw [Real.sqrt_eq_rpow, Real.rpow_def_of_pos ht, Kstar]
  ring_nf

/-- 同じ中間目標の `e^{K_2^*} = 1/r`（人手の段と 1 対 1 でない）。 -/
theorem exp_Kstar {K2 : ℝ} (h : 0 < K2) :
    Real.exp (Kstar K2) = 1 / Real.sqrt (Real.tanh K2) := by
  have h1 : Real.exp (Kstar K2) = (Real.exp (-(Kstar K2)))⁻¹ := by
    rw [Real.exp_neg, inv_inv]
  rw [h1, exp_neg_Kstar h, one_div]

/-! ## 前因子 `(2 s_2)^{1/2}` -/

/-- `(2 s_2)^{1/2} = 2 (sinh K_2 cosh K_2)^{1/2}`（Lean 独自の補助の式。人手の前因子 `q/(2r) = cosh K_2` とは別）。 -/
theorem sqrt_two_s2_eq {K2 : ℝ} :
    Real.sqrt (2 * Real.sinh (2 * K2))
      = 2 * Real.sqrt (Real.sinh K2 * Real.cosh K2) := by
  rw [Real.sinh_two_mul]
  rw [show 2 * (2 * Real.sinh K2 * Real.cosh K2)
      = (2 : ℝ) ^ 2 * (Real.sinh K2 * Real.cosh K2) by ring]
  rw [Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

/-- 人手の中間目標「示すべき 2 つの等式」の 1 つ目 `q cosh K_2^* = e^{K_2}`（人手の鎖と 1 対 1 でない）。 -/
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

/-- 人手の中間目標「示すべき 2 つの等式」の 2 つ目 `q sinh K_2^* = e^{-K_2}`（人手の鎖と 1 対 1 でない）。 -/
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

/-- 人手 `two_by_two_transfer_identity` の略記の取り決めでの `A` の成分 `A_{ij} = (exp(K_2(ς_iς_j)))_ℂ`
（複素行列の成分に書いた実数 `a` は `a_ℂ`）。Lean の `twoByTwo` は成分を `exp((K_2)_ℂ ς_i ς_j)`（`ς` は `sgnC`）と書くので、
その読み替え: `complex_exp_of_real_argument`（具体版が無く `Complex.ofReal_exp`）と `real_inclusion_preserves_product`
（`real_inclusion_mul` を 2 回）。積の並べ方 `((K_2)_ℂ ς_i)ς_j = (K_2)_ℂ(ς_iς_j)` は ℂ の積の結合法則。 -/
theorem twoByTwo_apply_eq_real_inclusion (K2 : ℝ) (i j : Fin 2) :
    twoByTwo (K2 : ℂ) i j = ((Real.exp (K2 * (sgn i * sgn j)) : ℝ) : ℂ) :=
  calc twoByTwo (K2 : ℂ) i j
      = Complex.exp ((K2 : ℂ) * ((sgn i : ℝ) : ℂ) * ((sgn j : ℝ) : ℂ)) := rfl -- `A` の成分（`ς` は `sgnC`）
    _ = Complex.exp ((K2 : ℂ) * (((sgn i : ℝ) : ℂ) * ((sgn j : ℝ) : ℂ))) := by
        rw [mul_assoc]                                                      -- ℂ の積の結合法則
    _ = Complex.exp ((K2 : ℂ) * ((sgn i * sgn j : ℝ) : ℂ)) := by
        rw [real_inclusion_mul]                                             -- `real_inclusion_preserves_product`
    _ = Complex.exp (((K2 * (sgn i * sgn j) : ℝ) : ℂ)) := by
        rw [real_inclusion_mul]                                             -- `real_inclusion_preserves_product`
    _ = ((Real.exp (K2 * (sgn i * sgn j)) : ℝ) : ℂ) :=
        (Complex.ofReal_exp _).symm                                         -- `complex_exp_of_real_argument`

/-- 人手の中間目標「結論」の 1 行目: `A = !![(exp K_2)_ℂ, (exp(-K_2))_ℂ; (exp(-K_2))_ℂ, (exp K_2)_ℂ]`
（`A` の定義と主張の記法の約束）。成分の読み方は `twoByTwo_apply_eq_real_inclusion`、`ς_1ς_1 = ς_2ς_2 = 1`・
`ς_1ς_2 = ς_2ς_1 = -1` は実数の積。 -/
theorem twoByTwo_eq_real_inclusion (K2 : ℝ) :
    twoByTwo (K2 : ℂ)
      = !![((Real.exp K2 : ℝ) : ℂ), ((Real.exp (-K2) : ℝ) : ℂ);
           ((Real.exp (-K2) : ℝ) : ℂ), ((Real.exp K2 : ℝ) : ℂ)] := by
  ext i j
  rw [twoByTwo_apply_eq_real_inclusion]
  fin_cases i <;> fin_cases j <;> simp [sgn]

/-- 人手の「部分和の成分の極限」の後の式（`exp(τσ^x)` の成分の形）:
`exp(τσ^x) = !![(cosh τ)_ℂ, (sinh τ)_ℂ; (sinh τ)_ℂ, (cosh τ)_ℂ]`（`τ ∈ ℝ`）。
人手は部分和の成分の極限としてこの形を直接得る。Lean は `t ∈ ℂ` の `exp_smul_pauliX` に `t = τ_ℂ` を代入し、
`cosh(τ_ℂ) = (cosh τ)_ℂ`・`sinh(τ_ℂ) = (sinh τ)_ℂ`（`Complex.ofReal_cosh`・`Complex.ofReal_sinh`）で読み替える
（人手の手順と 1 対 1 でない）。 -/
theorem exp_real_smul_pauliX (τ : ℝ) :
    exp ((τ : ℂ) • pauliX)
      = !![((Real.cosh τ : ℝ) : ℂ), ((Real.sinh τ : ℝ) : ℂ);
           ((Real.sinh τ : ℝ) : ℂ), ((Real.cosh τ : ℝ) : ℂ)] := by
  rw [exp_smul_pauliX, Complex.ofReal_cosh, Complex.ofReal_sinh]

/-- 人手の「`τ = K_2^*` として」の 4 行の鎖:
`(2s_2)^{1/2} exp(K_2^*σ^x) = q_ℂ exp(B_{K_2^*}) = q_ℂ !![(cosh K_2^*)_ℂ, …] = !![q_ℂ(cosh K_2^*)_ℂ, …]
= !![(q cosh K_2^*)_ℂ, …]`（`q := (2s_2)^{1/2}`）。1 行目（主張の記法の約束）は Lean では書き方そのもので段は無い。 -/
theorem sqrt_two_s2_smul_exp_Kstar_pauliX (K2 : ℝ) :
    ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) • exp (((Kstar K2 : ℝ) : ℂ) • pauliX)
      = !![((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ);
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ)] :=
  calc ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) • exp (((Kstar K2 : ℝ) : ℂ) • pauliX)
      = ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) •
          !![((Real.cosh (Kstar K2) : ℝ) : ℂ), ((Real.sinh (Kstar K2) : ℝ) : ℂ);
             ((Real.sinh (Kstar K2) : ℝ) : ℂ), ((Real.cosh (Kstar K2) : ℝ) : ℂ)] := by
        rw [exp_real_smul_pauliX]                     -- 直前の式に `τ = K_2^*` を代入
    _ = !![((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * ((Real.cosh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * ((Real.sinh (Kstar K2) : ℝ) : ℂ);
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * ((Real.sinh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) * ((Real.cosh (Kstar K2) : ℝ) : ℂ)] := by
        ext i j                                       -- `def_matrix_scalar_multiple`
        fin_cases i <;> fin_cases j <;> rfl
    _ = !![((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ);
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ)] := by
        rw [real_inclusion_mul, real_inclusion_mul]   -- `real_inclusion_preserves_product`

/-- **原文 `two_by_two_transfer_identity`。** 人手の中間目標「結論」の 3 行の鎖と 1 対 1 である。 -/
theorem two_by_two_transfer_identity {K2 : ℝ} (h : 0 < K2) :
    twoByTwo (K2 : ℂ)
      = ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) • exp (((Kstar K2 : ℝ) : ℂ) • pauliX) :=
  calc twoByTwo (K2 : ℂ)
      = !![((Real.exp K2 : ℝ) : ℂ), ((Real.exp (-K2) : ℝ) : ℂ);
           ((Real.exp (-K2) : ℝ) : ℂ), ((Real.exp K2 : ℝ) : ℂ)] :=
        twoByTwo_eq_real_inclusion K2                 -- `A` の定義と主張の記法の約束
    _ = !![((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ);
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.sinh (Kstar K2) : ℝ) : ℂ),
           ((Real.sqrt (2 * Real.sinh (2 * K2)) * Real.cosh (Kstar K2) : ℝ) : ℂ)] := by
        rw [sqrt_two_s2_mul_cosh_Kstar h, sqrt_two_s2_mul_sinh_Kstar h]
                                                      -- 示すべき 2 つの等式を四つの成分へ同時に代入
    _ = ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) • exp (((Kstar K2 : ℝ) : ℂ) • pauliX) :=
        (sqrt_two_s2_smul_exp_Kstar_pauliX K2).symm   -- 上で求めた `(2s_2)^{1/2}exp(K_2^*σ^x)` の成分

end Ising2D
