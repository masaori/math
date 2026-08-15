/-
「周期境界と開境界の境界評価」の実数評価の上下評価の必要十分版。

格子・配位・破れボンド数・実数を除き、具体版の証明が実際に使っている次だけを残す:
- 添字の全単射（配位の読み替え r_L にあたる）
- 指数の二項分解（破れボンド数の分解 b = b^op + s^bd にあたる）
- 境界因子の項ごとの下限・上限（自然数冪の順序の評価にあたる）

証明手順は具体版と同じ: 全単射と分解で全体の和を「内部の冪 × 境界の冪」の和へ
書き換え、項ごとに評価して有限和を取る。

接合不等式の必要十分版 `sum_pow_glue_bounds_necSuf` との違いは、添字が対ではなく
一つであること（接合は二つの配位から一つを作るが、境界評価は一つの配位を読み替える
だけ）である。対の構造は具体版の証明に現れないので、仮定にも置かない。

仮定が要る理由（削ると通らない）:
- `CommSemiring K`: 冪の指数法則 `pow_add`、定数倍と有限和の分配（`mul_sum`）、
  `mul_comm` に要る。減法・除法は使わないので環・体は課さない。
- `PartialOrder K` + `IsOrderedRing K`: 非負元を左から掛けても順序が保たれること
  （`mul_le_mul_of_nonneg_left`）と有限和の単調性（`sum_le_sum`）、および
  非負元の冪の非負性（`pow_nonneg`）に要る。全順序（三分律）は使わないので課さない。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 添字の全単射・指数の二項分解・境界因子の項ごとの評価から、
全体の和を内部の和の定数倍で上下から挟む（具体版と同じ手順）。 -/
theorem sum_pow_reindex_bounds_necSuf
    {ι P K : Type*} [Fintype ι] [Fintype P]
    [CommSemiring K] [PartialOrder K] [IsOrderedRing K]
    (E : ι ≃ P) (base : K) (f : ι → ℕ) (e : P → ℕ) (s : ι → ℕ)
    (hdecomp : ∀ i, e (E i) = f i + s i)
    (low high : K) (hbase : 0 ≤ base)
    (hlow : ∀ i, low ≤ base ^ s i)
    (hhigh : ∀ i, base ^ s i ≤ high) :
    low * (∑ i : ι, base ^ f i) ≤ ∑ p : P, base ^ e p ∧
      ∑ p : P, base ^ e p ≤ high * (∑ i : ι, base ^ f i) := by
  have hsum : ∑ p : P, base ^ e p = ∑ i : ι, base ^ f i * base ^ s i := by
    rw [← Fintype.sum_equiv E (fun i : ι => base ^ e (E i))
      (fun p => base ^ e p) (fun _ => rfl)]
    exact sum_congr rfl fun i _ => by rw [hdecomp i, pow_add]
  constructor
  · rw [hsum, mul_sum]
    refine sum_le_sum fun i _ => ?_
    calc
      low * base ^ f i = base ^ f i * low := mul_comm _ _
      _ ≤ base ^ f i * base ^ s i :=
        mul_le_mul_of_nonneg_left (hlow i) (pow_nonneg hbase _)
  · rw [hsum, mul_sum]
    refine sum_le_sum fun i _ => ?_
    calc
      base ^ f i * base ^ s i ≤ base ^ f i * high :=
        mul_le_mul_of_nonneg_left (hhigh i) (pow_nonneg hbase _)
      _ = high * base ^ f i := mul_comm _ _

end Ising2DLambda.NecSuf.ThermodynamicLimit
