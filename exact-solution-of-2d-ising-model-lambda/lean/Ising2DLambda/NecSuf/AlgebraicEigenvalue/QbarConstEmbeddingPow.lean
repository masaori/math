/-
主張「定数として送る写像は冪を冪へ写す」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarConstEmbeddingPow`）と同じである。
すなわち `n` についての帰納法で、出発点は「`w^0 = 1`」「`φ 1 = 1`」「`(φ w)^0 = 1`」の
3 段、一歩は「`w^{n+1} = w^n w`」「`φ (a b) = φ a φ b`」「帰納法の仮定」
「`(φ w)^{n+1} = (φ w)^n (φ w)`」の 4 段の鎖である。

  使っている性質                                    なぜ削れないか
  `One`・`Mul`・`Pow _ ℕ`（両側）                   冪の約束を書くための材料（記号だけ）。
  `hM0`・`hMs`・`hN0`・`hNs`（冪の約束そのもの）    出発点と一歩の書き換えの両端。
  `h1`（`φ 1 = 1`）                                 出発点の中央の段。
  `hmul`（`φ (a b) = φ a φ b`）                     一歩の中央の段。

削れたもの: 積の結合則（`Monoid` / `Semigroup`）・積の可換性・単位元の法則
（`1 * a = a` すら使っていない）・加法の存在・体であること・係数が代数的数である
こと（`Qbar`）・行き先が多項式環であること。すなわちこの主張は「両側に同じ形の
冪の約束があり、写像が単位元と積を保つ」ことだけで成り立つ。
`Monoid` を仮定しないため冪は型クラス `Pow _ ℕ` の記号として受け取り、
その意味（`a^0 = 1` と `a^{n+1} = a^n a`）は仮定として明示的に受け取る。

住処: ここに ℝ / ℂ は現れない（元は一般の型、指数は ℕ）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 単位元と積を保つ写像は、反復で約束された冪を冪へ写す。 -/
theorem constant_embedding_pow_necSuf
    {M N : Type*} [One M] [Mul M] [Pow M ℕ] [One N] [Mul N] [Pow N ℕ]
    (hM0 : ∀ a : M, a ^ 0 = 1)
    (hMs : ∀ (a : M) (n : ℕ), a ^ (n + 1) = a ^ n * a)
    (hN0 : ∀ b : N, b ^ 0 = 1)
    (hNs : ∀ (b : N) (n : ℕ), b ^ (n + 1) = b ^ n * b)
    (φ : M → N) (h1 : φ 1 = 1)
    (hmul : ∀ a b : M, φ (a * b) = φ a * φ b)
    (w : M) (n : ℕ) : φ (w ^ n) = φ w ^ n := by
  induction n with
  | zero =>
      -- 出発点。w^0 = 1、φ 1 = 1、(φ w)^0 = 1。
      calc φ (w ^ 0) = φ 1 := by rw [hM0]
        _ = 1 := h1
        _ = φ w ^ 0 := (hN0 _).symm
  | succ n ih =>
      -- 一歩。w^{n+1} = w^n w、積を保つこと、帰納法の仮定、(φ w)^{n+1} = (φ w)^n (φ w)。
      calc φ (w ^ (n + 1)) = φ (w ^ n * w) := by rw [hMs]
        _ = φ (w ^ n) * φ w := hmul _ _
        _ = φ w ^ n * φ w := by rw [ih]
        _ = φ w ^ (n + 1) := (hNs _ _).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
