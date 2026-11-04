/-
# 符号の反転則の Step 1 と Step 3 の前半（数ベクトルの上の必要十分版）

人手のラベル: **`epsilon_eigenvalue_on_check_Q`** (2)
（正本 `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean` の
`CheckFermi.nOp_mulVec_generator_eq_zero`・`ann_mulVec_cre_mulVec_generator`・`cre_mulVec_generator_ne_zero`・
`epsilon_mulVec_cre_mulVec_generator` で、各定理の calc は具体版と同じ行である。

人手の (2) は `im Q̌_ε` の `0` でない元 `q`（`Q̌_ε q = q`、`εq = η_ε q`）の上で計算する。
行列 `ψ̌_μ^† Q̌_ε` の上で同じ結論を出す必要十分版 `NecSuf.cre_mul_projOn_ne_zero`（`NecSuf/ParityFermion.lean`）は
人手と手順が違う（数ベクトルを使わない）ので、人手の鎖と同じ手順の必要十分版を本ファイルに置く。

## 何が効いているか / 効いていないか

- **Step 1 の `ň_μ q = 0`**（`num_mulVec_eq_zero_of_fixed`）に効いているのは、`Q q = q`、`n Q = s Q`、`s = 0` と、
  行列の積と数ベクトルへの作用の結合則、零のスカラー倍が零行列であること（スカラーの側は `0 • x = 0` だけ）、零行列が数ベクトルを `0` へ送ることだけである。
  係数は `NonUnitalSemiring`（結合則に要る。単位元・符号反転・可換則は使わない）。スカラー `s` は係数と別の集合 `S` の元でよく、`S` に要るのは `0` と `R` への作用だけである。
- **Step 1 の `ψ̌_{M+1−μ}(ψ̌_μ^† q) = q`**（`ann_mulVec_cre_mulVec_eq_of_num_mulVec_eq_zero`）に効いているのは、
  `a c = I − n`、`n q = 0` と、結合則・差の作用の分配・単位行列の作用・`v − 0 = v` だけである。
  係数は `Ring`（単位行列と差に要る。可換則は使わない）。`n` が `c a` であることも、`n` の冪等性も効いていない。
- **Step 1 の結論 `ψ̌_μ^† q ≠ 0`**（`cre_mulVec_ne_zero_of_ann_mulVec_cre_mulVec_eq`）は、行列が `0` を `0` へ送ることだけ
  （`NonUnitalNonAssocSemiring`）である。
- **Step 3 の前半 `ε(ψ̌_μ^† q) = (−η)(ψ̌_μ^† q)`**（`mulVec_cre_mulVec_eq_neg_smul_of_anticomm`）に効いているのは、
  `e c = −(c e)`、`e q = η q` と、結合則・符号反転が左の因子から外へ出ること・スカラー倍が右の因子から外へ出ること・
  `−v = (−1)v`・スカラー倍の結合則・`(−1)η = −η` だけである。係数 `R` は `NonUnitalRing`（可換則も単位元も使わない）。
  スカラー `η` は係数と別の環 `S` の元でよく（`S` の可換則も使わない）、効いているのは `η` 倍が成分の積の左の因子を越えて外へ出ること
  （`x(ηy) = η(xy)`。`SMulCommClass S R R`。`A(ηv) = η(Av)` の行に要る）だけで、`(ηx)y = η(xy)`（`IsScalarTower`）は使わない。
- どの定理でも、添字の集合が `Conf M` であること、係数が `ℂ` であること、`ψ̌` が `Ž, Y̌` の 1 次結合であること、
  `ε` が `σ^x` の積であること、`im Q̌_ε` が 1 次元であることは効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Ising2D.NecSuf.ZeroSmulAndAddCommMatrix
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference

namespace Ising2D.NecSuf

open Matrix

variable {ι : Type*} [Fintype ι]

section StepOneNumber

variable {R : Type*} [NonUnitalSemiring R] {S : Type*} [Zero S] [SMul S R]

/-- **`n q = 0`**（人手 (2) Step 1 の 6 行の鎖。具体版 `CheckFermi.nOp_mulVec_generator_eq_zero`）。
`hz` はスカラーの側の `0 • x = 0`（零のスカラー倍が零行列であることの成分）である。 -/
theorem num_mulVec_eq_zero_of_fixed (hz : ∀ x : R, (0 : S) • x = 0) {n Q : Matrix ι ι R} {q : ι → R}
    {s : S} (hqfix : Q *ᵥ q = q) (hnQ : n * Q = s • Q) (hs : s = 0) : n *ᵥ q = 0 :=
  calc n *ᵥ q
      = n *ᵥ (Q *ᵥ q) := by rw [hqfix]                  -- `Q̌_ε q = q`
    _ = (n * Q) *ᵥ q := Matrix.mulVec_mulVec _ _ _       -- `mat_mult_associative`
    _ = (s • Q) *ᵥ q := by rw [hnQ]                     -- `check_joint_eigenspace_decomposition` (3)
    _ = ((0 : S) • Q) *ᵥ q := by rw [hs]                -- `ε_μ = 0`
    _ = (0 : Matrix ι ι R) *ᵥ q := by rw [zero_smul_matrix' hz Q]
                                                        -- `zero_scalar_multiple_is_zero_matrix`
    _ = 0 := Matrix.zero_mulVec q                       -- `zero_matrix_is_left_zero_of_mat_mult`

end StepOneNumber

section StepOneAnn

variable [DecidableEq ι] {R : Type*} [Ring R]

/-- **`a(c q) = q`**（人手 (2) Step 1 の 6 行の鎖。具体版 `CheckFermi.ann_mulVec_cre_mulVec_generator`）。 -/
theorem ann_mulVec_cre_mulVec_eq_of_num_mulVec_eq_zero {a c n : Matrix ι ι R} {q : ι → R}
    (hac : a * c = 1 - n) (hn : n *ᵥ q = 0) : a *ᵥ (c *ᵥ q) = q :=
  calc a *ᵥ (c *ᵥ q)
      = (a * c) *ᵥ q := Matrix.mulVec_mulVec _ _ _       -- `mat_mult_associative`
    _ = (1 - n) *ᵥ q := by rw [hac]                     -- `check_number_operator_idempotent` (2)
    _ = (1 : Matrix ι ι R) *ᵥ q - n *ᵥ q := (sub_mulVec_eq' _ _ _).symm
                                                        -- `matrix_difference_mul_vector`
    _ = q - n *ᵥ q := by rw [one_mulVec_eq]             -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = q - 0 := by rw [hn]                             -- 上の `n q = 0`
    _ = q := sub_zero q                                 -- `matrix_minus_zero_matrix`

end StepOneAnn

section StepOneNeZero

variable {R : Type*} [NonUnitalNonAssocSemiring R]

/-- **`c q ≠ 0`**（人手 (2) Step 1 の背理法の 3 行の鎖。具体版 `CheckFermi.cre_mulVec_generator_ne_zero`）。 -/
theorem cre_mulVec_ne_zero_of_ann_mulVec_cre_mulVec_eq {a c : Matrix ι ι R} {q : ι → R}
    (h : a *ᵥ (c *ᵥ q) = q) (hq0 : q ≠ 0) : c *ᵥ q ≠ 0 := by
  intro h0                                              -- 仮に `c q = 0` とする
  apply hq0
  calc q
      = a *ᵥ (c *ᵥ q) := h.symm                         -- 上の式変形
    _ = a *ᵥ 0 := by rw [h0]                            -- 仮定 `c q = 0`
    _ = 0 := Matrix.mulVec_zero a                       -- `zero_matrix_is_right_zero_of_mat_mult`

end StepOneNeZero

section StepThree

variable {R : Type*} [NonUnitalRing R] {S : Type*} [Ring S] [Module S R] [SMulCommClass S R R]

/-- **`e(c q) = (−η)(c q)`**（人手 (2) Step 3 の 9 行の鎖。具体版 `CheckFermi.epsilon_mulVec_cre_mulVec_generator`）。 -/
theorem mulVec_cre_mulVec_eq_neg_smul_of_anticomm {e c : Matrix ι ι R} {q : ι → R} {η : S}
    (hec : e * c = -(c * e)) (heq : e *ᵥ q = η • q) : e *ᵥ (c *ᵥ q) = (-η) • (c *ᵥ q) :=
  calc e *ᵥ (c *ᵥ q)
      = (e * c) *ᵥ q := Matrix.mulVec_mulVec _ _ _       -- `mat_mult_associative`
    _ = (-(c * e)) *ᵥ q := by rw [hec]                  -- `epsilon_anticommutes_with_check_Z_Y` (3)
    _ = -((c * e) *ᵥ q) := Matrix.neg_mulVec _ _        -- `negation_factors_out_of_left_factor`
    _ = -(c *ᵥ (e *ᵥ q)) := by rw [Matrix.mulVec_mulVec] -- `mat_mult_associative`
    _ = -(c *ᵥ (η • q)) := by rw [heq]                  -- `εq = η_ε q`
    _ = -(η • (c *ᵥ q)) := by rw [Matrix.mulVec_smul]   -- `scalar_multiple_factors_out_of_right_factor`
    _ = (-1 : S) • (η • (c *ᵥ q)) := (neg_one_smul S _).symm
                                                        -- `negation_is_scalar_multiple_by_minus_one`
    _ = ((-1 : S) * η) • (c *ᵥ q) := smul_smul _ _ _    -- `scalar_multiple_is_associative`
    _ = (-η) • (c *ᵥ q) := by rw [neg_one_mul]          -- `multiply_by_minus_one`

end StepThree

end Ising2D.NecSuf
