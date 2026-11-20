/-
節「最高次の係数が一の多項式の一次因子への分解」の具体版。
人手証明の正本は `claim_qbar_monic_polynomial_linear_factor_product` である。

人手証明と同じ d についての帰納法（任意の f について）である。

  人手証明                                         このファイル
  出発点の式鎖（単項式分解 → 一項の和 → 1̂·1 → 1 → 空積）  `qbarPolyEqOneOfCoeffZeroBound` と `zero` の場合
  一歩: 代数閉性による根 w の存在                   `rootPolynomialDistinctFactorizationRootExists`
    （Qbar の定義＝ℚ の代数閉包が持つ性質 `IsAlgClosed.exists_root` で引く。
      次数 1 以上は番号 d+1 の係数 1 ≠ 0 から出す）
  一歩: 因数定理の商 g、商の係数の上界、
        先頭の係数の式鎖（ac_d(g) = ac_{d+1}((t-ŵ)g) = ac_{d+1}(f) = 1）
                                                   `rootPolynomialDistinctFactorizationQuotient`
    （`qbarFactorTheorem`・`qbarFactorQuotientCoeffBound`・`qbarPolyLinearFactorLeadingCoeff` を同じ商へ当てる）
  一歩: 帰納法の仮定で α'、α の定め方、結論の式鎖の五つの等号   `succ` の場合の calc

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialDistinctFactorization
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyMonomialDecomposition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

/-- 出発点の式鎖。番号 0 より上の係数が零で番号 0 の係数が 1 の多項式は 1 である
（単項式分解 → 一項の和 → 1̂·1 → 1）。 -/
theorem qbarPolyEqOneOfCoeffZeroBound (f : QbarPoly)
    (hbound : ∀ k : ℕ, 0 < k → f.coeff k = 0) (hlead : f.coeff 0 = 1) : f = 1 := by
  calc
    f = ∑ k ∈ Finset.range (0 + 1), qbarConst (f.coeff k) * Polynomial.X ^ k :=
          -- 第一の等号: 単項式分解を n = 0 へ当てる。
          qbarPolyMonomialDecomposition f 0 hbound
    _ = qbarConst (f.coeff 0) * Polynomial.X ^ 0 := by
          -- 第二の等号: 一項だけの和。
          rw [Finset.sum_range_one]
    _ = qbarConst 1 * 1 := by
          -- 第三の等号: ac_0(f) = 1 と t^0 = 1。
          rw [hlead, pow_zero]
    _ = 1 := by
          -- 第四の等号: 1̂ = 1。
          rw [qbarConst, Polynomial.C_1, one_mul]

/-- `claim_qbar_monic_polynomial_linear_factor_product` の具体版。
番号 `d` より上の係数が零で番号 `d` の係数が 1 の `f ∈ Qbar[t]` は、ある `α : ℕ → Qbar` で
`f = ∏_{i<d} (t - α̂(i))` と書ける。 -/
theorem qbarMonicPolynomialLinearFactorProduct (d : ℕ) :
    ∀ f : QbarPoly, (∀ k : ℕ, d < k → f.coeff k = 0) → f.coeff d = 1 →
      ∃ α : ℕ → Qbar, f = ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i)) := by
  induction d with
  | zero =>
      intro f hbound hlead
      refine ⟨fun _ => 0, ?_⟩
      -- 第五の等号: 空積は単位元。
      rw [Finset.range_zero, Finset.prod_empty]
      exact qbarPolyEqOneOfCoeffZeroBound f hbound hlead
  | succ d ih =>
      intro f hbound hlead
      -- 代数閉性により f の根 w を取る。
      obtain ⟨w, hroot⟩ :=
        rootPolynomialDistinctFactorizationRootExists f (d + 1) (by omega) hlead
      -- 因数定理の商 g、その係数の上界、先頭の係数 ac_d(g) = 1。
      obtain ⟨g, hfact, hgbound', hglead'⟩ :=
        rootPolynomialDistinctFactorizationQuotient f w (d + 1) (by omega) hbound hlead hroot
      have hgbound : ∀ k : ℕ, d < k → g.coeff k = 0 := by
        intro k hk
        exact hgbound' k (by omega)
      have hglead : g.coeff d = 1 := by simpa using hglead'
      -- 帰納法の仮定を g へ当てる。
      obtain ⟨α', hα'⟩ := ih g hgbound hglead
      refine ⟨fun i => if i = d then w else α' i, ?_⟩
      have hprod :
          (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)))
            = ∏ i ∈ Finset.range d,
                (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)) := by
        refine Finset.prod_congr rfl (fun i hi => ?_)
        have hid : ¬ i = d := by
          have := Finset.mem_range.mp hi
          omega
        simp only [if_neg hid]
      calc
        f = (Polynomial.X - qbarConst w) * g := hfact
        _ = (Polynomial.X - qbarConst w)
              * ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)) := by
              -- 第二の等号: α' の取り方。
              rw [← hα']
        _ = (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α' i)))
              * (Polynomial.X - qbarConst w) := by
              -- 第三の等号: 積の可換則。
              rw [mul_comm]
        _ = (∏ i ∈ Finset.range d,
                (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)))
              * (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) d)) := by
              -- 第四の等号: i < d で α(i) = α'(i)、α(d) = w。
              rw [← hprod]; simp only [↓reduceIte]
        _ = ∏ i ∈ Finset.range (d + 1),
              (Polynomial.X - qbarConst ((fun i => if i = d then w else α' i) i)) := by
              -- 第五の等号: 番号の小さい因子から順に掛ける有限積の約束。
              rw [Finset.prod_range_succ]

end Ising2DLambda.FisherZero
