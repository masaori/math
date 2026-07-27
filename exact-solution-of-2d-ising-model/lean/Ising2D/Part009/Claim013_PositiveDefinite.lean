/-
# エルミート性・正定値性と `V` の正定値性（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `def_hermitian_positive_definite`（`eigenvalues_of_V_011_definition_...`）
- `star_preserves_norm_and_limits`（`eigenvalues_of_V_012_claim_...`）
- `exp_hermitian_is_positive_definite`（`eigenvalues_of_V_013_claim_...`）
- `iH_is_real_symmetric`（`eigenvalues_of_V_014_claim_...`）
- `V_is_positive_definite`（`eigenvalues_of_V_015_claim_...`）

原文の「共役転置 `A^*`」「エルミート」「正定値」は mathlib の
`Matrix.conjTranspose` / `Matrix.IsHermitian` / `Matrix.PosDef` と同じものである。

## 原文との違い（形式化して分かったこと）

原文 `star_preserves_norm_and_limits` の (2)(3)（`‖A^*‖ = ‖A‖` と極限の共役転置）は、
原文では `exp(S)` がエルミートであることを示すためだけに使われている。
mathlib は同じ事実を `Matrix.exp_conjTranspose`（`exp(A^*) = exp(A)^*`）として
持っているので、本ファイルではそちらを使う。したがって (2)(3) は
**結論に効かない補題**であり、ここでは (1) だけを形式化する。

原文 `iH_is_real_symmetric` は `S_1^{(±)}` を `K_1 ∑ σ^z_m σ^z_{m+1} ∓ K_1 G` へ、
`S_2` を `K_2^* ∑ σ^x_m` へ書き換えてから成分の実性と転置対称性を数えている。
形式化してみると、**その書き換えは不要**で、

- `Z_m^⊤ = Z_m`, `Y_m^⊤ = -Y_m`（Pauli 行列の転置の性質だけ）
- `Z_m^* = Z_m`, `Y_m^* = Y_m`（Pauli 行列がエルミートであること）
- `[Z_μ, Y_ν]_+ = 0`（既に形式化済みの `anticomm_Z_Y`）

の 3 つから直ちに従う（`G` も `M` の偶奇も出てこない）。
なお「実対称」は「エルミートかつ転置不変」と同値なので、両方を示す。
-/
import Ising2D.Part004.Definition010_H1H2V1V2
import Ising2D.Part006.Claim000_AnticommutatorZY
import Ising2D.Part009.Definition001_Trace
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open Matrix
open scoped ComplexOrder

section Herm

variable {M : ℕ}

/-! ## Pauli 行列の転置・共役転置 -/

@[simp] theorem pauliX_transpose : pauliXᵀ = pauliX := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliX]

@[simp] theorem pauliZ_transpose : pauliZᵀ = pauliZ := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliZ]

@[simp] theorem pauliY_transpose : pauliYᵀ = -pauliY := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliY]

@[simp] theorem pauliX_conjTranspose : pauliXᴴ = pauliX := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliX]

@[simp] theorem pauliZ_conjTranspose : pauliZᴴ = pauliZ := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliZ]

@[simp] theorem pauliY_conjTranspose : pauliYᴴ = pauliY := by
  ext a b; fin_cases a <;> fin_cases b <;> simp [pauliY]

/-! ## `siteProd` の転置・共役転置 -/

theorem siteProd_transpose (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M x)ᵀ = siteProd M (fun i => (x i)ᵀ) := by
  ext s t
  simp only [Matrix.transpose_apply, siteProd_apply]

theorem siteProd_conjTranspose (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M x)ᴴ = siteProd M (fun i => (x i)ᴴ) := by
  ext s t
  show star (siteProd M x t s) = ∏ i, star (x i (t i) (s i))
  rw [siteProd_apply]
  exact map_prod (starRingEnd ℂ) _ _

/-! ## `Z_m`, `Y_m` の転置・共役転置 -/

theorem Z_transpose (m : Fin M) : (Z m)ᵀ = Z m := by
  rw [Z, siteProd_transpose]
  congr 1
  funext i
  unfold jwFamily
  split
  · exact pauliX_transpose
  · split
    · exact pauliZ_transpose
    · exact Matrix.transpose_one

theorem Z_conjTranspose (m : Fin M) : (Z m)ᴴ = Z m := by
  rw [Z, siteProd_conjTranspose]
  congr 1
  funext i
  unfold jwFamily
  split
  · exact pauliX_conjTranspose
  · split
    · exact pauliZ_conjTranspose
    · exact Matrix.conjTranspose_one

theorem Y_conjTranspose (m : Fin M) : (Y m)ᴴ = Y m := by
  rw [Y, siteProd_conjTranspose]
  congr 1
  funext i
  unfold jwFamily
  split
  · exact pauliX_conjTranspose
  · split
    · exact pauliY_conjTranspose
    · exact Matrix.conjTranspose_one

theorem Y_transpose (m : Fin M) : (Y m)ᵀ = -(Y m) := by
  rw [Y, siteProd_transpose]
  have hfam : (fun i => (jwFamily m pauliY i)ᵀ) = jwFamily m (-pauliY) := by
    funext i
    unfold jwFamily
    split
    · exact pauliX_transpose
    · split
      · exact pauliY_transpose
      · exact Matrix.transpose_one
  rw [hfam, jw_eq_xString_mul, map_neg, Matrix.mul_neg, ← jw_eq_xString_mul]

/-! ## `H_1^{(±)}`, `H_2` の反エルミート性・転置対称性 -/

/-- `(Y_m Z_n)^* = -(Y_m Z_n)`（`[Z,Y]_+ = 0` による）。 -/
theorem conjTranspose_Y_mul_Z (m n : Fin M) : (Y m * Z n)ᴴ = -(Y m * Z n) := by
  rw [Matrix.conjTranspose_mul, Z_conjTranspose, Y_conjTranspose]
  have h := anticomm_Z_Y n m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) h

/-- `(Y_m Z_n)^⊤ = Y_m Z_n`。 -/
theorem transpose_Y_mul_Z (m n : Fin M) : (Y m * Z n)ᵀ = Y m * Z n := by
  rw [Matrix.transpose_mul, Z_transpose, Y_transpose]
  have h := anticomm_Z_Y n m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) -h

theorem conjTranspose_Z_mul_Y (m : Fin M) : (Z m * Y m)ᴴ = -(Z m * Y m) := by
  rw [Matrix.conjTranspose_mul, Z_conjTranspose, Y_conjTranspose]
  have h := anticomm_Z_Y m m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) h

theorem transpose_Z_mul_Y (m : Fin M) : (Z m * Y m)ᵀ = Z m * Y m := by
  rw [Matrix.transpose_mul, Z_transpose, Y_transpose]
  have h := anticomm_Z_Y m m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) -h

theorem H1_conjTranspose {η : ℂ} (hη : star η = η) :
    (H1 M η)ᴴ = -(H1 M η) := by
  rw [H1, Matrix.conjTranspose_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  have hstar : star (lastSign η m) = lastSign η m := by
    unfold lastSign
    split
    · exact hη
    · exact star_one _
  rw [Matrix.conjTranspose_smul, conjTranspose_Y_mul_Z, smul_neg, hstar]

theorem H1_transpose {η : ℂ} : (H1 M η)ᵀ = H1 M η := by
  rw [H1]
  rw [Matrix.transpose_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Matrix.transpose_smul, transpose_Y_mul_Z]

theorem H2_conjTranspose : (H2 M)ᴴ = -(H2 M) := by
  rw [H2, Matrix.conjTranspose_sum, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => conjTranspose_Z_mul_Y m

theorem H2_transpose : (H2 M)ᵀ = H2 M := by
  rw [H2, Matrix.transpose_sum]
  exact Finset.sum_congr rfl fun m _ => transpose_Z_mul_Y m

private theorem star_I_mul {c : ℂ} (hc : star c = c) :
    star (Complex.I * c) = -(Complex.I * c) := by
  have hI : star Complex.I = -Complex.I := by simp [Complex.star_def]
  rw [star_mul', hI, hc]
  ring

/-- **原文 `iH_is_real_symmetric`**: `S_1^{(±)} = i K_1 H_1^{(±)}` は実対称
（エルミートかつ転置不変）。 -/
theorem S1_isHermitian {K1 η : ℂ} (hK1 : star K1 = K1) (hη : star η = η) :
    (((Complex.I * K1) • H1 M η)).IsHermitian := by
  have h : (((Complex.I * K1) • H1 M η))ᴴ = (Complex.I * K1) • H1 M η := by
    rw [Matrix.conjTranspose_smul, H1_conjTranspose hη, star_I_mul hK1,
      smul_neg, neg_smul, neg_neg]
  exact h

theorem S1_transpose {K1 η : ℂ} : (((Complex.I * K1) • H1 M η))ᵀ = (Complex.I * K1) • H1 M η := by
  rw [Matrix.transpose_smul, H1_transpose]

/-- **原文 `iH_is_real_symmetric`**: `S_2 = i K_2^* H_2` は実対称。 -/
theorem S2_isHermitian {K2star : ℂ} (hK2 : star K2star = K2star) :
    (((Complex.I * K2star) • H2 M)).IsHermitian := by
  have h : (((Complex.I * K2star) • H2 M))ᴴ = (Complex.I * K2star) • H2 M := by
    rw [Matrix.conjTranspose_smul, H2_conjTranspose, star_I_mul hK2,
      smul_neg, neg_smul, neg_neg]
  exact h

theorem S2_transpose {K2star : ℂ} :
    (((Complex.I * K2star) • H2 M))ᵀ = (Complex.I * K2star) • H2 M := by
  rw [Matrix.transpose_smul, H2_transpose]

/-- 原文の「成分がすべて実数で転置について対称」＝「エルミートかつ転置不変」。 -/
theorem entries_real_of_isHermitian_of_transpose {A : TensorPow M}
    (hH : A.IsHermitian) (hT : Aᵀ = A) (s t : Conf M) : (starRingEnd ℂ) (A s t) = A s t := by
  have h1 : star (A t s) = A s t := congrFun (congrFun hH s) t
  have h2 : A s t = A t s := (congrFun (congrFun hT s) t).symm
  calc (starRingEnd ℂ) (A s t) = star (A t s) := by rw [h2]; rfl
    _ = A s t := h1

end Herm

/-! ## `exp` の正定値性（原文 `exp_hermitian_is_positive_definite`） -/

section PosDef

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **原文 (3)**: 正定値行列の正実数倍は正定値。 -/
theorem posDef_smul_of_pos {A : Matrix n n ℂ} (hA : A.PosDef) {r : ℝ} (hr : 0 < r) :
    (((r : ℂ)) • A).PosDef := by
  refine Matrix.PosDef.of_dotProduct_mulVec_pos ?_ ?_
  · have h : (((r : ℂ)) • A)ᴴ = ((r : ℂ)) • A := by
      rw [Matrix.conjTranspose_smul, hA.isHermitian.eq, Complex.star_def, Complex.conj_ofReal]
    exact h
  · intro x hx
    have hpos := hA.dotProduct_mulVec_pos hx
    have hr' : (0 : ℂ) < (r : ℂ) := by
      simpa using (RCLike.ofReal_pos (K := ℂ)).2 hr
    rw [Matrix.smul_mulVec, dotProduct_smul, smul_eq_mul]
    exact mul_pos hr' hpos

/-- **原文 (1)**: エルミート行列の `exp` はエルミートかつ正定値。

原文は `exp(S) = exp(S/2)^* exp(S/2)` と `w^*w = ‖w‖^2 > 0` で示す。
ここも同じ経路（`exp(S/2)` の可逆性 → `A^* A` が正定値）を辿る。 -/
theorem posDef_exp_of_isHermitian {S : Matrix n n ℂ} (hS : S.IsHermitian) :
    (NormedSpace.exp S).PosDef := by
  set X : Matrix n n ℂ := (1 / 2 : ℂ) • S with hX
  have hhalf : X.IsHermitian := by
    have : Xᴴ = X := by
      rw [hX, Matrix.conjTranspose_smul, hS.eq]
      norm_num
    exact this
  have hsq : NormedSpace.exp X * NormedSpace.exp X = NormedSpace.exp S := by
    rw [← Matrix.exp_add_of_commute _ _ (Commute.refl _), hX, ← two_smul ℂ, smul_smul]
    norm_num
  have hinj : Function.Injective (NormedSpace.exp X).mulVec :=
    Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  have h := Matrix.PosDef.conjTranspose_mul_self (NormedSpace.exp X) hinj
  rwa [hhalf.exp.eq, hsq] at h

end PosDef

/-! ## `V` の正定値性（原文 `V_is_positive_definite`） -/

section Vpos

variable {M : ℕ}

/-- **原文 `V_is_positive_definite` の `V := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`**。 -/
noncomputable def Vmat (M : ℕ) (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  V1half M K1 η * V2 M s2 K2star * V1half M K1 η

/-- **原文 `V_is_positive_definite` Step 3**: `V` は正定値。 -/
theorem Vmat_posDef {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (Vmat M K1 η s2 K2star).PosDef := by
  have hS1 : (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)).IsHermitian := by
    have : ((((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)))ᴴ
        = ((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η) := by
      rw [Matrix.conjTranspose_smul, (S1_isHermitian hK1 hη).eq]
      norm_num
    exact this
  have hB : (V1half M K1 η).IsHermitian := by
    have hEq : V1half M K1 η = NormedSpace.exp (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)) := by
      rw [V1half, matExp, smul_smul, mul_assoc]
    rw [hEq]
    exact hS1.exp
  have hA : (NormedSpace.exp ((Complex.I * K2star) • H2 M)).PosDef :=
    posDef_exp_of_isHermitian (S2_isHermitian hK2)
  have hinj : Function.Injective (V1half M K1 η).mulVec := by
    have hEq : V1half M K1 η = NormedSpace.exp (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η) := rfl
    rw [hEq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  have hBAB : ((V1half M K1 η)ᴴ * NormedSpace.exp ((Complex.I * K2star) • H2 M)
      * V1half M K1 η).PosDef := hA.conjTranspose_mul_mul_same hinj
  rw [hB.eq] at hBAB
  have hV : Vmat M K1 η s2 K2star
      = (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ)) : ℂ))
        • (V1half M K1 η * NormedSpace.exp ((Complex.I * K2star) • H2 M) * V1half M K1 η) := by
    rw [Vmat, V2, matExp]
    rw [Matrix.mul_smul, Matrix.smul_mul]
  rw [hV]
  refine posDef_smul_of_pos hBAB ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact Real.rpow_pos_of_pos this _

/-- **原文 `V_is_positive_definite` Step 5**: `tr(V) > 0`。 -/
theorem trace_Vmat_pos {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (Vmat M K1 η s2 K2star).trace :=
  (Vmat_posDef hK1 hη hK2 hs2).trace_pos

end Vpos

end Ising2D
