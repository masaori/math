/-
# 章 011「転送行列の最大固有値と分配関数の挟み撃ち」— 共通の道具

正本: `structured-latex/content/011_max_eigenvalue.ts`

この章は実行列 `W ∈ Mat(2^M, ℝ)` と実ベクトル空間 `ℝ^{2^M}` の上での議論なので、
`TensorPow M = Matrix (Conf M) (Conf M) ℂ` ではなく実行列
`Matrix n n ℝ`（`n` は有限添字型。Ising の場合は `n = Conf M`、`Fintype.card n = 2^M`）
を土台にする。

ここでは以下を用意する。

* `Ising2D.matBilin A` — 実行列が定める双線型形式 `(x, y) ↦ xᵀ A y`
* `Ising2D.vecNormSq` / `Ising2D.vecNorm` — `‖x‖²` と `‖x‖`
  （`n → ℝ` に mathlib が入れている既定のノルムは sup ノルムなので、
  ユークリッドノルムは自前で定義する）
* 抽象版（`Ising2D/Abstract/RayleighMoments.lean`）の
  `IsPsdPair` / `IsPdPair` を実対称（半）正定値行列から作る橋渡し

## 他章への依存について

この章の `W` は章 010 の `V_1`, `V_2` から作られるが、章 010 の Lean 形式化は
本タスクの担当外なので、**`W` の作り方によらない部分（`Part011` の主要な不等式）は
`W : Matrix n n ℝ` とその対称性・正定値性だけを仮定して述べる**。
`W = V_1^{1/2} V_2 V_1^{1/2}` という具体形は
`Ising2D/Part011/Definition001_SymmetrizedTransferMatrix.lean` で扱う。
-/
import Ising2D.Abstract.RayleighMoments
import Mathlib.LinearAlgebra.Matrix.Symmetric
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Sqrt

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## 実行列が定める双線型形式 -/

/-- 実行列 `A` が定める双線型形式 `(x, y) ↦ xᵀ A y`。 -/
def matBilin (A : Matrix n n ℝ) : (n → ℝ) →ₗ[ℝ] (n → ℝ) →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ (fun x y => x ⬝ᵥ A *ᵥ y)
    (fun _ _ _ => by simp [add_dotProduct])
    (fun _ _ _ => by simp [smul_dotProduct])
    (fun _ _ _ => by simp [Matrix.mulVec_add, dotProduct_add])
    (fun _ _ _ => by simp [Matrix.mulVec_smul, dotProduct_smul])

@[simp]
theorem matBilin_apply (A : Matrix n n ℝ) (x y : n → ℝ) :
    matBilin A x y = x ⬝ᵥ A *ᵥ y := rfl

@[simp]
theorem matBilin_one_apply (x y : n → ℝ) :
    matBilin (1 : Matrix n n ℝ) x y = x ⬝ᵥ y := by
  simp [matBilin]

/-- 対称行列に対する `xᵀ A y = yᵀ A x`。 -/
theorem dotProduct_mulVec_comm {A : Matrix n n ℝ} (hA : A.IsSymm) (x y : n → ℝ) :
    x ⬝ᵥ A *ᵥ y = y ⬝ᵥ A *ᵥ x := by
  have hAt : Aᵀ = A := hA.eq
  have hvm : x ᵥ* A = A *ᵥ x := by
    conv_lhs => rw [← hAt]
    exact Matrix.vecMul_transpose A x
  rw [Matrix.dotProduct_mulVec, hvm, dotProduct_comm]

/-- 対称行列に対する自己共役性 `(A x)ᵀ y = xᵀ (A y)`。 -/
theorem mulVec_dotProduct_selfadjoint {A : Matrix n n ℝ} (hA : A.IsSymm) (x y : n → ℝ) :
    x ⬝ᵥ A *ᵥ y = (A *ᵥ x) ⬝ᵥ y := by
  have hAt : Aᵀ = A := hA.eq
  have hvm : x ᵥ* A = A *ᵥ x := by
    conv_lhs => rw [← hAt]
    exact Matrix.vecMul_transpose A x
  rw [Matrix.dotProduct_mulVec, hvm]

/-- 標準基底ベクトルによる成分の取り出し `e_iᵀ A e_j = A_ij`。 -/
theorem single_dotProduct_mulVec_single (A : Matrix n n ℝ) (i j : n) :
    (Pi.single i (1 : ℝ)) ⬝ᵥ A *ᵥ (Pi.single j (1 : ℝ)) = A i j := by
  simp [Matrix.mulVec_single_one, single_one_dotProduct]

/-! ## ユークリッドノルム -/

/-- `‖x‖² = xᵀx`。 -/
def vecNormSq (x : n → ℝ) : ℝ := x ⬝ᵥ x

/-- `‖x‖ = √(xᵀx)`。 -/
noncomputable def vecNorm (x : n → ℝ) : ℝ := Real.sqrt (vecNormSq x)

theorem vecNormSq_eq_sum (x : n → ℝ) : vecNormSq x = ∑ i, x i ^ 2 := by
  simp [vecNormSq, dotProduct, sq]

theorem vecNormSq_nonneg (x : n → ℝ) : 0 ≤ vecNormSq x := by
  rw [vecNormSq_eq_sum]
  exact Finset.sum_nonneg fun i _ => sq_nonneg _

theorem vecNormSq_eq_zero_iff {x : n → ℝ} : vecNormSq x = 0 ↔ x = 0 := by
  rw [vecNormSq_eq_sum]
  constructor
  · intro h
    funext i
    have := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (x j))).mp h i
      (Finset.mem_univ i)
    simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  · rintro rfl
    simp

theorem vecNormSq_pos {x : n → ℝ} (hx : x ≠ 0) : 0 < vecNormSq x :=
  lt_of_le_of_ne (vecNormSq_nonneg x) (fun h => hx (vecNormSq_eq_zero_iff.mp h.symm))

theorem vecNormSq_smul (c : ℝ) (x : n → ℝ) :
    vecNormSq (c • x) = c ^ 2 * vecNormSq x := by
  simp [vecNormSq_eq_sum, Finset.mul_sum, mul_pow]

/-- 標準基底ベクトルは単位ベクトル。 -/
theorem vecNormSq_single (i : n) : vecNormSq (Pi.single i (1 : ℝ)) = 1 := by
  simp [vecNormSq]

theorem vecNorm_nonneg (x : n → ℝ) : 0 ≤ vecNorm x := Real.sqrt_nonneg _

theorem vecNorm_sq (x : n → ℝ) : vecNorm x ^ 2 = vecNormSq x :=
  Real.sq_sqrt (vecNormSq_nonneg x)

/-! ## 行列の冪と線型写像の冪 -/

/-- `A^k` の定める線型写像は `A` の定める線型写像の `k` 乗。 -/
theorem mulVecLin_pow (A : Matrix n n ℝ) (k : ℕ) :
    (A ^ k).mulVecLin = A.mulVecLin ^ k := by
  induction k with
  | zero => ext x i; simp
  | succ k ih =>
      rw [pow_succ, pow_succ, Matrix.mulVecLin_mul, ih]
      rfl

theorem mulVecLin_pow_apply (A : Matrix n n ℝ) (k : ℕ) (x : n → ℝ) :
    (A.mulVecLin ^ k) x = A ^ k *ᵥ x := by
  rw [← mulVecLin_pow]
  rfl

/-! ## 抽象版への橋渡し -/

/-- 実対称半正定値行列から抽象版の `IsPsdPair` を作る。 -/
theorem isPsdPair_of_matrix {A : Matrix n n ℝ} (hA : A.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ A *ᵥ x) :
    Abstract.IsPsdPair (matBilin (1 : Matrix n n ℝ)) A.mulVecLin where
  ip_symm := by intro u v; simp [dotProduct_comm]
  ip_psd := by
    intro u
    simpa [vecNormSq] using vecNormSq_nonneg u
  W_selfadjoint := by
    intro u v
    simp only [matBilin_one_apply, Matrix.mulVecLin_apply]
    rw [dotProduct_comm (A *ᵥ u) v]
    exact dotProduct_mulVec_comm hA u v
  W_psd := by
    intro u
    simpa using hpsd u

/-- 実対称正定値行列から抽象版の `IsPdPair` を作る。 -/
theorem isPdPair_of_matrix {A : Matrix n n ℝ} (hA : A.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ A *ᵥ x) :
    Abstract.IsPdPair (matBilin (1 : Matrix n n ℝ)) A.mulVecLin where
  toIsPsdPair := isPsdPair_of_matrix hA (by
    intro x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · exact (hpd x hx).le)
  ip_pos := by
    intro u hu
    simpa [vecNormSq] using vecNormSq_pos hu
  W_pos := by
    intro u hu
    simpa using hpd u hu

end Ising2D
