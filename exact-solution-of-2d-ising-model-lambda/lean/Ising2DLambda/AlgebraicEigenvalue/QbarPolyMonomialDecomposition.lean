/-
章「固有値の代数性」の「多項式は、その係数を定数として送ったものと不定元の冪との積の
有限和に等しい」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_poly_monomial_decomposition`）と
定義 1 件（`def_qbar_poly_evaluation`）に対応する。

  人手証明                                          このファイル
  aev_w（Qbar[t] の元の w における値）              `qbarPolyEval`
  準備の段（ac_j(â t^k) の 9 段の鎖）               `qbarPolyCoeffConstMulPow`
  本体の第 1 の等号（和の係数）                     `Polynomial.finsetSum_coeff`
  場合 1（j ≤ n）の k = j の項の取り出し            `Finset.sum_eq_single`
  場合 2（j > n）のすべての項が零                   `Finset.sum_eq_zero`
  係数がすべて等しい 2 つの多項式は等しい           `Polynomial.ext`

`Polynomial.as_sum_range`（主張そのものにあたる mathlib の既製定理）へは委ねない。
準備の段も積の係数の定義から書き、`Polynomial.coeff_C_mul` へ委ねない。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の `aev_w`（`def_qbar_poly_evaluation`。係数が零でない項だけの有限和）。 -/
noncomputable def qbarPolyEval (w : Qbar) (f : QbarPoly) : Qbar :=
  ∑ k ∈ f.support, f.coeff k * w ^ k

/-- 人手証明の準備の段。`ac_j(â t^k)` は `j = k` のとき `a`、そうでないとき零元である。 -/
theorem qbarPolyCoeffConstMulPow (a : Qbar) (k j : ℕ) :
    ((qbarConst a) * Polynomial.X ^ k).coeff j = if j = k then a else 0 := by
  -- 第 1 の等号（積の係数の定義）。
  rw [qbarConst, Polynomial.coeff_mul]
  -- 第 2 から第 6 の等号（i = 0 の項を取り出し、i ≥ 1 の項が零であることを使う）。
  rw [Finset.sum_eq_single ((0, j) : ℕ × ℕ)]
  · -- 第 7・第 8・第 9 の等号（ac_0(â) = a、不定元の冪の係数、積の単位元と零元との積）。
    rw [Polynomial.coeff_C_zero, qbarPolyIndeterminatePowerCoefficient]
    by_cases h : j = k
    · simp [h]
    · simp [h]
  · intro b hb hne
    have hb' : b.1 + b.2 = j := Finset.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ 0 := by
      intro h0
      apply hne
      have hb2 : b.2 = j := by omega
      exact Prod.ext h0 hb2
    simp only [Polynomial.coeff_C, if_neg hb1, zero_mul]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : 0 + j = j)) h

/-- 人手証明の本体。`n` 次より上の係数が零である多項式は、その係数を定数として送ったものと
不定元の冪との積の有限和に等しい（`claim_qbar_poly_monomial_decomposition`）。 -/
theorem qbarPolyMonomialDecomposition (f : QbarPoly) (n : ℕ)
    (h : ∀ k : ℕ, n < k → f.coeff k = 0) :
    f = ∑ k ∈ Finset.range (n + 1), (qbarConst (f.coeff k)) * Polynomial.X ^ k := by
  -- 係数がすべて等しい 2 つの多項式は等しい。
  ext j
  -- 第 1 の等号（和の係数を有限和へ繰り返し当てる）。
  rw [Polynomial.finsetSum_coeff]
  by_cases hj : j ≤ n
  · -- 場合 1（j ≤ n）。k = j の項を取り出す。
    rw [Finset.sum_eq_single j]
    · -- 準備の段を a = ac_j(f)、k = j へ当てる。
      rw [qbarPolyCoeffConstMulPow]
      simp
    · intro k _ hne
      -- k ≠ j の項は準備の段より零元。
      rw [qbarPolyCoeffConstMulPow]
      simp [Ne.symm hne]
    · intro hnot
      exact absurd (Finset.mem_range.mpr (by omega : j < n + 1)) hnot
  · -- 場合 2（j > n）。0 ≤ k ≤ n < j よりすべての項が零元。
    have hzero : ∀ k ∈ Finset.range (n + 1),
        ((qbarConst (f.coeff k)) * Polynomial.X ^ k).coeff j = 0 := by
      intro k hk
      have hkn : k < n + 1 := Finset.mem_range.mp hk
      have hjk : j ≠ k := by omega
      rw [qbarPolyCoeffConstMulPow]
      simp [hjk]
    rw [Finset.sum_eq_zero hzero]
    -- j > n についての仮定。
    exact h j (by omega)

end Ising2DLambda.AlgebraicEigenvalue
