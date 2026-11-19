import Ising2DLambda.FisherZero.SquareRootAdjoinedQuadraticRepresentationUnique
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 共役した有限平方和の恒等式の具体版。係数は代数的数の部分体に属する。 -/
theorem quadraticConjugateSquareSumIdentity
    (F : Subfield Qbar) (a b : Qbar) (ha : a ∈ F) (hb : b * b = a)
    (ι : Type) [Fintype ι] (c u v : ι → Qbar)
    (hc : ∀ i, c i ∈ F) (hu : ∀ i, u i ∈ F) (hv : ∀ i, v i ∈ F) :
    (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
      (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) =
      2 * ∑ i, c i * ((u i * u i) + a * (v i * v i)) := by
  classical
  -- 本文の有限和の鎖：二つの和をまとめ、各添字の等号を適用してから二をくくる。
  calc
    (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
        (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) =
        ∑ i, (c i * ((u i + v i * b) * (u i + v i * b)) +
          c i * ((u i - v i * b) * (u i - v i * b))) := by rw [Finset.sum_add_distrib]
    _ = ∑ i, 2 * c i * (u i * u i + a * (v i * v i)) := by
      apply Finset.sum_congr rfl
      intro i _
      let r := u i
      let s := v i * b
      -- 本文の添字ごとの鎖：展開、交差項の相殺、係数への復帰、平方関係の代入。
      calc
        c i * ((r + s) * (r + s)) + c i * ((r - s) * (r - s)) =
            c i * (((r + s) * (r + s)) + ((r - s) * (r - s))) := by ring
        _ = c i * (((r*r + 2*r*s + s*s) + (r*r - 2*r*s + s*s))) := by ring
        _ = c i * (2*(r*r) + 2*(s*s)) := by ring
        _ = 2*c i * (r*r + s*s) := by ring
        _ = 2*c i * (u i*u i + (v i*v i)*(b*b)) := by dsimp [r, s]; ring
        _ = 2*c i * (u i*u i + a*(v i*v i)) := by rw [hb]; ring
    _ = 2 * ∑ i, c i * (u i * u i + a * (v i * v i)) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      ring

end Ising2DLambda.FisherZero
