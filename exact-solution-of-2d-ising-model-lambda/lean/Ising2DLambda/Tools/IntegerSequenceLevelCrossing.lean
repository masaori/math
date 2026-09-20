/-
道具の章「隣接差が高々 1 の整数列の水準横断数の恒等式」
（`claim_integer_sequence_level_crossing`）の具体版。

人手証明と同じく、水準より上かを表す指示値の一歩差を上横断・下横断の指示値へ同定し、
その有限和を望遠鏡和で端点差へ移す。列 `(a₁,…,aₙ)` は Lean では自然数上の関数 `a` の
先頭 `n+1` 項 `(a 0,…,a n)` として表す。`upCrossingCount n a c` と
`downCrossingCount n a c` は添字 `0,…,n-1` の有限和なので自然数である。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

namespace Ising2DLambda.Tools

open BigOperators

/-- 水準 `c` を `a k` から `a (k+1)` へ上向きに横断する回数。 -/
def upCrossingCount (n : ℕ) (a : ℕ → ℤ) (c : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n, if a k = c ∧ a (k + 1) = c + 1 then 1 else 0

/-- 水準 `c` を `a k` から `a (k+1)` へ下向きに横断する回数。 -/
def downCrossingCount (n : ℕ) (a : ℕ → ℤ) (c : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n, if a k = c + 1 ∧ a (k + 1) = c then 1 else 0

/-- 整数 `x` が水準 `c` より上なら 1、そうでなければ 0。 -/
def levelIndicator (c x : ℤ) : ℤ := if c < x then 1 else 0

/-- 人手証明の右辺に現れる端点三場合。 -/
def endpointCrossingValue (c first last : ℤ) : ℤ :=
  if first ≤ c ∧ c < last then 1
  else if last ≤ c ∧ c < first then -1
  else 0

/-- 隣接差が `-1, 0, 1` のいずれかなら、指示値の差は横断方向の指示値の差である。 -/
theorem levelIndicator_step (c x y : ℤ)
    (hstep : y - x = -1 ∨ y - x = 0 ∨ y - x = 1) :
    levelIndicator c y - levelIndicator c x
      = (if x = c ∧ y = c + 1 then 1 else 0)
        - (if x = c + 1 ∧ y = c then 1 else 0) := by
  rcases hstep with hstep | hstep | hstep <;>
    simp only [levelIndicator] <;> split_ifs <;> omega

/-- 水準指示値の端点差は、人手証明の三場合に一致する。 -/
theorem levelIndicator_endpoint (c first last : ℤ) :
    levelIndicator c last - levelIndicator c first
      = endpointCrossingValue c first last := by
  simp only [levelIndicator, endpointCrossingValue]
  split_ifs <;> omega

/-- 水準指示値の隣接差を有限和にすると中間項が相殺する。 -/
theorem levelIndicator_telescope (c : ℤ) (a : ℕ → ℤ) (n : ℕ) :
    (∑ k ∈ Finset.range n,
      (levelIndicator c (a (k + 1)) - levelIndicator c (a k)))
      = levelIndicator c (a n) - levelIndicator c (a 0) := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      abel

/-- `claim_integer_sequence_level_crossing` の具体版。 -/
theorem integerSequence_levelCrossing (n : ℕ) (a : ℕ → ℤ) (c : ℤ)
    (hstep : ∀ k < n, a (k + 1) - a k = -1 ∨
      a (k + 1) - a k = 0 ∨ a (k + 1) - a k = 1) :
    (upCrossingCount n a c : ℤ) - (downCrossingCount n a c : ℤ)
      = endpointCrossingValue c (a 0) (a n) := by
  have hlocal : ∀ k ∈ Finset.range n,
      levelIndicator c (a (k + 1)) - levelIndicator c (a k)
        = (if a k = c ∧ a (k + 1) = c + 1 then 1 else 0)
          - (if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) := by
    intro k hk
    exact levelIndicator_step c (a k) (a (k + 1)) (hstep k (Finset.mem_range.mp hk))
  calc
    (upCrossingCount n a c : ℤ) - (downCrossingCount n a c : ℤ)
        = (∑ k ∈ Finset.range n,
            ((if a k = c ∧ a (k + 1) = c + 1 then 1 else 0) : ℤ))
          - (∑ k ∈ Finset.range n,
            ((if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) : ℤ)) := by
              simp [upCrossingCount, downCrossingCount]
    _ = ∑ k ∈ Finset.range n,
          (((if a k = c ∧ a (k + 1) = c + 1 then 1 else 0) : ℤ)
            - ((if a k = c + 1 ∧ a (k + 1) = c then 1 else 0) : ℤ)) := by
              rw [Finset.sum_sub_distrib]
    _ = ∑ k ∈ Finset.range n,
          (levelIndicator c (a (k + 1)) - levelIndicator c (a k)) := by
              apply Finset.sum_congr rfl
              intro k hk
              exact (hlocal k hk).symm
    _ = levelIndicator c (a n) - levelIndicator c (a 0) :=
          levelIndicator_telescope c a n
    _ = endpointCrossingValue c (a 0) (a n) := levelIndicator_endpoint _ _ _

end Ising2DLambda.Tools
