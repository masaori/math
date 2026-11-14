/-
# `V_1` の Jordan--Wigner 行列表示

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `transfer_matrix_003_claim_V1_in_Z_Y_epsilon`
  （ラベル **`V1_in_Z_Y_epsilon`**）

人手本文の等式

`V_1 = exp(i K_1 (Y_1 Z_2 + ... + Y_{M-1} Z_M - epsilon Y_M Z_1))`

を `TensorPow M = Matrix (Conf M) (Conf M) ℂ` の行列等式として形式化する。
Lean のサイト添字は 0 始まりなので、最後のサイトは
`(m : ℕ) + 1 = M` で判定する。

## 証明の対応

* 人手証明 Step 0: `pauliY_mul_pauliX_eq` と `pauliX_mul_pauliY_eq`。
* Step 1: `Y`, `Z`, `epsilon` の定義展開と `siteProd_mul` によるサイトごとの積。
* Step 2: `Y_mul_Z_next_of_not_last`。
* Step 3: `epsilon_mul_Y_mul_Z_next_of_last`。
* Step 4: `sum_sigmaZ_sigmaZ_eq_jordanWigner`（指数の肩の等式）、
  `V1PauliForm_eq_jordanWigner`（右辺の式 `V1PauliForm` についての行列等式。`K1 : ℂ` の一般の値で）、
  `V1_in_Z_Y_epsilon`（人手の `V_1` そのものについての主張。`first_transfer_matrix_pauli_form` を
  引く段が人手の最終の式変形の第 1 行に対応する）。

必要十分版は置かない。この主張に固有なのは、同じ具体的な `V_1` の Pauli 表示と
Jordan--Wigner 表示を突き合わせることだからである。証明が使う一般的な内容は、
既に `siteProd_mul` と `siteProd_smul_family` が表す「サイトごとの積」と
「各サイトについての複素線型性」に分離されている。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimFirstTransferMatrixPauliForm
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimSitePauliPrefixProductKroneckerForm

namespace Ising2D

variable {M : ℕ}

/-- `ε = σ^x⊠⋯⊠σ^x`（人手 `global_spin_flip_kronecker_form`。`M ≥ 1` はその具体版、人手に無い `M = 0` は帰納法の版）。 -/
private theorem epsilon_eq_siteProd_for_jordanWigner :
    ∀ M : ℕ, epsilon M = siteProd M (fun _ => pauliX)
  | 0 => epsilon_eq_siteProd_pauliX_by_induction
  | n + 1 => global_spin_flip_kronecker_form n

private theorem siteProd_smul_family_for_jordanWigner (c : Fin M → ℂ)
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun i => c i • x i) = (∏ i, c i) • siteProd M x :=
  MultilinearMap.map_smul_univ (siteProd M) c x

/-! ## 単一サイトの Pauli 行列の積 -/

/-- 人手証明 Step 0 の `σʸσˣ = -iσᶻ`。人手 `iH_is_real_symmetric` の Step 0 の第 2 の鎖（`eigenvalue_problem_eigenvalues_of_V_plus.ts`）も同じ鎖で、
どちらの鎖の各段とも 1 対 1 に対応する。 -/
theorem pauliY_mul_pauliX_eq : pauliY * pauliX = (-Complex.I) • pauliZ := by
  calc
    -- `def_pauli_matrices`（Pauli 行列）
    pauliY * pauliX = !![0, -Complex.I; Complex.I, 0] * !![0, 1; 1, 0] := rfl
    -- `mat_mult`
    _ = !![0 * 0 + (-Complex.I) * 1, 0 * 1 + (-Complex.I) * 0;
          Complex.I * 0 + 0 * 1, Complex.I * 1 + 0 * 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Matrix.mul_apply, Fin.sum_univ_two] <;> rfl
    -- `complex_zero_times_is_zero`（4 か所へ同時に適用）
    _ = !![0 + (-Complex.I) * 1, 0 + (-Complex.I) * 0;
          Complex.I * 0 + 0, Complex.I * 1 + 0] := by simp only [zero_mul]
    -- `complex_zero_plus_is_original`（`z → (-i)·1, (-i)·0`）を 2 か所へ（具体版は無く `zero_add`）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0; Complex.I * 0 + 0, Complex.I * 1 + 0] := by
      rw [zero_add, zero_add]
    -- `0_ℂ` は加法の単位元（`complex_numbers_form_a_field`。右から足す 0 を 2 か所へ）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0; Complex.I * 0, Complex.I * 1] := by
      rw [add_zero, add_zero]
    -- `complex_times_zero_is_zero`
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0; 0, Complex.I * 1] := by rw [mul_zero Complex.I]
    -- `complex_times_zero_is_zero`（右辺の `(-i)·0` へ）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0; (-Complex.I) * 0, Complex.I * 1] := by
      rw [mul_zero (-Complex.I)]
    -- ℂ で `(-1)·(-1) = 1`（`definition_of_cc` の積。Lean では `(-1)·z = -z` と `-(-1) = 1` の 2 補題で閉じる）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0;
          (-Complex.I) * 0, Complex.I * ((-1) * (-1))] := by
      rw [neg_one_mul, neg_neg]
    -- 積の結合律（`complex_numbers_form_a_field`）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0;
          (-Complex.I) * 0, (Complex.I * (-1)) * (-1)] := by
      rw [mul_assoc Complex.I]
    -- 積の可換律（`complex_numbers_form_a_field`）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0;
          (-Complex.I) * 0, ((-1) * Complex.I) * (-1)] := by
      rw [mul_comm Complex.I (-1)]
    -- `multiply_by_minus_one`（`-z := (-1)·z`）
    _ = !![(-Complex.I) * 1, (-Complex.I) * 0; (-Complex.I) * 0, (-Complex.I) * (-1)] := by
      rw [neg_one_mul Complex.I]
    -- `def_matrix_scalar_multiple`
    _ = (-Complex.I) • !![1, 0; 0, -1] := by
      ext i j
      rw [matrix_smul_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `def_pauli_matrices`（Pauli 行列）
    _ = (-Complex.I) • pauliZ := rfl

/-- 人手証明 Step 0 の `σˣσʸ = iσᶻ`。人手の鎖の各段と 1 対 1 に対応する。 -/
theorem pauliX_mul_pauliY_eq : pauliX * pauliY = Complex.I • pauliZ := by
  calc
    -- `def_pauli_matrices`（Pauli 行列）
    pauliX * pauliY = !![0, 1; 1, 0] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- `mat_mult`
    _ = !![0 * 0 + 1 * Complex.I, 0 * (-Complex.I) + 1 * 0;
          1 * 0 + 0 * Complex.I, 1 * (-Complex.I) + 0 * 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Matrix.mul_apply, Fin.sum_univ_two] <;> rfl
    -- `complex_zero_times_is_zero`（4 か所へ同時に適用）
    _ = !![0 + 1 * Complex.I, 0 + 1 * 0; 1 * 0 + 0, 1 * (-Complex.I) + 0] := by
      simp only [zero_mul]
    -- `complex_zero_plus_is_original`（`z → 1·i, 1·0`）を 2 か所へ（具体版は無く `zero_add`）
    _ = !![1 * Complex.I, 1 * 0; 1 * 0 + 0, 1 * (-Complex.I) + 0] := by
      rw [zero_add, zero_add]
    -- `0_ℂ` は加法の単位元（`complex_numbers_form_a_field`。右から足す 0 を 2 か所へ）
    _ = !![1 * Complex.I, 1 * 0; 1 * 0, 1 * (-Complex.I)] := by rw [add_zero, add_zero]
    -- `complex_times_zero_is_zero`（2 か所へ同時に適用）
    _ = !![1 * Complex.I, 0; 0, 1 * (-Complex.I)] := by rw [mul_zero (1 : ℂ)]
    -- `1_ℂ` は積の単位元（`complex_numbers_form_a_field`）
    _ = !![1 * Complex.I, 0; 0, -Complex.I] := by rw [one_mul (-Complex.I)]
    -- `multiply_by_minus_one`（`-z := (-1)·z`）
    _ = !![1 * Complex.I, 0; 0, (-1) * Complex.I] := by rw [neg_one_mul Complex.I]
    -- 積の可換律（`complex_numbers_form_a_field`。2 か所へ同時に適用）
    _ = !![Complex.I * 1, 0; 0, Complex.I * (-1)] := by
      rw [mul_comm Complex.I 1, mul_comm Complex.I (-1)]
    -- `complex_times_zero_is_zero`（右辺の `i·0` へ。2 か所へ同時に適用）
    _ = !![Complex.I * 1, Complex.I * 0; Complex.I * 0, Complex.I * (-1)] := by
      rw [mul_zero Complex.I]
    -- `def_matrix_scalar_multiple`
    _ = Complex.I • !![1, 0; 0, -1] := by
      ext i j
      rw [matrix_smul_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `def_pauli_matrices`（Pauli 行列）
    _ = Complex.I • pauliZ := rfl

/-! ## 非境界項と周期境界項 -/

/-- 人手証明 Step 2 の `Y_m Z_{m+1} = -i σᶻ_m σᶻ_{m+1}`。
`m` が最後のサイトでない場合、Jordan--Wigner 文字列はサイト `m` だけで
`σʸσˣ = -iσᶻ` を作り、他の文字列部分は `σˣσˣ = I` で消える。 -/
theorem Y_mul_Z_next_of_not_last (m : Fin M) (hm : (m : ℕ) + 1 ≠ M) :
    Y m * Z (nextSite m) = (-Complex.I) • (sigmaZ m * sigmaZ (nextSite m)) := by
  have hnext : ((nextSite m : Fin M) : ℕ) = (m : ℕ) + 1 := by
    apply nextSite_val_of_lt
    omega
  rw [Y, Z, ← siteProd_mul, sigmaZ, sigmaZ, siteOp_apply, siteOp_apply, ← siteProd_mul]
  let c : Fin M → ℂ := Function.update 1 m (-Complex.I)
  let base : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
    Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ *
      Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (nextSite m) pauliZ
  have hfamily : jwFamily m pauliY * jwFamily (nextSite m) pauliZ =
      fun i => c i • base i := by
    funext i
    simp only [Pi.mul_apply]
    rcases lt_trichotomy (i : ℕ) (m : ℕ) with hi | hi | hi
    · have hinext : (i : ℕ) < (nextSite m : ℕ) := by omega
      have him : i ≠ m := Fin.ne_of_val_ne (by omega)
      have hin : i ≠ nextSite m := Fin.ne_of_val_ne (by omega)
      rw [jwFamily_of_lt hi, jwFamily_of_lt hinext]
      simp [c, base, him, hin]
    · have hieq : i = m := Fin.val_injective hi
      subst i
      have hmn : m ≠ nextSite m := Fin.ne_of_val_ne (by omega)
      rw [jwFamily_self, jwFamily_of_lt (by omega)]
      simp [c, base, hmn, pauliY_mul_pauliX_eq]
    · rcases lt_trichotomy (i : ℕ) (nextSite m : ℕ) with hin | hin | hin
      · omega
      · have hieq : i = nextSite m := Fin.val_injective hin
        subst i
        have hnm : nextSite m ≠ m := Fin.ne_of_val_ne (by omega)
        rw [jwFamily_of_gt (by omega), jwFamily_self]
        simp [c, base, hnm]
      · have him : i ≠ m := Fin.ne_of_val_ne (by omega)
        have hin' : i ≠ nextSite m := Fin.ne_of_val_ne (by omega)
        rw [jwFamily_of_gt (by omega), jwFamily_of_gt hin, one_mul]
        simp [c, base, him, hin']
  rw [hfamily, siteProd_smul_family_for_jordanWigner]
  have hprod : (∏ i, c i) = -Complex.I := by
    simp [c, Finset.prod_update_of_mem]
  rw [hprod]

/-- 人手証明 Step 3 の `ε Y_M Z_1 = i σᶻ_M σᶻ_1`。
`ε` を掛けると、周期境界で一周した Jordan--Wigner 文字列が全サイトで消え、
最後のサイトだけ `σˣσʸ = iσᶻ` を作る。 -/
theorem epsilon_mul_Y_mul_Z_next_of_last (hM : 2 ≤ M) (m : Fin M)
    (hm : (m : ℕ) + 1 = M) :
    epsilon M * Y m * Z (nextSite m) =
      Complex.I • (sigmaZ m * sigmaZ (nextSite m)) := by
  have hnext : ((nextSite m : Fin M) : ℕ) = 0 := nextSite_val_of_last hm
  have hmpos : 0 < (m : ℕ) := by omega
  rw [epsilon_eq_siteProd_for_jordanWigner, Y, Z, ← siteProd_mul, ← siteProd_mul,
    sigmaZ, sigmaZ, siteOp_apply, siteOp_apply, ← siteProd_mul]
  let c : Fin M → ℂ := Function.update 1 m Complex.I
  let base : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
    Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ *
      Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (nextSite m) pauliZ
  have hfamily : (fun _ : Fin M => pauliX) * jwFamily m pauliY *
      jwFamily (nextSite m) pauliZ = fun i => c i • base i := by
    funext i
    simp only [Pi.mul_apply]
    rcases lt_trichotomy (i : ℕ) (m : ℕ) with hi | hi | hi
    · by_cases hi0 : (i : ℕ) = 0
      · have hieq : i = nextSite m := Fin.val_injective (by omega)
        subst i
        have hnm : nextSite m ≠ m := Fin.ne_of_val_ne (by omega)
        rw [jwFamily_of_lt (by omega), jwFamily_self]
        simp [c, base, hnm]
      · have hin_gt : (nextSite m : ℕ) < (i : ℕ) := by omega
        have him : i ≠ m := Fin.ne_of_val_ne (by omega)
        have hin : i ≠ nextSite m := Fin.ne_of_val_ne (by omega)
        rw [jwFamily_of_lt hi, jwFamily_of_gt hin_gt]
        simp [c, base, him, hin]
    · have hieq : i = m := Fin.val_injective hi
      subst i
      have hmn : m ≠ nextSite m := Fin.ne_of_val_ne (by omega)
      rw [jwFamily_self, jwFamily_of_gt (by omega)]
      simp [c, base, hmn, pauliX_mul_pauliY_eq]
    · omega
  rw [hfamily, siteProd_smul_family_for_jordanWigner]
  have hprod : (∏ i, c i) = Complex.I := by
    simp [c, Finset.prod_update_of_mem]
  rw [hprod]

/-! ## 指数の肩と `V_1` の行列等式 -/

/-- 人手本文の
`Y_1 Z_2 + ... + Y_{M-1} Z_M - ε Y_M Z_1`。
Lean では全サイトの和と、最後のサイトかどうかの判定で表す。 -/
noncomputable def H1JordanWigner (M : ℕ) : TensorPow M :=
  ∑ m : Fin M, if (m : ℕ) + 1 = M
    then -(epsilon M * Y m * Z (nextSite m))
    else Y m * Z (nextSite m)

/-- 各結合 `σᶻ_m σᶻ_{m+1}` を、非境界項と周期境界項に応じた
Jordan--Wigner 二次式へ置き換える。 -/
theorem sigmaZ_mul_sigmaZ_next_eq_jordanWignerBond (hM : 2 ≤ M) (m : Fin M) :
    sigmaZ m * sigmaZ (nextSite m) = Complex.I •
      (if (m : ℕ) + 1 = M
        then -(epsilon M * Y m * Z (nextSite m))
        else Y m * Z (nextSite m)) := by
  by_cases hm : (m : ℕ) + 1 = M
  · rw [if_pos hm, epsilon_mul_Y_mul_Z_next_of_last hM m hm, smul_neg, smul_smul]
    norm_num [Complex.I_mul_I]
  · rw [if_neg hm, Y_mul_Z_next_of_not_last m hm, smul_smul]
    norm_num [Complex.I_mul_I]

/-- 人手証明 Step 4 の指数の肩の等式。 -/
theorem sum_sigmaZ_sigmaZ_eq_jordanWigner (hM : 2 ≤ M) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) =
      Complex.I • H1JordanWigner M := by
  rw [H1JordanWigner, Finset.smul_sum]
  exact Finset.sum_congr rfl fun m _ => sigmaZ_mul_sigmaZ_next_eq_jordanWignerBond hM m

/-- 人手 Step 4 の最終の式変形の第 2 行（指数の肩の等式を `exp` に代入する段）を、
右辺の式 `V1PauliForm`（`K1 : ℂ` の一般の値）について述べたもの。 -/
theorem V1PauliForm_eq_jordanWigner (hM : 2 ≤ M) (K1 : ℂ) :
    V1PauliForm M K1 = matExp ((Complex.I * K1) • H1JordanWigner M) := by
  rw [V1PauliForm, sum_sigmaZ_sigmaZ_eq_jordanWigner hM, smul_smul]
  rw [mul_comm K1 Complex.I]

/-- **人手本文 `V1_in_Z_Y_epsilon` の行列等式**:

`V_1 = exp(i K_1 (Y_1 Z_2 + ... + Y_{M-1} Z_M - ε Y_M Z_1))`（`V_1` は `def_transfer_matrix` の `V_1`）。
-/
theorem V1_in_Z_Y_epsilon (hM : 2 ≤ M) (K1 : ℝ) :
    V1 M K1 = matExp ((Complex.I * (K1 : ℂ)) • H1JordanWigner M) := by
  rw [first_transfer_matrix_pauli_form, V1PauliForm_eq_jordanWigner hM]

end Ising2D
