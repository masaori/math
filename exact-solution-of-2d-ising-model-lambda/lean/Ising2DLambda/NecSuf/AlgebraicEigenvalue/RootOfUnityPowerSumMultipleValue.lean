/-
主張「指数が根の次数の倍数のとき、冪の和は根の次数の与える代数的数である」の必要十分版。

具体版と同じ鎖（各項を定数へ・数え上げの全単射で添字を取り替え・個数を当て・和の値を当てる）を、
仮定を必要十分まで薄めて通す。

- 値の型 `M` に要るのは**可換な加法モノイドだけ**である（有限和がそれを要求する）。
  積・積の単位元・冪・体・代数閉性は不要で、定数は任意の元 `u` でよい
  （具体版の `1` が積の単位元であることは使っていない）。
- 各項が `u` に等しいこと（`hconst`）、添字の型の元の個数が `n` であること（`hcard`）、
  `u` の `n` 個の有限和の値（`hsum`）は、個別の仮定として受け取る。

住処: 一般の型。ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fintype.EquivFin

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open BigOperators

/-- 各項が定数 `u` である有限型 `α` にわたる有限和は、`α` の元の個数 `n` と
`u` の `n` 個の有限和の値 `c` だけで決まる。 -/
theorem sum_const_reindex_necSuf {α : Type*} [Fintype α] {M : Type*}
    [AddCommMonoid M] {f : α → M} {u c : M} {n : ℕ}
    (hconst : ∀ z : α, f z = u) (hcard : Fintype.card α = n)
    (hsum : (∑ _i ∈ Finset.range n, u) = c) :
    (∑ z : α, f z) = c := by
  calc (∑ z : α, f z)
      = ∑ _z : α, u := Finset.sum_congr rfl (fun z _ => hconst z)
        -- 第 2 の等号。各項を定数 u へ。
    _ = ∑ _i : Fin (Fintype.card α), u :=
        Fintype.sum_bijective (Fintype.equivFin α)
          (Fintype.equivFin α).bijective _ _ (fun _ => rfl)
        -- 第 3 の等号（前半）。数え上げの全単射による添字の取り替え。
    _ = ∑ _i ∈ Finset.range (Fintype.card α), u :=
        Fin.sum_univ_eq_sum_range (fun _ : ℕ => u) (Fintype.card α)
        -- 第 3 の等号（後半）。番号の集合にわたる和として書く。
    _ = ∑ _i ∈ Finset.range n, u := by rw [hcard]
        -- 個数の仮定を当てる。
    _ = c := hsum
        -- 第 4 の等号。有限和の値の仮定を当てる。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
