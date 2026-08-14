/-
「開境界長方形の接合不等式」の必要十分版。

格子・配位・破れボンド数・実数を除き、具体版の証明が実際に使っている次だけを残す:
- 添字の対と全体との全単射（接合の全単射にあたる）
- 指数の三項分解（破れボンド数の接合面分解にあたる）
- 接合面因子の項ごとの下限・上限（自然数冪の順序の評価にあたる）

証明手順は具体版と同じ: 全単射と分解で全体の和を二重和へ書き換え、積を二重和へ
展開し、項ごとに評価して有限和を取る。

仮定が要る理由（削ると通らない）:
- `CommSemiring K`: 冪の指数法則 `pow_add`、積と二重和の入れ替え（分配則）、
  `mul_comm` に要る。減法・除法は使わないので環・体は課さない。
- `PartialOrder K` + `IsOrderedRing K`: 非負元を左から掛けても順序が保たれること
  （`mul_le_mul_of_nonneg_left`）と有限和の単調性（`sum_le_sum`）、および
  非負元の冪の非負性（`pow_nonneg`）に要る。全順序（三分律）は使わないので課さない。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 対との全単射・指数の三項分解・接合面因子の項ごとの評価から、
全体の和を積で上下から挟む（具体版と同じ手順）。 -/
theorem sum_pow_glue_bounds_necSuf
    {ι κ P K : Type*} [Fintype ι] [Fintype κ] [Fintype P]
    [CommSemiring K] [PartialOrder K] [IsOrderedRing K]
    (E : ι × κ ≃ P) (base : K) (f : ι → ℕ) (g : κ → ℕ) (e : P → ℕ) (s : ι → κ → ℕ)
    (hdecomp : ∀ i j, e (E (i, j)) = f i + g j + s i j)
    (low high : K) (hbase : 0 ≤ base)
    (hlow : ∀ i j, low ≤ base ^ s i j)
    (hhigh : ∀ i j, base ^ s i j ≤ high) :
    low * ((∑ i : ι, base ^ f i) * (∑ j : κ, base ^ g j)) ≤ ∑ p : P, base ^ e p ∧
      ∑ p : P, base ^ e p ≤
        high * ((∑ i : ι, base ^ f i) * (∑ j : κ, base ^ g j)) := by
  have hsum : ∑ p : P, base ^ e p =
      ∑ i : ι, ∑ j : κ, base ^ (f i + g j) * base ^ s i j := by
    rw [← Fintype.sum_equiv E (fun q : ι × κ => base ^ e (E q))
      (fun p => base ^ e p) (fun _ => rfl)]
    rw [Fintype.sum_prod_type]
    exact sum_congr rfl fun i _ => sum_congr rfl fun j _ => by
      rw [hdecomp i j, pow_add]
  have hprod : (∑ i : ι, base ^ f i) * (∑ j : κ, base ^ g j) =
      ∑ i : ι, ∑ j : κ, base ^ (f i + g j) := by
    rw [sum_mul_sum]
    exact sum_congr rfl fun i _ => sum_congr rfl fun j _ => (pow_add base _ _).symm
  constructor
  · rw [hsum, hprod, mul_sum]
    refine sum_le_sum fun i _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun j _ => ?_
    calc
      low * base ^ (f i + g j) = base ^ (f i + g j) * low := mul_comm _ _
      _ ≤ base ^ (f i + g j) * base ^ s i j :=
        mul_le_mul_of_nonneg_left (hlow i j) (pow_nonneg hbase _)
  · rw [hsum, hprod, mul_sum]
    refine sum_le_sum fun i _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun j _ => ?_
    calc
      base ^ (f i + g j) * base ^ s i j ≤ base ^ (f i + g j) * high :=
        mul_le_mul_of_nonneg_left (hhigh i j) (pow_nonneg hbase _)
      _ = high * base ^ (f i + g j) := mul_comm _ _

end Ising2DLambda.NecSuf.ThermodynamicLimit
