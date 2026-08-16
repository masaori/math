/-
「回文性で対称化した素指数データは逆数で不変である」
（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）の Lean 具体版・第一歩。

人手証明の第一歩「回文性 Z_L(X) = X^{#E_L} Z_L(1/X) の X=q 代入」に対応する。
自由境界の分配多項式が #E_L について回文である（`reflect #E_L Z_L = Z_L`）ことと
次数が #E_L 以下であることから、q ≠ 0 なる有理点で値の等式
  Z_L.eval q = q ^ #E_L * Z_L.eval (1/q)
を、mathlib の `eval₂_reflect_mul_pow`（反転多項式の 1/q での値に q^N を掛けると元の値）だけで示す。
第二歩（付値の乗法性）は `SymmetrizedReciprocalInvariantStepTwo.lean`、
第三歩（Λ の加法で整理）は `SymmetrizedReciprocalInvariantStepThree.lean`。
-/
import Mathlib.Algebra.Polynomial.Reverse

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 第一歩。`f` が `E` に関して回文（`reflect E f = f`）で次数が `E` 以下なら、
`q ≠ 0` で `f.eval q = q ^ E * f.eval (1/q)`。 -/
theorem eval_eq_pow_mul_eval_inv_of_reflect_eq {E : ℕ} {f : ℚ[X]}
    (hpal : reflect E f = f) (hdeg : f.natDegree ≤ E) {q : ℚ} (hq : q ≠ 0) :
    f.eval q = q ^ E * f.eval (1 / q) := by
  letI : Invertible q := invertibleOfNonzero hq
  have h := eval₂_reflect_mul_pow (RingHom.id ℚ) q E f hdeg
  rw [hpal] at h
  have hinv : (⅟q : ℚ) = 1 / q := by
    rw [one_div, invOf_eq_inv]
  rw [hinv, eval₂_id, eval₂_id] at h
  rw [← h, mul_comm]

end Ising3DCut.LimitQuantity
