/-
正本: content/finite-discrete-continuous-symmetry-boundary.ts の必要十分版。

必要な構造の検査結果:
  - 大域写像と可換する対称性には、集合の置換群と写像の合成だけを要る。
    その有限性には配位型の有限性だけを追加する。
  - 保存写像の加法群には、値域の加法群だけを要る。
  - 対称性による引き戻しには、置換が大域写像と可換することだけを要る。
  - パラメータ作用の自明性には、有限群と整除可能な加法群だけを要る。
  - 有限舞台、二元状態、整数値域、実数体は、具体版で一般定理の仮定を
    供給する段階だけに残る。位相、極限、微分、対数は使わない。

具体版と同じく、可換置換群、保存写像の引き戻し、作用律を順に示す。
続いて有限群の位数の階乗を取り、パラメータの除法可能性から得た根の像を
同じ階乗だけ冪乗して、作用が自明であることを示す。
-/
import CellularAutomata.FiniteDiscreteContinuousSymmetryBoundary
import Mathlib.GroupTheory.Divisible

namespace CellularAutomata.NecSuf.FiniteDiscreteContinuousSymmetryBoundary

variable {X A D G : Type*}

/-! ## 可換置換群に必要な構造 -/

/-- 自己写像 `F` と可換する `X` の置換からなる群。 -/
def commutingPermutationGroup (F : X → X) : Subgroup (Equiv.Perm X) where
  carrier := {sigma | ∀ x, sigma (F x) = F (sigma x)}
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

/-- 有限型上で自己写像と可換する置換群は有限である。 -/
theorem commutingPermutationGroup_isFinite [Finite X] (F : X → X) :
    Finite (commutingPermutationGroup F) := by
  infer_instance

/-! ## 保存写像と引き戻しに必要な構造 -/

/-- 自己写像 `F` で保存される加法群値写像からなる加法群。 -/
def conservedFunctionGroup [AddGroup A] (F : X → X) : AddSubgroup (X → A) where
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

/-- 可換置換による保存写像の引き戻し。 -/
def pullback [AddGroup A] (F : X → X)
    (sigma : commutingPermutationGroup F) (H : conservedFunctionGroup (A := A) F) : X → A :=
  fun x => H.1 (sigma.1.symm x)

/-- 可換置換で引き戻した写像も保存される。 -/
theorem pullback_mem [AddGroup A] (F : X → X)
    (sigma : commutingPermutationGroup F) (H : conservedFunctionGroup (A := A) F) :
    ∀ x, pullback F sigma H (F x) = pullback F sigma H x := by
  intro x
  change H.1 (sigma.1.symm (F x)) = H.1 (sigma.1.symm x)
  have hinverse : sigma.1.symm (F x) = F (sigma.1.symm x) := by
    apply sigma.1.injective
    simpa only [Equiv.apply_symm_apply] using
      (sigma.2 (sigma.1.symm x)).symm
  rw [hinverse, H.2]

/-- 恒等置換による引き戻しは元の保存写像である。 -/
theorem pullback_identity [AddGroup A] (F : X → X)
    (H : conservedFunctionGroup (A := A) F) :
    pullback F 1 H = H := by
  funext x
  rfl

/-- 置換の積による引き戻しは、順に引き戻す左作用と一致する。 -/
theorem pullback_multiplication [AddGroup A] (F : X → X)
    (sigma tau : commutingPermutationGroup F) (H : conservedFunctionGroup (A := A) F) :
    pullback F (sigma * tau) H =
      pullback F sigma ⟨pullback F tau H, pullback_mem F tau H⟩ := by
  funext x
  rfl

/-! ## 整除可能な加法パラメータによる有限群作用 -/

/-- 加法モノイド `D` から群 `G` への作用。位相は仮定しない。 -/
structure AdditiveParameterAction [AddMonoid D] [Group G] where
  toFun : D → G
  map_zero : toFun 0 = 1
  map_add : ∀ s t, toFun (s + t) = toFun s * toFun t

namespace AdditiveParameterAction

/-- 自然数倍は像の同じ回数の冪へ送られる。 -/
theorem map_nsmul_as_pow [AddMonoid D] [Group G]
    (Theta : AdditiveParameterAction (D := D) (G := G)) (n : ℕ) (t : D) :
    Theta.toFun (n • t) = Theta.toFun t ^ n := by
  induction n with
  | zero => simpa using Theta.map_zero
  | succ n ih =>
      rw [succ_nsmul, Theta.map_add, ih, pow_succ]

end AdditiveParameterAction

/-- 整除可能な加法群から有限群への作用は自明である。 -/
theorem additiveParameterAction_trivial [AddGroup D] [Group G] [Finite G]
    [DivisibleBy D ℤ] (Theta : AdditiveParameterAction (D := D) (G := G)) (t : D) :
    Theta.toFun t = 1 := by
  letI : DivisibleBy D ℕ := AddGroup.divisibleByNatOfDivisibleByInt D
  let c := Nat.card G
  let m := c.factorial
  have hc : 0 < c := Nat.card_pos
  have hm : m ≠ 0 := (Nat.factorial_pos c).ne'
  let r : D := DivisibleBy.div t m
  have ht : m • r = t := by
    exact DivisibleBy.div_cancel t hm
  rw [← ht, Theta.map_nsmul_as_pow]
  obtain ⟨k, hk⟩ := Nat.dvd_factorial hc (le_refl c)
  have hcard : Theta.toFun r ^ c = 1 := pow_card_eq_one'
  change Theta.toFun r ^ c.factorial = 1
  rw [hk, pow_mul, hcard, one_pow]

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FiniteDiscreteContinuousSymmetryBoundary

variable {V : Type} [Fintype V]

/-- 具体版の可換対称群の有限性は、有限型上の一般定理から得られる。 -/
theorem commutingSymmetryGroup_isFinite_of_necSuf
    (F : Configuration V → Configuration V) :
    Finite (commutingSymmetryGroup F) := by
  change Finite (commutingPermutationGroup F)
  exact commutingPermutationGroup_isFinite F

/-- 具体版の引き戻し保存性は、加法群値保存写像の一般定理から得られる。 -/
theorem pullback_mem_of_necSuf (F : Configuration V → Configuration V)
    (sigma : commutingSymmetryGroup F) (H : conservedObservableGroup F) :
    ∀ x, pullbackConservedObservable F sigma H (F x) =
      pullbackConservedObservable F sigma H x := by
  exact pullback_mem (A := ℤ) F sigma H

/-- 具体版の引き戻し単位律は一般の引き戻し単位律から得られる。 -/
theorem pullback_identity_of_necSuf (F : Configuration V → Configuration V)
    (H : conservedObservableGroup F) :
    pullbackConservedObservable F 1 H = H := by
  exact pullback_identity (A := ℤ) F H

/-- 具体版の引き戻し積律は一般の引き戻し積律から得られる。 -/
theorem pullback_multiplication_of_necSuf (F : Configuration V → Configuration V)
    (sigma tau : commutingSymmetryGroup F) (H : conservedObservableGroup F) :
    pullbackConservedObservable F (sigma * tau) H =
      pullbackConservedObservable F sigma
        ⟨pullbackConservedObservable F tau H,
          pullback_mem (A := ℤ) F tau H⟩ := by
  exact pullback_multiplication (A := ℤ) F sigma tau H

/-- 具体版の実数作用を整除可能な加法パラメータ作用として束ねる。 -/
def realParameterActionAsAdditiveAction (F : Configuration V → Configuration V)
    (Theta : RealParameterAction F) :
    AdditiveParameterAction (D := ℝ) (G := commutingSymmetryGroup F) where
  toFun := Theta.toFun
  map_zero := Theta.map_zero
  map_add := Theta.map_add

/-- 具体版の自明性は、整除可能な加法パラメータから有限群への一般定理から得られる。 -/
theorem realParameterAction_trivial_of_necSuf (F : Configuration V → Configuration V)
    (Theta : RealParameterAction F) (t : ℝ) :
    Theta.toFun t = 1 := by
  exact additiveParameterAction_trivial (realParameterActionAsAdditiveAction F Theta) t

end Derivation

end CellularAutomata.NecSuf.FiniteDiscreteContinuousSymmetryBoundary
