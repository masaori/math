/-
「正錐の非負係数条件どうしの和」の具体版。
本文と同じく和の表示を使い、二座標の非負性と非零性を個別に示す。
-/
import Ising2DLambda.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegativeCoefficients
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  -- 本文の和の表示と、独立な二つの非負不等式。
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  apply Or.inl
  have hNonnegA : 0 ≤ a + a' := add_nonneg hxi.1 heta.1
  have hNonnegB : 0 ≤ b + b' := add_nonneg hxi.2.1 heta.2.1
  refine ⟨hNonnegA, hNonnegB, ?_⟩
  intro hPair
  have hA : a + a' = 0 := congrArg Prod.fst hPair
  have hB : b + b' = 0 := congrArg Prod.snd hPair
  -- 第一係数: 加法の零元、単調性、背理仮定の成分、反対称性。
  have haNonpos : a ≤ 0 := by
    calc
      a = a + 0 := (add_zero a).symm
      _ ≤ a + a' := _root_.add_le_add (le_refl a) heta.1
      _ = 0 := hA
  have ha0 : a = 0 := le_antisymm haNonpos hxi.1
  have hapNonpos : a' ≤ 0 := by
    calc
      a' = 0 + a' := (zero_add a').symm
      _ ≤ a + a' := _root_.add_le_add hxi.1 (le_refl a')
      _ = 0 := hA
  have _hap0 : a' = 0 := le_antisymm hapNonpos heta.1
  -- 第二係数も同じ四段で示す。
  have hbNonpos : b ≤ 0 := by
    calc
      b = b + 0 := (add_zero b).symm
      _ ≤ b + b' := _root_.add_le_add (le_refl b) heta.2.1
      _ = 0 := hB
  have hb0 : b = 0 := le_antisymm hbNonpos hxi.2.1
  have hbpNonpos : b' ≤ 0 := by
    calc
      b' = 0 + b' := (zero_add b').symm
      _ ≤ b + b' := _root_.add_le_add hxi.2.1 (le_refl b')
      _ = 0 := hB
  have _hbp0 : b' = 0 := le_antisymm hbpNonpos heta.2.1
  have hZeroPair : (a, b) = (0, 0) := Prod.ext ha0 hb0
  exact hxi.2.2 hZeroPair

end Ising2DLambda.FisherZero
