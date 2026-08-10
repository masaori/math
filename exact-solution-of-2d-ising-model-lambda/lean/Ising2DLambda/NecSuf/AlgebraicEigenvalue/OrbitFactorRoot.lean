/-
主張「軌道ごとの因子の値を 0 にする代数的数は 1 の冪根である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitFactorRoot`）と同じ鎖である
（和を保つ → t^m の値が z^m → 定数の値が係数の像 → 逆元を逆元へ送る）。

  使っている性質            なぜ削れないか
  `CommSemiring R`          `Polynomial R` を作り `eval₂` を回すのに要る（係数環）。
  `CommSemiring S`          値の側。`eval₂ φ z` が和と積を保つのに要る。
  `φ : R →+* S`             係数を値の側へ送る写像。人手証明の「係数を ev_ξ で送る」に当たる。

削れたもの: 体であること・代数閉であること・代数的数であること（`Qbar` であること）・
標数 0・加法の逆元の存在（因子の定数項を勝手な係数 `a` として受けるので、
`-κ(1)` であることを使わない）・`m` が 0 でないこと・軌道であること・特性多項式であること。
すなわちこの段は**多項式の代入が和を保つことと、単項式と定数の値だけ**しか使っていない。

住処: ここに ℝ / ℂ は現れない（値は一般の可換半環、指数は ℕ）。
-/
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 必要十分版の本体。可換半環の間の環準同型 `φ` と値 `z` について、
`X ^ m + C a` の値は `z ^ m + φ a` である。 -/
theorem eval₂_X_pow_add_C_necSuf {R S : Type*} [CommSemiring R] [CommSemiring S]
    (φ : R →+* S) (z : S) (m : ℕ) (a : R) :
    Polynomial.eval₂ φ z ((X : R[X]) ^ m + C a) = z ^ m + φ a := by
  calc Polynomial.eval₂ φ z ((X : R[X]) ^ m + C a)
      = Polynomial.eval₂ φ z ((X : R[X]) ^ m) + Polynomial.eval₂ φ z (C a) := by
        rw [Polynomial.eval₂_add]                 -- 第 1 段。代入は和を保つ。
    _ = z ^ m + Polynomial.eval₂ φ z (C a) := by
        rw [Polynomial.eval₂_X_pow]               -- 第 2 段。単項式の値。
    _ = z ^ m + φ a := by
        rw [Polynomial.eval₂_C]                   -- 第 3 段。定数の値は係数の像。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
