/-
主張「代数的数の冪の有限和は、1 を引いたものを掛けると伸縮する」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarGeometricTelescope`）と同じである。
すなわち `n` についての帰納法で、出発点は空和、一歩は分配則を 2 度当てて帰納法の仮定を入れ、
`z^n` を相殺させる。

  使っている性質                なぜ削れないか
  `Ring R`                      加法群であること（`z^n` の相殺と `1 - 1 = 0`）と、
                                積が和へ分配されること、積の単位元があること。
                                半環まで削ると `z^n - 1` が書けない。

削れたもの: 積の可換性（`CommRing` を要求しない）・積の逆元の存在・体であること・
代数閉であること・値が代数的数であること（`Qbar`）・`z` が 1 の冪根であること。

この版の眼目は、**積の可換性を使っていない**ことである。具体版では体 `Qbar` の中で
計算しているので可換性は無料で付いてくるが、証明が実際に掛け合わせているのは
`z` と `z` 自身の冪だけであり、それらは互いに可換なので仮定として要らない。
`pow_succ`（`z^(n+1) = z^n * z`）と `pow_succ'`（`z^(n+1) = z * z^n`）が
非可換環でも両方使えるのはこのためである。

住処: ここに ℝ / ℂ は現れない（元は一般の環の元）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Defs
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Ring.Defs
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open BigOperators

/-- 必要十分版の本体。可換とは限らない環 `R` の元 `z` について、
`(z - 1) Σ_{k<n} z^k = z^n - 1`。 -/
theorem geometric_telescope_necSuf {R : Type*} [Ring R] (z : R) (n : ℕ) :
    (z - 1) * (∑ k ∈ Finset.range n, z ^ k) = z ^ n - 1 := by
  induction n with
  | zero =>
      -- 出発点。空和が 0、0 との積が 0、z^0 = 1。
      calc (z - 1) * (∑ k ∈ Finset.range 0, z ^ k)
          = (z - 1) * 0 := by rw [Finset.range_zero, Finset.sum_empty]
        _ = 0 := mul_zero _
        _ = 1 - 1 := (sub_self 1).symm
        _ = z ^ 0 - 1 := by rw [pow_zero]
  | succ n ih =>
      -- 一歩。分配則を 2 度当て、帰納法の仮定を入れ、z^n を相殺させる。
      calc (z - 1) * (∑ k ∈ Finset.range (n + 1), z ^ k)
          = (z - 1) * ((∑ k ∈ Finset.range n, z ^ k) + z ^ n) := by
            rw [Finset.sum_range_succ]
        _ = (z - 1) * (∑ k ∈ Finset.range n, z ^ k) + (z - 1) * z ^ n := mul_add _ _ _
        _ = (z ^ n - 1) + (z - 1) * z ^ n := by rw [ih]
        _ = (z ^ n - 1) + (z * z ^ n - 1 * z ^ n) := by rw [sub_mul]
        _ = (z ^ n - 1) + (z ^ (n + 1) - z ^ n) := by rw [one_mul, ← pow_succ']
        _ = z ^ (n + 1) - 1 := by
            -- 加法群の計算だけ（積は現れない）。
            abel

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
