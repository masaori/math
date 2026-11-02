/-
# 共役写像は環準同型

対応する人手証明（本文の正本は `structured-latex/content/000_calculation_formulae_45_46.ts`）:
`parts/000_計算公式/045_claim_共役写像は環準同型.typ`
(`<conjugation_is_ring_homomorphism>`)

原文: `n ∈ ℤ_{≥1}`、`B ∈ (Mat(n, ℂ))^×`（正則）について、
共役写像 `T_B : Mat(n,ℂ) → Mat(n,ℂ)`, `T_B(A) = B A B⁻¹` は

1. 乗法的: `T_B(A C) = T_B(A) T_B(C)`
2. 単位的: `T_B(I) = I`
3. 合成則: `T_A ∘ T_B = T_{A B}`

を満たす。原文はこれらを行列積の結合法則と `B B⁻¹ = B⁻¹ B = I` から直接示している。

## 人手証明と 1 対 1 に対応する具体版

節 `ComplexMatrixChains` の 6 本が人手の鎖と 1 段ずつ対応する。人手の正則な `B ∈ Mat(n,ℂ)` は Lean の単元
`B : (Matrix (Fin n) (Fin n) ℂ)ˣ`（`↑B` が `B`、`↑B⁻¹` が `B^{-1}`）で、人手の `T_B`（`mat_conj` の `T_B(A) := (BA)B^{-1}`）は
`T B A = ↑B * A * ↑B⁻¹`（Lean の `x * y * z` は `(x * y) * z`）である。

* 乗法性の鎖の 9 行 ↔ `conj_mul_matrix` の `calc` の 9 段。
* 単位性の鎖の 3 行 ↔ `conj_one_matrix` の 3 段。
* 合成則の準備の 2 本（右逆元・左逆元の各 5 行）↔ `mul_mul_inv_rev_matrix`・`inv_rev_mul_mul_matrix`。
  人手の「`H^{-1}G^{-1}` は `GH` の両側逆元であり、`GH` は正則」↔ `mulUnitOfChains`（2 本の鎖から組んだ単元）と
  `mulUnitOfChains_eq_mul`（その単元は単元の積 `G * H` と同じ）。
  人手の `(GH)^{-1} = H^{-1}G^{-1}` の 5 行の鎖 ↔ `units_mul_inv_rev_matrix` の 5 段（値が `GH` のどの単元 `U` についても述べる）。
* 合成則の鎖の 8 行 ↔ `conj_comp_matrix` の 8 段（`T_{GH}` は値が `GH` の単元 `U` の `T U`）。
  2 本の鎖から組んだ単元で述べたものが `conj_comp_matrix_of_chains`。
* `mat_mult_associative` は Lean の具体版が無く、mathlib の `Matrix.mul_assoc` を 1 段に 1 回使う。
  `identity_matrix_is_left_unit_of_mat_mult`・`..._right_unit_...` は `identity_matrix_mul`・`mul_identity_matrix`。
  `B^{-1}B = I`・`BB^{-1} = I` は単元の `Units.inv_mul`・`Units.mul_inv`。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。

必要十分版は `Ising2D/NecSuf/Conjugation.lean` の `Conj.sandwich_mul`・`Conj.sandwich_one`・`Conj.sandwich_comp`（同じ段の `calc`）。

## 一般の環での形（下の節 `Ring`）

本ファイルではさらに
* 一般の環 `R` とその可逆元 `B : Rˣ` に対して定式化し（行列環はその特別な場合）、
* 原文と同じ形（`Matrix n n ℂ` と `Matrix.inv` による `B⁻¹`）でも系として述べ、
* さらに mathlib の `ConjAct` 作用（`MulSemiringAction (ConjAct Rˣ) R`）と一致することを示して、
  加法性まで込めた「環準同型」であることを既存結果に接続する。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Mathlib.Algebra.Ring.Action.ConjAct
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Ising2D.Conjugation

section Ring

variable {R : Type*} [Ring R]

/-- 共役写像 `T_B(A) = B A B⁻¹`（`B` は環 `R` の可逆元）。 -/
def T (B : Rˣ) (A : R) : R := (B : R) * A * ((B⁻¹ : Rˣ) : R)

@[simp]
theorem T_apply (B : Rˣ) (A : R) : T B A = (B : R) * A * ((B⁻¹ : Rˣ) : R) := rfl

/-- `T_B` は mathlib の共役作用 `ConjAct Rˣ ↷ R` そのものである。 -/
theorem T_eq_conjAct_smul (B : Rˣ) (A : R) : T B A = ConjAct.toConjAct B • A := rfl

/-- **(1) 乗法的**（一般の環の単元）: `T_B(A C) = T_B(A) T_B(C)`。

結合法則と `B⁻¹ B = I` を挿し込む計算だけで示す（mathlib の群作用の一般論には委ねない）。
`simp` で結合法則をまとめて使うので、人手の鎖と 1 段ずつは対応しない。1 対 1 の具体版は節 `ComplexMatrixChains` の `conj_mul_matrix`。 -/
theorem T_mul (B : Rˣ) (A C : R) : T B (A * C) = T B A * T B C := by
  calc T B (A * C) = (B : R) * A * C * ((B⁻¹ : Rˣ) : R) := by
        simp only [T, mul_assoc]
    _ = (B : R) * A * (((B⁻¹ : Rˣ) : R) * (B : R)) * C * ((B⁻¹ : Rˣ) : R) := by
        rw [B.inv_mul]; simp only [mul_one]
    _ = T B A * T B C := by simp only [T, mul_assoc]

/-- **(2) 単位的**: `T_B(1) = 1`。原文どおり `B I B⁻¹ = B B⁻¹ = I`。 -/
theorem T_one (B : Rˣ) : T B (1 : R) = 1 := by
  rw [T, mul_one, B.mul_inv]

/-- 加法性（原文は明示していないが、「環準同型」であるために必要）。
分配法則だけで従う。 -/
theorem T_add (B : Rˣ) (A C : R) : T B (A + C) = T B A + T B C := by
  simp only [T, mul_add, add_mul]

/-- 共役写像を環準同型（実際には環自己同型）としてまとめたもの。
中身の 3 性質は上の `T_mul` / `T_one` / `T_add`（いずれも原文の計算そのもの）で与える。 -/
def TRingHom (B : Rˣ) : R →+* R where
  toFun := T B
  map_one' := T_one B
  map_mul' := T_mul B
  map_zero' := by simp [T]
  map_add' := T_add B

@[simp]
theorem coe_TRingHom (B : Rˣ) : ⇑(TRingHom B) = T B := rfl

/-- **(3) 合成則**: `T_A ∘ T_B = T_{A B}`。 -/
theorem T_comp (A B : Rˣ) : T A ∘ T B = T (A * B) := by
  funext x
  simp only [Function.comp_apply, T_apply, Units.val_mul, mul_inv_rev, Units.val_mul]
  simp only [mul_assoc]

/-- 合成則の各点版。 -/
theorem T_T (A B : Rˣ) (x : R) : T A (T B x) = T (A * B) x :=
  congrFun (T_comp A B) x

/-- 原文 Step 3 で用いられる逆元公式 `(A B)⁻¹ = B⁻¹ A⁻¹`（mathlib の `mul_inv_rev`）。 -/
theorem inv_mul_rev (A B : Rˣ) : (A * B)⁻¹ = B⁻¹ * A⁻¹ := mul_inv_rev A B

/-- 合成則 (3) を「`B ↦ T_B` は群準同型 `Rˣ →* RingAut R` である」という形で述べたもの。 -/
def TMonoidHom : Rˣ →* RingAut R where
  toFun B :=
    { toFun := T B
      invFun := T B⁻¹
      left_inv := fun x => by simp [T, mul_assoc]
      right_inv := fun x => by simp [T, mul_assoc]
      map_mul' := T_mul B
      map_add' := T_add B }
  map_one' := by ext x; simp [T]
  map_mul' A B := by ext x; simpa using (T_T A B x).symm

@[simp]
theorem TMonoidHom_apply (B : Rˣ) (x : R) : TMonoidHom B x = T B x := rfl

end Ring

section Matrix

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 原文の記法に沿った版: `B : Mat(n, ℂ)` が正則（`IsUnit B.det`）のとき、
`Matrix.inv` による `B⁻¹` を使った共役写像が乗法的であること。 -/
theorem matrix_conj_mul (B : Matrix n n ℂ) (hB : IsUnit B.det) (A C : Matrix n n ℂ) :
    B * (A * C) * B⁻¹ = (B * A * B⁻¹) * (B * C * B⁻¹) := by
  have h : B⁻¹ * B = 1 := nonsing_inv_mul B hB
  calc B * (A * C) * B⁻¹ = B * A * (B⁻¹ * B) * C * B⁻¹ := by
        rw [h]; simp [Matrix.mul_assoc]
    _ = (B * A * B⁻¹) * (B * C * B⁻¹) := by simp [Matrix.mul_assoc]

/-- 原文の記法に沿った版: 単位性 `T_B(I) = I`。 -/
theorem matrix_conj_one (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    B * 1 * B⁻¹ = 1 := by
  rw [Matrix.mul_one, mul_nonsing_inv B hB]

/-- 原文の記法に沿った版: 合成則 `T_A(T_B(M)) = T_{A B}(M)`。

原文 Step 3 は `A, B` の正則性を仮定しているが、mathlib の `Matrix.inv` は特異行列に対して
`0` を返す全域関数として定義されており、`Matrix.mul_inv_rev`（`(A B)⁻¹ = B⁻¹ A⁻¹`）が
**正則性なしで**成立する。したがってこの合成則も仮定なしで成り立つ。 -/
theorem matrix_conj_comp (A B : Matrix n n ℂ)
    (X : Matrix n n ℂ) :
    A * (B * X * B⁻¹) * A⁻¹ = (A * B) * X * (A * B)⁻¹ := by
  rw [Matrix.mul_inv_rev]
  simp [Matrix.mul_assoc]

end Matrix

section ComplexMatrixChains

open Matrix

variable {n : ℕ}

/-- **`conjugation_is_ring_homomorphism` の乗法性**: `T_B(AC) = T_B(A)T_B(C)`。人手の乗法性の鎖の 9 行。 -/
theorem conj_mul_matrix (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (A C : Matrix (Fin n) (Fin n) ℂ) :
    T B (A * C) = T B A * T B C :=
  calc T B (A * C)
      = ((B : Matrix (Fin n) (Fin n) ℂ) * (A * C)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `mat_conj` の `T_B` の定義
    _ = (((B : Matrix (Fin n) (Fin n) ℂ) * A) * C) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [Matrix.mul_assoc (B : Matrix (Fin n) (Fin n) ℂ) A C]             -- `mat_mult_associative`
    _ = (((B : Matrix (Fin n) (Fin n) ℂ) * A) * ((1 : Matrix (Fin n) (Fin n) ℂ) * C))
          * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [identity_matrix_mul C]                                            -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (((B : Matrix (Fin n) (Fin n) ℂ) * A)
          * ((((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) * (B : Matrix (Fin n) (Fin n) ℂ)) * C))
          * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [B.inv_mul]                                                        -- `B^{-1}B = I`
    _ = (((B : Matrix (Fin n) (Fin n) ℂ) * A)
          * (((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) * ((B : Matrix (Fin n) (Fin n) ℂ) * C)))
          * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [Matrix.mul_assoc ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          (B : Matrix (Fin n) (Fin n) ℂ) C]                                   -- `mat_mult_associative`
    _ = ((((B : Matrix (Fin n) (Fin n) ℂ) * A) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
          * ((B : Matrix (Fin n) (Fin n) ℂ) * C))
          * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [← Matrix.mul_assoc ((B : Matrix (Fin n) (Fin n) ℂ) * A)
          ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          ((B : Matrix (Fin n) (Fin n) ℂ) * C)]                               -- `mat_mult_associative`
    _ = (((B : Matrix (Fin n) (Fin n) ℂ) * A) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
          * (((B : Matrix (Fin n) (Fin n) ℂ) * C) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        Matrix.mul_assoc _ _ _                                                -- `mat_mult_associative`
    _ = T B A * (((B : Matrix (Fin n) (Fin n) ℂ) * C) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        rfl                                                                   -- `mat_conj` の `T_B` の定義
    _ = T B A * T B C := rfl                                                  -- `mat_conj` の `T_B` の定義

/-- **`conjugation_is_ring_homomorphism` の単位性**: `T_B(I) = I`。人手の単位性の鎖の 3 行。 -/
theorem conj_one_matrix (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) :
    T B (1 : Matrix (Fin n) (Fin n) ℂ) = 1 :=
  calc T B (1 : Matrix (Fin n) (Fin n) ℂ)
      = ((B : Matrix (Fin n) (Fin n) ℂ) * 1) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `mat_conj` の `T_B` の定義
    _ = (B : Matrix (Fin n) (Fin n) ℂ) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [mul_identity_matrix]                                              -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := B.mul_inv                                                        -- `BB^{-1} = I`

/-- **`conjugation_is_ring_homomorphism` の合成則の準備（右逆元）**: `(GH)(H^{-1}G^{-1}) = I`。人手の 5 行。 -/
theorem mul_mul_inv_rev_matrix (G H : (Matrix (Fin n) (Fin n) ℂ)ˣ) :
    ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))
      * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) = 1 :=
  calc ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))
        * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
            * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
      = (G : Matrix (Fin n) (Fin n) ℂ) * ((H : Matrix (Fin n) (Fin n) ℂ)
          * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
            * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))) :=
        Matrix.mul_assoc _ _ _                                                -- `mat_mult_associative`
    _ = (G : Matrix (Fin n) (Fin n) ℂ) * (((H : Matrix (Fin n) (Fin n) ℂ)
          * ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
            * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [Matrix.mul_assoc (H : Matrix (Fin n) (Fin n) ℂ)]                  -- `mat_mult_associative`
    _ = (G : Matrix (Fin n) (Fin n) ℂ)
          * ((1 : Matrix (Fin n) (Fin n) ℂ) * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [H.mul_inv]                                                        -- `HH^{-1} = I`
    _ = (G : Matrix (Fin n) (Fin n) ℂ) * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [identity_matrix_mul]                                              -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = 1 := G.mul_inv                                                        -- `GG^{-1} = I`

/-- **`conjugation_is_ring_homomorphism` の合成則の準備（左逆元）**: `(H^{-1}G^{-1})(GH) = I`。人手の 5 行。 -/
theorem inv_rev_mul_mul_matrix (G H : (Matrix (Fin n) (Fin n) ℂ)ˣ) :
    (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
        * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
      * ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) = 1 :=
  calc (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
        * ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))
      = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * (((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
            * ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))) :=
        Matrix.mul_assoc _ _ _                                                -- `mat_mult_associative`
    _ = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) * (G : Matrix (Fin n) (Fin n) ℂ))
            * (H : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [Matrix.mul_assoc ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)]
                                                                              -- `mat_mult_associative`
    _ = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((1 : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [G.inv_mul]                                                        -- `G^{-1}G = I`
    _ = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ) := by
        rw [identity_matrix_mul]                                              -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = 1 := H.inv_mul                                                        -- `H^{-1}H = I`

/-- **`conjugation_is_ring_homomorphism` の合成則の準備（`GH` は正則）**: 右逆元・左逆元の 2 本の鎖から組んだ、
`GH` を値に、`H^{-1}G^{-1}` を逆元に持つ単元。人手の「`H^{-1}G^{-1}` は `GH` の両側逆元であり、`GH` は正則」。 -/
def mulUnitOfChains (G H : (Matrix (Fin n) (Fin n) ℂ)ˣ) : (Matrix (Fin n) (Fin n) ℂ)ˣ :=
  ⟨(G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ),
    ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
      * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ),
    mul_mul_inv_rev_matrix G H, inv_rev_mul_mul_matrix G H⟩

/-- 2 本の鎖から組んだ単元 `mulUnitOfChains G H` は、単元の積 `G * H` と同じ単元である（値がどちらも `GH`）。
合成則の `T_{GH}` を `T (G * H)` で書くための橋。 -/
theorem mulUnitOfChains_eq_mul (G H : (Matrix (Fin n) (Fin n) ℂ)ˣ) : mulUnitOfChains G H = G * H :=
  Units.ext rfl

/-- **`conjugation_is_ring_homomorphism` の合成則の準備（逆元は一つに定まる）**: 値が `GH` の単元 `U` なら、どれについても
`U^{-1} = H^{-1}G^{-1}`。人手の 5 行の鎖（`(GH)^{-1}(GH) = I` と右逆元の鎖）。人手の `(GH)^{-1}` は、`GH` を値に持つ
どの単元の逆元でもよい（どれも `H^{-1}G^{-1}` になることが、逆元が一つに定まることである）。 -/
theorem units_mul_inv_rev_matrix (G H U : (Matrix (Fin n) (Fin n) ℂ)ˣ)
    (hU : (U : Matrix (Fin n) (Fin n) ℂ) = (G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) :
    ((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
      = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
  calc ((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
      = ((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) * 1 := by
        rw [mul_identity_matrix]                                              -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = ((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * (((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))
            * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
              * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))) := by
        rw [mul_mul_inv_rev_matrix]                                           -- 右逆元の鎖
    _ = (((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)))
            * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
              * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        (Matrix.mul_assoc _ _ _).symm                                         -- `mat_mult_associative`
    _ = (1 : Matrix (Fin n) (Fin n) ℂ)
            * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
              * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) := by
        rw [← hU, U.inv_mul]                                                 -- `(GH)^{-1}(GH) = I`
    _ = ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        identity_matrix_mul _                                                 -- `identity_matrix_is_left_unit_of_mat_mult`

/-- **`conjugation_is_ring_homomorphism` の合成則**: `(T_G ∘ T_H)(X) = T_{GH}(X)`。人手の合成則の鎖の 8 行。
`T_{GH}` は、値が `GH` の単元 `U`（例えば 2 本の鎖から組んだ `mulUnitOfChains G H`）による共役である。 -/
theorem conj_comp_matrix (G H U : (Matrix (Fin n) (Fin n) ℂ)ˣ)
    (hU : (U : Matrix (Fin n) (Fin n) ℂ) = (G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ))
    (X : Matrix (Fin n) (Fin n) ℂ) :
    (T G ∘ T H) X = T U X :=
  calc (T G ∘ T H) X
      = T G (T H X) := rfl                                                    -- 写像の合成の定義
    _ = T G (((H : Matrix (Fin n) (Fin n) ℂ) * X) * ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        rfl                                                                   -- `mat_conj` の `T_B` の定義（`B → H`）
    _ = ((G : Matrix (Fin n) (Fin n) ℂ)
          * (((H : Matrix (Fin n) (Fin n) ℂ) * X) * ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)))
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `mat_conj` の `T_B` の定義（`B → G`）
    _ = (((G : Matrix (Fin n) (Fin n) ℂ) * ((H : Matrix (Fin n) (Fin n) ℂ) * X))
          * ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [← Matrix.mul_assoc (G : Matrix (Fin n) (Fin n) ℂ) ((H : Matrix (Fin n) (Fin n) ℂ) * X)]
                                                                              -- `mat_mult_associative`
    _ = ((((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) * X)
          * ((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ))
          * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [← Matrix.mul_assoc (G : Matrix (Fin n) (Fin n) ℂ) (H : Matrix (Fin n) (Fin n) ℂ) X]
                                                                              -- `mat_mult_associative`
    _ = (((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) * X)
          * (((H⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
            * ((G⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        Matrix.mul_assoc _ _ _                                                -- `mat_mult_associative`
    _ = (((G : Matrix (Fin n) (Fin n) ℂ) * (H : Matrix (Fin n) (Fin n) ℂ)) * X)
          * ((U⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [units_mul_inv_rev_matrix G H U hU]                               -- `(GH)^{-1} = H^{-1}G^{-1}`
    _ = T U X := by rw [T, hU]                                                -- `mat_conj` の `T_B` の定義（`B → GH`）

/-- 合成則を、2 本の鎖から組んだ単元（`GH` は正則）で述べたもの。 -/
theorem conj_comp_matrix_of_chains (G H : (Matrix (Fin n) (Fin n) ℂ)ˣ) (X : Matrix (Fin n) (Fin n) ℂ) :
    (T G ∘ T H) X = T (mulUnitOfChains G H) X :=
  conj_comp_matrix G H (mulUnitOfChains G H) rfl X

end ComplexMatrixChains

end Ising2D.Conjugation
