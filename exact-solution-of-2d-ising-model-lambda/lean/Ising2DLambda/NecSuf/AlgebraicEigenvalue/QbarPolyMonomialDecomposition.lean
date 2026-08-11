/-
主張「多項式は、その係数を定数として送ったものと不定元の冪との積の有限和に等しい」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarPolyMonomialDecomposition`）と同じである。
すなわち準備の段（`ac_j((a)^ t^k)` の値）を先に出し、そのうえで係数 `j` を任意に取り、
`j ≤ n` の場合は `k = j` の項を取り出し、`j > n` の場合はすべての項が零であることを使って、
どちらも `ac_j(f)` に一致させ、最後に「係数がすべて等しい 2 つの多項式は等しい」で結ぶ。

  使っている性質                なぜ削れないか
  `Semiring R`                  係数環であること（積の係数の定義に和と積が要る）。
                                引き算も可換性も使っていないので、環まで上げる必要はない。

削れたもの: 環の加法の逆元（`Ring`）・積の可換性（`CommSemiring`）・体であること・
代数閉であること・係数が代数的数であること（`Qbar`）。

この版の眼目は、**分解が使っているのが係数環の半環としての構造だけ**である点である。
具体版は体 `Qbar` の中で計算しているが、証明が引くのは積と和の係数の定義、
零元・単位元の性質、そして不定元の冪の係数（`indeterminate_power_coefficient_necSuf`）だけであり、
引き算も割り算も可換性も現れない。

住処: ここに ℝ / ℂ は現れない（係数は一般の半環の元、指数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の準備の段。`ac_j((a)^ t^k)` は `j = k` のとき `a`、そうでないとき零元である。 -/
theorem coeff_C_mul_X_pow_necSuf {R : Type*} [Semiring R] (a : R) (k j : ℕ) :
    ((C a : R[X]) * X ^ k).coeff j = if j = k then a else 0 := by
  -- 第 1 の等号（積の係数の定義）。
  rw [Polynomial.coeff_mul]
  -- 第 2 から第 6 の等号（i = 0 の項を取り出し、i ≥ 1 の項が零であることを使う）。
  rw [Finset.sum_eq_single ((0, j) : ℕ × ℕ)]
  · -- 第 7・第 8・第 9 の等号（ac_0((a)^) = a、不定元の冪の係数、積の単位元と零元との積）。
    rw [Polynomial.coeff_C_zero, indeterminate_power_coefficient_necSuf]
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

/-- 必要十分版の本体。係数環が半環でありさえすれば、`n` 次より上の係数が零である多項式は
その係数を定数として送ったものと不定元の冪との積の有限和に等しい。 -/
theorem monomial_decomposition_necSuf {R : Type*} [Semiring R] (f : R[X]) (n : ℕ)
    (h : ∀ k : ℕ, n < k → f.coeff k = 0) :
    f = ∑ k ∈ Finset.range (n + 1), (C (f.coeff k) : R[X]) * X ^ k := by
  -- 係数がすべて等しい 2 つの多項式は等しい。
  ext j
  -- 第 1 の等号（和の係数を有限和へ繰り返し当てる）。
  rw [Polynomial.finsetSum_coeff]
  by_cases hj : j ≤ n
  · -- 場合 1（j ≤ n）。k = j の項を取り出す。
    rw [Finset.sum_eq_single j]
    · -- 準備の段を a = ac_j(f)、k = j へ当てる。
      rw [coeff_C_mul_X_pow_necSuf]
      simp
    · intro k _ hne
      -- k ≠ j の項は準備の段より零元。
      rw [coeff_C_mul_X_pow_necSuf]
      simp [Ne.symm hne]
    · intro hnot
      exact absurd (Finset.mem_range.mpr (by omega : j < n + 1)) hnot
  · -- 場合 2（j > n）。0 ≤ k ≤ n < j よりすべての項が零元。
    have hzero : ∀ k ∈ Finset.range (n + 1),
        ((C (f.coeff k) : R[X]) * X ^ k).coeff j = 0 := by
      intro k hk
      have hkn : k < n + 1 := Finset.mem_range.mp hk
      have hjk : j ≠ k := by omega
      rw [coeff_C_mul_X_pow_necSuf]
      simp [hjk]
    rw [Finset.sum_eq_zero hzero]
    -- j > n についての仮定。
    exact h j (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
