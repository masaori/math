/-
主張「多重度の総和は配位の総数に等しい」の必要十分版。

目的は 2 つ（`lean/README.md`）。何が本質的かを示すことと、具体版が過剰な構造を
要求していないかを検査することである。

具体版（`Ising2DLambda.PartitionPolynomial.CoefficientSum`）の証明が実際に使っているのは
次だけである。格子の形・周期境界条件・スピンの値が `{+1,-1}` であること・
配位の総数が `2^{L²}` であることは、どこにも使っていない。

  使っている性質            なぜ削れないか
  `Fintype α`               類 `fiber f m` を有限集合として扱い、その元の個数を数えるため。
                            無限集合では第 2 の等号の「個数の和」が意味をなさない。
  `DecidableEq α`           第 2 の等号で使う `Finset.card_biUnion` が合併を取るのに要る。
                            決定可能でないと `biUnion` が定義できない。
  `f a ≤ N`（有界性）       類別の被覆に要る。これが無いと `f a` の類が
                            添字の範囲 `{0,…,N}` の外に出て、合併が全体にならない。

値域を `ℕ` に固定してあるのは、添字の範囲を `Finset.range (N+1)` として書くためであり、
順序集合一般へ持ち上げるとこの書き方ができなくなる（持ち上げても本質は増えない）。

証明手順は具体版と同じである（別の論法へ差し替えていない）。人手証明の 3 つの等号のうち、
第 3 の等号（配位の総数が `2^{L²}`）だけは具体版に固有の計算なので、ここでは
`Fintype.card α` のまま残す。すなわちこの版が示すのは第 1・第 2 の等号の部分である。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.PartitionPolynomial

open Finset

variable {α : Type*} [Fintype α] [DecidableEq α] (f : α → ℕ) (N : ℕ)

omit [DecidableEq α] in
/-- 第 1 の等号。値 `m` をとる元の類。 -/
def fiber (m : ℕ) : Finset α := univ.filter fun a => f a = m

/-- 類別（被覆）。各 `a` は `f a` の類に属し、有界性から添字が範囲に収まる。 -/
lemma biUnion_fiber (hf : ∀ a, f a ≤ N) :
    (range (N + 1)).biUnion (fiber f) = (univ : Finset α) := by
  apply eq_univ_of_forall
  intro a
  simp only [mem_biUnion, mem_range, fiber, mem_filter, mem_univ, true_and]
  exact ⟨f a, Nat.lt_succ_of_le (hf a), rfl⟩

omit [DecidableEq α] in
/-- 類別（互いに素）。`f` は写像なのでただ 1 つの値をとる。 -/
lemma fiber_pairwise_disjoint :
    ∀ m ∈ range (N + 1), ∀ m' ∈ range (N + 1), m ≠ m' → Disjoint (fiber f m) (fiber f m') := by
  intro m _ m' _ hne
  refine disjoint_left.mpr ?_
  intro a hm hm'
  simp only [fiber, mem_filter] at hm hm'
  exact hne (hm.2.symm.trans hm'.2)

/-- 第 2 の等号。互いに素な有限個の有限集合の合併の元の個数は、各集合の元の個数の和である。 -/
theorem sum_card_fiber_eq_card (hf : ∀ a, f a ≤ N) :
    ∑ m ∈ range (N + 1), (fiber f m).card = Fintype.card α := by
  rw [← card_univ, ← biUnion_fiber f N hf, card_biUnion (fiber_pairwise_disjoint f N)]

end Ising2DLambda.NecSuf.PartitionPolynomial
