/-
主張「1 の冪根の全体は積で閉じている」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMul`）と同じ 4 段の鎖である
（積の冪は冪の積である → w^n = 1 の代入 → z^n = 1 の代入 → 1 は積の単位元）。

  使っている性質                     なぜ削れないか
  `Monoid M`                         冪 `y ^ n` を書くのに要る。鎖の第 4 段が単位元、
                                     第 1 段が引く `mul_pow_necSuf` が結合則を使う。
  `h : w * z = z * w`                第 1 段が引く `mul_pow_necSuf` の仮定である。
                                     **この 2 元についてだけ**の可換則であり、
                                     可換モノイドを要求していない。

削れたもの: 加法・零元・分配則・逆元の存在・体であること・代数閉であること・
値が代数的数であること（`Qbar`）・積の全体としての可換性（`CommMonoid`）・
`n` が 0 でないこと。すなわちこの段は**代数的数の話も、1 の冪根であることの
「1 の」の部分も使っていない**。使うのは「n 乗して単位元になる」という等式 2 本だけである。

第 1 段を mathlib の `mul_pow` へ委ねず、自前の `mul_pow_necSuf`（`claim_qbar_mul_pow` の
必要十分版）を引いているのは、具体版が自前の `qbarMul_pow` を引いているのと 1 対 1 に
対応させるためである。

住処: ここに ℝ / ℂ は現れない（元は一般のモノイドの元、指数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarMulPow

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。可換な 2 元がともに `n` 乗して単位元なら、その積も `n` 乗して単位元。 -/
theorem mul_mem_pow_eq_one_necSuf {M : Type*} [Monoid M] (w z : M) (h : w * z = z * w)
    (n : ℕ) (hw : w ^ n = 1) (hz : z ^ n = 1) : (w * z) ^ n = 1 := by
  calc (w * z) ^ n
      = w ^ n * z ^ n := mul_pow_necSuf w z h n   -- 第 1 段。積の冪は冪の積である。
    _ = 1 * z ^ n := by rw [hw]                   -- 第 2 段。w^n = 1 の代入。
    _ = 1 * 1 := by rw [hz]                       -- 第 3 段。z^n = 1 の代入。
    _ = 1 := one_mul 1                            -- 第 4 段。1 は積の単位元。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
