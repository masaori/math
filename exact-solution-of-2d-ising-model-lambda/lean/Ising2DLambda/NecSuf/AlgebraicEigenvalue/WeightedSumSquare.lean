/-
重み付き有限和の自己積を順序付き添字対の和へ展開する必要十分版。
乗法の結合則、指定した左乗法・右乗法の零と加法の保存、中央の二因子の交換だけを使う。
-/
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 平方を自己積へ戻した後の本文と同じ計算。
乗法全体の可換性・単位元・分配則・環・符号・マッチングは仮定しない。 -/
theorem weightedSum_mul_self_necSuf
    {S R : Type*} [Fintype S] [AddCommMonoid R] [Semigroup R]
    (w a : S → R)
    (hRightZero : (0 : R) * (∑ i : S, w i * a i) = 0)
    (hRightAdd : ∀ u v : R,
      (u + v) * (∑ i : S, w i * a i) =
        u * (∑ i : S, w i * a i) + v * (∑ i : S, w i * a i))
    (hLeftZero : ∀ i : S, (w i * a i) * 0 = 0)
    (hLeftAdd : ∀ (i : S) (u v : R),
      (w i * a i) * (u + v) = (w i * a i) * u + (w i * a i) * v)
    (hcomm : ∀ i j : S, a i * w j = w j * a i) :
    (∑ i : S, w i * a i) * (∑ j : S, w j * a j) =
      ∑ p : S × S, (w p.1 * w p.2) * (a p.1 * a p.2) := by
  classical
  let T : S → R := fun i => w i * a i
  let total : R := ∑ i : S, T i
  let right : R →+ R :=
    { toFun := fun u => u * total
      map_zero' := hRightZero
      map_add' := hRightAdd }
  let left (i : S) : R →+ R :=
    { toFun := fun u => T i * u
      map_zero' := hLeftZero i
      map_add' := hLeftAdd i }
  calc
    total * total = (∑ i : S, w i * a i) * (∑ j : S, w j * a j) := rfl
    _ = ∑ i : S, (w i * a i) * (∑ j : S, w j * a j) := map_sum right T univ
    _ = ∑ i : S, ∑ j : S, (w i * a i) * (w j * a j) := by
      exact Finset.sum_congr rfl (fun i _ => map_sum (left i) T univ)
    _ = ∑ i : S, ∑ j : S, ((w i * a i) * w j) * a j := by
      exact Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ =>
        (mul_assoc (w i * a i) (w j) (a j)).symm))
    _ = ∑ i : S, ∑ j : S, (w i * (a i * w j)) * a j := by
      exact Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ =>
        congrArg (· * a j) (mul_assoc (w i) (a i) (w j))))
    _ = ∑ i : S, ∑ j : S, (w i * (w j * a i)) * a j := by
      exact Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ =>
        congrArg (fun z => (w i * z) * a j) (hcomm i j)))
    _ = ∑ i : S, ∑ j : S, ((w i * w j) * a i) * a j := by
      exact Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ =>
        congrArg (· * a j) (mul_assoc (w i) (w j) (a i)).symm))
    _ = ∑ i : S, ∑ j : S, (w i * w j) * (a i * a j) := by
      exact Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ =>
        mul_assoc (w i * w j) (a i) (a j)))
    _ = ∑ p : S × S, (w p.1 * w p.2) * (a p.1 * a p.2) :=
      (Fintype.sum_prod_type (fun p : S × S => (w p.1 * w p.2) * (a p.1 * a p.2))).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
