/-
主張「代数的数の冪の差は、もとの 2 元の差を因子に持つ」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarPowerDifferenceFactorization`）と同じである。
すなわち `n` についての帰納法で、出発点は `H_0 = 0`、一歩は分配則と結合則を当てて
帰納法の仮定を入れ、`z^n * w` を相殺させる。

  使っている性質                なぜ削れないか
  `Ring R`                      加法群であること（`z^n * w` の相殺と `1 - 1 = 0`）と、
                                積が和へ分配されること、積が結合的であること、
                                積の単位元があること。
                                半環まで削ると `z^n - w^n` が書けない。
  `Commute z w`                 一歩の最後から 2 番めの段で `w * z^n = z^n * w` を使う。
                                これが無いと等式そのものが破れる（2 次整数行列環の
                                可換でない 2 元での反例を SageMath 側に置いてある）。

削れたもの: 環全体の可換性（`CommRing` を要求しない）・積の逆元の存在・体であること・
代数閉であること・値が代数的数であること（`Qbar`）・`z` や `w` が 1 の冪根であること・
`z ≠ w` であること。

この版の眼目は、**要求されるのが環の可換性ではなく、この 2 元が可換であることだけ**である点である。
具体版では体 `Qbar` の中で計算しているので可換性は無料で付いてくるが、
証明が可換性を使っているのは 1 箇所（`w * z^n = z^n * w`）だけであり、
そこは `Commute z w` から出る。

住処: ここに ℝ / ℂ は現れない（元は一般の環の元）。
-/
import Mathlib.Algebra.Group.Commute.Defs
import Mathlib.Algebra.Ring.Defs
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 人手証明の `H_n(z, w)`（`H_0 = 0`、`H_{n+1} = H_n w + z^n`）。 -/
def powDiffSum {R : Type*} [Ring R] (z w : R) : ℕ → R
  | 0 => 0
  | n + 1 => powDiffSum z w n * w + z ^ n

/-- 必要十分版の本体。可換とは限らない環 `R` の互いに可換な 2 元 `z`, `w` について、
`(z - w) H_n(z, w) = z^n - w^n`。 -/
theorem power_difference_factorization_necSuf {R : Type*} [Ring R] (z w : R)
    (h : Commute z w) (n : ℕ) :
    (z - w) * powDiffSum z w n = z ^ n - w ^ n := by
  induction n with
  | zero =>
      -- 出発点。H_0 = 0、0 との積が 0、z^0 = 1、w^0 = 1。
      calc (z - w) * powDiffSum z w 0
          = (z - w) * 0 := by rw [powDiffSum]
        _ = 0 := mul_zero _
        _ = 1 - 1 := (sub_self 1).symm
        _ = z ^ 0 - 1 := by rw [pow_zero]
        _ = z ^ 0 - w ^ 0 := by rw [pow_zero w]
  | succ n ih =>
      -- 一歩。人手証明の 11 段の鎖をそのまま書く。
      calc (z - w) * powDiffSum z w (n + 1)
          = (z - w) * (powDiffSum z w n * w + z ^ n) := by rw [powDiffSum]
        _ = (z - w) * (powDiffSum z w n * w) + (z - w) * z ^ n := mul_add _ _ _
        _ = ((z - w) * powDiffSum z w n) * w + (z - w) * z ^ n := by rw [mul_assoc]
        _ = (z ^ n - w ^ n) * w + (z - w) * z ^ n := by rw [ih]
        _ = (z ^ n * w - w ^ n * w) + (z - w) * z ^ n := by rw [sub_mul]
        _ = (z ^ n * w - w ^ (n + 1)) + (z - w) * z ^ n := by rw [← pow_succ]
        _ = (z ^ n * w - w ^ (n + 1)) + (z * z ^ n - w * z ^ n) := by rw [sub_mul]
        _ = (z ^ n * w - w ^ (n + 1)) + (z ^ (n + 1) - w * z ^ n) := by rw [← pow_succ']
        _ = (z ^ n * w - w ^ (n + 1)) + (z ^ (n + 1) - z ^ n * w) := by
            rw [(h.symm.pow_right n).eq]
        _ = z ^ (n + 1) - w ^ (n + 1) := by
            -- 加法群の計算だけ（積は現れない）。
            abel

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
