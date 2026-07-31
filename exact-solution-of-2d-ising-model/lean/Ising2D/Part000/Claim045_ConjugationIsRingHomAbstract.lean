/-
# `<conjugation_is_ring_homomorphism>` — 具体版を抽象版の特殊化として導出する

対応する人手証明:
`parts/000_計算公式/045_claim_共役写像は環準同型.typ`
(`<conjugation_is_ring_homomorphism>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | 本ファイルの `Ising2D.matrix_conj_mul_of_abstract` ほか（原文と同じ `Mat(n,ℂ)` と `Matrix.inv`） | `n` は有限・等号判定可能、成分は ℂ、`B` は正則 |
| **抽象版** | `Abstract.conj_mul` / `conj_one` / `conj_conj` / `conjAut`（`Abstract/Conjugation.lean`） | (1)(2)(3) は**モノイドとその単元群だけ**。加法性にだけ分配法則 |

原文と同じ形の直接証明は `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean` にある
（そちらは編集していない）。本ファイルは同じ主張を**抽象版の系として**得ることで、
具体版が過剰な構造を要求していないことを確かめる。

特殊化で埋めるべきなのは「正則行列 `B` が行列環 `Mat(n,ℂ)` の単元であり、
その単元の逆元の成分が `Matrix.inv` による `B⁻¹` に一致すること」だけである
（`matUnit` 以下）。したがって原文の (1)(2)(3) に効いているのは
**行列環がモノイドであることと `B` が単元であること**だけであり、
成分が ℂ であることも、行列であることも、加法（環であること）も効いていない。
-/
import Ising2D.Abstract.Conjugation
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## 橋渡し: 正則行列を行列環の単元として見る -/

/-- 正則行列 `B`（`IsUnit B.det`）を行列環 `Mat(n,ℂ)` の単元として与える。
mathlib の `Matrix.nonsingInvUnit` はその逆元が `Matrix.inv` による `B⁻¹` と定義的に一致するので、
抽象版の `Abstract.conj` が原文の `B A B⁻¹` にそのまま一致する。 -/
noncomputable def matUnit (B : Matrix n n ℂ) (hB : IsUnit B.det) : (Matrix n n ℂ)ˣ :=
  Matrix.nonsingInvUnit B hB

@[simp]
theorem matUnit_val (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    ((matUnit B hB : (Matrix n n ℂ)ˣ) : Matrix n n ℂ) = B := rfl

@[simp]
theorem matUnit_inv_val (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    (((matUnit B hB)⁻¹ : (Matrix n n ℂ)ˣ) : Matrix n n ℂ) = B⁻¹ := rfl

/-- 抽象版の共役写像が、原文の記法 `T_B(A) = B A B⁻¹` と一致すること。 -/
theorem abstract_conj_eq_matrix_conj (B : Matrix n n ℂ) (hB : IsUnit B.det) (A : Matrix n n ℂ) :
    Abstract.conj (matUnit B hB) A = B * A * B⁻¹ := by
  simp [Abstract.conj_apply]

/-! ## 原文の主張を抽象版の系として得る -/

/-- **(1) 乗法性を抽象版の特殊化として導出した形**: `T_B(AC) = T_B(A) T_B(C)`。 -/
theorem matrix_conj_mul_of_abstract (B : Matrix n n ℂ) (hB : IsUnit B.det) (A C : Matrix n n ℂ) :
    B * (A * C) * B⁻¹ = (B * A * B⁻¹) * (B * C * B⁻¹) := by
  have h := Abstract.conj_mul (matUnit B hB) A C
  simpa only [abstract_conj_eq_matrix_conj] using h

/-- **(2) 単位性を抽象版の特殊化として導出した形**: `T_B(I) = I`。 -/
theorem matrix_conj_one_of_abstract (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    B * 1 * B⁻¹ = 1 := by
  have h := Abstract.conj_one (matUnit B hB)
  simpa only [abstract_conj_eq_matrix_conj] using h

/-- **(3) 合成則を抽象版の特殊化として導出した形**: `T_A(T_B(M)) = T_{AB}(M)`。

抽象版では合成則に可逆性が効いていない（`Abstract.sandwich_sandwich` は結合法則だけで従う）が、
ここでは原文と同じく `A, B` の正則性を仮定した形で述べる。 -/
theorem matrix_conj_comp_of_abstract (A B : Matrix n n ℂ) (hA : IsUnit A.det) (hB : IsUnit B.det)
    (X : Matrix n n ℂ) :
    A * (B * X * B⁻¹) * A⁻¹ = (A * B) * X * (A * B)⁻¹ := by
  have h := Abstract.conj_conj (matUnit A hA) (matUnit B hB) X
  rw [abstract_conj_eq_matrix_conj, abstract_conj_eq_matrix_conj] at h
  rw [h, Abstract.conj_apply]
  simp [Matrix.mul_inv_rev, Matrix.mul_assoc]

/-- 加法性を抽象版の特殊化として導出した形（原文は明示していないが、「環準同型」に必要）。 -/
theorem matrix_conj_add_of_abstract (B : Matrix n n ℂ) (hB : IsUnit B.det) (A C : Matrix n n ℂ) :
    B * (A + C) * B⁻¹ = B * A * B⁻¹ + B * C * B⁻¹ := by
  have h := Abstract.conj_add (matUnit B hB) A C
  simpa only [abstract_conj_eq_matrix_conj] using h

/-- 原文の「共役写像は環準同型」を、抽象版の `Abstract.conjRingHom` の特殊化として
`Mat(n,ℂ) →+* Mat(n,ℂ)` の形で述べたもの。 -/
noncomputable def matrixConjRingHom (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    Matrix n n ℂ →+* Matrix n n ℂ :=
  Abstract.conjRingHom (matUnit B hB)

@[simp]
theorem matrixConjRingHom_apply (B : Matrix n n ℂ) (hB : IsUnit B.det) (A : Matrix n n ℂ) :
    matrixConjRingHom B hB A = B * A * B⁻¹ :=
  abstract_conj_eq_matrix_conj B hB A

/-- 原文 (3) の集約形を具体版で述べたもの: `B ↦ T_B` は行列環の単元群から
環自己同型群への群準同型である。 -/
theorem matrixConjRingHom_comp (A B : Matrix n n ℂ) (hA : IsUnit A.det) (hB : IsUnit B.det)
    (hAB : IsUnit (A * B).det) (X : Matrix n n ℂ) :
    matrixConjRingHom A hA (matrixConjRingHom B hB X) = matrixConjRingHom (A * B) hAB X := by
  simp only [matrixConjRingHom_apply]
  exact matrix_conj_comp_of_abstract A B hA hB X

end Ising2D
