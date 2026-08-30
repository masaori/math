/-
「横断の平滑化は循環総回転数を保つ」の必要十分版。
有限和が二つの項だけで変わり、その二項の和が変わらないなら、全体の和は変わらない。
格子・回転数・横断の構造は使わない。

- 仮定 `AddCommMonoid` は、有限集合上の和の並べ替え（結合性と可換性）に必要である。
  簡約も順序も整除も要らない。
- 仮定 `hpair`（二項の和の保存）と `hother`（他項の一致）が、人手証明の
  「新しい二項の和は零、古い二項の和も零、他の項は不変」に対応する。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 有限和が二点だけで変わり、二点の和が保たれるなら、全体の和は保たれる。 -/
theorem two_point_preserved_sum_necSuf {ι : Type} [Fintype ι] [DecidableEq ι]
    {M : Type} [AddCommMonoid M] (f g : ι → M) (a b : ι) (hab : a ≠ b)
    (hpair : g a + g b = f a + f b)
    (hother : ∀ r, r ≠ a → r ≠ b → g r = f r) :
    ∑ r : ι, g r = ∑ r : ι, f r := by
  have hbmem : b ∈ Finset.univ.erase a :=
    Finset.mem_erase.mpr ⟨Ne.symm hab, Finset.mem_univ b⟩
  -- 和を「二点以外」「b の項」「a の項」へ分ける
  have h1f : ((Finset.univ.erase a).erase b).sum f + f b = (Finset.univ.erase a).sum f :=
    Finset.sum_erase_add _ f hbmem
  have h2f : (Finset.univ.erase a).sum f + f a = Finset.univ.sum f :=
    Finset.sum_erase_add _ f (Finset.mem_univ a)
  have h1g : ((Finset.univ.erase a).erase b).sum g + g b = (Finset.univ.erase a).sum g :=
    Finset.sum_erase_add _ g hbmem
  have h2g : (Finset.univ.erase a).sum g + g a = Finset.univ.sum g :=
    Finset.sum_erase_add _ g (Finset.mem_univ a)
  -- 二点以外の項は一致する
  have hrest : ((Finset.univ.erase a).erase b).sum g =
      ((Finset.univ.erase a).erase b).sum f := by
    apply Finset.sum_congr rfl
    intro r hr
    exact hother r (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hr))
      (Finset.ne_of_mem_erase hr)
  have hg : ∑ r : ι, g r = ((Finset.univ.erase a).erase b).sum g + (g a + g b) := by
    rw [← h2g, ← h1g]; abel
  have hf : ∑ r : ι, f r = ((Finset.univ.erase a).erase b).sum f + (f a + f b) := by
    rw [← h2f, ← h1f]; abel
  rw [hg, hf, hrest, hpair]

end Ising2DLambda.NecSuf.KacWard
