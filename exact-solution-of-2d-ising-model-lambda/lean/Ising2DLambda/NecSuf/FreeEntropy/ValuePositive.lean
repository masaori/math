/-
主張「分配多項式の正の有理点での値は正の有理数である」の必要十分版。

具体版（`Ising2DLambda.FreeEntropy.ValuePositive`）の証明が実際に使っているのは次だけである。
値が有理数であること・多項式であること・添字が配位であること・指数が破れボンド数であること・
格子の形は、どこにも使っていない。

  使っている性質              なぜ削れないか
  `StrictOrderedSemiring K`   Step 2 で「正の元の積は正」（`pow_pos`）に要る。
                              Step 3 で「正の元どうしの和は正」に要る。
                              順序と半環の両立が無いと、どちらの段も言えない。
  `Fintype ι`                 Step 1 の和が有限和であること。無限和は意味をなさない。
  `Nonempty ι`                Step 3 で和が少なくとも 1 項を持つこと。
                              これが無いと空和 `0` になり、正であることが崩れる
                              （具体版ではこれが `|Σ_L| = 2^{L²} ≥ 1` にあたる）。

指数写像 `f : ι → ℕ` には何も仮定していない（有界性すら要らない）。
すなわちこの版が言っているのは「正の元の冪を空でない有限個足すと正」ということである。

証明手順は具体版と同じ Step 2–3 である（別の論法へ差し替えていない）。
Step 1（代入を和へ配る）は具体版に固有の書き換えなので、ここでは和の形を仮定として受け取る。

住処: ここに ℝ / ℂ は現れない（指数は ℕ、値は一般の狭義順序半環）。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.FreeEntropy

open Finset

/-- Step 2–3。正の元 `q` の冪を、空でない有限添字集合の上で足したものは正である。 -/
theorem sum_pow_pos {ι : Type*} [Fintype ι] [Nonempty ι]
    {K : Type*} [Semiring K] [PartialOrder K] [IsStrictOrderedRing K]
    (f : ι → ℕ) {q : K} (hq : 0 < q) :
    0 < ∑ i : ι, q ^ f i := by
  -- Step 3。空でない有限個の正の元の和は正。
  refine sum_pos (fun i _ => ?_) univ_nonempty
  -- Step 2。正の元の冪は正（0 乗は 1 で、これも正）。
  exact pow_pos hq (f i)

end Ising2DLambda.NecSuf.FreeEntropy
