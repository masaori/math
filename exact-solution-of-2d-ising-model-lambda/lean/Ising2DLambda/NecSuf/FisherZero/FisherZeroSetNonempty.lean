/-
「正次数の非零係数を持つ多項式は、根を供給できる係数体上で根を持つ」の必要十分版。

具体版が使うのは、正次数の係数が非零であることと、次数が零でない多項式へ根を供給することだけである。
配位・格子・代数的数は仮定しない。
-/
import Mathlib.Algebra.Polynomial.Degree.Lemmas
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

theorem rootSet_nonempty_of_positive_coeff_necSuf
    {R : Type*} [CommRing R] (p : Polynomial R) (m : ℕ) (hm : 0 < m)
    (hcoeff : p.coeff m ≠ 0)
    (hroot : p.degree ≠ 0 → ∃ x : R, p.eval x = 0) :
    {x : R | p.eval x = 0}.Nonempty := by
  have hdegree : p.degree ≠ 0 := by
    intro hzero
    have hlower : ((m : ℕ) : WithBot ℕ) ≤ p.degree := Polynomial.le_degree_of_ne_zero hcoeff
    rw [hzero] at hlower
    have : m ≤ 0 := by exact_mod_cast hlower
    omega
  obtain ⟨x, hx⟩ := hroot hdegree
  exact ⟨x, hx⟩

end Ising2DLambda.NecSuf.FisherZero
