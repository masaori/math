/-
「二本の閉歩道の切断線偶奇の和は元の切断線偶奇に等しい」（`claim_smoothing_split_seam_parity`）の
必要十分版。具体版 `closedWalk_smoothing_split_seam_parity` と同じ手順で、辺・切断線・閉歩道・
剰余の添字を使わない。使うのは次だけである。
- 値は加法可換モノイド（二本の和の並べ替えと、互いに素な有限和の分割に可換性が要る）。
- 添字は有限集合 `ι`。二本の位置から添字への写像 `iA`・`iB` は単射で、像が `A` と補集合 `Aᶜ`。
- 偶奇の読み取りは、値の集合から任意の集合への写像 `read`（具体版では二で割った余り）。
  和の等式を得た後に両辺へ同じ写像を施すだけなので、`read` に性質は要らない。
単射性は、像の上の和を位置の上の和へ移すために要る（同じ添字を二度数えないため）。
-/
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 二本の位置の上の和の和は、添字全体の上の和である。 -/
theorem split_position_sum_necSuf {M ι : Type} [AddCommMonoid M] [Fintype ι] [DecidableEq ι]
    (A : Finset ι) (g : ι → M) {nA nB : ℕ}
    (iA : Fin nA → ι) (iB : Fin nB → ι)
    (hiA : Function.Injective iA) (hiB : Function.Injective iB)
    (hA : univ.image iA = A) (hB : univ.image iB = Aᶜ) :
    (∑ j, g (iA j)) + ∑ j, g (iB j) = ∑ r, g r := by
  calc (∑ j, g (iA j)) + ∑ j, g (iB j)
      = (∑ r ∈ univ.image iA, g r) + ∑ r ∈ univ.image iB, g r := by
        rw [Finset.sum_image (fun x _ y _ h => hiA h),
          Finset.sum_image (fun x _ y _ h => hiB h)]
    _ = (∑ r ∈ A, g r) + ∑ r ∈ Aᶜ, g r := by rw [hA, hB]
    _ = ∑ r, g r := Finset.sum_add_sum_compl A g

/-- 二成分のそれぞれで和を分割してから読み取る。 -/
theorem split_position_reading_pair_necSuf {M P ι : Type} [AddCommMonoid M] [Fintype ι]
    [DecidableEq ι] (A : Finset ι) (horizontal vertical : ι → M) (read : M → P) {nA nB : ℕ}
    (iA : Fin nA → ι) (iB : Fin nB → ι)
    (hiA : Function.Injective iA) (hiB : Function.Injective iB)
    (hA : univ.image iA = A) (hB : univ.image iB = Aᶜ) :
    (read ((∑ j, horizontal (iA j)) + ∑ j, horizontal (iB j)),
      read ((∑ j, vertical (iA j)) + ∑ j, vertical (iB j))) =
    (read (∑ r, horizontal r), read (∑ r, vertical r)) := by
  rw [split_position_sum_necSuf A horizontal iA iB hiA hiB hA hB,
    split_position_sum_necSuf A vertical iA iB hiA hiB hA hB]

end Ising2DLambda.NecSuf.KacWard
