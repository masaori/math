/-
# 必要十分版: 対合の置換行列と「成分の絶対値を取る」操作

人手の本文で使う箇所（具体版は `Ising2D/Part011/ClaimEpsilonIsRealSymmetric.lean` と
`Ising2D/Part018/Theorem010_OnsagerExactSolution.lean`）:

* **`trace_of_epsilon_V_plus`** の証明 Step 3 の (b)（`ε` は置換行列）
  — `permMat`, `permMat_mulVec`, `permMat_isSymm`, `permMat_mul_self`
* **`onsager_exact_solution`** の証明 Step 3（`u_k := |x_k|` と `uᵀWu ≥ xᵀWx`、`‖u‖ = ‖x‖`）
  — `absVec`, `abs_quad_le_quad_absVec`, `quad_le_quad_absVec`, `vecNormSq_absVec`

## 本質的に効いている構造

1. `ε` が「ある対合 `π : n → n` の置換行列」であること。`ε` が `σ^x_1 ⋯ σ^x_M` であることも、
   `n` が `Conf M = Fin M → Fin 2` であることも効いていない。効くのは `(ε x)_k = x_{π(k)}` だけである。
2. 三角不等式 `|Σ x_k x_l W_{kl}| ≤ Σ |x_k||x_l|W_{kl}` に必要なのは `0 ≤ W_{kl}` だけで、
   狭義の正値性は使っていない。

本ファイルの内容はもと `Ising2D/NecSuf/PermSector.lean`（人手の本文から参照用ノートへ退避した
章 019 の必要十分版）にあった。本文の主張が使う部分だけをここへ移した。
-/
import Ising2D.Part011.Basic

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## 対合の置換行列 -/

/-- 写像 `π : n → n` の置換行列 `(permMat π)_{i j} = δ_{j, π(i)}`（成分は `0` か `1`）。

人手 `trace_of_epsilon_V_plus` の証明 Step 3 の (b)（`ε` は各基底ベクトルを別の基底ベクトルへ写す
置換行列）の必要十分版。 -/
def permMat (π : n → n) : Matrix n n ℝ := fun i j => if j = π i then 1 else 0

theorem permMat_apply (π : n → n) (i j : n) :
    permMat π i j = if j = π i then 1 else 0 := rfl

/-- 成分は `0` か `1` のいずれか。 -/
theorem permMat_entry_zero_or_one (π : n → n) (i j : n) :
    permMat π i j = 0 ∨ permMat π i j = 1 := by
  by_cases h : j = π i
  · exact Or.inr (by rw [permMat_apply, if_pos h])
  · exact Or.inl (by rw [permMat_apply, if_neg h])

/-- 各行の成分の和はちょうど `1`（各行にちょうど 1 個の `1` がある）。 -/
theorem permMat_row_sum (π : n → n) (i : n) : ∑ j, permMat π i j = 1 := by
  simp [permMat_apply]

/-- 置換行列の作用 `(ε x)_k = x_{π(k)}`。 -/
theorem permMat_mulVec (π : n → n) (x : n → ℝ) (i : n) :
    (permMat π *ᵥ x) i = x (π i) := by
  rw [Matrix.mulVec, dotProduct]
  rw [Finset.sum_eq_single (π i)]
  · rw [permMat_apply, if_pos rfl, one_mul]
  · intro j _ hj
    rw [permMat_apply, if_neg hj, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-- 置換行列は基底ベクトルを基底ベクトルへ写す: `ε e_k = e_{π(k)}`。 -/
theorem permMat_mulVec_single (π : n → n) (hπ : Function.Involutive π) (k : n) :
    permMat π *ᵥ (Pi.single k (1 : ℝ)) = Pi.single (π k) 1 := by
  funext i
  rw [permMat_mulVec]
  by_cases h : i = π k
  · rw [h, hπ k, Pi.single_eq_same, Pi.single_eq_same]
  · rw [Pi.single_eq_of_ne (fun hc => h (by rw [← hc, hπ])), Pi.single_eq_of_ne h]

/-- 対合の置換行列は対称。 -/
theorem permMat_isSymm {π : n → n} (hπ : Function.Involutive π) : (permMat π).IsSymm := by
  ext i j
  show permMat π j i = permMat π i j
  rw [permMat_apply, permMat_apply]
  by_cases h : j = π i
  · rw [if_pos h, if_pos (by rw [h, hπ])]
  · rw [if_neg h, if_neg (fun hc => h (by rw [hc, hπ]))]

/-- 対合の置換行列は対合（`ε² = I`）。 -/
theorem permMat_mul_self {π : n → n} (hπ : Function.Involutive π) :
    permMat π * permMat π = 1 := by
  ext i k
  rw [Matrix.mul_apply, Finset.sum_eq_single (π i)]
  · rw [permMat_apply, if_pos rfl, one_mul, permMat_apply, hπ, Matrix.one_apply]
    simp [eq_comm]
  · intro j _ hj
    rw [permMat_apply, if_neg hj, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-! ## 成分ごとの絶対値 -/

/-- 人手証明の `u_k := |x_k|`。 -/
def absVec (x : n → ℝ) : n → ℝ := fun i => |x i|

@[simp] theorem absVec_apply (x : n → ℝ) (i : n) : absVec x i = |x i| := rfl

/-- `‖u‖ = ‖x‖`（`u_k := |x_k|`。ノルムは成分の絶対値だけで決まる。ここでは `‖·‖²` の形で述べる）。 -/
theorem vecNormSq_absVec (x : n → ℝ) : vecNormSq (absVec x) = vecNormSq x := by
  rw [vecNormSq_eq_sum, vecNormSq_eq_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [absVec_apply, sq_abs]

/-- 二次形式の成分表示 `xᵀWx = Σ_k Σ_l x_k W_{kl} x_l`。 -/
theorem quad_eq_sum (W : Matrix n n ℝ) (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x = ∑ k, ∑ l, x k * W k l * x l := by
  rw [dotProduct]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Matrix.mulVec, dotProduct, Finset.mul_sum]
  exact Finset.sum_congr rfl fun l _ => by ring

/-- **人手 `onsager_exact_solution` Step 3 の三角不等式の必要十分版**
`uᵀWu ≥ |xᵀWx| ≥ xᵀWx`（`u_k := |x_k|`）。

**仮定は `0 ≤ W_{kl}` だけ**（人手証明が引く `W_has_positive_entries` の狭義の正値性は不要）。 -/
theorem abs_quad_le_quad_absVec {W : Matrix n n ℝ} (hW : ∀ k l, 0 ≤ W k l) (x : n → ℝ) :
    |x ⬝ᵥ W *ᵥ x| ≤ absVec x ⬝ᵥ W *ᵥ absVec x := by
  rw [quad_eq_sum, quad_eq_sum]
  calc |∑ k, ∑ l, x k * W k l * x l|
      ≤ ∑ k, |∑ l, x k * W k l * x l| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ k, ∑ l, |x k * W k l * x l| :=
        Finset.sum_le_sum fun k _ => Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k, ∑ l, absVec x k * W k l * absVec x l := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
        rw [abs_mul, abs_mul, abs_of_nonneg (hW k l)]
        rfl

theorem quad_le_quad_absVec {W : Matrix n n ℝ} (hW : ∀ k l, 0 ≤ W k l) (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ absVec x ⬝ᵥ W *ᵥ absVec x :=
  le_trans (le_abs_self _) (abs_quad_le_quad_absVec hW x)

end Ising2D.NecSuf
