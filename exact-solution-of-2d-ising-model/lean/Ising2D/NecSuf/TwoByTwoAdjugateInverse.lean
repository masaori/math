/-
# 2×2 行列の余因子行列と両側逆元（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTwoSidedInverseOfTwoByTwo.lean`
（人手 `def_adjugate_two_by_two`・`matrix_times_adjugate_two_by_two`・`adjugate_times_matrix_two_by_two`・
`two_sided_inverse_of_two_by_two_with_nonzero_det`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTwoSidedInverseOfTwoByTwoFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 成分の鎖が引く `mul_neg_eq_neg_mul_complex`・`neg_mul_eq_neg_mul_complex`・`neg_add_self_complex`（人手 `complex_times_negation_is_negation_of_product_in_cc`・`negation_times_complex_is_negation_of_product_in_cc`・`negation_plus_self_is_zero_in_cc`） | `mul_neg_eq_neg_mul'`・`neg_mul_eq_neg_mul'`・`neg_add_self'`（`NegationInProductAndNegationPlusSelf.lean` の必要十分版の可換環での特殊化） |
| `mul_adjTwo_apply_*`・`mul_adjTwo` | `mul_adjTwo'` |
| `adjTwo_mul_apply_*`・`adjTwo_mul` | `adjTwo_mul'` |
| `mul_detInv_smul_adjTwo`・`detInv_smul_adjTwo_mul`（スカラー倍を積の外へ → 上の主張 → スカラー倍の結合 → `u det = 1` → `1 I = I`） | `mul_smul_adjTwo_of_mul_det'`・`smul_adjTwo_mul_of_mul_det'` |

## 何が効いているか / 効いていないか

- 係数は可換環 `R` である。行列式 `Matrix.det` の定義そのものが `CommRing` を要求するので、これより弱くはできない。
  加えて証明の中でも乗法の可換則が効いている（成分の鎖の `B_{12}B_{11} = B_{11}B_{12}` などの段）。成分の鎖が引く
  `z(-w) = -(zw)`・`(-z)w = -(zw)`・`(-x) + x = 0` で何が効いているかは `NegationInProductAndNegationPlusSelf.lean` に書いた。
- 両側逆元に要るのは、`det B` の左逆元 `u`（`u · det B = 1`）が在ることだけである。体であること、`det B ≠ 0` から
  逆元を作ることは効いていない（具体版では `ℂ` が体なので `u := (det B)^{-1}` が取れる）。可換なので左逆元は右逆元でもあり、
  `B h = I` と `h B = I` の両方に同じ `u` で足りる。
- `u · det B = 1` は外せない。`u = 0` とすると、0 でない環では `B (0 · adj B) = 0 ≠ I` となる。
- 具体版との段の違いは次の 3 つで、どれも具体版の定義（`ℂ` の成分、Lean で置いたクロネッカーのデルタ、スカラー倍の成分の補題）を
  経由するかどうかだけの違いである。`(-x) + x = 0` の `(-1) + 1 = 0` は、具体版では `ℂ` の成分の等式
  `(-1,0) + (1,0) = (0,0)` で出す 4 段で、ここでは成分を持たないので環の公理（加法の逆元）の 1 段で `hsum` に渡す。
  単位行列の成分は、具体版の `kroneckerDelta_self`（`kroneckerDelta_of_ne`）→ `identity_matrix_apply` の 2 段を
  `one_apply_eq'`（`one_apply_ne''`）の 1 段で出す。スカラー倍の成分は、具体版の `matrix_smul_apply` を定義の展開（`rfl`）で出す。
  ほかの段は具体版と同じである。
- 複素数であること、添字の順序は効いていない（添字は `Fin 2` のまま。2×2 の余因子行列の形が添字を名指すため）。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases
import Ising2D.NecSuf.NegationInProductAndNegationPlusSelf

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [CommRing R]

/-- 2×2 行列の余因子行列 `[[B_{22}, -B_{12}], [-B_{21}, B_{11}]]`。 -/
def adjTwo' (B : Matrix (Fin 2) (Fin 2) R) : Matrix (Fin 2) (Fin 2) R :=
  !![B 1 1, -B 0 1; -B 1 0, B 0 0]

theorem mul_two_apply' (A B : Matrix (Fin 2) (Fin 2) R) (i k : Fin 2) :
    (A * B) i k = A i 0 * B 0 k + A i 1 * B 1 k := by
  rw [Matrix.mul_apply, Fin.sum_univ_two]

/-- `z(-w) = -(zw)`: `NecSuf.mul_neg_eq_neg_mul_of_neg_one'` の可換環での特殊化。 -/
theorem mul_neg_eq_neg_mul' (z w : R) : z * (-w) = -(z * w) :=
  mul_neg_eq_neg_mul_of_neg_one' (fun x => (neg_one_mul x).symm) (fun x => mul_comm x (-1)) z w

/-- `(-z)w = -(zw)`: `NecSuf.neg_mul_eq_neg_mul_of_neg_one'` の可換環での特殊化。 -/
theorem neg_mul_eq_neg_mul' (z w : R) : (-z) * w = -(z * w) :=
  neg_mul_eq_neg_mul_of_neg_one' (fun x => (neg_one_mul x).symm) z w

/-- `(-x) + x = 0`: `NecSuf.neg_add_self_of_neg_one'` の可換環での特殊化（`(-1) + 1 = 0` は加法の逆元）。 -/
theorem neg_add_self' (x : R) : (-x) + x = 0 :=
  neg_add_self_of_neg_one' (fun y => (neg_one_mul y).symm) one_mul (neg_add_cancel 1) zero_mul x

theorem det_two' (B : Matrix (Fin 2) (Fin 2) R) : B.det = B 0 0 * B 1 1 - B 0 1 * B 1 0 :=
  Matrix.det_fin_two B

theorem one_apply_eq' (i : Fin 2) : (1 : Matrix (Fin 2) (Fin 2) R) i i = 1 := Matrix.one_apply_eq i

theorem one_apply_ne'' {i j : Fin 2} (h : i ≠ j) : (1 : Matrix (Fin 2) (Fin 2) R) i j = 0 :=
  Matrix.one_apply_ne h

/-- `B (adj B) = (det B) I`（具体版 `mul_adjTwo` と同じ成分の鎖）。 -/
theorem mul_adjTwo' (B : Matrix (Fin 2) (Fin 2) R) :
    B * adjTwo' B = B.det • (1 : Matrix (Fin 2) (Fin 2) R) := by
  ext i k
  fin_cases i <;> fin_cases k
  · show (B * adjTwo' B) 0 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 0
    calc (B * adjTwo' B) 0 0
        = B 0 0 * adjTwo' B 0 0 + B 0 1 * adjTwo' B 1 0 := mul_two_apply' _ _ _ _
      _ = B 0 0 * B 1 1 + B 0 1 * (-B 1 0) := rfl
      _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_neg_eq_neg_mul']
      _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm
      _ = B.det := (det_two' B).symm
      _ = B.det * 1 := (mul_one _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 0 0 := by rw [one_apply_eq']
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 0 := rfl
  · show (B * adjTwo' B) 0 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 1
    calc (B * adjTwo' B) 0 1
        = B 0 0 * adjTwo' B 0 1 + B 0 1 * adjTwo' B 1 1 := mul_two_apply' _ _ _ _
      _ = B 0 0 * (-B 0 1) + B 0 1 * B 0 0 := rfl
      _ = (-(B 0 0 * B 0 1)) + B 0 1 * B 0 0 := by rw [mul_neg_eq_neg_mul']
      _ = (-(B 0 0 * B 0 1)) + B 0 0 * B 0 1 := by rw [mul_comm (B 0 1) (B 0 0)]
      _ = 0 := neg_add_self' _
      _ = B.det * 0 := (mul_zero _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 0 1 := by rw [one_apply_ne'' (by decide)]
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 1 := rfl
  · show (B * adjTwo' B) 1 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 0
    calc (B * adjTwo' B) 1 0
        = B 1 0 * adjTwo' B 0 0 + B 1 1 * adjTwo' B 1 0 := mul_two_apply' _ _ _ _
      _ = B 1 0 * B 1 1 + B 1 1 * (-B 1 0) := rfl
      _ = B 1 0 * B 1 1 + (-(B 1 1 * B 1 0)) := by rw [mul_neg_eq_neg_mul']
      _ = B 1 0 * B 1 1 + (-(B 1 0 * B 1 1)) := by rw [mul_comm (B 1 1) (B 1 0)]
      _ = (-(B 1 0 * B 1 1)) + B 1 0 * B 1 1 := add_comm _ _
      _ = 0 := neg_add_self' _
      _ = B.det * 0 := (mul_zero _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 1 0 := by rw [one_apply_ne'' (by decide)]
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 0 := rfl
  · show (B * adjTwo' B) 1 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 1
    calc (B * adjTwo' B) 1 1
        = B 1 0 * adjTwo' B 0 1 + B 1 1 * adjTwo' B 1 1 := mul_two_apply' _ _ _ _
      _ = B 1 0 * (-B 0 1) + B 1 1 * B 0 0 := rfl
      _ = (-(B 1 0 * B 0 1)) + B 1 1 * B 0 0 := by rw [mul_neg_eq_neg_mul']
      _ = B 1 1 * B 0 0 + (-(B 1 0 * B 0 1)) := add_comm _ _
      _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by
          rw [mul_comm (B 1 1) (B 0 0), mul_comm (B 1 0) (B 0 1)]
      _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm
      _ = B.det := (det_two' B).symm
      _ = B.det * 1 := (mul_one _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 1 1 := by rw [one_apply_eq']
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 1 := rfl

/-- `(adj B) B = (det B) I`（具体版 `adjTwo_mul` と同じ成分の鎖）。 -/
theorem adjTwo_mul' (B : Matrix (Fin 2) (Fin 2) R) :
    adjTwo' B * B = B.det • (1 : Matrix (Fin 2) (Fin 2) R) := by
  ext i k
  fin_cases i <;> fin_cases k
  · show (adjTwo' B * B) 0 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 0
    calc (adjTwo' B * B) 0 0
        = adjTwo' B 0 0 * B 0 0 + adjTwo' B 0 1 * B 1 0 := mul_two_apply' _ _ _ _
      _ = B 1 1 * B 0 0 + (-B 0 1) * B 1 0 := rfl
      _ = B 1 1 * B 0 0 + (-(B 0 1 * B 1 0)) := by rw [neg_mul_eq_neg_mul']
      _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_comm (B 1 1) (B 0 0)]
      _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm
      _ = B.det := (det_two' B).symm
      _ = B.det * 1 := (mul_one _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 0 0 := by rw [one_apply_eq']
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 0 := rfl
  · show (adjTwo' B * B) 0 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 1
    calc (adjTwo' B * B) 0 1
        = adjTwo' B 0 0 * B 0 1 + adjTwo' B 0 1 * B 1 1 := mul_two_apply' _ _ _ _
      _ = B 1 1 * B 0 1 + (-B 0 1) * B 1 1 := rfl
      _ = B 1 1 * B 0 1 + (-(B 0 1 * B 1 1)) := by rw [neg_mul_eq_neg_mul']
      _ = B 1 1 * B 0 1 + (-(B 1 1 * B 0 1)) := by rw [mul_comm (B 0 1) (B 1 1)]
      _ = (-(B 1 1 * B 0 1)) + B 1 1 * B 0 1 := add_comm _ _
      _ = 0 := neg_add_self' _
      _ = B.det * 0 := (mul_zero _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 0 1 := by rw [one_apply_ne'' (by decide)]
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 0 1 := rfl
  · show (adjTwo' B * B) 1 0 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 0
    calc (adjTwo' B * B) 1 0
        = adjTwo' B 1 0 * B 0 0 + adjTwo' B 1 1 * B 1 0 := mul_two_apply' _ _ _ _
      _ = (-B 1 0) * B 0 0 + B 0 0 * B 1 0 := rfl
      _ = (-(B 1 0 * B 0 0)) + B 0 0 * B 1 0 := by rw [neg_mul_eq_neg_mul']
      _ = (-(B 1 0 * B 0 0)) + B 1 0 * B 0 0 := by rw [mul_comm (B 0 0) (B 1 0)]
      _ = 0 := neg_add_self' _
      _ = B.det * 0 := (mul_zero _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 1 0 := by rw [one_apply_ne'' (by decide)]
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 0 := rfl
  · show (adjTwo' B * B) 1 1 = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 1
    calc (adjTwo' B * B) 1 1
        = adjTwo' B 1 0 * B 0 1 + adjTwo' B 1 1 * B 1 1 := mul_two_apply' _ _ _ _
      _ = (-B 1 0) * B 0 1 + B 0 0 * B 1 1 := rfl
      _ = (-(B 1 0 * B 0 1)) + B 0 0 * B 1 1 := by rw [neg_mul_eq_neg_mul']
      _ = B 0 0 * B 1 1 + (-(B 1 0 * B 0 1)) := add_comm _ _
      _ = B 0 0 * B 1 1 + (-(B 0 1 * B 1 0)) := by rw [mul_comm (B 1 0) (B 0 1)]
      _ = B 0 0 * B 1 1 - B 0 1 * B 1 0 := (sub_eq_add_neg _ _).symm
      _ = B.det := (det_two' B).symm
      _ = B.det * 1 := (mul_one _).symm
      _ = B.det * (1 : Matrix (Fin 2) (Fin 2) R) 1 1 := by rw [one_apply_eq']
      _ = (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) 1 1 := rfl

/-- `u det B = 1` なら `B (u adj B) = I`（具体版 `mul_detInv_smul_adjTwo` と同じ 5 段）。 -/
theorem mul_smul_adjTwo_of_mul_det' (B : Matrix (Fin 2) (Fin 2) R) (u : R) (hu : u * B.det = 1) :
    B * (u • adjTwo' B) = 1 :=
  calc B * (u • adjTwo' B)
      = u • (B * adjTwo' B) := Matrix.mul_smul _ _ _
    _ = u • (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) := by rw [mul_adjTwo']
    _ = (u * B.det) • (1 : Matrix (Fin 2) (Fin 2) R) := smul_smul _ _ _
    _ = (1 : R) • (1 : Matrix (Fin 2) (Fin 2) R) := by rw [hu]
    _ = 1 := one_smul _ _

/-- `u det B = 1` なら `(u adj B) B = I`（具体版 `detInv_smul_adjTwo_mul` と同じ 5 段）。 -/
theorem smul_adjTwo_mul_of_mul_det' (B : Matrix (Fin 2) (Fin 2) R) (u : R) (hu : u * B.det = 1) :
    (u • adjTwo' B) * B = 1 :=
  calc (u • adjTwo' B) * B
      = u • (adjTwo' B * B) := Matrix.smul_mul _ _ _
    _ = u • (B.det • (1 : Matrix (Fin 2) (Fin 2) R)) := by rw [adjTwo_mul']
    _ = (u * B.det) • (1 : Matrix (Fin 2) (Fin 2) R) := smul_smul _ _ _
    _ = (1 : R) • (1 : Matrix (Fin 2) (Fin 2) R) := by rw [hu]
    _ = 1 := one_smul _ _

end Ising2D.NecSuf
