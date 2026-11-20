/-
節「一次因子の積の根」の具体版。
人手証明の正本は `claim_qbar_linear_factor_product_root_is_listed_root` である。

  人手証明                                                 このファイル
  第一の式鎖の第三・第四・第五の等号（aev_z は積・和・逆元を保ち、
    aev_z(t) = z、aev_z(â) = a）                            `qbarPolyEvalLinearFactorProduct`
    （`def_qbar_poly_evaluation` の約束。`qbarPolyEval_eq_eval` で mathlib の評価へ移して引く）
  `claim_qbar_prod_eq_zero` を s = {r | r < N}、c_r = z - β(r) へ当てる   `exists_eq_zero_of_prod_eq_zero`
  第二の式鎖（z = (z - β(r₀)) + β(r₀) = 0 + β(r₀) = β(r₀)）              本体の calc

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow
import Ising2DLambda.AlgebraicEigenvalue.QbarProdZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

/-- 第一の式鎖。`aev_z(∏_{r<N}(t - β̂(r))) = ∏_{r<N}(z - β(r))`。 -/
theorem qbarPolyEvalLinearFactorProduct (N : ℕ) (β : ℕ → Qbar) (z : Qbar) :
    qbarPolyEval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r)))
      = ∏ r ∈ Finset.range N, (z - β r) := by
  calc
    qbarPolyEval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r)))
        = Polynomial.eval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) :=
          qbarPolyEval_eq_eval z _
    _ = ∏ r ∈ Finset.range N, Polynomial.eval z (Polynomial.X - qbarConst (β r)) := by
          -- 第三の等号: aev_z は積と単位元を保つ。
          rw [Polynomial.eval_prod]
    _ = ∏ r ∈ Finset.range N,
          (Polynomial.eval z Polynomial.X - Polynomial.eval z (qbarConst (β r))) := by
          -- 第四の等号: aev_z は和と加法の逆元を保つ。
          refine Finset.prod_congr rfl (fun r _ => ?_)
          rw [Polynomial.eval_sub]
    _ = ∏ r ∈ Finset.range N, (z - β r) := by
          -- 第五の等号: aev_z(t) = z と aev_z(â) = a。
          refine Finset.prod_congr rfl (fun r _ => ?_)
          rw [Polynomial.eval_X, qbarConst, Polynomial.eval_C]

/-- `claim_qbar_linear_factor_product_root_is_listed_root` の具体版。
`aev_z(∏_{r<N}(t - β̂(r))) = 0` なら、ある `r < N` で `z = β(r)`。 -/
theorem qbarLinearFactorProductRootIsListedRoot (N : ℕ) (β : ℕ → Qbar) (z : Qbar)
    (h : qbarPolyEval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) = 0) :
    ∃ r : ℕ, r < N ∧ z = β r := by
  have hprod : (∏ r ∈ Finset.range N, (z - β r)) = 0 := by
    rw [← qbarPolyEvalLinearFactorProduct N β z]
    exact h
  -- claim_qbar_prod_eq_zero を s = {r | r < N}、c_r = z - β(r) へ当てる。
  obtain ⟨r₀, hr₀, hzero⟩ := exists_eq_zero_of_prod_eq_zero (fun r => z - β r) _ hprod
  refine ⟨r₀, Finset.mem_range.mp hr₀, ?_⟩
  calc
    z = (z - β r₀) + β r₀ := by
          -- 第一の等号: 加法の結合則と逆元。
          rw [sub_add_cancel]
    _ = 0 + β r₀ := by
          -- 第二の等号: z - β(r₀) = 0。
          rw [show z - β r₀ = 0 from hzero]
    _ = β r₀ := by
          -- 第三の等号: 0 は加法の単位元。
          rw [zero_add]

end Ising2DLambda.FisherZero
