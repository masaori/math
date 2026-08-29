/-
必要十分版: 可換環 R 上の有限正方行列 A について、det(I - X C(A)) の定数項が 1 であることを示す。

人手証明と同じ経路（置換展開）を使う。
  定数項 = 0 での評価（係数の有限和のうち k=0 だけが残る）
  行列式を置換展開で開く
  評価は有限和・有限積を保つので項ごとに通す
  成分の 0 での値は対角 1・非対角 0
  恒等置換の項だけが残り、符号 1・全因子 1 で値は 1

可換環を仮定するのは行列式を定めるためである。体・順序・代数閉性は使わない。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Algebra.Polynomial.Eval.Coeff

namespace Ising2DLambda.NecSuf.KacWard

open Matrix Polynomial Equiv

/-- `det(I - X C(A))` の定数項は 1。人手証明の置換展開と同じ経路で示す。 -/
theorem det_one_sub_X_mul_coeff_zero {R : Type} [CommRing R]
    {ι : Type} [Fintype ι] [DecidableEq ι] (A : Matrix ι ι R) :
    (Matrix.det ((1 : Matrix ι ι (Polynomial R)) -
      (Polynomial.X : Polynomial R) • A.map Polynomial.C)).coeff 0 = 1 := by
  classical
  set B : Matrix ι ι (Polynomial R) :=
    1 - (Polynomial.X : Polynomial R) • A.map Polynomial.C with hB
  -- 人手証明: 定数項は 0 での評価（係数の有限和のうち k=0 の項だけが残る）
  rw [Polynomial.coeff_zero_eq_eval_zero]
  -- 人手証明: 行列式の置換展開
  rw [Matrix.det_apply']
  -- 人手証明: 評価は有限和を保つ
  rw [Polynomial.eval_finsetSum]
  -- 人手証明: 恒等置換の項だけが残る
  rw [Finset.sum_eq_single (1 : Equiv.Perm ι)]
  · -- 恒等置換の項: 符号 1、全因子の 0 での値は 1
    simp [B, Polynomial.eval_prod]
  · -- 非恒等置換の項: 動く点の因子が 0 になる
    intro σ _ hσ
    obtain ⟨i, hi⟩ : ∃ i, σ i ≠ i := by
      by_contra h
      push Not at h
      exact hσ (Equiv.ext h)
    rw [Polynomial.eval_mul, Polynomial.eval_prod]
    have hzero : Polynomial.eval (0 : R) (B (σ i) i) = 0 := by
      simp [B, hi]
    rw [Finset.prod_eq_zero (Finset.mem_univ i) hzero, mul_zero]
  · -- 恒等置換は必ず和の添字に入っている
    intro h
    exact absurd (Finset.mem_univ (1 : Equiv.Perm ι)) h

end Ising2DLambda.NecSuf.KacWard
