/-
# `V_2` の成分定義とパウリ表示の一致

対応する人手証明（正本は `structured-latex/content/*.ts`）:

* `004_transfer_matrix.ts` の
  `transfer_matrix_003a_claim_V2_in_Z_Y`（ラベル **`V2_in_Z_Y`**）
* `010_transfer_matrix_bridge.ts` の
  `bridge_006_claim_V2_component_equals_pauli`（ラベル **`V2_component_equals_pauli`**）

`V2_in_Z_Y` の Step 0–2 は `Ising2D.Z_mul_Y_same` と
`Ising2D.I_smul_H2_eq_sum_sigmaX` が担う。Step 3 の最終行列等式は
`V2_eq_V2pauli` の対称向きである。

原文の主張（`K_2 = J`）:

  `((2 sinh 2K_2)^{M/2} exp(K_2^* ∑_m σ^x_m))_{ι(μ),ι(μ')} = exp(∑_m J μ(m) μ'(m))`

## 原文の Step との対応

* Step 1（右辺を因子ごとの積 `∏_m A_{i_m j_m}` に分ける）→ `V2comp_eq_siteProd_twoByTwo`。
  `siteProd` の成分が因子の成分の積であること（`Ising2D.siteProd_apply`）が
  原文の「クロネッカー積の成分は因子ごとの成分の積」にあたる。
* Step 2（スカラー `(2s_2)^{1/2}` を `M` 個の因子から前へ出す）→ `siteProd_smul_const`。
* Step 3・Step 4（1 因子の `exp` をサイト演算子の `exp` にして積にまとめる）→
  `exp_smul_sum_sigmaX`。原文は「各因子の冪 → 部分和 → 成分ごとの収束」と
  「異サイトの可換性 + `theorem_exp_product`」で通しているが、Lean では
  `σ^x` を全サイトで同時に対角化する単元 `hadUnits M` による共役
  （`Matrix.exp_units_conj`）と対角行列の指数関数（`Ising2D.matrixExp_diagonal`）で通す。
  どちらも「`exp` は 1 サイトずつ計算してよい」という同じ事実であり、
  級数の分割・極限の交換を経由しないぶん Lean では短い。
* Step 5（結論）→ `V2pauli_eq_V2comp` および `V2_component_equals_pauli`。

必要十分版は置いていない（内容は `NecSuf/SiteDiagonal.lean` と `NecSuf/ExpDiagonal.lean` の
合成であり、本ファイル固有の内容は 2 つの `V_2` の定義の突き合わせである）。
-/
import Ising2D.Part010.Claim005_TwoByTwoTransfer
import Ising2D.Part010.Definition000_ComponentTransfer

namespace Ising2D

open NormedSpace

variable {M : ℕ}

/-! ## 全サイト同時の対角化 -/

/-- 各サイトに `hadU` を置いたクロネッカー積（単元として）。 -/
noncomputable def hadUnits (M : ℕ) : (TensorPow M)ˣ where
  val := siteProd M (fun _ => (hadU : Matrix (Fin 2) (Fin 2) ℂ))
  inv := siteProd M (fun _ => ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) :
    Matrix (Fin 2) (Fin 2) ℂ))
  val_inv := by
    rw [← siteProd_mul]
    have h : ((fun _ => (hadU : Matrix (Fin 2) (Fin 2) ℂ)) *
        (fun _ => ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ))
        : Fin M → Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
      funext i; exact hadU.mul_inv
    rw [h, siteProd_one]
  inv_val := by
    rw [← siteProd_mul]
    have h : ((fun _ => ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ)) *
        (fun _ => (hadU : Matrix (Fin 2) (Fin 2) ℂ)) : Fin M → Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
      funext i; exact hadU.inv_mul
    rw [h, siteProd_one]

/-- 全サイト同時の共役は、サイトごとの共役である。 -/
theorem hadUnits_conj (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    ((hadUnits M : (TensorPow M)ˣ) : TensorPow M) * siteProd M x *
        (((hadUnits M)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = siteProd M (fun i => (hadU : Matrix (Fin 2) (Fin 2) ℂ) * x i *
          ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ)) := by
  show siteProd M _ * siteProd M x * siteProd M _ = _
  rw [← siteProd_mul, ← siteProd_mul]
  rfl

/-- `σ^x = U σ^z U⁻¹`（`U = !![1,1;1,-1]` は `σ^x` の固有ベクトルを並べた行列）。 -/
theorem pauliX_eq_conj :
    pauliX = (hadU : Matrix (Fin 2) (Fin 2) ℂ) * pauliZ *
      ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ) := by
  rw [hadU_val, hadU_inv_val]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two, Matrix.vecMul, dotProduct] <;>
    norm_num

/-- `σ^x_m = U_big σ^z_m U_big⁻¹`。 -/
theorem sigmaX_eq_conj (m : Fin M) :
    sigmaX m = ((hadUnits M : (TensorPow M)ˣ) : TensorPow M) * sigmaZ m *
      (((hadUnits M)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
  rw [sigmaZ, siteOp_apply, hadUnits_conj, sigmaX, siteOp_apply]
  congr 1
  funext i
  by_cases h : i = m
  · subst h
    rw [Function.update_self, Function.update_self, ← pauliX_eq_conj]
  · rw [Function.update_of_ne h, Function.update_of_ne h, Pi.one_apply, mul_one,
      hadU.mul_inv]

/-- `∑_m σ^z_m` は対角行列。 -/
theorem sum_sigmaZ_eq_diagonal (M : ℕ) :
    (∑ m : Fin M, sigmaZ m)
      = Matrix.diagonal (fun I : Conf M => ∑ m : Fin M, sgnC (I m)) := by
  ext I J
  rw [Matrix.sum_apply]
  by_cases h : I = J
  · subst h
    simp only [sigmaZ_eq_diagonal, Matrix.diagonal_apply_eq]
  · simp only [sigmaZ_eq_diagonal, Matrix.diagonal_apply_ne _ h, Finset.sum_const_zero]

/-- **原文 Step 3・Step 4: `exp(t ∑_m σ^x_m)` は 1 因子ずつの `exp(t σ^x)` のクロネッカー積。** -/
theorem exp_smul_sum_sigmaX (t : ℂ) :
    exp (t • ∑ m : Fin M, sigmaX m) = siteProd M (fun _ => exp (t • pauliX)) := by
  -- 左辺: 全サイト同時に対角化してから指数関数を計算する
  have hconj : (t • ∑ m : Fin M, sigmaX m)
      = ((hadUnits M : (TensorPow M)ˣ) : TensorPow M) *
          (Matrix.diagonal (fun I : Conf M => t * ∑ m : Fin M, sgnC (I m))) *
          (((hadUnits M)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
    have h1 : (∑ m : Fin M, sigmaX m)
        = ((hadUnits M : (TensorPow M)ˣ) : TensorPow M) * (∑ m : Fin M, sigmaZ m) *
            (((hadUnits M)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
      rw [Finset.mul_sum, Finset.sum_mul]
      exact Finset.sum_congr rfl fun m _ => sigmaX_eq_conj m
    have hpull : ∀ A B C : TensorPow M, A * (t • B) * C = t • (A * B * C) := by
      intro A B C
      rw [mul_smul_comm, smul_mul_assoc]
    rw [h1, sum_sigmaZ_eq_diagonal, ← hpull]
    congr 2
    rw [← Matrix.diagonal_smul]
    congr 1
  -- 右辺: 1 因子ずつ対角化する
  have hfac : (fun _ : Fin M => exp (t • pauliX))
      = fun _ : Fin M => (hadU : Matrix (Fin 2) (Fin 2) ℂ) *
          Matrix.diagonal (fun i : Fin 2 => Complex.exp (t * sgnC i)) *
          ((hadU⁻¹ : (Matrix (Fin 2) (Fin 2) ℂ)ˣ) : Matrix (Fin 2) (Fin 2) ℂ) := by
    have hv : (fun I : Fin 2 => Complex.exp ((![t, -t] : Fin 2 → ℂ) I))
        = fun i : Fin 2 => Complex.exp (t * sgnC i) := by
      funext i
      fin_cases i <;> simp
    funext _
    rw [smul_pauliX_eq_conj, Matrix.exp_units_conj, matrixExp_diagonal, hv]
  have hdiag : Matrix.diagonal (fun I : Conf M => Complex.exp (t * ∑ m : Fin M, sgnC (I m)))
      = Matrix.diagonal (fun I : Conf M => ∏ i : Fin M, Complex.exp (t * sgnC (I i))) := by
    congr 1
    funext I
    rw [Finset.mul_sum, Complex.exp_sum]
  rw [hconj, Matrix.exp_units_conj, matrixExp_diagonal, hdiag, hfac, ← hadUnits_conj,
    siteProd_diagonal]

/-! ## パウリ表示の `V_2` -/

/-- **原文 `def_transfer_matrix_symbols` の
`V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^*(σ^x_1 + ⋯ + σ^x_M))`。**

既存の `Ising2D.V2`（`(2s_2)^{M/2} exp(√-1 K_2^* H_2)`）と一致することは
`V2_eq_V2pauli` で確認する。 -/
noncomputable def V2pauli (M : ℕ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • exp (K2star • ∑ m : Fin M, sigmaX m)

/-- **原文 `V2_in_Z_Y` Step 3。** 既存の `Ising2D.V2`（`H_2` を使う表式）と
本ファイルの `V2pauli`（`σ^x` を使う表式）は同じ行列である
（`√-1 H_2 = ∑_m σ^x_m` による。`Ising2D.I_smul_H2_eq_sum_sigmaX`）。
原文は Pauli 表示から `H_2` 表示への向きであり、本定理の対称向きがその等式にあたる。 -/
theorem V2_eq_V2pauli (s2 : ℝ) (K2star : ℂ) :
    V2 M s2 K2star = V2pauli M s2 K2star := by
  have h : (Complex.I * K2star) • H2 M = K2star • (Complex.I • H2 M) := by
    rw [smul_smul]
    congr 1
    ring
  rw [V2, V2pauli, ← I_smul_H2_eq_sum_sigmaX, ← h, matExp]

/-! ## 成分定義の `V_2` はクロネッカー冪 -/

/-- **原文 Step 1**: `(V_2)_{μ,μ'} = ∏_m A_{i_m j_m}`、すなわち成分定義の `V_2` は
2×2 の `A` のクロネッカー冪である。 -/
theorem V2comp_eq_siteProd_twoByTwo (K2 : ℂ) :
    V2comp M K2 = siteProd M (fun _ => twoByTwo K2) := by
  ext I J
  rw [V2comp_apply, siteProd_apply, interEnergy, Complex.exp_sum]
  rfl

/-- **原文 Step 2**: スカラー倍は `M` 個の因子から前へ出せる。 -/
theorem siteProd_smul_const (c : ℂ) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun _ => c • B) = c ^ M • siteProd M (fun _ => B) := by
  ext I J
  rw [siteProd_apply, Matrix.smul_apply, siteProd_apply, smul_eq_mul]
  simp only [Matrix.smul_apply, smul_eq_mul]
  rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ, Fintype.card_fin]

/-- 原文の前因子 `(2 s_2)^{M/2}` は `((2 s_2)^{1/2})^M` である。 -/
theorem rpow_half_pow (x : ℝ) (hx : 0 ≤ x) (M : ℕ) :
    (x ^ ((M : ℝ) / 2) : ℝ) = (Real.sqrt x) ^ M := by
  rw [Real.sqrt_eq_rpow, ← Real.rpow_natCast (x ^ (1 / (2 : ℝ))) M, ← Real.rpow_mul hx]
  congr 1
  ring

/-- **原文 `V2_component_equals_pauli` の行列としての形。** -/
theorem V2pauli_eq_V2comp {K2 : ℝ} (h : 0 < K2) :
    V2pauli M (Real.sinh (2 * K2)) ((Kstar K2 : ℝ) : ℂ) = V2comp M (K2 : ℂ) := by
  have hs2 : (0 : ℝ) ≤ 2 * Real.sinh (2 * K2) := by
    have : 0 < Real.sinh (2 * K2) := Real.sinh_pos_iff.mpr (by linarith)
    linarith
  rw [V2pauli, exp_smul_sum_sigmaX, V2comp_eq_siteProd_twoByTwo]
  have hA : (fun _ : Fin M => twoByTwo (K2 : ℂ))
      = fun _ : Fin M => ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) •
          exp (((Kstar K2 : ℝ) : ℂ) • pauliX) := by
    funext _
    exact two_by_two_transfer_identity h
  rw [hA, siteProd_smul_const, rpow_half_pow _ hs2]
  norm_cast

/-- **原文 `V2_component_equals_pauli` の成分の形（スピン配置 `μ, μ'` で書いたもの）。** -/
theorem V2_component_equals_pauli {J : ℝ} (h : 0 < J) (μ μ' : SpinConf M) :
    V2pauli M (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ)
        (configBasisIso M μ) (configBasisIso M μ')
      = Complex.exp (∑ m : Fin M, ((J * (μ m : ℝ) * (μ' m : ℝ) : ℝ) : ℂ)) := by
  rw [V2pauli_eq_V2comp h, V2comp_apply, interEnergy]
  congr 1
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [sgnC_configBasisIso, sgnC_configBasisIso]
  push_cast
  ring

end Ising2D
