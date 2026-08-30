/-
必要十分版: 有限集合上の単射な自己写像について、動く点だけから作った軌道族は
動く点の集合を互いに素に分割する。

使う構造は有限性、相等の判定、写像の単射性、各点の回帰の存在だけである。
全射性、格子、辺、非後退関係は使わない。
-/
import Ising2DLambda.NecSuf.KacWard.MovedOrbitClosedWalk
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbitPartition

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {E : Type} [Fintype E] [DecidableEq E]

/-- 自己写像が動かす点の有限集合。 -/
def movedSet (f : E → E) : Finset E :=
  univ.filter fun e => f e ≠ e

lemma mem_movedSet {f : E → E} {e : E} : e ∈ movedSet f ↔ f e ≠ e := by
  simp [movedSet]

/-- 動く点を始点とする相異なる軌道の有限族。`Finset.image` が同じ軌道を一度だけ残す。 -/
noncomputable def movedOrbitSet (f : E → E) : Finset (Finset E) :=
  open Classical in (movedSet f).image (orbit f)

lemma mem_movedOrbitSet {f : E → E} {O : Finset E} :
    O ∈ movedOrbitSet f ↔ ∃ e ∈ movedSet f, orbit f e = O := by
  classical
  simp [movedOrbitSet]

/-- 動く点の軌道族は動く点集合を分割する。 -/
theorem movedOrbitSet_partition (f : E → E) (hf : Function.Injective f)
    (hreturn : ∀ e : E, ∃ k, 1 ≤ k ∧ iterLeft f k e = e) :
    (∀ O ∈ movedOrbitSet f, O.Nonempty)
      ∧ (∀ O₁ ∈ movedOrbitSet f, ∀ O₂ ∈ movedOrbitSet f,
          O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (movedOrbitSet f).biUnion id = movedSet f := by
  classical
  refine ⟨?_, ?_, ?_⟩
  · -- 各軌道は始点を含む。
    intro O hO
    obtain ⟨e, he, rfl⟩ := mem_movedOrbitSet.mp hO
    exact ⟨e, self_mem_orbit f e⟩
  · -- 二軌道が交われば、軌道の元の軌道を前向きに辿って一致する。
    intro O₁ hO₁ O₂ hO₂ hne
    obtain ⟨e₁, he₁, rfl⟩ := mem_movedOrbitSet.mp hO₁
    obtain ⟨e₂, he₂, rfl⟩ := mem_movedOrbitSet.mp hO₂
    rw [Finset.disjoint_left]
    intro a ha₁ ha₂
    apply hne
    exact orbit_eq_of_inter_nonempty f e₁ e₂ (hreturn e₁) (hreturn e₂)
      ⟨a, mem_inter.mpr ⟨ha₁, ha₂⟩⟩
  · -- 合併が動く点集合に等しいことを両包含で示す。
    ext a
    constructor
    · intro ha
      obtain ⟨O, hO, haO⟩ := mem_biUnion.mp ha
      obtain ⟨e, he, rfl⟩ := mem_movedOrbitSet.mp hO
      obtain ⟨k, hk⟩ := mem_orbit.mp haO
      rw [hk, mem_movedSet]
      have hiter : ∀ (n : ℕ) (x : E), iterLeft f n x = f^[n] x := by
        intro n
        induction n with
        | zero => intro x; rfl
        | succ n ih =>
          intro x
          simp only [iterLeft, Function.iterate_succ_apply']
          rw [ih]
      rw [hiter k e]
      exact moved_iterate_ne hf (mem_movedSet.mp he) k
    · intro ha
      exact mem_biUnion.mpr
        ⟨orbit f a, mem_movedOrbitSet.mpr ⟨a, ha, rfl⟩, self_mem_orbit f a⟩

end Ising2DLambda.NecSuf.KacWard
