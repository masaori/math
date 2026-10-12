import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Defs
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文と同じ場合分けと十六行。零の積と表示を結論として仮定せず、
零保存・零との積・零の和から導く。正の係数の像と二集合の積の閉性は既証の補題に当たる。
環・体・順序構造・根の平方条件は不要で、係数側の正値性は述語で足りる。 -/
theorem natIndexed_mul_zero_or_mem_necSuf
    {A V : Type*} [Zero A] [Zero V] [Add V] [Mul V]
    (natMap : ℕ → A) (hNatZero : natMap 0 = 0)
    (embed : A → V) (hEmbedZero : embed 0 = 0)
    (hAddZero : (0 : V) + 0 = 0) (hZeroMul : ∀ x : V, 0 * x = 0)
    (positive : A → Prop) (hNatPositive : ∀ c : ℕ, 0 < c → positive (natMap c))
    (S P : Set V) (s : V)
    (hRepresentation : ∀ a b : A, embed a + embed b * s ∈ S)
    (hCoefficientMem : ∀ a : A, positive a → embed a ∈ S)
    (hCoefficientPositive : ∀ a : A, positive a → embed a ∈ P)
    (hMulMem : ∀ x y : V, x ∈ S → y ∈ S → x * y ∈ S)
    (hMulPositive : ∀ x y : V, x ∈ P → y ∈ P → x * y ∈ P)
    (c : ℕ) (x : V) (hxS : x ∈ S) (hxP : x ∈ P) :
    embed (natMap c) * x ∈ S ∧
      (c = 0 → embed (natMap c) * x = 0) ∧
      (1 ≤ c → embed (natMap c) * x ∈ P) := by
  by_cases hc : c = 0
  · have hzero : embed (natMap c) * x = 0 := by
      calc
        embed (natMap c) * x = embed (natMap 0) * x :=
          congrArg (fun n => embed (natMap n) * x) hc
        _ = embed 0 * x := congrArg (fun a => embed a * x) hNatZero
        _ = 0 * x := congrArg (fun v => v * x) hEmbedZero
        _ = 0 := hZeroMul x
    have hrep : (0 : V) = embed 0 + embed 0 * s := by
      calc
        (0 : V) = 0 + 0 := hAddZero.symm
        _ = 0 + (0 : V) * s := congrArg (fun v : V => 0 + v) (hZeroMul s).symm
        _ = embed 0 + (0 : V) * s :=
          congrArg (fun v => v + (0 : V) * s) hEmbedZero.symm
        _ = embed 0 + embed 0 * s := congrArg (fun v => embed 0 + v * s) hEmbedZero.symm
    have hzmem : (0 : V) ∈ S := by
      rw [hrep]
      exact hRepresentation 0 0
    have hmem : embed (natMap c) * x ∈ S := by
      rw [hzero]
      exact hzmem
    refine ⟨hmem, fun _ => hzero, ?_⟩
    intro hpositive
    omega
  · have hcpos : 1 ≤ c := Nat.one_le_iff_ne_zero.mpr hc
    have hnat : 0 < c := lt_of_lt_of_le Nat.zero_lt_one hcpos
    have hq : positive (natMap c) := hNatPositive c hnat
    have hcoefS : embed (natMap c) ∈ S := hCoefficientMem _ hq
    have hcoefP : embed (natMap c) ∈ P := hCoefficientPositive _ hq
    have hmem : embed (natMap c) * x ∈ S := hMulMem _ _ hcoefS hxS
    have hpos : embed (natMap c) * x ∈ P := hMulPositive _ _ hcoefP hxP
    exact ⟨hmem, fun h => (hc h).elim, fun _ => hpos⟩

end Ising2DLambda.NecSuf.FisherZero
