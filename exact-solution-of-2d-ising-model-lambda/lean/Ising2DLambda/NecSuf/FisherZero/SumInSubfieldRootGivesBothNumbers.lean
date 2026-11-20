/-
「和が部分体に入る二数は、二数を根とする二次式の値を零にする部分体の元があれば共に部分体に入る」の必要十分版。

具体版の証明が使うのは次だけである。
- 台が環で、零因子が無いこと（`γ-α ≠ 0` かつ `(γ-α)(γ-β) = 0` から `γ-β = 0`）。
  逆元は使わない（具体版の `qbarNoZeroDivisors` は逆元で示すが、使う結論は零因子が無いことだけ）。
- 積の可換性は、式鎖の二段目 `γβ = βγ` の一か所だけで使う。台の可換性は仮定せず、この一つの等式を仮定に取る。
  これを削ると `(γ-α)(γ-β)` と `γγ - (α+β)γ + αβ` が一致しなくなり、主張は一般に成り立たない。
- 部分集合 `S` については差で閉じることだけ。零元・単位元・積・商の閉性は使わない。
  `αβ ∈ S` も使わない。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Algebra.GroupWithZero.Defs
import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.NoncommRing

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版と同じ段（式鎖、`γ-α = 0` かどうかの場合分け、零因子が無いことによる `γ-β = 0`、差による所属）で示す。 -/
theorem mem_and_mem_of_sum_mem_of_root_mem_necSuf {R : Type*} [Ring R] [NoZeroDivisors R]
    (S : Set R) (hsub : ∀ a b : R, a ∈ S → b ∈ S → a - b ∈ S) (α β γ : R)
    (hcomm : γ * β = β * γ)
    (hsum : α + β ∈ S) (hγ : γ ∈ S)
    (hroot : γ * γ - (α + β) * γ + α * β = 0) :
    α ∈ S ∧ β ∈ S := by
  have hprod : (γ - α) * (γ - β) = 0 := by
    calc (γ - α) * (γ - β) = γ * γ - γ * β - α * γ + α * β := by noncomm_ring
      _ = γ * γ - (α * γ + β * γ) + α * β := by rw [hcomm]; abel
      _ = γ * γ - (α + β) * γ + α * β := by rw [add_mul]
      _ = 0 := hroot
  by_cases hα : γ - α = 0
  · have hαS : α ∈ S := by
      have hchain : α = γ := by
        calc α = γ - (γ - α) := by abel
          _ = γ - 0 := by rw [hα]
          _ = γ := sub_zero γ
      rw [hchain]; exact hγ
    have hchain : β = (α + β) - α := by abel
    refine ⟨hαS, ?_⟩
    rw [hchain]; exact hsub _ _ hsum hαS
  · have hβ : γ - β = 0 := (mul_eq_zero.mp hprod).resolve_left hα
    have hβS : β ∈ S := by
      have hchain : β = γ := by
        calc β = γ - (γ - β) := by abel
          _ = γ - 0 := by rw [hβ]
          _ = γ := sub_zero γ
      rw [hchain]; exact hγ
    have hchain : α = (α + β) - β := by abel
    refine ⟨?_, hβS⟩
    rw [hchain]; exact hsub _ _ hsum hβS

end Ising2DLambda.NecSuf.FisherZero
