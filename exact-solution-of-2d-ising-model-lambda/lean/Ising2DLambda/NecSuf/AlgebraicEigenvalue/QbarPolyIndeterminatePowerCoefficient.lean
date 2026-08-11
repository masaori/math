/-
主張「不定元の冪の係数は、番号が指数と一致するときだけ単位元である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient`）と
同じである。すなわち `k` についての帰納法で、出発点は `X^0 = 1` の係数、
一歩は `X^{k+1} = X^k X` と積の係数の定義から、`j = 0` の場合と `j = j'+1` の場合に分けて、
`j'` 以外の項が零であることを使って `X^k` の係数へ落とす。

  使っている性質                なぜ削れないか
  `Semiring R`                  係数環であること（積の係数の定義に和と積が要る）。
                                引き算も可換性も使っていないので、環まで上げる必要はない。

削れたもの: 環の加法の逆元（`Ring`）・積の可換性（`CommSemiring`）・体であること・
代数閉であること・係数が代数的数であること（`Qbar`）。

この版の眼目は、**この段が使っているのが係数環の半環としての構造だけ**である点である。
具体版は体 `Qbar` の中で計算しているが、証明が引くのは積の係数の定義（和と積）と
零元・単位元の性質だけであり、引き算も割り算も可換性も現れない。

住処: ここに ℝ / ℂ は現れない（係数は一般の半環の元、指数は ℕ）。
-/
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Algebra.Polynomial.Coeff

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の一歩の場合 2（`j = j'+1`）にあたる段。積の係数の定義から、
`i = j'` 以外の項が零であることを使って落とす。 -/
theorem coeff_mul_X_succ_necSuf {R : Type*} [Semiring R] (p : R[X]) (j : ℕ) :
    (p * X).coeff (j + 1) = p.coeff j := by
  -- 第 2 の等号（積の係数の定義）。
  rw [Polynomial.coeff_mul]
  -- 第 3 から第 7 の等号（i = j' の項を取り出し、他の項が零であることを使う）。
  rw [Finset.sum_eq_single ((j, 1) : ℕ × ℕ)]
  · -- 第 8・第 9 の等号（X の 1 次の係数が単位元であること、積の単位元）。
    simp
  · intro b hb hne
    have hb' : b.1 + b.2 = j + 1 := Finset.mem_antidiagonal.mp hb
    have hne2 : b.2 ≠ 1 := by
      intro h
      apply hne
      have : b.1 = j := by omega
      exact Prod.ext this h
    simp only [Polynomial.coeff_X, if_neg (fun h : (1 : ℕ) = b.2 => hne2 h.symm), mul_zero]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : j + 1 = j + 1)) h

/-- 人手証明の一歩の場合 1（`j = 0`）にあたる段。 -/
theorem coeff_mul_X_zero_necSuf {R : Type*} [Semiring R] (p : R[X]) :
    (p * X).coeff 0 = 0 := by
  -- 積の係数の定義（和は i = 0 の 1 項だけ）と、X の 0 次の係数が零であること。
  rw [Polynomial.mul_coeff_zero, Polynomial.coeff_X_zero, mul_zero]

/-- 必要十分版の本体。係数環が半環でありさえすれば `X^k` の係数は
`j = k` のとき単位元、そうでないとき零元である。 -/
theorem indeterminate_power_coefficient_necSuf {R : Type*} [Semiring R] (k j : ℕ) :
    ((X : R[X]) ^ k).coeff j = if j = k then 1 else 0 := by
  induction k generalizing j with
  | zero =>
      -- 出発点。X^0 = 1 と、1 の係数。
      rw [pow_zero, Polynomial.coeff_one]
  | succ k ih =>
      -- 一歩。X^{k+1} = X^k X としてから j で場合分けする。
      rw [pow_succ]
      match j with
      | 0 =>
          -- 場合 1（j = 0）。0 ≠ k + 1 なので右辺も零元。
          rw [coeff_mul_X_zero_necSuf]
          simp
      | j + 1 =>
          -- 場合 2（j = j'+1）。落としてから帰納法の仮定を入れる。
          rw [coeff_mul_X_succ_necSuf, ih]
          -- j' = k と j'+1 = k+1 は同値（後者の単射性）。
          simp

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
