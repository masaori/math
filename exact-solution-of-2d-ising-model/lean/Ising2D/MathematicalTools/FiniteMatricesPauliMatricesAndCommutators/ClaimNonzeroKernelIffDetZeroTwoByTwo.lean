/-
# 固有ベクトル・固有値、2×2 行列の行列式、0 でないベクトルを 0 へ送ることと行列式が 0 であることの同値（**具体版**）

対応する人手証明のラベル: `def_eigenvector`, `def_eigenvalue`, `def_det_two_by_two`,
`nonzero_kernel_iff_det_zero_two_by_two`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の
`finite_matrix_definition_eigenvector`, `finite_matrix_definition_eigenvalue`,
`finite_matrix_definition_determinant_two_by_two`,
`finite_matrix_claim_nonzero_kernel_iff_determinant_zero_two_by_two`）

**必要十分版**: `Ising2D/NecSuf/TwoByTwoKernelAndDeterminant.lean`
（`Ising2D.NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det`）。

## 人手証明との対応

* `def_eigenvector`: `IsEigenvector`。`def_eigenvalue`: `IsEigenvalue`。
* `def_det_two_by_two`: 行列式は mathlib の `Matrix.det`（Leibniz の定義）を `Fin 2` で使う。後段の章の Lean
  （`charPoly_factor_thetaTilde`・`det_checkPmat` など）が `Matrix.det` で書かれているからである。
  人手の定義 `det B := B_{11}B_{22} - B_{12}B_{21}` との接点は `det_two_by_two_def`（`Matrix.det_fin_two`）の
  1 か所だけで、行列式についてそれ以外の mathlib の定理は使わない。
* 添字: Lean の `Fin 2` の `0, 1` が人手の添字 `1, 2` に当たる（`B 0 1` が人手の `B_{12}`）。
* 人手の `n ∈ ℤ_{≥1}` に対し、`IsEigenvector`・`IsEigenvalue` は `n : ℕ` で `n = 0` も許す。
  `n = 0` では `v ≠ 0` となる `v` が無いので、どの `λ` も固有値にならないだけである。
* `nonzero_kernel_iff_det_zero_two_by_two`: `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two`。
  「⇒」の 2 本の鎖は `det_mul_v0_eq_zero`・`det_mul_v1_eq_zero`、`v_i ≠ 0` となる `i` を取って零因子が無いことから
  `det B = 0` を出す段は `det_eq_zero_of_ne_zero_mulVec_eq_zero`。「⇐」の 3 つの場合の成分の鎖は
  `mulVec_row0_ne_zero`・`mulVec_row0_zero_row1_ne_zero`・`mulVec_rows_zero`。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FinCases
import Ising2D.NecSuf.TwoByTwoKernelAndDeterminant

namespace Ising2D

open Matrix

/-- **`def_eigenvector`**: `v ≠ 0` かつ `Av = λv` のとき、`v` を `A` の `λ` に属する固有ベクトルと呼ぶ。 -/
def IsEigenvector {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (lam : ℂ) (v : Fin n → ℂ) : Prop :=
  v ≠ 0 ∧ A *ᵥ v = lam • v

/-- **`def_eigenvalue`**: `A` の `λ` に属する固有ベクトルが存在するとき、`λ` を `A` の固有値と呼ぶ。 -/
def IsEigenvalue {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (lam : ℂ) : Prop :=
  ∃ v : Fin n → ℂ, IsEigenvector A lam v

/-- **`def_det_two_by_two`**: `det B = B_{11}B_{22} - B_{12}B_{21}`。 -/
theorem det_two_by_two_def (B : Matrix (Fin 2) (Fin 2) ℂ) :
    B.det = B 0 0 * B 1 1 - B 0 1 * B 1 0 :=
  Matrix.det_fin_two B

/-- `mat_mult` の行列とベクトルの積の第 1 成分 `(Bv)_1 = B_{11}v_1 + B_{12}v_2`。 -/
theorem mulVec_two_zero (B : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) :
    (B *ᵥ v) 0 = B 0 0 * v 0 + B 0 1 * v 1 := by
  simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]

/-- `mat_mult` の行列とベクトルの積の第 2 成分 `(Bv)_2 = B_{21}v_1 + B_{22}v_2`。 -/
theorem mulVec_two_one (B : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) :
    (B *ᵥ v) 1 = B 1 0 * v 0 + B 1 1 * v 1 := by
  simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]

/-- 「⇒」の第 1 の鎖: `Bv = 0` なら `det B · v_1 = 0`。 -/
theorem det_mul_v0_eq_zero (B : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) (hBv : B *ᵥ v = 0) :
    B.det * v 0 = 0 :=
  calc B.det * v 0
      = (B 0 0 * B 1 1 - B 0 1 * B 1 0) * v 0 := by rw [det_two_by_two_def]  -- `def_det_two_by_two`
    _ = B 0 0 * B 1 1 * v 0 - B 0 1 * B 1 0 * v 0 := by ring                    -- 分配則
    _ = B 1 1 * B 0 0 * v 0 - B 0 1 * B 1 0 * v 0 := by ring                    -- 乗法の可換則
    _ = B 1 1 * B 0 0 * v 0 - B 0 1 * B 1 0 * v 0 + (B 1 1 * B 0 1 * v 1 - B 1 1 * B 0 1 * v 1) := by
        rw [sub_self, add_zero]                                                  -- `x - x = 0`
    _ = B 1 1 * B 0 0 * v 0 - B 0 1 * B 1 0 * v 0 + (B 1 1 * B 0 1 * v 1 - B 0 1 * B 1 1 * v 1) := by
        rw [mul_comm (B 1 1) (B 0 1)]                                            -- 乗法の可換則
    _ = B 1 1 * B 0 0 * v 0 + B 1 1 * B 0 1 * v 1 - B 0 1 * B 1 0 * v 0 - B 0 1 * B 1 1 * v 1 := by
        ring                                                                     -- 加法の交換則と結合則
    _ = B 1 1 * (B 0 0 * v 0 + B 0 1 * v 1) - B 0 1 * (B 1 0 * v 0 + B 1 1 * v 1) := by ring  -- 分配則
    _ = B 1 1 * (B *ᵥ v) 0 - B 0 1 * (B *ᵥ v) 1 := by
        rw [mulVec_two_zero, mulVec_two_one]                                     -- `mat_mult`
    _ = B 1 1 * 0 - B 0 1 * 0 := by rw [hBv]; rfl                               -- `Bv = 0`
    _ = 0 := by ring                                                             -- ℂ の四則

/-- 「⇒」の第 2 の鎖: `Bv = 0` なら `det B · v_2 = 0`。 -/
theorem det_mul_v1_eq_zero (B : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) (hBv : B *ᵥ v = 0) :
    B.det * v 1 = 0 :=
  calc B.det * v 1
      = (B 0 0 * B 1 1 - B 0 1 * B 1 0) * v 1 := by rw [det_two_by_two_def]  -- `def_det_two_by_two`
    _ = B 0 0 * B 1 1 * v 1 - B 0 1 * B 1 0 * v 1 := by ring                    -- 分配則
    _ = B 0 0 * B 1 1 * v 1 - B 1 0 * B 0 1 * v 1 := by ring                    -- 乗法の可換則
    _ = B 0 0 * B 1 1 * v 1 - B 1 0 * B 0 1 * v 1 + (B 0 0 * B 1 0 * v 0 - B 0 0 * B 1 0 * v 0) := by
        rw [sub_self, add_zero]                                                  -- `x - x = 0`
    _ = B 0 0 * B 1 1 * v 1 - B 1 0 * B 0 1 * v 1 + (B 0 0 * B 1 0 * v 0 - B 1 0 * B 0 0 * v 0) := by
        rw [mul_comm (B 0 0) (B 1 0)]                                            -- 乗法の可換則
    _ = B 0 0 * B 1 0 * v 0 + B 0 0 * B 1 1 * v 1 - B 1 0 * B 0 0 * v 0 - B 1 0 * B 0 1 * v 1 := by
        ring                                                                     -- 加法の交換則と結合則
    _ = B 0 0 * (B 1 0 * v 0 + B 1 1 * v 1) - B 1 0 * (B 0 0 * v 0 + B 0 1 * v 1) := by ring  -- 分配則
    _ = B 0 0 * (B *ᵥ v) 1 - B 1 0 * (B *ᵥ v) 0 := by
        rw [mulVec_two_zero, mulVec_two_one]                                     -- `mat_mult`
    _ = B 0 0 * 0 - B 1 0 * 0 := by rw [hBv]; rfl                               -- `Bv = 0`
    _ = 0 := by ring                                                             -- ℂ の四則

/-- 「⇒」: `v ≠ 0` なので `v_i ≠ 0` となる `i` があり、`det B · v_i = 0` と、`ℂ` が零因子を
持たないこと（`complex_numbers_form_a_field`）から `det B = 0`。 -/
theorem det_eq_zero_of_ne_zero_mulVec_eq_zero (B : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ)
    (hv : v ≠ 0) (hBv : B *ᵥ v = 0) : B.det = 0 := by
  obtain ⟨i, hi⟩ := Function.ne_iff.mp hv
  fin_cases i
  · exact (mul_eq_zero.mp (det_mul_v0_eq_zero B v hBv)).resolve_right hi
  · exact (mul_eq_zero.mp (det_mul_v1_eq_zero B v hBv)).resolve_right hi

/-- 「⇐」の 1 行目が零でない場合: `det B = 0` なら `v := (B_{12}, -B_{11})` について `Bv = 0`。 -/
theorem mulVec_row0_ne_zero (B : Matrix (Fin 2) (Fin 2) ℂ) (hdet : B.det = 0) :
    B *ᵥ ![B 0 1, -B 0 0] = 0 := by
  ext i
  fin_cases i
  · show (B *ᵥ ![B 0 1, -B 0 0]) 0 = 0
    calc (B *ᵥ ![B 0 1, -B 0 0]) 0
        = B 0 0 * B 0 1 + B 0 1 * (-B 0 0) := by rw [mulVec_two_zero]; rfl  -- `mat_mult`
      _ = B 0 0 * B 0 1 - B 0 1 * B 0 0 := by ring                         -- ℂ の四則
      _ = B 0 0 * B 0 1 - B 0 0 * B 0 1 := by rw [mul_comm (B 0 1) (B 0 0)]  -- 乗法の可換則
      _ = 0 := sub_self _                                                   -- `x - x = 0`
  · show (B *ᵥ ![B 0 1, -B 0 0]) 1 = 0
    calc (B *ᵥ ![B 0 1, -B 0 0]) 1
        = B 1 0 * B 0 1 + B 1 1 * (-B 0 0) := by rw [mulVec_two_one]; rfl  -- `mat_mult`
      _ = B 1 0 * B 0 1 - B 1 1 * B 0 0 := by ring                         -- ℂ の四則
      _ = B 0 1 * B 1 0 - B 0 0 * B 1 1 := by ring                         -- 乗法の可換則
      _ = -(B 0 0 * B 1 1 - B 0 1 * B 1 0) := by ring                      -- ℂ の四則
      _ = -B.det := by rw [det_two_by_two_def]                              -- `def_det_two_by_two`
      _ = -0 := by rw [hdet]                                                -- `det B = 0`
      _ = 0 := neg_zero                                                     -- ℂ の四則

/-- 「⇐」の 1 行目が零で 2 行目が零でない場合: `v := (B_{22}, -B_{21})` について `Bv = 0`。 -/
theorem mulVec_row0_zero_row1_ne_zero (B : Matrix (Fin 2) (Fin 2) ℂ)
    (h00 : B 0 0 = 0) (h01 : B 0 1 = 0) : B *ᵥ ![B 1 1, -B 1 0] = 0 := by
  ext i
  fin_cases i
  · show (B *ᵥ ![B 1 1, -B 1 0]) 0 = 0
    calc (B *ᵥ ![B 1 1, -B 1 0]) 0
        = B 0 0 * B 1 1 + B 0 1 * (-B 1 0) := by rw [mulVec_two_zero]; rfl  -- `mat_mult`
      _ = 0 * B 1 1 + 0 * (-B 1 0) := by rw [h00, h01]                     -- `B_{11} = B_{12} = 0`
      _ = 0 := by ring                                                      -- ℂ の四則
  · show (B *ᵥ ![B 1 1, -B 1 0]) 1 = 0
    calc (B *ᵥ ![B 1 1, -B 1 0]) 1
        = B 1 0 * B 1 1 + B 1 1 * (-B 1 0) := by rw [mulVec_two_one]; rfl  -- `mat_mult`
      _ = B 1 0 * B 1 1 - B 1 1 * B 1 0 := by ring                         -- ℂ の四則
      _ = B 1 0 * B 1 1 - B 1 0 * B 1 1 := by rw [mul_comm (B 1 1) (B 1 0)]  -- 乗法の可換則
      _ = 0 := sub_self _                                                   -- `x - x = 0`

/-- 「⇐」の 1 行目も 2 行目も零の場合: `v := (1, 0)` について `Bv = 0`。 -/
theorem mulVec_rows_zero (B : Matrix (Fin 2) (Fin 2) ℂ)
    (h00 : B 0 0 = 0) (h01 : B 0 1 = 0) (h10 : B 1 0 = 0) (h11 : B 1 1 = 0) :
    B *ᵥ ![1, 0] = 0 := by
  ext i
  fin_cases i
  · show (B *ᵥ ![(1 : ℂ), 0]) 0 = 0
    calc (B *ᵥ ![(1 : ℂ), 0]) 0
        = B 0 0 * 1 + B 0 1 * 0 := by rw [mulVec_two_zero]; rfl  -- `mat_mult`
      _ = 0 * 1 + 0 * 0 := by rw [h00, h01]                      -- `B_{11} = B_{12} = 0`
      _ = 0 := by ring                                            -- ℂ の四則
  · show (B *ᵥ ![(1 : ℂ), 0]) 1 = 0
    calc (B *ᵥ ![(1 : ℂ), 0]) 1
        = B 1 0 * 1 + B 1 1 * 0 := by rw [mulVec_two_one]; rfl   -- `mat_mult`
      _ = 0 * 1 + 0 * 0 := by rw [h10, h11]                      -- `B_{21} = B_{22} = 0`
      _ = 0 := by ring                                            -- ℂ の四則

/-- **`nonzero_kernel_iff_det_zero_two_by_two`**: `2×2` の複素行列 `B` について、
`Bv = 0` となる `v ≠ 0` があることと `det B = 0` は同値である。 -/
theorem exists_ne_zero_mulVec_eq_zero_iff_det_fin_two (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ B *ᵥ v = 0) ↔ B.det = 0 := by
  constructor
  · rintro ⟨v, hv, hBv⟩
    exact det_eq_zero_of_ne_zero_mulVec_eq_zero B v hv hBv
  · intro hdet
    by_cases hrow0 : B 0 0 = 0 ∧ B 0 1 = 0
    · by_cases hrow1 : B 1 0 = 0 ∧ B 1 1 = 0
      · -- 1 行目も 2 行目も零: `v = (1, 0)`。`1 ≠ 0` なので `v ≠ 0`
        exact ⟨![1, 0], fun h => one_ne_zero (congrFun h 0),
          mulVec_rows_zero B hrow0.1 hrow0.2 hrow1.1 hrow1.2⟩
      · -- 1 行目が零で 2 行目が零でない: `v = (B_{22}, -B_{21})`。`B_{22} ≠ 0` または `-B_{21} ≠ 0`
        refine ⟨![B 1 1, -B 1 0], fun h => hrow1 ⟨?_, ?_⟩,
          mulVec_row0_zero_row1_ne_zero B hrow0.1 hrow0.2⟩
        · simpa using congrFun h 1
        · simpa using congrFun h 0
    · -- 1 行目が零でない: `v = (B_{12}, -B_{11})`。`B_{12} ≠ 0` または `-B_{11} ≠ 0`
      refine ⟨![B 0 1, -B 0 0], fun h => hrow0 ⟨?_, ?_⟩, mulVec_row0_ne_zero B hdet⟩
      · simpa using congrFun h 1
      · simpa using congrFun h 0

/-- `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` を必要十分版
`NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det`（係数 `R := ℂ`）の特殊化として得る。 -/
theorem exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ B *ᵥ v = 0) ↔ B.det = 0 :=
  NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det B

end Ising2D
