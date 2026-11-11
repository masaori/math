/-
「二本の閉歩道の循環総回転数の和は元の循環総回転数に等しい」（`claim_smoothing_split_turning_sum`）の
二つの準備と合併の段の必要十分版。具体版 `smoothing_split_walk_turning_sum` と同じ手順で、
辺・回転数・格子・剰余の添字を使わない。使うのは次だけである。
- 値は加法可換モノイド（二本の和の並べ替えと、互いに素な有限和の分割に可換性が要る）。
- 添字は有限集合 `ι`。二本の位置から添字への写像 `iA`・`iB` は単射で、像が `A` と補集合 `Aᶜ`。
- 各本の循環総回転数は「内部の項の和 + 閉じる項」で、各項が位置の写像を通した `g` の値に等しい。
単射性は、像の上の和を位置の上の和へ移すために要る（同じ添字を二度数えないため）。
-/
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 一本の区間: 内部の項の和と閉じる項の和は、像の上の `g` の和である。 -/
theorem segment_cyclic_sum_necSuf {M ι : Type} [AddCommMonoid M] [DecidableEq ι]
    (S : Finset ι) (g : ι → M) {n : ℕ} (i : Fin (n + 1) → ι)
    (hi : Function.Injective i) (himg : univ.image i = S)
    (t : Fin n → M) (c : M)
    (ht : ∀ j, t j = g (i j.castSucc)) (hc : c = g (i (Fin.last n))) :
    (∑ j, t j) + c = ∑ r ∈ S, g r := by
  calc (∑ j, t j) + c
      = (∑ j : Fin n, g (i j.castSucc)) + g (i (Fin.last n)) := by
        rw [Finset.sum_congr rfl (fun j _ => ht j), hc]
    _ = ∑ j : Fin (n + 1), g (i j) := (Fin.sum_univ_castSucc (fun j => g (i j))).symm
    _ = ∑ r ∈ univ.image i, g r :=
        (Finset.sum_image (fun x _ y _ h => hi h)).symm
    _ = ∑ r ∈ S, g r := by rw [himg]

/-- 二本の区間の和は、添字全体の上の `g` の和である。 -/
theorem split_cyclic_sum_necSuf {M ι : Type} [AddCommMonoid M] [Fintype ι] [DecidableEq ι]
    (A : Finset ι) (g : ι → M) {nA nB : ℕ}
    (iA : Fin (nA + 1) → ι) (iB : Fin (nB + 1) → ι)
    (hiA : Function.Injective iA) (hiB : Function.Injective iB)
    (hA : univ.image iA = A) (hB : univ.image iB = Aᶜ)
    (tA : Fin nA → M) (cA : M) (tB : Fin nB → M) (cB : M)
    (htA : ∀ j, tA j = g (iA j.castSucc)) (hcA : cA = g (iA (Fin.last nA)))
    (htB : ∀ j, tB j = g (iB j.castSucc)) (hcB : cB = g (iB (Fin.last nB))) :
    ((∑ j, tA j) + cA) + ((∑ j, tB j) + cB) = ∑ r, g r := by
  calc ((∑ j, tA j) + cA) + ((∑ j, tB j) + cB)
      = (∑ r ∈ A, g r) + ∑ r ∈ Aᶜ, g r := by
        rw [segment_cyclic_sum_necSuf A g iA hiA hA tA cA htA hcA,
          segment_cyclic_sum_necSuf Aᶜ g iB hiB hB tB cB htB hcB]
    _ = ∑ r, g r := Finset.sum_add_sum_compl A g

end Ising2DLambda.NecSuf.KacWard
