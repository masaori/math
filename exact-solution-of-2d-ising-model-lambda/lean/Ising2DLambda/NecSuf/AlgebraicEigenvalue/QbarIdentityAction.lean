/-
「単位行列の作用は列ベクトルを動かさない」（`claim_qbar_identity_action`）の必要十分版。

手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.qbarIdentity_action`）と同じ 7 段の鎖である。
削ったのは次のもので、削っても同じ手順で通る。

- 添字が行配位であること → 有限で相等が判定できる型でよい（1 項を分ける段と場合分けの段でだけ効く）。
- 値が代数的数であること → 積が定まっていて `1 * a = a` と `0 * a = 0` の 2 本が成り立ち、
  加法が可換モノイドであればよい。この 2 本は型クラスではなく仮定として置いてある
  （型クラスで置くと零元がどちらの構造由来か曖昧になるうえ、使っていない性質まで抱き込む）。
  体であることも、加法の逆元も、零元でない元の逆元も使わない。
- 積の可換性・結合則・分配則は一度も使わない（仮定した 2 本の等式はいずれも要求しない）。

残した仮定がなぜ要るか。

- `[Fintype ι]`: 有限和を取るために要る（無限和は定義されない）。
- `[DecidableEq ι]`: 単位行列の成分の場合分け（`if j = i`）そのものに要る。
- `hone` / `hzero`: 第 4 段で `1 * v i = v i` を、第 5 段で `0 * v j = 0` を使う。
- `[AddCommMonoid M]`: 有限和と、第 6・7 段（零元だけの和が零元・零元を足しても変わらない）に要る。
  零元はこの構造のものだけを使う。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版。単位行列の成分を掛けた有限和は、その添字における値そのものである。 -/
theorem identity_action_necSuf {ι M : Type*} [Fintype ι] [DecidableEq ι]
    [AddCommMonoid M] [One M] [Mul M]
    (hone : ∀ a : M, (1 : M) * a = a) (hzero : ∀ a : M, (0 : M) * a = 0)
    (v : ι → M) (i : ι) :
    ∑ j : ι, (if j = i then (1 : M) else 0) * v j = v i := by
  calc ∑ j : ι, (if j = i then (1 : M) else 0) * v j
      = (if i = i then (1 : M) else 0) * v i
          + ∑ j ∈ (univ : Finset ι).erase i, (if j = i then (1 : M) else 0) * v j :=
        (Finset.add_sum_erase _ _ (mem_univ i)).symm
        -- 第 2 段。有限和から j = i の 1 項を分ける。
    _ = (1 : M) * v i + ∑ j ∈ (univ : Finset ι).erase i, (0 : M) * v j := by
        refine congrArg₂ (· + ·) ?_ (sum_congr rfl fun j hj => ?_)
        · rw [if_pos rfl]
        · rw [if_neg (Finset.mem_erase.mp hj).1]
        -- 第 3 段。場合分け（対角では 1、対角の外では 0）。
    _ = v i + ∑ j ∈ (univ : Finset ι).erase i, (0 : M) * v j := by
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
