/-
章「トーラス上の Kac--Ward 行列式」の「四つの Kac--Ward 行列式の定数項は一である」
（`claim_kac_ward_determinant_constant_term_one`）の具体版。

人手証明                                      このファイル
Qbar[x] 成分の有限行列                         `QbarPolynomialMatrix`
K(x) = I - x C(M)（成分ごとの定義）            `kacWardPolynomialMatrix`
D(x) = det K(x)                              `kacWardDeterminant`
定数項 = 0 での評価（k=0 の項だけが残る）      `Polynomial.coeff_zero_eq_eval_zero`
行列式の置換展開                              `Matrix.det_apply'`
評価は有限和を保つ                            `Polynomial.eval_finsetSum`
評価は有限積を保つ・符号の定数は値へ戻る       `Polynomial.eval_mul`・`Polynomial.eval_prod`・`Polynomial.eval_intCast`
成分の 0 での値は対角 1・非対角 0             成分ごとの同じ計算（simp の場合分け）
恒等置換の項だけが残る                        `Finset.sum_eq_single`

添字集合を向き付き辺に特殊化し、M を四つの遷移行列に取れば本文の四つの主張を得る。
住処は Qbar と Qbar[x] であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Ising2DLambda.NecSuf.KacWard.DeterminantConstantTerm
import Mathlib.LinearAlgebra.Matrix.Polynomial

namespace Ising2DLambda.KacWard

open Matrix Polynomial Equiv Ising2DLambda.AlgebraicEigenvalue

/-- 本文の `Mat_J(Qbar[x])`。 -/
abbrev QbarPolynomialMatrix (ι : Type) := Matrix ι ι QbarPoly

/-- 本文の `K(x) = I - x M`（成分ごとの定義）。 -/
noncomputable def kacWardPolynomialMatrix {ι : Type} [DecidableEq ι]
    (M : Matrix ι ι Qbar) : QbarPolynomialMatrix ι :=
  1 - (Polynomial.X : QbarPoly) • M.map Polynomial.C

/-- 本文の `D(x) = det K(x)`。 -/
noncomputable def kacWardDeterminant {ι : Type} [Fintype ι] [DecidableEq ι]
    (M : Matrix ι ι Qbar) : QbarPoly :=
  Matrix.det (kacWardPolynomialMatrix M)

/-- 人手証明の置換展開と同じ経路の具体版。 -/
theorem kacWardDeterminant_coeff_zero {ι : Type} [Fintype ι] [DecidableEq ι]
    (M : Matrix ι ι Qbar) : (kacWardDeterminant M).coeff 0 = 1 := by
  classical
  -- 人手証明: 定数項は 0 での評価（係数の有限和のうち k=0 の項だけが残る）
  rw [Polynomial.coeff_zero_eq_eval_zero]
  -- 人手証明: 行列式の置換展開
  rw [kacWardDeterminant, Matrix.det_apply']
  -- 人手証明: 評価は有限和を保つ
  rw [Polynomial.eval_finsetSum]
  -- 人手証明: 恒等置換の項だけが残る
  rw [Finset.sum_eq_single (1 : Equiv.Perm ι)]
  · -- 恒等置換の項: 符号 1、全因子の 0 での値は 1
    simp [kacWardPolynomialMatrix, Polynomial.eval_prod]
  · -- 非恒等置換の項: 動く点の因子が 0 になる
    intro σ _ hσ
    obtain ⟨i, hi⟩ : ∃ i, σ i ≠ i := by
      by_contra h
      push Not at h
      exact hσ (Equiv.ext h)
    rw [Polynomial.eval_mul, Polynomial.eval_prod]
    have hzero :
        Polynomial.eval (0 : Qbar) (kacWardPolynomialMatrix M (σ i) i) = 0 := by
      simp [kacWardPolynomialMatrix, hi]
    rw [Finset.prod_eq_zero (Finset.mem_univ i) hzero, mul_zero]
  · -- 恒等置換は必ず和の添字に入っている
    intro h
    exact absurd (Finset.mem_univ (1 : Equiv.Perm ι)) h

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem kacWardDeterminant_coeff_zero_from_necSuf {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) :
    (kacWardDeterminant M).coeff 0 = 1 := by
  exact Ising2DLambda.NecSuf.KacWard.det_one_sub_X_mul_coeff_zero M

end Ising2DLambda.KacWard
