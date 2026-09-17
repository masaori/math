/-
正本: content/finite-permutation-complex-phase-boundary.ts の必要十分版。

有限位相符号から軌道固有ベクトルを作る証明で実際に使うのは、有限な添字型、
相異なる軌道点の列、後退写像による列の共変性、係数の共変関係、有限和だけである。
有限舞台、二元状態、可逆写像、複素指数関数、円周定数は一般定理には要らない。
値域には有限和、係数倍、零の吸収だけを使い、単位元や分配法則は仮定しない。
-/
import CellularAutomata.FinitePermutationComplexPhaseBoundary

namespace CellularAutomata.NecSuf.FinitePermutationComplexPhaseBoundary

variable {X I R : Type*}

/-- 相異なる有限列上の係数だけを支えに持つ有限和ベクトル。 -/
def supportedVector [Fintype I] [DecidableEq X] [AddCommMonoid R]
    (points : I → X) (coefficient : I → R) : X → R :=
  fun x => ∑ j : I, if x = points j then coefficient j else 0

theorem supportedVector_at_point [Fintype I] [DecidableEq X] [AddCommMonoid R]
    (points : I → X) (coefficient : I → R)
    (hpoints : Function.Injective points) (j : I) :
    supportedVector points coefficient (points j) = coefficient j := by
  classical
  simp [supportedVector, hpoints.eq_iff]

theorem supportedVector_outside [Fintype I] [DecidableEq X] [AddCommMonoid R]
    (points : I → X) (coefficient : I → R) (x : X)
    (hx : ¬∃ j, x = points j) :
    supportedVector points coefficient x = 0 := by
  classical
  rw [supportedVector]
  apply Finset.sum_eq_zero
  intro j _
  simp only [ite_eq_right_iff]
  intro hxj
  exact (hx ⟨j, hxj⟩).elim

/--
有限列上の後退写像と係数が同じ巡回方向に共変なら、列に支えられた有限和は
後退引き戻しの固有ベクトルになる。非零性には係数が非零な位置を一つだけ要る。
-/
theorem supportedVector_nonzero_and_eigenpair
    [Fintype I] [DecidableEq X] [AddCommMonoid R]
    (backward : X → X) (previous : I → I) (points : I → X)
    (coefficient : I → R) (scale : R → R → R) (lambda : R)
    (hpoints : Function.Injective points)
    (hbackward : ∀ j, backward (points j) = points (previous j))
    (houtside : ∀ y, (¬∃ j, y = points j) → ¬∃ j, backward y = points j)
    (hscale_zero : scale lambda 0 = 0)
    (hcoefficient : ∀ j, coefficient (previous j) = scale lambda (coefficient j))
    (j0 : I) (hj0 : coefficient j0 ≠ 0) :
    supportedVector points coefficient ≠ 0 ∧
      (fun y => supportedVector points coefficient (backward y)) =
        fun y => scale lambda (supportedVector points coefficient y) := by
  classical
  constructor
  · intro hzero
    have hat := supportedVector_at_point points coefficient hpoints j0
    rw [hzero] at hat
    exact hj0 hat.symm
  · funext y
    by_cases hy : ∃ j, y = points j
    · obtain ⟨j, rfl⟩ := hy
      rw [hbackward, supportedVector_at_point points coefficient hpoints,
        supportedVector_at_point points coefficient hpoints, hcoefficient]
    · rw [supportedVector_outside points coefficient _ (houtside y hy),
        supportedVector_outside points coefficient _ hy, hscale_zero]

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FinitePermutationComplexPhaseBoundary

variable {V : Type} [Fintype V]

/-- 具体版の軌道位相ベクトルは一般の有限和ベクトルである。 -/
theorem supportedVector_eq_orbitPhaseVector (d k : ℕ)
    (points : Fin d → Configuration V) :
    supportedVector points (orbitPhaseCoefficient d k) =
      orbitPhaseVector d k points := by
  rfl

/-- 具体版の固有対構成は有限列と係数共変性だけを使う一般定理から得られる。 -/
theorem orbitPhaseVector_nonzero_and_eigenpair_of_necSuf
    (F : ReversibleEvolution V) (d : ℕ) (hd : 0 < d) (k : ℕ)
    (points : Fin d → Configuration V) (hpoints : Function.Injective points)
    (hforward : ∀ j, F (points j) = points (cyclicNext d hd j))
    (hbackward : ∀ j, F.symm (points j) = points (cyclicPrevious d hd j)) :
    orbitPhaseVector d k points ≠ 0 ∧
      complexAction F (orbitPhaseVector d k points) =
        phaseValue d k • orbitPhaseVector d k points := by
  let j0 : Fin d := ⟨0, hd⟩
  have hj0 : orbitPhaseCoefficient d k j0 ≠ 0 := by
    have hcoefficient : orbitPhaseCoefficient d k j0 = 1 := by
      simp [orbitPhaseCoefficient, j0, phaseValue_pow_period d hd k]
    simp [hcoefficient]
  have houtside : ∀ y, (¬∃ j, y = points j) →
      ¬∃ j, F.symm y = points j := by
    intro y hy
    rintro ⟨j, hj⟩
    apply hy
    refine ⟨cyclicNext d hd j, ?_⟩
    rw [← hforward j, ← hj]
    exact (F.apply_symm_apply y).symm
  have hgeneral := supportedVector_nonzero_and_eigenpair
    (R := ℂ) F.symm (cyclicPrevious d hd) points
    (orbitPhaseCoefficient d k) (fun a b => a * b) (phaseValue d k)
    hpoints hbackward houtside (mul_zero (phaseValue d k))
    (orbitPhaseCoefficient_previous d hd k) j0 hj0
  change orbitPhaseVector d k points ≠ 0 ∧
    (fun y => orbitPhaseVector d k points (F.symm y)) =
      fun y => phaseValue d k * orbitPhaseVector d k points y
  simpa only [supportedVector_eq_orbitPhaseVector] using hgeneral

end Derivation

end CellularAutomata.NecSuf.FinitePermutationComplexPhaseBoundary
