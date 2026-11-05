/-
# 対称化転送行列 `W := V₁^{1/2} V₂ V₁^{1/2}` と `Z = tr(W^{N_row})`

正本: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`

* `maxeig_001_definition_transfer_matrix_square_root`（ラベル **`def_transfer_matrix_square_root`**）
* `maxeig_001a_definition_symmetrized_transfer_matrix`（ラベル **`def_symmetrized_transfer_matrix`**）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`

* `maxeig_002_claim_Z_equals_trace_of_W`（ラベル **`Z_equals_trace_of_W`**）
* `maxeig_003_claim_W_is_positive_definite`（ラベル **`W_is_real_symmetric_positive_definite`**）

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_004_claim_W_has_positive_entries`（ラベル **`W_has_positive_entries`**）

## 他章に仮定として置いた事実（重要）

本ファイルは章 001（`partition_function_via_transfer_matrix`, `def_transfer_matrix`）・章 004
（`def_config_basis_iso`, `sigma_z_diagonal_action`, `first_transfer_matrix_pauli_form`）・章 009
（
`iH_is_real_symmetric`, `exp_hermitian_is_positive_definite`）に依存するが、
それらの Lean 形式化は本タスクの担当外なので **import せず仮定として受け取る**。
具体的には次を仮定の形にしている。

1. `Z(K_1,K_2) = tr((V₁V₂)^{N_row})`（章 001 の `partition_function_via_transfer_matrix`）— `ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimPartitionFunctionSandwich.lean` と `ClaimZEqualsTraceOfWFromNecSuf.lean` の `partition_function_eq_trace_symTransfer_pow` の仮定（具体的な `Z` については `PhysicalPartitionFunctionSandwich.lean` が Lean の `partition_function_via_transfer_matrix` を引く）。
2. `V₁^{1/2}` が**正の対角行列**であること（章 009 の `sigma_z_diagonal_action` +
   `exp_of_diagonal_matrix`）— ここでは `Ising2D.diagExp d`（`d : n → ℝ`）として与える。
   人手証明の `d μ = (1/2)K₁ ∑_m μ(m)μ(m+1)` に対応する。
3. `V₂` の成分がすべて正であること（章 001 の `def_transfer_matrix` の成分定義）— 仮定。
4. `V₂` が実対称正定値であること（章 009 の `iH_is_real_symmetric` +
   `exp_hermitian_is_positive_definite`）— 仮定。なお 4 を導く一般補題
   `Ising2D.matExp_isSymm` / `Ising2D.matExp_posDef`（実対称行列の指数関数は
   実対称正定値）は本ファイルで証明済みなので、章 009 が形式化されればそのまま接続できる。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerSandwich
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix
open scoped NormedSpace

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## `W := B V₂ B` -/

/-- 人手証明の `W := V₁^{1/2} V₂ V₁^{1/2}`（`B = V₁^{1/2}`）。 -/
def symTransfer (B V2 : Matrix n n ℝ) : Matrix n n ℝ := B * V2 * B

/-! ## `Z = tr(W^{N_row})`（人手 `Z_equals_trace_of_W`）

人手は `B, V_1, V_2 ∈ Mat(2^{M_col}, ℂ)` で述べるので、具体版も係数が `ℂ` の行列について、人手の準備 2・準備 3・本体の鎖と
同じ段の calc で置く（準備 1 の `BB = V_1`・`W = (BV_2)B` は仮定 `hBB`・`hW` として受け取る）。「とくに」の
`Z(K_1,K_2) = tr(W^{N_row})` は、具体的な `V_1`・`V_2`・`V_1^{1/2}` について
`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean` の `partition_function_eq_trace_physicalSymTransferC` に置く。
人手の `X^0 := I`、`X^{m+1} := X^m X`（`def_exp` (1)）は mathlib の `pow_zero`・`pow_succ` と同じ定め方である。
`mat_mult_associative` は具体版が無いので、既存の慣行どおり `Matrix.mul_assoc` を 1 段に 1 回ずつ引く。
単位行列の左右の単位律（`identity_matrix_is_left_unit_of_mat_mult`・`_right_unit_`）の具体版は添字が `Fin m` の行列にしかないので、
同じ主張の mathlib の一段の補題 `Matrix.one_mul`・`Matrix.mul_one` を引く。跡の巡回性（`trace_basic_properties` (2)）は具体版 `trace_cyclic`。
必要十分版は `NecSuf/OpenProductPowAndCyclicTrace.lean`（モノイドと巡回的な写像）で、具体版とその特殊化の一致、
および使う側（`partition_function_sandwich`）が引く係数が `ℝ` の行列での読みは
同じフォルダの `ClaimZEqualsTraceOfWFromNecSuf.lean` にある。 -/

/-- 人手 `Z_equals_trace_of_W` の準備 2: `(X(YX)^k)Y = (XY)^{k+1}`（`k` の帰納法。`k = 0` の 5 行と帰納段階の 6 行）。 -/
theorem open_product_pow (X Y : Matrix n n ℂ) (k : ℕ) :
    (X * (Y * X) ^ k) * Y = (X * Y) ^ (k + 1) := by
  induction k with
  | zero =>
    calc (X * (Y * X) ^ 0) * Y
        = (X * 1) * Y := by rw [pow_zero]                      -- `def_exp` (1) の `(YX)^0 := I`
      _ = X * Y := by rw [Matrix.mul_one]                      -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = 1 * (X * Y) := (Matrix.one_mul _).symm               -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = (X * Y) ^ 0 * (X * Y) := by rw [pow_zero]            -- `def_exp` (1) の `(XY)^0 := I`
      _ = (X * Y) ^ (0 + 1) := (pow_succ _ _).symm             -- `def_exp` (1) の `(XY)^{0+1} := (XY)^0(XY)`
  | succ k ih =>
    calc (X * (Y * X) ^ (k + 1)) * Y
        = (X * ((Y * X) ^ k * (Y * X))) * Y := by rw [pow_succ] -- `def_exp` (1) の `(YX)^{k+1} := (YX)^k(YX)`
      _ = ((X * (Y * X) ^ k) * (Y * X)) * Y := by
          rw [← Matrix.mul_assoc X ((Y * X) ^ k) (Y * X)]      -- `mat_mult_associative`
      _ = (((X * (Y * X) ^ k) * Y) * X) * Y := by
          rw [← Matrix.mul_assoc (X * (Y * X) ^ k) Y X]          -- `mat_mult_associative`
      _ = ((X * Y) ^ (k + 1) * X) * Y := by rw [ih]            -- 帰納法の仮定
      _ = (X * Y) ^ (k + 1) * (X * Y) := Matrix.mul_assoc _ _ _ -- `mat_mult_associative`
      _ = (X * Y) ^ (k + 1 + 1) := (pow_succ _ _).symm         -- `def_exp` (1) の `(XY)^{(k+1)+1} := (XY)^{k+1}(XY)`

/-- 人手 `Z_equals_trace_of_W` の準備 3: `B B = V_1`（準備 1）のもとで `W^{k+1} = ((B(V_2V_1)^k)V_2)B`
（`k` の帰納法。`k = 0` の 6 行と帰納段階の 12 行。帰納段階の `C := B(V_2V_1)^k` は等式 `hC` を持つ変数として置く）。
準備 1 の `W = (BV_2)B`（`def_symmetrized_transfer_matrix`）は仮定 `hW` として受け取る。 -/
theorem symmetrized_pow_succ {B V1 V2 W : Matrix n n ℂ} (hBB : B * B = V1)
    (hW : W = (B * V2) * B) (k : ℕ) :
    W ^ (k + 1) = ((B * (V2 * V1) ^ k) * V2) * B := by
  induction k with
  | zero =>
    calc W ^ (0 + 1)
        = W ^ 0 * W := pow_succ _ _                            -- `def_exp` (1) の `W^{0+1} := W^0W`
      _ = 1 * W := by rw [pow_zero]                            -- `def_exp` (1) の `W^0 := I`
      _ = W := Matrix.one_mul _                                -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = (B * V2) * B := hW                                   -- 準備 1（`def_symmetrized_transfer_matrix`）
      _ = ((B * 1) * V2) * B := by rw [Matrix.mul_one]         -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = ((B * (V2 * V1) ^ 0) * V2) * B := by rw [pow_zero]   -- `def_exp` (1) の `(V_2V_1)^0 := I`
  | succ k ih =>
    obtain ⟨C, hC⟩ : ∃ C : Matrix n n ℂ, C = B * (V2 * V1) ^ k := ⟨_, rfl⟩
    calc W ^ (k + 1 + 1)
        = W ^ (k + 1) * W := pow_succ _ _                      -- `def_exp` (1) の `W^{(k+1)+1} := W^{k+1}W`
      _ = (((B * (V2 * V1) ^ k) * V2) * B) * W := by rw [ih]   -- 帰納法の仮定
      _ = ((C * V2) * B) * W := by rw [hC]                     -- `C` の置き方
      _ = ((C * V2) * B) * ((B * V2) * B) := by rw [hW]        -- 準備 1（`def_symmetrized_transfer_matrix`）
      _ = (((C * V2) * B) * (B * V2)) * B :=
          (Matrix.mul_assoc _ _ _).symm                        -- `mat_mult_associative`
      _ = ((((C * V2) * B) * B) * V2) * B := by
          rw [← Matrix.mul_assoc ((C * V2) * B) B V2]          -- `mat_mult_associative`
      _ = (((C * V2) * (B * B)) * V2) * B := by
          rw [Matrix.mul_assoc (C * V2) B B]                   -- `mat_mult_associative`
      _ = (((C * V2) * V1) * V2) * B := by rw [hBB]            -- 準備 1（`def_transfer_matrix_square_root`）
      _ = ((C * (V2 * V1)) * V2) * B := by
          rw [Matrix.mul_assoc C V2 V1]                        -- `mat_mult_associative`
      _ = (((B * (V2 * V1) ^ k) * (V2 * V1)) * V2) * B := by rw [hC] -- `C` の置き方
      _ = ((B * ((V2 * V1) ^ k * (V2 * V1))) * V2) * B := by
          rw [Matrix.mul_assoc B ((V2 * V1) ^ k) (V2 * V1)]   -- `mat_mult_associative`
      _ = ((B * (V2 * V1) ^ (k + 1)) * V2) * B := by rw [← pow_succ] -- `def_exp` (1) の `(V_2V_1)^{k+1} := (V_2V_1)^k(V_2V_1)`

/-- **人手 `Z_equals_trace_of_W` の本体**: `n ∈ ℤ_{≥1}` について `tr((V_1V_2)^n) = tr(W^n)`。
`k := n - 1` と置いて（`k + 1 = n`）、人手の 6 行と同じ段の calc で示す。`B * B = V₁`（準備 1）だけを仮定する。 -/
theorem trace_mul_pow_eq_trace_symmetrized_pow {B V1 V2 W : Matrix n n ℂ} (hBB : B * B = V1)
    (hW : W = (B * V2) * B) (N : ℕ) (hN : 1 ≤ N) :
    ((V1 * V2) ^ N).trace = (W ^ N).trace := by
  obtain ⟨k, rfl⟩ : ∃ k, N = k + 1 := ⟨N - 1, by omega⟩
  calc ((V1 * V2) ^ (k + 1)).trace
      = ((V1 * (V2 * V1) ^ k) * V2).trace := by
        rw [open_product_pow]                                  -- 準備 2 を `X := V_1`、`Y := V_2` に適用
    _ = (((B * B) * (V2 * V1) ^ k) * V2).trace := by rw [hBB]  -- 準備 1
    _ = ((B * (B * (V2 * V1) ^ k)) * V2).trace := by
        rw [Matrix.mul_assoc B B]                              -- `mat_mult_associative`
    _ = (B * ((B * (V2 * V1) ^ k) * V2)).trace := by
        rw [Matrix.mul_assoc B (B * (V2 * V1) ^ k) V2]         -- `mat_mult_associative`
    _ = (((B * (V2 * V1) ^ k) * V2) * B).trace :=
        trace_cyclic _ _                                       -- `trace_basic_properties` (2)（左の因子 `B`、右の因子 `(B(V_2V_1)^k)V_2`）
    _ = (W ^ (k + 1)).trace := by
        rw [symmetrized_pow_succ hBB hW]                          -- 準備 3

/-! ## `W` の対称性・正定値性・成分の正値性 -/

/-- `B`, `V₂` が実対称なら `W = B V₂ B` も実対称
（人手証明 `W_is_real_symmetric_positive_definite` の Step 3 の後半）。 -/
theorem symTransfer_isSymm {B V2 : Matrix n n ℝ} (hB : B.IsSymm) (hV2 : V2.IsSymm) :
    (symTransfer B V2).IsSymm := by
  show (B * V2 * B)ᵀ = B * V2 * B
  rw [Matrix.transpose_mul, Matrix.transpose_mul, hB.eq, hV2.eq, Matrix.mul_assoc]

/-- 可逆な行列の `mulVec` は単射。 -/
theorem mulVec_eq_zero_iff_of_isUnit {B : Matrix n n ℝ} (hB : IsUnit B) {x : n → ℝ}
    (hx : B *ᵥ x = 0) : x = 0 := by
  obtain ⟨u, hu⟩ := hB
  have : (↑u⁻¹ : Matrix n n ℝ) *ᵥ (B *ᵥ x) = x := by
    rw [Matrix.mulVec_mulVec, ← hu, ← Units.val_mul]
    simp
  rw [hx, Matrix.mulVec_zero] at this
  exact this.symm

/-- **`W = B V₂ B` は正定値**（人手証明 Step 3 の合同変換）。

`B` は実対称かつ可逆、`V₂` は正定値とする。 -/
theorem symTransfer_posDef {B V2 : Matrix n n ℝ} (hB : B.IsSymm) (hBunit : IsUnit B)
    (hV2 : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ V2 *ᵥ x) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ symTransfer B V2 *ᵥ x := by
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hexp : x ⬝ᵥ symTransfer B V2 *ᵥ x = (B *ᵥ x) ⬝ᵥ V2 *ᵥ (B *ᵥ x) := by
    show x ⬝ᵥ (B * V2 * B) *ᵥ x = (B *ᵥ x) ⬝ᵥ V2 *ᵥ (B *ᵥ x)
    rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
      mulVec_dotProduct_selfadjoint hB x (V2 *ᵥ (B *ᵥ x))]
  rw [hexp]
  exact hV2 _ hBx

/-- **`W` の成分はすべて正**（人手証明 `W_has_positive_entries`）。

`B` が正の成分をもつ対角行列（人手証明の `V₁^{1/2}`）で `V₂` の成分がすべて正なら、
`W = B V₂ B` の成分もすべて正。 -/
theorem symTransfer_entry_pos {d : n → ℝ} {V2 : Matrix n n ℝ} (hd : ∀ i, 0 < d i)
    (hV2 : ∀ i j, 0 < V2 i j) (i j : n) :
    0 < symTransfer (diagonal d) V2 i j := by
  have hval : symTransfer (diagonal d) V2 i j = d i * V2 i j * d j := by
    show ((diagonal d) * V2 * (diagonal d)) i j = d i * V2 i j * d j
    rw [Matrix.mul_assoc, Matrix.diagonal_mul, Matrix.mul_diagonal, mul_assoc]
  rw [hval]
  exact mul_pos (mul_pos (hd i) (hV2 i j)) (hd j)

/-! ## 正の対角行列としての `V₁^{1/2}` -/

/-- 対角行列の指数関数 `exp(diagonal d) = diagonal (exp ∘ d)`。

人手証明の `V₁^{1/2} = exp((1/2)K₁D)` は、`D` が対角（章 009 の `sigma_z_diagonal_action`）
なのでこの形になる。 -/
noncomputable def diagExp (d : n → ℝ) : Matrix n n ℝ := diagonal (fun i => Real.exp (d i))

theorem diagExp_isSymm (d : n → ℝ) : (diagExp d).IsSymm := Matrix.isSymm_diagonal _

theorem diagExp_entry_pos (d : n → ℝ) (i : n) : 0 < Real.exp (d i) := Real.exp_pos _

/-- **`V₁^{1/2} V₁^{1/2} = V₁`**（人手証明 `def_transfer_matrix_square_root` の平方根の意味）。 -/
theorem diagExp_mul_self (d : n → ℝ) :
    diagExp d * diagExp d = diagExp (fun i => 2 * d i) := by
  simp only [diagExp, Matrix.diagonal_mul_diagonal]
  congr 1
  funext i
  rw [← Real.exp_add]
  ring_nf

theorem diagExp_isUnit (d : n → ℝ) : IsUnit (diagExp d) := by
  rw [Matrix.isUnit_iff_isUnit_det]
  simp only [diagExp, Matrix.det_diagonal]
  exact isUnit_iff_ne_zero.mpr (Finset.prod_pos fun i _ => Real.exp_pos (d i)).ne'

theorem diagExp_posDef (d : n → ℝ) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ diagExp d *ᵥ x := by
  set B := diagExp (fun i => d i / 2) with hBdef
  have hhalf : (fun i => 2 * (d i / 2)) = d := by
    funext i
    ring
  have hfac : diagExp d = B * B := by
    rw [hBdef, diagExp_mul_self, hhalf]
  have hBsymm : B.IsSymm := diagExp_isSymm _
  have hBunit : IsUnit B := diagExp_isUnit _
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hval : x ⬝ᵥ diagExp d *ᵥ x = vecNormSq (B *ᵥ x) := by
    rw [hfac, ← Matrix.mulVec_mulVec, mulVec_dotProduct_selfadjoint hBsymm x (B *ᵥ x)]
    rfl
  rw [hval]
  exact vecNormSq_pos hBx

/-! ## 実対称行列の指数関数は実対称正定値（章 009 の `exp_hermitian_is_positive_definite` の実版） -/

/-- 実対称行列の指数関数は実対称。 -/
theorem matExp_isSymm {S : Matrix n n ℝ} (hS : S.IsSymm) :
    (NormedSpace.exp S).IsSymm := Matrix.IsSymm.exp hS

/-- 実対称行列の指数関数は正定値。

人手証明 `W_is_real_symmetric_positive_definite` の Step 2 が引用している
`exp_hermitian_is_positive_definite` の実行列版。
`exp(S) = exp(S/2)exp(S/2)` と `exp(S/2)` の対称性・可逆性だけから従う。 -/
theorem matExp_posDef {S : Matrix n n ℝ} (hS : S.IsSymm) (x : n → ℝ) (hx : x ≠ 0) :
    0 < x ⬝ᵥ NormedSpace.exp S *ᵥ x := by
  set B := NormedSpace.exp ((1 / 2 : ℝ) • S) with hBdef
  have hhalf : NormedSpace.exp S = B * B := by
    have hcomm : Commute ((1 / 2 : ℝ) • S) ((1 / 2 : ℝ) • S) := Commute.refl _
    rw [hBdef, ← Matrix.exp_add_of_commute _ _ hcomm]
    congr 1
    rw [← add_smul]
    norm_num
  have hBsymm : B.IsSymm := by
    refine Matrix.IsSymm.exp ?_
    show ((1 / 2 : ℝ) • S)ᵀ = (1 / 2 : ℝ) • S
    rw [Matrix.transpose_smul, hS.eq]
  have hBunit : IsUnit B := Matrix.isUnit_exp _
  have hBx : B *ᵥ x ≠ 0 := fun h => hx (mulVec_eq_zero_iff_of_isUnit hBunit h)
  have hval : x ⬝ᵥ NormedSpace.exp S *ᵥ x = vecNormSq (B *ᵥ x) := by
    rw [hhalf, ← Matrix.mulVec_mulVec, mulVec_dotProduct_selfadjoint hBsymm x (B *ᵥ x)]
    rfl
  rw [hval]
  exact vecNormSq_pos hBx

end Ising2D
