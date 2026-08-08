/-
主張「分配多項式の係数は多重度である」の必要十分版。

具体版（`Ising2DLambda.PartitionPolynomial.CoefficientRepresentation`）の証明が
実際に使っているのは次だけである。多項式であること・係数が `ℤ` であること・
不定元の冪であること・格子の形・スピンの値が `{+1,-1}` であることは、どこにも使っていない。

  使っている性質            なぜ削れないか
  `Fintype α`               類 `fiber f m` を有限集合として扱い、その上の和を取るため。
                            無限集合では Step 3 の「和の和」が意味をなさない。
  `DecidableEq α`           Step 3 で使う `Finset.sum_biUnion` が合併を取るのに要る。
                            決定可能でないと `biUnion` が定義できない。
  `f a ≤ N`（有界性）       Step 2 の被覆に要る。これが無いと `f a` の類が
                            添字の範囲 `{0,…,N}` の外に出て、合併が全体にならない。
  `AddCommMonoid M`         Step 3 で和の順序を組み替えるのに可換性と結合性が要る。
                            Step 4 で「同じ元を `k` 個足したもの」を `k • g m` と書くのに
                            零元と `ℕ` 倍が要る。逆元・積・分配則は使っていないので、
                            環ではなく可換モノイドで足りる。

具体版で足し合わせていた単項式 `x^{b(σ)}` は、ここでは `g : ℕ → M` を通した `g (f a)` になる。
すなわちこの版が言っているのは「値 `f a` だけで決まる量を全体で足すと、値ごとの個数で束ねられる」
ということであり、単項式であることは本質ではない。

証明手順は具体版と同じ Step 1–5 である（別の論法へ差し替えていない）。
Step 1・Step 2 は主張「多重度の総和は配位の総数に等しい」の必要十分版で示した
`fiber` / `biUnion_fiber` / `fiber_pairwise_disjoint` をそのまま使う。

住処: ここに ℝ / ℂ は現れない（添字は ℕ、値は一般の可換モノイド）。
-/
import Ising2DLambda.NecSuf.PartitionPolynomial.CoefficientSum

namespace Ising2DLambda.NecSuf.PartitionPolynomial

open Finset

variable {α : Type*} [Fintype α] [DecidableEq α] (f : α → ℕ) (N : ℕ)

omit [DecidableEq α] in
/-- Step 2（互いに素）を `Finset.sum_biUnion` が要求する形へ言い換えたもの。 -/
lemma fiber_pairwiseDisjoint :
    (↑(range (N + 1)) : Set ℕ).PairwiseDisjoint (fiber f) := by
  intro m hm m' hm' hne
  exact fiber_pairwise_disjoint f N m (by simpa using hm) m' (by simpa using hm') hne

omit [DecidableEq α] in
/-- Step 4。1 つの類 `fiber f m` の中では `f a = m` なので、足し合わせる値はどれも `g m` に等しい。 -/
lemma sum_fiber_const {M : Type*} [AddCommMonoid M] (g : ℕ → M) (m : ℕ) :
    ∑ a ∈ fiber f m, g (f a) = (fiber f m).card • g m := by
  have hterm : ∀ a ∈ fiber f m, g (f a) = g m := by
    intro a ha
    simp only [fiber, mem_filter] at ha
    rw [ha.2]
  rw [sum_congr rfl hterm, sum_const]

/-- Step 5（結論）。値 `f a` だけで決まる量の全体和は、値ごとの個数で束ねられる。 -/
theorem sum_comp_eq_sum_nsmul {M : Type*} [AddCommMonoid M] (g : ℕ → M) (hf : ∀ a, f a ≤ N) :
    ∑ a : α, g (f a) = ∑ m ∈ range (N + 1), (fiber f m).card • g m := by
  -- Step 2（被覆）
  rw [← biUnion_fiber f N hf]
  -- Step 3
  rw [sum_biUnion (fiber_pairwiseDisjoint f N)]
  -- Step 4
  exact sum_congr rfl fun m _ => sum_fiber_const f g m

end Ising2DLambda.NecSuf.PartitionPolynomial
