/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」で歩の方向の列に使う、連結 `p *_n q`・
二区間の列・余りによる反復と、整数値の重みの内部和 `I_n` と循環隣接和 `C_n` の具体版。

本文（`claim_four_part_adjacent_sum`・`claim_repeated_adjacent_sum_difference`・
`claim_reversed_parallel_staircase_turning_zero`）は、列を `ℕ` 上の写像として扱い、
重みの値を ℤ に取る。ここでも値を ℤ に固定する。列の項の型は、本文が整数ベクトルの列にも
方向の列にも同じ記法を使うので、型の引数として受け取る。必要十分版は import しない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 連結 `(p *_a q)_j`。`j < a` なら `p_j`、それ以外は `q_{j-a}`。 -/
def joinDirectionSequence {α : Type*} (u v : ℕ → α) (a j : ℕ) : α :=
  if j < a then u j else v (j - a)

/-- 内部和 `I_n(u) = Σ_{j=0}^{n-2} weight(u_j, u_{j+1})`。 -/
def internalAdjacentSum {α : Type*} (weight : α → α → ℤ) (n : ℕ) (u : ℕ → α) : ℤ :=
  ∑ j ∈ Finset.range (n - 1), weight (u j) (u (j + 1))

/-- 循環隣接和 `C_n(u) = I_n(u) + weight(u_{n-1}, u_0)`。 -/
def cyclicAdjacentSum {α : Type*} (weight : α → α → ℤ) (n : ℕ) (u : ℕ → α) : ℤ :=
  (∑ s ∈ Finset.range (n - 1), weight (u s) (u (s + 1))) + weight (u (n - 1)) (u 0)

/-- 内部の隣接対と閉じ目の重みが一致すれば、二つの循環隣接和は等しい。 -/
theorem cyclicAdjacentSum_transport {α β : Type*}
    (a : α → α → ℤ) (b : β → β → ℤ) (p : ℕ → α) (u : ℕ → β) (n : ℕ)
    (hinternal : ∀ j < n - 1, a (p j) (p (j + 1)) = b (u j) (u (j + 1)))
    (hclosing : a (p (n - 1)) (p 0) = b (u (n - 1)) (u 0)) :
    cyclicAdjacentSum a n p = cyclicAdjacentSum b n u := by
  unfold cyclicAdjacentSum
  apply congrArg₂ (· + ·)
  · apply Finset.sum_congr rfl
    intro j hj
    exact hinternal j (Finset.mem_range.mp hj)
  · exact hclosing

/-- 長さ `n` の範囲で一致する二つの列は、同じ循環隣接和を持つ。 -/
theorem cyclicAdjacentSum_congr_range {α : Type*}
    (weight : α → α → ℤ) (n : ℕ) (hn : 0 < n) (u v : ℕ → α)
    (h : ∀ j < n, u j = v j) :
    cyclicAdjacentSum weight n u = cyclicAdjacentSum weight n v := by
  apply cyclicAdjacentSum_transport weight weight u v n
  · intro j hj
    rw [h j (by omega), h (j + 1) (by omega)]
  · rw [h (n - 1) (by omega), h 0 hn]

/-- 先頭 `p` 項が `a`、それ以降が `b` の列。 -/
def twoBlockSequence {α : Type*} (p : ℕ) (a b : α) (s : ℕ) : α :=
  if s < p then a else b

/-- `u` の先頭 `n` 項を、添字の `n` による余りで反復した列。 -/
def repeatDirectionSequence {α : Type*} (u : ℕ → α) (n j : ℕ) : α :=
  u (j % n)

/-- 反復列は `n` 項ずらしても変わらない（余りの加法）。 -/
theorem repeatDirectionSequence_period {α : Type*} (u : ℕ → α) (n c j : ℕ) :
    repeatDirectionSequence u n (c * n + j) = repeatDirectionSequence u n j := by
  simp [repeatDirectionSequence, Nat.add_mod]

/-- `c` 回反復した列の末項は `u_{n-1}` である。 -/
theorem repeatDirectionSequence_last {α : Type*} (u : ℕ → α) (n c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    repeatDirectionSequence u n (c * n - 1) = u (n - 1) := by
  have hindex : c * n - 1 = (c - 1) * n + (n - 1) := by
    have hc' : c = (c - 1) + 1 := by omega
    conv_lhs => rw [hc', Nat.add_mul, one_mul]
    omega
  rw [hindex, repeatDirectionSequence_period]
  simp [repeatDirectionSequence, Nat.mod_eq_of_lt (show n - 1 < n by omega)]

end Ising2DLambda.KacWard
