/-
「代数的数を成分とする単位行列は積の単位元である」（`claim_qbar_identity_matrix_unit`）の
うち、**右から掛ける側**の必要十分版。

手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.qbarMatrix_mul_qbarIdentityMatrix`）と
同じ 7 段の鎖である。削ったのは次のもので、削っても同じ手順で通る。

- 添字が行配位であること → 有限で相等が判定できる型でよい（1 項を分ける段と場合分けの段でだけ効く）。
- 値が代数的数であること → 積が定まっていて `a * 1 = a` と `a * 0 = 0` の 2 本が成り立ち、
  加法が可換モノイドであればよい。体であることも、加法の逆元も、零元でない元の逆元も使わない。
- 積の可換性・結合則・分配則は一度も使わない。

**左から掛ける側の必要十分版（`identity_action_necSuf`）からは得られない。**
あちらが仮定するのは `1 * a = a` と `0 * a = 0` であり、積の可換性を仮定しない以上、
こちらの 2 本は別の仮定である。場合分けの条件も向きが違う（こちらは `if i = j`）。

残した仮定がなぜ要るか。

- `[Fintype ι]`: 有限和を取るために要る（無限和は定義されない）。
- `[DecidableEq ι]`: 単位行列の成分の場合分け（`if i = j`）そのものに要る。
- `hone` / `hzero`: 第 4 段で `v i * 1 = v i` を、第 5 段で `v j * 0 = 0` を使う。
- `[AddCommMonoid M]`: 有限和と、第 6・7 段（零元だけの和が零元・零元を足しても変わらない）に要る。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版（右から掛ける側）。値へ単位行列の成分を右から掛けた有限和は、
その添字における値そのものである。 -/
theorem identity_action_right_necSuf {ι M : Type*} [Fintype ι] [DecidableEq ι]
    [AddCommMonoid M] [One M] [Mul M]
    (hone : ∀ a : M, a * (1 : M) = a) (hzero : ∀ a : M, a * (0 : M) = 0)
    (v : ι → M) (i : ι) :
    ∑ j : ι, v j * (if i = j then (1 : M) else 0) = v i := by
  calc ∑ j : ι, v j * (if i = j then (1 : M) else 0)
      = v i * (if i = i then (1 : M) else 0)
          + ∑ j ∈ (univ : Finset ι).erase i, v j * (if i = j then (1 : M) else 0) :=
        (Finset.add_sum_erase _ _ (mem_univ i)).symm
        -- 第 2 段。有限和から j = i の 1 項を分ける。
    _ = v i * (1 : M) + ∑ j ∈ (univ : Finset ι).erase i, v j * (0 : M) := by
        refine congrArg₂ (· + ·) ?_ (sum_congr rfl fun j hj => ?_)
        · rw [if_pos rfl]
        · rw [if_neg (Ne.symm (Finset.mem_erase.mp hj).1)]
        -- 第 3 段。場合分け（第 2 添字が第 1 添字に等しいときだけ 1）。
    _ = v i + ∑ j ∈ (univ : Finset ι).erase i, v j * (0 : M) := by
        exact congrArg₂ (· + ·) (hone _) rfl
        -- 第 4 段。単位元との積。
    _ = v i + ∑ _j ∈ (univ : Finset ι).erase i, (0 : M) := by
        exact congrArg₂ (· + ·) rfl (sum_congr rfl fun j _ => hzero _)
        -- 第 5 段。零元との積。
    _ = v i + 0 := by rw [Finset.sum_const_zero]
        -- 第 6 段。零元だけの有限和は零元である。
    _ = v i := add_zero _
        -- 第 7 段。零元を足しても変わらない。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
