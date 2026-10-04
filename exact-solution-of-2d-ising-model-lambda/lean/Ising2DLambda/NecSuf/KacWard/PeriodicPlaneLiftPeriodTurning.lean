/-
周期持ち上げの一周期の隣接和を、元の有限列へ戻す。
点は可換加法群、回転の重みは可換加法モノイドへ一般化できる。
点の可換性は (p + v) - p = v に、値の可換性は有限和の添字変更に使う。
単位歩・方向・非後退性・回転表の反対称性はこの論法に不要である。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.NecSuf.KacWard.PlaneProjectionCyclicTurning
import Ising2DLambda.NecSuf.KacWard.CyclicShiftAdjacentSum
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.KacWard

/-- 内部の m-1 項と閉じ目を、剰余類全体の隣接和へ書き換える。 -/
theorem cyclicAdjacentSum_zmod {α M : Type*} [AddCommMonoid M]
    (m : ℕ) [NeZero m] (weight : α → α → M) (v : ZMod m → α) :
    cyclicAdjacentSum weight m (fun j => v (j : ZMod m)) =
      ∑ j : ZMod m, weight (v j) (v (j + 1)) := by
  let f : ℕ → M := fun j => weight (v (j : ZMod m)) (v ((j + 1 : ℕ) : ZMod m))
  have hcast (i : Fin m) : ZMod.finEquiv m i = (i.val : ZMod m) := by
    cases m with
    | zero => exact Fin.elim0 i
    | succ n => exact (ZMod.natCast_zmod_val (n := n + 1) i).symm
  have hsum : (∑ j : ZMod m, weight (v j) (v (j + 1))) =
      ∑ j ∈ Finset.range m, f j := by
    calc
      _ = ∑ i : Fin m, weight (v (ZMod.finEquiv m i))
          (v (ZMod.finEquiv m i + 1)) :=
        (Equiv.sum_comp (ZMod.finEquiv m).toEquiv (fun j => weight (v j) (v (j + 1)))).symm
      _ = ∑ i : Fin m, f i.val := by
        apply Finset.sum_congr rfl
        intro i _
        simp only [hcast, f, Nat.cast_add, Nat.cast_one]
      _ = ∑ j ∈ Finset.range m, f j := Fin.sum_univ_eq_sum_range f m
  have hm : m - 1 + 1 = m := Nat.sub_add_cancel (NeZero.one_le : 1 ≤ m)
  have hlast : f (m - 1) = weight (v ((m - 1 : ℕ) : ZMod m)) (v 0) := by
    dsimp only [f]
    rw [hm, ZMod.natCast_self]
  calc
    _ = (∑ j ∈ Finset.range (m - 1), f j) + f (m - 1) := by
      rw [hlast]
      simp only [cyclicAdjacentSum, f, Nat.cast_zero]
    _ = ∑ j ∈ Finset.range (m - 1 + 1), f j := (Finset.sum_range_succ f (m - 1)).symm
    _ = ∑ j ∈ Finset.range m, f j := by rw [hm]
    _ = _ := hsum.symm

/-- 一周期内の漸化式と端点の並進から、任意整数位置の一歩を導く。 -/
theorem integerPeriodicLift_period_step_necSuf {G : Type*} [AddCommGroup G]
    (m : ℕ) [NeZero m] (base : ℤ → G) (shift : G) (v : ZMod m → G)
    (hstep : ∀ j : ℕ, j < m → base ((j : ℤ) + 1) = base j + v (j : ZMod m))
    (hend : base m = base 0 + shift) (k : ℤ) :
    integerPeriodicLift m base shift (k + 1) - integerPeriodicLift m base shift k =
      v (k : ZMod m) := by
  have hm : 0 < m := NeZero.pos m
  have hmz : (m : ℤ) ≠ 0 := by omega
  have hbase (j : ℕ) (hj : j < m) :
      integerPeriodicLift m base shift j = base j := by
    simp [integerPeriodicLift, Int.emod_eq_of_lt (by omega : (0 : ℤ) ≤ j)
      (by omega : (j : ℤ) < m), Int.ediv_eq_zero_of_lt (by omega : (0 : ℤ) ≤ j)
      (by omega : (j : ℤ) < m)]
  have hterminal : integerPeriodicLift m base shift m = base m := by
    simp [integerPeriodicLift, Int.ediv_self hmz, hend]
  have hfinite (j : ℕ) (hj : j < m) :
      integerPeriodicLift m base shift ((j : ℤ) + 1) - integerPeriodicLift m base shift j =
        v (j : ZMod m) := by
    have hnext : integerPeriodicLift m base shift ((j : ℤ) + 1) = base ((j : ℤ) + 1) := by
      by_cases hlt : j + 1 < m
      · exact_mod_cast hbase (j + 1) hlt
      · have heq : (j : ℤ) + 1 = m := by omega
        rw [heq, hterminal]
    rw [hnext, hbase j hj, hstep j hj]
    abel
  -- 本文と同じく、まず任意整数位置を余りの位置へ戻す。
  calc
    _ = integerPeriodicLift m base shift (k % m + 1) -
        integerPeriodicLift m base shift (k % m) := by
      simpa only [zero_add] using
        integerPeriodicLift_step_remainder_necSuf m hmz base shift 0 k
    _ = integerPeriodicLift m base shift (((k : ZMod m).val : ℤ) + 1) -
        integerPeriodicLift m base shift ((k : ZMod m).val : ℤ) := by
      rw [ZMod.val_intCast]
    _ = v ((k : ZMod m).val : ZMod m) := hfinite _ (ZMod.val_lt _)
    _ = v (k : ZMod m) := by rw [ZMod.natCast_zmod_val]

/-- `claim_periodic_plane_lift_period_turning`。一歩の同定、閉じ目の吸収、巡回移動の順。 -/
theorem integerPeriodicLift_periodAdjacentSum_necSuf
    {G M : Type*} [AddCommGroup G] [AddCommMonoid M]
    (m : ℕ) [NeZero m] (base : ℤ → G) (shift : G) (v : ZMod m → G)
    (weight : G → G → M)
    (hstep : ∀ j : ℕ, j < m → base ((j : ℤ) + 1) = base j + v (j : ZMod m))
    (hend : base m = base 0 + shift) (k₀ : ℤ) :
    cyclicAdjacentSum weight m
        (fun j => integerPeriodicLift m base shift (k₀ + j + 1) -
          integerPeriodicLift m base shift (k₀ + j)) =
      ∑ j : ZMod m, weight (v j) (v (j + 1)) := by
  have hsteps : (fun j : ℕ => integerPeriodicLift m base shift (k₀ + j + 1) -
      integerPeriodicLift m base shift (k₀ + j)) =
      (fun j : ℕ => v ((j : ZMod m) + (k₀ : ZMod m))) := by
    funext j
    rw [integerPeriodicLift_period_step_necSuf m base shift v hstep hend]
    simp [Int.cast_add, add_comm]
  let shiftIndex : Equiv.Perm (ZMod m) :=
    ⟨fun j => j + (k₀ : ZMod m), fun j => j - (k₀ : ZMod m),
      fun j => add_sub_cancel_right j _, fun j => sub_add_cancel j _⟩
  have hnext (j : ZMod m) : shiftIndex (j + 1) = shiftIndex j + 1 := by
    change (j + 1) + (k₀ : ZMod m) = (j + (k₀ : ZMod m)) + 1
    abel
  calc
    _ = cyclicAdjacentSum weight m (fun j => v ((j : ZMod m) + (k₀ : ZMod m))) :=
      congrArg (cyclicAdjacentSum weight m) hsteps
    _ = ∑ j : ZMod m, weight (v (j + (k₀ : ZMod m)))
        (v ((j + 1) + (k₀ : ZMod m))) :=
      cyclicAdjacentSum_zmod m weight (fun j => v (j + (k₀ : ZMod m)))
    _ = _ := permutedAdjacentSum_necSuf (fun j => j + 1) shiftIndex hnext
      (fun i j => weight (v i) (v j))

end Ising2DLambda.NecSuf.KacWard
