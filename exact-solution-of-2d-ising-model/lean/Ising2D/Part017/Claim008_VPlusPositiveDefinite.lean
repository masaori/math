/-
# `V^{(+)}` は正定値（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`V_plus_is_positive_definite`（`evenEigen_008_claim_...`）。

**必要十分版は置かない。** この主張は `S_1^{(+)}, S_2` というこの模型の具体的な対象についての
主張であり、取り払える一般構造が無い。使っている一般論（エルミート行列の `exp` が正定値、
`B^* A B` が正定値、正実数倍が正定値）は章 009 の
`Ising2D/Part009/Claim013_PositiveDefinite.lean` で既に「任意の有限次元複素行列」について
述べてあり、そこがこの主張の必要十分版にあたる。

## 章 009 との関係（本章の要点）

人手証明が明記しているとおり、章 009 の `iH_is_real_symmetric` と
`exp_hermitian_is_positive_definite` は**複号によらない形**で述べられている。
Lean 側でも `Ising2D.Vmat M K1 η s2 K2star` は符号 `η` を**パラメータとして**持つので、
`(+)` セクターは `η = -1` を代入するだけで得られる
（`H_1^{(+)}` が `Ising2D.H1 M (-1)` であることは章 013
`Ising2D/Part013/Claim004_CommutatorHCheckZY.lean` の用法と一致する）。

**したがって本ファイルの正定値性は章 009 の `Vmat_posDef` の系である。**
新しく証明したのは `(V^{(+)})^{-1}` の正定値性だけで、
これは章 009 では述べられていなかった（章 009 の `V_is_positive_definite` は
`V^{-1}` の明示形までしか出していない）。
-/
import Ising2D.Part009.Claim017_ConstantC
import Ising2D.Part014.Definition001_VPlus
import Ising2D.Part017.Claim007_TraceCheckVprime

namespace Ising2D

open Matrix
open scoped ComplexOrder

section VPlus

variable {M : ℕ}

/-- **原文 `def_V_plus` の `V^{(+)}`は章 014 の
`Ising2D.VPlus`（`Part014/Definition001_VPlus.lean`）をそのまま使う。**
`H_1^{(+)} = Ising2D.H1 M (-1)` なので、これは章 009 の `Vmat` に `η = -1` を
代入したものに等しい（両者とも `V1half M K1 (-1) * V2 M s2 K2star * V1half M K1 (-1)` に
簡約されるので `rfl`）。この同一視により、章 009 の正定値性がそのまま使える。 -/
theorem VPlus_eq_Vmat (M : ℕ) (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) :
    VPlus M s2 K1 K2star = Vmat M K1 (-1) s2 K2star := rfl

/-- `(V^{(+)})^{-1}` の明示形（章 009 の `VmatInv` に `η = -1` を代入したもの）。 -/
noncomputable def VPlusInv (M : ℕ) (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  VmatInv M K1 (-1) s2 K2star

theorem star_neg_one : star (-1 : ℂ) = -1 := by simp

/-- **原文 `V_plus_is_positive_definite` Step 3**: `V^{(+)}` は正定値（章 009 の系）。 -/
theorem VPlus_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlus M s2 K1 K2star).PosDef :=
  Vmat_posDef hK1 star_neg_one hK2 hs2

/-- **原文 `V_plus_is_positive_definite` Step 4**: `V^{(+)}` は可逆で逆行列は `VPlusInv`。 -/
theorem VPlus_mul_VPlusInv {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star = 1 :=
  Vmat_mul_VmatInv K1 (-1) hs2 K2star

theorem VPlusInv_mul_VPlus {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star = 1 :=
  VmatInv_mul_Vmat K1 (-1) hs2 K2star

/-- **原文 `V_plus_is_positive_definite` Step 4 後半**: `(V^{(+)})^{-1}` も正定値。

章 009 では述べられていない（章 009 は `V^{-1}` の明示形までしか出していない）。
証明は Step 2〜3 をそのまま `-\tfrac12 S_1^{(+)}`, `-S_2` に適用するだけである。 -/
theorem VPlusInv_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlusInv M K1 s2 K2star).PosDef := by
  set E := matExp (-(((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1))) with hE
  set B := matExp (-((Complex.I * K2star) • H2 M)) with hB
  -- `-\tfrac12 S_1^{(+)}` はエルミート
  have hS1 : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M (-1)))).IsHermitian := by
    have h : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M (-1))))ᴴ
        = -(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M (-1))) := by
      rw [Matrix.conjTranspose_neg, Matrix.conjTranspose_smul,
        (S1_isHermitian hK1 star_neg_one).eq]
      norm_num
    exact h
  have hEeq : E = NormedSpace.exp (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M (-1)))) := by
    rw [hE, matExp]
    congr 1
    rw [smul_smul, mul_assoc]
  have hEherm : E.IsHermitian := by rw [hEeq]; exact hS1.exp
  have hEinj : Function.Injective E.mulVec := by
    rw [hEeq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  -- `-S_2` はエルミートなので `exp(-S_2)` は正定値
  have hS2 : (-((Complex.I * K2star) • H2 M)).IsHermitian := by
    have h : (-((Complex.I * K2star) • H2 M))ᴴ = -((Complex.I * K2star) • H2 M) := by
      rw [Matrix.conjTranspose_neg, (S2_isHermitian hK2).eq]
    exact h
  have hBpos : B.PosDef := by
    rw [hB, matExp]
    exact posDef_exp_of_isHermitian hS2
  have hEBE : (Eᴴ * B * E).PosDef := hBpos.conjTranspose_mul_mul_same hEinj
  rw [hEherm.eq] at hEBE
  have hscal : ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ)⁻¹ : ℝ) : ℂ) := by
    rw [Complex.ofReal_inv]
  rw [VPlusInv, VmatInv, hscal]
  refine posDef_smul_of_pos hEBE ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact inv_pos.2 (Real.rpow_pos_of_pos this _)

/-- **原文 `V_plus_is_positive_definite` Step 5**: `tr(V^{(+)}) > 0`。 -/
theorem trace_VPlus_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlus M s2 K1 K2star).trace :=
  (VPlus_posDef hK1 hK2 hs2).trace_pos

/-- **原文 `V_plus_is_positive_definite` Step 5**: `tr((V^{(+)})^{-1}) > 0`。 -/
theorem trace_VPlusInv_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlusInv M K1 s2 K2star).trace :=
  (VPlusInv_posDef hK1 hK2 hs2).trace_pos

end VPlus

end Ising2D
