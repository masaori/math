/-
主張「1 の冪根の冪は 1 の冪根である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPow`）と同じ
`k` についての帰納法である（出発点は「単位元が集合に属すること」、
一歩は「集合が積で閉じていること」）。

  使っている性質                     なぜ削れないか
  `Monoid M`                         冪 `w ^ k` を書くのに要る（`pow_zero` / `pow_succ`）。
  `h1 : (1 : M) ∈ S`                 出発点そのものである。
  `hmul : S が積で閉じている`         一歩そのものである。
  `hw : w ∈ S`                       一歩で右から掛ける元が S に属することに要る。

削れたもの: 加法・零元・分配則・逆元の存在・体であること・代数閉であること・
値が代数的数であること（`Qbar`）・積の可換性・`n` と「n 乗して 1 になる」という条件そのもの。
すなわちこの段は **S が 1 の冪根の全体であることを一切使っていない**。
要るのは「単位元を含み積で閉じた部分集合」であることだけである
（`Submonoid` の 2 条件そのものだが、mathlib の `Submonoid.pow_mem` へは委ねず
人手証明の帰納法を書いている）。

住処: ここに ℝ / ℂ は現れない（元は一般のモノイドの元、指数は ℕ）。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。単位元を含み積で閉じた部分集合は、その元の冪をすべて含む。 -/
theorem pow_mem_necSuf {M : Type*} [Monoid M] (S : Set M) (h1 : (1 : M) ∈ S)
    (hmul : ∀ a b : M, a ∈ S → b ∈ S → a * b ∈ S) {w : M} (hw : w ∈ S) (k : ℕ) :
    w ^ k ∈ S := by
  induction k with
  | zero =>
      -- 出発点。w^0 = 1 であり、1 は S に属する。
      rw [pow_zero]
      exact h1
  | succ k ih =>
      -- 一歩。w^{k+1} = w^k w へ、S が積で閉じていることを当てる。
      rw [pow_succ]
      exact hmul _ _ ih hw

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
