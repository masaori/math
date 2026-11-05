/-
# 必要十分版: 開いた積の冪と、巡回的な写像による `tr((V_1V_2)^n) = tr(W^n)`

対応する具体版: `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionSymmetrizedTransferMatrix.lean`
（人手 `Z_equals_trace_of_W` の準備 2・準備 3・本体）。具体版と同じ段の calc で置く。

効いているもの:
* 準備 2・準備 3 は、積の結合律・単位元の左右の単位律・冪の定め方 `x^0 = 1`、`x^{m+1} = x^m x` だけ
  （モノイド）。加法も係数も効かない。
* 本体はそれに、写像 `τ : α → β` の巡回性 `τ(ab) = τ(ba)` を足すだけ。`τ` の線型性も `β` の構造も効かない。
* 準備 1 の `bb = v_1`・`w = (bv_2)b` は仮定 `hbb`・`hw` として受け取る（`b` が平方根であること・可逆性・正定値性は効かない）。

各段の右の注記は、具体版の同じ段が引く人手の根拠である（`pow_zero`・`pow_succ` は `def_exp` (1) の冪の定め方、
`mul_one`・`one_mul` は単位行列の右・左の単位律、`mul_assoc` は `mat_mult_associative`、`hcyc` は `trace_basic_properties` (2)）。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.Group.Basic

namespace Ising2D.NecSuf

variable {α : Type*} [Monoid α]

/-- 準備 2: `(x(yx)^k)y = (xy)^{k+1}`。 -/
theorem open_product_pow (x y : α) (k : ℕ) : (x * (y * x) ^ k) * y = (x * y) ^ (k + 1) := by
  induction k with
  | zero =>
    calc (x * (y * x) ^ 0) * y
        = (x * 1) * y := by rw [pow_zero]
      _ = x * y := by rw [mul_one]
      _ = 1 * (x * y) := (one_mul _).symm
      _ = (x * y) ^ 0 * (x * y) := by rw [pow_zero]
      _ = (x * y) ^ (0 + 1) := (pow_succ _ _).symm
  | succ k ih =>
    calc (x * (y * x) ^ (k + 1)) * y
        = (x * ((y * x) ^ k * (y * x))) * y := by rw [pow_succ]
      _ = ((x * (y * x) ^ k) * (y * x)) * y := by rw [← mul_assoc x ((y * x) ^ k) (y * x)]
      _ = (((x * (y * x) ^ k) * y) * x) * y := by rw [← mul_assoc (x * (y * x) ^ k) y x]
      _ = ((x * y) ^ (k + 1) * x) * y := by rw [ih]
      _ = (x * y) ^ (k + 1) * (x * y) := mul_assoc _ _ _
      _ = (x * y) ^ (k + 1 + 1) := (pow_succ _ _).symm

/-- 準備 3: `bb = v_1`・`w = (bv_2)b`（準備 1）のもとで `w^{k+1} = ((b(v_2v_1)^k)v_2)b`。 -/
theorem sandwich_pow_succ {b v1 v2 w : α} (hbb : b * b = v1) (hw : w = (b * v2) * b) (k : ℕ) :
    w ^ (k + 1) = ((b * (v2 * v1) ^ k) * v2) * b := by
  induction k with
  | zero =>
    calc w ^ (0 + 1)
        = w ^ 0 * w := pow_succ _ _
      _ = 1 * w := by rw [pow_zero]
      _ = w := one_mul _
      _ = (b * v2) * b := hw
      _ = ((b * 1) * v2) * b := by rw [mul_one]
      _ = ((b * (v2 * v1) ^ 0) * v2) * b := by rw [pow_zero]
  | succ k ih =>
    obtain ⟨c, hc⟩ : ∃ c : α, c = b * (v2 * v1) ^ k := ⟨_, rfl⟩
    calc w ^ (k + 1 + 1)
        = w ^ (k + 1) * w := pow_succ _ _
      _ = (((b * (v2 * v1) ^ k) * v2) * b) * w := by rw [ih]
      _ = ((c * v2) * b) * w := by rw [hc]
      _ = ((c * v2) * b) * ((b * v2) * b) := by rw [hw]
      _ = (((c * v2) * b) * (b * v2)) * b := (mul_assoc _ _ _).symm
      _ = ((((c * v2) * b) * b) * v2) * b := by rw [← mul_assoc ((c * v2) * b) b v2]
      _ = (((c * v2) * (b * b)) * v2) * b := by rw [mul_assoc (c * v2) b b]
      _ = (((c * v2) * v1) * v2) * b := by rw [hbb]
      _ = ((c * (v2 * v1)) * v2) * b := by rw [mul_assoc c v2 v1]
      _ = (((b * (v2 * v1) ^ k) * (v2 * v1)) * v2) * b := by rw [hc]
      _ = ((b * ((v2 * v1) ^ k * (v2 * v1))) * v2) * b := by
          rw [mul_assoc b ((v2 * v1) ^ k) (v2 * v1)]
      _ = ((b * (v2 * v1) ^ (k + 1)) * v2) * b := by rw [← pow_succ]

/-- 本体: `τ` が巡回的（`τ(ac) = τ(ca)`）で `bb = v_1`・`w = (bv_2)b` なら、`n ≥ 1` で `τ((v_1v_2)^n) = τ(w^n)`。 -/
theorem trace_mul_pow_eq_trace_sandwich_pow {β : Type*} (τ : α → β)
    (hcyc : ∀ a c : α, τ (a * c) = τ (c * a)) {b v1 v2 w : α} (hbb : b * b = v1)
    (hw : w = (b * v2) * b) (N : ℕ) (hN : 1 ≤ N) :
    τ ((v1 * v2) ^ N) = τ (w ^ N) := by
  obtain ⟨k, rfl⟩ : ∃ k, N = k + 1 := ⟨N - 1, by omega⟩
  calc τ ((v1 * v2) ^ (k + 1))
      = τ ((v1 * (v2 * v1) ^ k) * v2) := by rw [open_product_pow]
    _ = τ (((b * b) * (v2 * v1) ^ k) * v2) := by rw [hbb]
    _ = τ ((b * (b * (v2 * v1) ^ k)) * v2) := by rw [mul_assoc b b ((v2 * v1) ^ k)]
    _ = τ (b * ((b * (v2 * v1) ^ k) * v2)) := by rw [mul_assoc b (b * (v2 * v1) ^ k) v2]
    _ = τ (((b * (v2 * v1) ^ k) * v2) * b) := hcyc _ _
    _ = τ (w ^ (k + 1)) := by rw [sandwich_pow_succ hbb hw]

end Ising2D.NecSuf
