/-
# 2×2 行列が 0 でないベクトルを 0 へ送ることと行列式が 0 であることの同値（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` の
`exists_ne_zero_mulVec_eq_zero_iff_det_fin_two`（人手 `nonzero_kernel_iff_det_zero_two_by_two`。
`eigenvector_of_A_theta_tilde` Step 1 の「`λ` が固有値であることは `det(A(θ) - λI) = 0` と同値」の最後の段で引く）。具体版をこのファイルの系として導くのは、
同じファイルの `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 「⇒」: `det B · v_1 = B_{22}(Bv)_1 - B_{12}(Bv)_2`、`det B · v_2 = B_{11}(Bv)_2 - B_{21}(Bv)_1` | `det_mul_vec_zero_of_mulVec`・`det_mul_vec_one_of_mulVec` |
| 「⇒」: `v_i ≠ 0` となる `i` を取り、`det B · v_i = 0` と零因子が無いことから `det B = 0` | `det_eq_zero_of_mulVec_eq_zero` |
| 「⇐」: 1 行目が 0 でなければ `v = (B_{12}, -B_{11})`、1 行目が 0 で 2 行目が 0 でなければ `v = (B_{22}, -B_{21})`、`B = 0` なら `v = (1, 0)` | `exists_ne_zero_mulVec_eq_zero_of_det_eq_zero` |

## 何が効いているか / 効いていないか

- 「⇒」の 2 本の恒等式と「⇐」の 3 つのベクトルの計算で効くのは、係数の可換環の構造（分配則・乗法の可換則・加法逆元）だけである。
- 「⇒」の最後の段では、`det B · v_i = 0` と `v_i ≠ 0` から `det B = 0` を出すために、零因子が無いこと（`NoZeroDivisors`）が効く。
  これを外すと主張は成り立たない（`ℤ/4ℤ` で `B = diag(2, 1)`、`v = (2, 0)` とすると `Bv = 0`、`v ≠ 0` だが `det B = 2 ≠ 0`）。
- 「⇐」は零因子が無いことを使わない。`B = 0` の場合の `v = (1, 0) ≠ 0` に `1 ≠ 0`（`Nontrivial`）が効く。
  これを外すと主張は成り立たない（零環では `det B = 0` だが、すべてのベクトルが `0` なので `v ≠ 0` が無い）。
- 体であること、`ℂ` であること、複素共役は効いていない。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FinCases

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [CommRing R]

/-- 「⇒」の第 1 の恒等式: `det B · v_1 = B_{22}(Bv)_1 - B_{12}(Bv)_2`。 -/
theorem det_mul_vec_zero_of_mulVec (B : Matrix (Fin 2) (Fin 2) R) (v : Fin 2 → R) :
    B.det * v 0 = B 1 1 * (B *ᵥ v) 0 - B 0 1 * (B *ᵥ v) 1 := by
  rw [Matrix.det_fin_two]
  simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
  ring

/-- 「⇒」の第 2 の恒等式: `det B · v_2 = B_{11}(Bv)_2 - B_{21}(Bv)_1`。 -/
theorem det_mul_vec_one_of_mulVec (B : Matrix (Fin 2) (Fin 2) R) (v : Fin 2 → R) :
    B.det * v 1 = B 0 0 * (B *ᵥ v) 1 - B 1 0 * (B *ᵥ v) 0 := by
  rw [Matrix.det_fin_two]
  simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
  ring

/-- 「⇒」: `v ≠ 0` かつ `Bv = 0` なら `det B = 0`。零因子が無いことを使う。 -/
theorem det_eq_zero_of_mulVec_eq_zero [NoZeroDivisors R] (B : Matrix (Fin 2) (Fin 2) R)
    (v : Fin 2 → R) (hv : v ≠ 0) (hBv : B *ᵥ v = 0) : B.det = 0 := by
  have h0 : B.det * v 0 = 0 := by
    rw [det_mul_vec_zero_of_mulVec, hBv]; simp
  have h1 : B.det * v 1 = 0 := by
    rw [det_mul_vec_one_of_mulVec, hBv]; simp
  obtain ⟨i, hi⟩ := Function.ne_iff.mp hv
  fin_cases i
  · exact (mul_eq_zero.mp h0).resolve_right hi
  · exact (mul_eq_zero.mp h1).resolve_right hi

/-- 「⇐」: `det B = 0` なら、`B` が 0 へ送る 0 でないベクトルがある。 -/
theorem exists_ne_zero_mulVec_eq_zero_of_det_eq_zero [Nontrivial R]
    (B : Matrix (Fin 2) (Fin 2) R) (hdet : B.det = 0) : ∃ v : Fin 2 → R, v ≠ 0 ∧ B *ᵥ v = 0 := by
  rw [Matrix.det_fin_two] at hdet
  by_cases hrow0 : B 0 0 = 0 ∧ B 0 1 = 0
  · by_cases hrow1 : B 1 0 = 0 ∧ B 1 1 = 0
    · -- `B = 0`: `v = (1, 0)`
      refine ⟨![1, 0], fun h => one_ne_zero (congrFun h 0), ?_⟩
      ext i; fin_cases i <;>
        simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, hrow0.1, hrow0.2, hrow1.1, hrow1.2]
    · -- 1 行目が 0、2 行目が 0 でない: `v = (B_{22}, -B_{21})`
      refine ⟨![B 1 1, -B 1 0], fun h => hrow1 ⟨?_, ?_⟩, ?_⟩
      · simpa using congrFun h 1
      · simpa using congrFun h 0
      ext i; fin_cases i
      · simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two, hrow0.1, hrow0.2]
      · simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]; ring
  · -- 1 行目が 0 でない: `v = (B_{12}, -B_{11})`
    refine ⟨![B 0 1, -B 0 0], fun h => hrow0 ⟨?_, ?_⟩, ?_⟩
    · simpa using congrFun h 1
    · simpa using congrFun h 0
    ext i; fin_cases i
    · simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]; ring
    · simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
      linear_combination (-1 : R) * hdet

/-- 2×2 行列が 0 でないベクトルを 0 へ送ることと `det B = 0` の同値。 -/
theorem exists_ne_zero_mulVec_eq_zero_iff_det [NoZeroDivisors R] [Nontrivial R]
    (B : Matrix (Fin 2) (Fin 2) R) : (∃ v : Fin 2 → R, v ≠ 0 ∧ B *ᵥ v = 0) ↔ B.det = 0 :=
  ⟨fun ⟨v, hv, hBv⟩ => det_eq_zero_of_mulVec_eq_zero B v hv hBv,
    exists_ne_zero_mulVec_eq_zero_of_det_eq_zero B⟩

end Ising2D.NecSuf
