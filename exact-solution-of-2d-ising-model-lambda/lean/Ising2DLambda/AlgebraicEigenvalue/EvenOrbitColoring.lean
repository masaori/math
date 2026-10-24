import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitEnumeration
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitBasepoint
import Mathlib.Data.Finset.Max

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

noncomputable def finitePermutationOrbitPoints (σ : Equiv.Perm J) (i : J) : Finset J :=
  open Classical in Set.toFinset (finitePermutationOrbit σ i)

theorem finitePermutationOrbitPoints_nonempty (σ : Equiv.Perm J) (i : J) :
    (finitePermutationOrbitPoints σ i).Nonempty := by
  classical
  exact ⟨i, Set.mem_toFinset.mpr (finitePermutationOrbit_self_mem σ i)⟩

variable [LinearOrder J]

/-- 本文の軌道最小元。空の添字集合にも追加の仮定を置かない。 -/
noncomputable def finitePermutationOrbitMinimum (σ : Equiv.Perm J) (i : J) : J :=
  (finitePermutationOrbitPoints σ i).min' (finitePermutationOrbitPoints_nonempty σ i)

theorem finitePermutationOrbitMinimum_mem (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitMinimum σ i ∈ finitePermutationOrbit σ i := by
  classical
  exact Set.mem_toFinset.mp (Finset.min'_mem _ _)

/-- 台の一致から二つの所属を移し、二つの比較と反対称律を使う。 -/
theorem finitePermutationOrbitMinimum_eq_of_mem (σ : Equiv.Perm J) (i j : J)
    (hj : j ∈ finitePermutationOrbit σ i) :
    finitePermutationOrbitMinimum σ j = finitePermutationOrbitMinimum σ i := by
  classical
  have hsets := finitePermutationOrbit_basepoint σ i j hj
  have hmj : finitePermutationOrbitMinimum σ j ∈ finitePermutationOrbitPoints σ i := by
    apply Set.mem_toFinset.mpr
    rw [← hsets]
    exact finitePermutationOrbitMinimum_mem σ j
  have hmi : finitePermutationOrbitMinimum σ i ∈ finitePermutationOrbitPoints σ j := by
    apply Set.mem_toFinset.mpr
    rw [hsets]
    exact finitePermutationOrbitMinimum_mem σ i
  have hle : finitePermutationOrbitMinimum σ j ≤ finitePermutationOrbitMinimum σ i :=
    Finset.min'_le _ _ hmi
  have hge : finitePermutationOrbitMinimum σ i ≤ finitePermutationOrbitMinimum σ j :=
    Finset.min'_le _ _ hmj
  exact le_antisymm hle hge

theorem finitePermutationOrbitMinimum_apply (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitMinimum σ (σ i) = finitePermutationOrbitMinimum σ i :=
  finitePermutationOrbitMinimum_eq_of_mem σ i (σ i)
    (finitePermutationOrbit_apply_mem σ i i (finitePermutationOrbit_self_mem σ i))

theorem finitePermutationOrbitCoordinate_exists (σ : Equiv.Perm J) (i : J) :
    ∃ r : ℕ, r < finitePermutationMinimalPeriod σ (finitePermutationOrbitMinimum σ i) ∧
      finiteMapIterate σ r (finitePermutationOrbitMinimum σ i) = i :=
  (finitePermutationOrbit_mem_iff_lt_period σ _ i).mp
    (finitePermutationOrbit_mem_symm σ i _ (finitePermutationOrbitMinimum_mem σ i))

/-- 本文の短い反復座標。存在は列挙、選択の一意性は短い反復の単射性による。 -/
noncomputable def finitePermutationOrbitCoordinate (σ : Equiv.Perm J) (i : J) : ℕ :=
  Classical.choose (finitePermutationOrbitCoordinate_exists σ i)

theorem finitePermutationOrbitCoordinate_spec (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitCoordinate σ i <
        finitePermutationMinimalPeriod σ (finitePermutationOrbitMinimum σ i) ∧
      finiteMapIterate σ (finitePermutationOrbitCoordinate σ i)
        (finitePermutationOrbitMinimum σ i) = i :=
  Classical.choose_spec (finitePermutationOrbitCoordinate_exists σ i)

theorem finitePermutationOrbitCoordinate_unique (σ : Equiv.Perm J) (i : J) (r : ℕ)
    (hr : r < finitePermutationMinimalPeriod σ (finitePermutationOrbitMinimum σ i))
    (heq : finiteMapIterate σ r (finitePermutationOrbitMinimum σ i) = i) :
    finitePermutationOrbitCoordinate σ i = r := by
  have hs := finitePermutationOrbitCoordinate_spec σ i
  exact finitePermutationIterate_injOn_period σ _ hs.1 hr (hs.2.trans heq.symm)

/-- `def_even_orbit_coloring` の第一色。 -/
noncomputable def finitePermutationEvenColor (σ : Equiv.Perm J) : Finset J := by
  classical
  exact Finset.univ.filter (fun i => finitePermutationOrbitCoordinate σ i % 2 = 0)

@[simp] theorem finitePermutationEvenColor_mem (σ : Equiv.Perm J) (i : J) :
    i ∈ finitePermutationEvenColor σ ↔ finitePermutationOrbitCoordinate σ i % 2 = 0 := by
  classical
  simp only [finitePermutationEvenColor, Finset.mem_filter, Finset.mem_univ, true_and]

/-- 最小元から最小元への短い反復は零回だけである。 -/
theorem finitePermutationOrbitCoordinate_minimum (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitCoordinate σ (finitePermutationOrbitMinimum σ i) = 0 := by
  have hm := finitePermutationOrbitMinimum_eq_of_mem σ i _
    (finitePermutationOrbitMinimum_mem σ i)
  apply finitePermutationOrbitCoordinate_unique σ _ 0
  · exact (finitePermutationMinimalPeriod_spec σ _).1
  · change finitePermutationOrbitMinimum σ (finitePermutationOrbitMinimum σ i) = _
    exact hm

theorem finitePermutationEvenColor_minimum_mem (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbitMinimum σ i ∈ finitePermutationEvenColor σ := by
  rw [finitePermutationEvenColor_mem, finitePermutationOrbitCoordinate_minimum]

/-- 本文の非末端と末端の二場合。一意性によって次の座標を同定する。 -/
theorem finitePermutationEvenColor_alternates (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    σ i ∈ finitePermutationEvenColor σ ↔ i ∉ finitePermutationEvenColor σ := by
  let m := finitePermutationOrbitMinimum σ i
  let p := finitePermutationMinimalPeriod σ m
  let r := finitePermutationOrbitCoordinate σ i
  have hs := finitePermutationOrbitCoordinate_spec σ i
  have hr : r < p := hs.1
  have hm := finitePermutationOrbitMinimum_apply σ i
  have hp : 0 < p := (finitePermutationMinimalPeriod_spec σ m).1
  have hpar : p % 2 = 0 := by
    apply Nat.even_iff.mp
    change Even (finitePermutationMinimalPeriod σ m)
    rw [finitePermutationMinimalPeriod_eq_orbitLength]
    exact heven m
  have hstep : finiteMapIterate σ (r + 1) m = σ i := by
    calc
      finiteMapIterate σ (r + 1) m = finiteMapIterate σ r (σ m) := rfl
      _ = σ (finiteMapIterate σ r m) := (finiteMapIterate_commute σ r m).symm
      _ = σ i := congrArg σ hs.2
  by_cases hnext : r + 1 < p
  · have hcoord : finitePermutationOrbitCoordinate σ (σ i) = r + 1 := by
      apply finitePermutationOrbitCoordinate_unique σ (σ i) (r + 1)
      · rw [hm]
        exact hnext
      · rw [hm]
        exact hstep
    rw [finitePermutationEvenColor_mem, finitePermutationEvenColor_mem, hcoord]
    change (r + 1) % 2 = 0 ↔ ¬ r % 2 = 0
    rcases Nat.mod_two_eq_zero_or_one r with hzero | hone
    · have hodd : (r + 1) % 2 = 1 := by
        calc
          (r + 1) % 2 = (r % 2 + 1) % 2 := by omega
          _ = (0 + 1) % 2 := by rw [hzero]
          _ = 1 := rfl
      omega
    · have hevenNext : (r + 1) % 2 = 0 := by
        calc
          (r + 1) % 2 = (r % 2 + 1) % 2 := by omega
          _ = (1 + 1) % 2 := by rw [hone]
          _ = 0 := rfl
      omega
  · have hend : r + 1 = p := by omega
    have hreturn : σ i = m := by
      calc
        σ i = finiteMapIterate σ (r + 1) m := hstep.symm
        _ = finiteMapIterate σ p m := congrArg (fun n => finiteMapIterate σ n m) hend
        _ = m := (finitePermutationMinimalPeriod_spec σ m).2.1
    have hcoord : finitePermutationOrbitCoordinate σ (σ i) = 0 := by
      apply finitePermutationOrbitCoordinate_unique σ (σ i) 0
      · rw [hm]
        exact hp
      · change finitePermutationOrbitMinimum σ (σ i) = σ i
        exact hm.trans hreturn.symm
    rw [finitePermutationEvenColor_mem, finitePermutationEvenColor_mem, hcoord]
    change 0 % 2 = 0 ↔ ¬ r % 2 = 0
    have hnot : ¬ r % 2 = 0 := by
      intro hzero
      have hfalse : (0 : ℕ) = 1 := by
        calc
          0 = p % 2 := hpar.symm
          _ = (r + 1) % 2 := congrArg (fun n => n % 2) hend.symm
          _ = (r % 2 + 1) % 2 := by omega
          _ = (0 + 1) % 2 := by rw [hzero]
          _ = 1 := rfl
      exact Nat.zero_ne_one hfalse
    exact iff_of_true rfl hnot

end Ising2DLambda.AlgebraicEigenvalue
