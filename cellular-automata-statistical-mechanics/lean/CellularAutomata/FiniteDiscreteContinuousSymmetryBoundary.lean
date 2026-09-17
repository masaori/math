/-
正本: content/finite-discrete-continuous-symmetry-boundary.ts の具体版。

def_binary_ca_commuting_configuration_symmetries
  → commutingSymmetryGroup
claim_binary_ca_commuting_configuration_symmetries_finite_group
  → commutingSymmetryGroup_isFinite
def_binary_ca_integer_conserved_observable_group
  → conservedObservableGroup
claim_binary_ca_integer_conserved_observables_additive_group
  → conservedObservableGroup_isAddGroup
claim_binary_ca_symmetry_pullback_preserves_conserved_observables
  → pullbackConservedObservable, pullback_mem, pullback_identity, pullback_multiplication
def_binary_ca_real_parameter_symmetry_action
  → RealParameterAction
claim_binary_ca_real_parameter_symmetry_action_trivial
  → realParameterAction_trivial

有限舞台、二元状態、整数値保存写像、実数加法群に固定し、本文と同じ順序で示す。
位相、極限、微分、対数は使わない。実数体は一径数作用のパラメータと、
有限群の位数の階乗による除法可能性にだけ使う。
-/
import Mathlib.Data.Real.Basic
import Mathlib.GroupTheory.OrderOfElement

namespace CellularAutomata.FiniteDiscreteContinuousSymmetryBoundary

variable {V : Type} [Fintype V]

abbrev Configuration (V : Type) := V → Bool

def CommutesWith (F : Configuration V → Configuration V)
    (sigma : Equiv.Perm (Configuration V)) : Prop :=
  ∀ x, sigma (F x) = F (sigma x)

/-- 有限二元配位上で大域写像と可換する置換からなる群。 -/
def commutingSymmetryGroup (F : Configuration V → Configuration V) :
    Subgroup (Equiv.Perm (Configuration V)) where
  carrier := {sigma | CommutesWith F sigma}
  one_mem' := by
    intro x
    rfl
  mul_mem' := by
    intro sigma tau hsigma htau x
    change sigma (tau (F x)) = F (sigma (tau x))
    rw [htau x, hsigma (tau x)]
  inv_mem' := by
    intro sigma hsigma x
    change sigma.symm (F x) = F (sigma.symm x)
    apply sigma.injective
    rw [sigma.apply_symm_apply, hsigma (sigma.symm x), sigma.apply_symm_apply]

/-- 可換する配位置換の群は有限である。 -/
theorem commutingSymmetryGroup_isFinite
    (F : Configuration V → Configuration V) :
    Finite (commutingSymmetryGroup F) := by
  infer_instance

/-- 大域写像で保存される整数値写像からなる加法群。 -/
def conservedObservableGroup (F : Configuration V → Configuration V) :
    AddSubgroup (Configuration V → ℤ) where
  carrier := {H | ∀ x, H (F x) = H x}
  zero_mem' := by
    intro x
    rfl
  add_mem' := by
    intro H K hH hK x
    change H (F x) + K (F x) = H x + K x
    rw [hH x, hK x]
  neg_mem' := by
    intro H hH x
    change -H (F x) = -H x
    rw [hH x]

/-- 可換対称性による整数値保存写像の引き戻し。 -/
def pullbackConservedObservable (F : Configuration V → Configuration V)
    (sigma : commutingSymmetryGroup F) (H : conservedObservableGroup F) :
    Configuration V → ℤ :=
  fun x => H.1 (sigma.1.symm x)

/-- 引き戻した整数値写像も保存される。 -/
theorem pullback_mem (F : Configuration V → Configuration V)
    (sigma : commutingSymmetryGroup F) (H : conservedObservableGroup F) :
    ∀ x, pullbackConservedObservable F sigma H (F x) =
      pullbackConservedObservable F sigma H x := by
  intro x
  change H.1 (sigma.1.symm (F x)) = H.1 (sigma.1.symm x)
  have hinverse : sigma.1.symm (F x) = F (sigma.1.symm x) := by
    apply sigma.1.injective
    simpa only [Equiv.apply_symm_apply] using
      (sigma.2 (sigma.1.symm x)).symm
  rw [hinverse, H.2]

/-- 恒等対称性による引き戻しは元の保存写像である。 -/
theorem pullback_identity (F : Configuration V → Configuration V)
    (H : conservedObservableGroup F) :
    pullbackConservedObservable F 1 H = H := by
  funext x
  change H.1 x = H.1 x
  rfl

/-- 対称性の積による引き戻しは、順に引き戻す左作用と一致する。 -/
theorem pullback_multiplication (F : Configuration V → Configuration V)
    (sigma tau : commutingSymmetryGroup F) (H : conservedObservableGroup F) :
    pullbackConservedObservable F (sigma * tau) H =
      pullbackConservedObservable F sigma
        ⟨pullbackConservedObservable F tau H, pullback_mem F tau H⟩ := by
  funext x
  rfl

/-- 実数加法群から有限配位対称群への作用。位相的連続性は仮定しない。 -/
structure RealParameterAction (F : Configuration V → Configuration V) where
  toFun : ℝ → commutingSymmetryGroup F
  map_zero : toFun 0 = 1
  map_add : ∀ s t, toFun (s + t) = toFun s * toFun t

namespace RealParameterAction

theorem map_nsmul_as_pow (F : Configuration V → Configuration V)
    (Theta : RealParameterAction F) (n : ℕ) (t : ℝ) :
    Theta.toFun (n • t) = Theta.toFun t ^ n := by
  induction n with
  | zero => simpa using Theta.map_zero
  | succ n ih =>
      rw [succ_nsmul, Theta.map_add, ih, pow_succ]

end RealParameterAction

/-- 有限配位上の実数加法群作用は恒等置換だけを取る。 -/
theorem realParameterAction_trivial (F : Configuration V → Configuration V)
    (Theta : RealParameterAction F) (t : ℝ) :
    Theta.toFun t = 1 := by
  let c := Nat.card (commutingSymmetryGroup F)
  let m := c.factorial
  have hc : 0 < c := Nat.card_pos
  have hm : 0 < m := Nat.factorial_pos c
  let r : ℝ := t / m
  have ht : m • r = t := by
    dsimp [r]
    rw [nsmul_eq_mul]
    change (m : ℝ) * (t / (m : ℝ)) = t
    rw [mul_div_cancel₀ t (Nat.cast_ne_zero.mpr (ne_of_gt hm))]
  rw [← ht, Theta.map_nsmul_as_pow]
  obtain ⟨k, hk⟩ := Nat.dvd_factorial hc (le_refl c)
  have hcard : Theta.toFun r ^ c = 1 := pow_card_eq_one'
  change Theta.toFun r ^ c.factorial = 1
  rw [hk, pow_mul, hcard, one_pow]

end CellularAutomata.FiniteDiscreteContinuousSymmetryBoundary
