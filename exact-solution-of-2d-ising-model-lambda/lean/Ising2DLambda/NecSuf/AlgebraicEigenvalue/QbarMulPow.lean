/-
主張「代数的数の積の冪は、冪の積である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarMulPow`）と同じである
（n についての帰納法。出発点は単位元、一歩は結合則と 2 元の可換則）。

  使っている性質                     なぜ削れないか
  `Monoid M`                         冪 `y ^ n`（`y^0 = 1`, `y^{j+1} = y^j y`）を書くのに要る。
                                     出発点の第 2 段が単位元、一歩の第 3・4・6・7 段が結合則。
  `h : w * z = z * w`                一歩の第 5 段。**この 2 元についてだけ**の可換則である。
                                     可換モノイドを要求していないのが眼目で、
                                     可換性が要ることは SageMath 側でも確かめてある
                                     （`w z ≠ z w` な 2 次行列の組で `(wz)^2 ≠ w^2 z^2`）。

削れたもの: 加法・零元・分配則・逆元の存在・体であること・値が代数的数であること（`Qbar`）・
積の全体としての可換性（`CommMonoid`）。mathlib からはモノイドの定義（`Monoid`。冪 `y ^ n` の
再帰そのもの）だけを引いている。

補題 `pow_mul_comm_of_comm` を先に置くのは、一歩の第 5 段が可換則を `w` と `z` ではなく
`z ^ n` と `w` に当てるためである。仮定は 2 元についての等式 1 本しか置いていないので、
そこから `z ^ n` へ持ち上げる帰納法が別に要る（具体版では体の可換性から直に出ていた部分で、
必要十分版で新しく現れる分である）。

住処: ここに ℝ / ℂ は現れない（元は一般のモノイドの元）。
-/

import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 2 元が可換なら、一方の冪ともう一方も可換である（一歩の第 5 段が要求する形）。 -/
theorem pow_mul_comm_of_comm {M : Type*} [Monoid M] (w z : M) (h : w * z = z * w) :
    ∀ n : ℕ, z ^ n * w = w * z ^ n := by
  intro n
  induction n with
  | zero => rw [pow_zero, one_mul, mul_one]
  | succ n ih =>
      calc z ^ (n + 1) * w
          = (z ^ n * z) * w := by rw [pow_succ]
        _ = z ^ n * (z * w) := mul_assoc _ _ _
        _ = z ^ n * (w * z) := by rw [h]
        _ = (z ^ n * w) * z := (mul_assoc _ _ _).symm
        _ = (w * z ^ n) * z := by rw [ih]
        _ = w * (z ^ n * z) := mul_assoc _ _ _
        _ = w * z ^ (n + 1) := by rw [pow_succ]

/-- 必要十分版。人手証明の帰納法と鎖をそのまま書いたものである。 -/
theorem mul_pow_necSuf {M : Type*} [Monoid M] (w z : M) (h : w * z = z * w) :
    ∀ n : ℕ, (w * z) ^ n = w ^ n * z ^ n := by
  intro n
  induction n with
  | zero =>
      calc (w * z) ^ 0
          = 1 := pow_zero _
            -- 第 1 段。y^0 := 1。
        _ = 1 * 1 := (one_mul 1).symm
            -- 第 2 段。1 は積の単位元。
        _ = w ^ 0 * 1 := by rw [pow_zero]
            -- 第 3 段。y^0 := 1。
        _ = w ^ 0 * z ^ 0 := by rw [pow_zero z]
            -- 第 4 段。y^0 := 1。
  | succ n ih =>
      calc (w * z) ^ (n + 1)
          = (w * z) ^ n * (w * z) := pow_succ _ _
            -- 第 1 段。y^{j+1} := y^j y。
        _ = (w ^ n * z ^ n) * (w * z) := by rw [ih]
            -- 第 2 段。帰納法の仮定。
        _ = w ^ n * (z ^ n * (w * z)) := mul_assoc _ _ _
            -- 第 3 段。積の結合則。
        _ = w ^ n * ((z ^ n * w) * z) := by rw [mul_assoc]
            -- 第 4 段。積の結合則。
        _ = w ^ n * ((w * z ^ n) * z) := by rw [pow_mul_comm_of_comm w z h n]
            -- 第 5 段。可換則を z^n と w に当てる（仮定 h から持ち上げたもの）。
        _ = w ^ n * (w * (z ^ n * z)) := by rw [mul_assoc]
            -- 第 6 段。積の結合則。
        _ = (w ^ n * w) * (z ^ n * z) := (mul_assoc _ _ _).symm
            -- 第 7 段。積の結合則。
        _ = w ^ (n + 1) * (z ^ n * z) := by rw [pow_succ]
            -- 第 8 段。y^{j+1} := y^j y。
        _ = w ^ (n + 1) * z ^ (n + 1) := by rw [pow_succ z n]
            -- 第 9 段。y^{j+1} := y^j y。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
