/-
# トレースの定義と基本性質（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `def_trace`（`eigenvalues_of_V_001_definition_trace`）
- `trace_basic_properties`（`eigenvalues_of_V_002_claim_trace_properties`）
- `trace_of_idempotent`（`eigenvalues_of_V_003_claim_trace_of_idempotent`）

原文の `tr(A) := ∑_{k=1}^n A_{kk}` は mathlib の `Matrix.trace`
（`Matrix.trace A = ∑ i, A i i`）と**定義そのものが一致する**ので、
以降は `Matrix.trace` をそのまま使う（`trace_eq_sum_diag` で一致を明示する）。

必要十分版は置かない。理由: 原文 (1)(2)(3) は mathlib の
`Matrix.trace_add` / `trace_smul` / `trace_mul_comm` / `trace_one` が
既に任意の可換半環について述べており、これ以上取り払える構造が無い。
(4) も (2) の系である。なお (2) の巡回性という**性質だけ**を仮定にした必要十分版は
`Ising2D/NecSuf/NumberOperator.lean` の `tau_num_mul_add_self` と
`Ising2D/NecSuf/JointEigenspace.lean` の `two_pow_smul_tau_projOn` にある
（そこでは `τ` の値域すら任意の可換群でよいことが分かる）。
-/
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Trace
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Projection
import Mathlib.Data.Complex.Basic
import Ising2D.Basic
import Ising2D.NecSuf.MatrixProductIdentityAndScalar
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference

namespace Ising2D

open Matrix

section TraceBasic

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **原文 `def_trace` の形式化**: `tr(A) = ∑_{k} A_{kk}`。
mathlib の `Matrix.trace` の定義そのもの。 -/
theorem trace_eq_sum_diag (A : Matrix n n ℂ) : A.trace = ∑ k, A k k := rfl

/-- **原文 `trace_basic_properties` (1)**（線型性）。 -/
theorem trace_linear (α β : ℂ) (A B : Matrix n n ℂ) :
    (α • A + β • B).trace = α * A.trace + β * B.trace := by
  rw [Matrix.trace_add, Matrix.trace_smul, Matrix.trace_smul, smul_eq_mul, smul_eq_mul]

/-- **原文 `trace_basic_properties` (2)**（巡回性）。 -/
theorem trace_cyclic (A B : Matrix n n ℂ) : (A * B).trace = (B * A).trace :=
  Matrix.trace_mul_comm A B

/-- **人手 `trace_basic_properties` (3)**: `tr(I_n) = Σ_{k=1}^{n} 1_ℂ`。人手の 3 行と 1 対 1 の `calc`。 -/
theorem trace_identity_eq_sum_one : (1 : Matrix n n ℂ).trace = ∑ _k : n, (1 : ℂ) :=
  calc (1 : Matrix n n ℂ).trace
      = ∑ k, (1 : Matrix n n ℂ) k k := rfl                               -- `def_trace`
    _ = ∑ k, (if k = k then (1 : ℂ) else 0) :=
        Finset.sum_congr rfl fun _ _ => Matrix.one_apply              -- `def_identity_matrix`（成分は `δ_{kk}`）
    _ = ∑ _k : n, (1 : ℂ) := Finset.sum_congr rfl fun _ _ => if_pos rfl   -- `def_kronecker_delta` の `i = j` の場合

/-- **原文 `trace_basic_properties` (3)**: `tr(I_n) = n`。 -/
theorem trace_one_eq_card : (1 : Matrix n n ℂ).trace = (Fintype.card n : ℂ) :=
  Matrix.trace_one

/-- **原文 `trace_basic_properties` (4)**: 共役でトレースは変わらない。

原文は `P` が可逆であることを仮定するが、証明が使うのは `P^{-1}P = I` だけなので、
逆行列の存在ではなく「左逆元 `Q`」の形で述べる（可逆な `P` に対しては `Q = P^{-1}`）。 -/
theorem trace_conj (P Q A : Matrix n n ℂ) (h : Q * P = 1) :
    (P * A * Q).trace = A.trace := by
  calc (P * A * Q).trace = (Q * (P * A)).trace := Matrix.trace_mul_comm _ _
    _ = ((Q * P) * A).trace := by rw [mul_assoc]
    _ = A.trace := by rw [h, one_mul]

/-- **原文 `trace_basic_properties` (4)** の人手の形: `P'P = I` なら `tr(P(AP')) = tr(A)`。

人手の 5 行と 1 対 1（`mat_mult_associative` は Lean の具体版が無く、mathlib の `Matrix.mul_assoc` を引く。
`identity_matrix_is_left_unit_of_mat_mult` は具体版の添字が `Fin m` に限るので、必要十分版
`NecSuf.one_mul_matrix` の係数 `ℂ`・添字 `n` の特殊化を引く）。上の `trace_conj` は左辺を `(PA)P'` で受け取る旧い形である。 -/
theorem trace_similarity_invariant (P P' A : Matrix n n ℂ) (h : P' * P = 1) :
    (P * (A * P')).trace = A.trace :=
  calc (P * (A * P')).trace
      = ((P * A) * P').trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = (P' * (P * A)).trace := trace_cyclic _ _           -- (2) を `A → PA`、`B → P'` に適用
    _ = ((P' * P) * A).trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = ((1 : Matrix n n ℂ) * A).trace := by rw [h]        -- `P'P = I`
    _ = A.trace := by rw [NecSuf.one_mul_matrix]           -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 単元による共役版（原文の `P` が可逆な場合そのもの）。 -/
theorem trace_units_conj (P : (Matrix n n ℂ)ˣ) (A : Matrix n n ℂ) :
    ((P : Matrix n n ℂ) * A * (↑P⁻¹ : Matrix n n ℂ)).trace = A.trace :=
  trace_conj _ _ _ (by simp)

end TraceBasic

/-! ## 冪等行列のトレースは像の次元（原文 `trace_of_idempotent`） -/

section TraceIdempotent

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **原文 `trace_of_idempotent` の形式化**:
`Q^2 = Q` なら `tr(Q) = dim_ℂ (im Q)`。

原文の `im Q = {Qx}` は、`Q` の定める線型写像 `x ↦ Q x` の像
（`LinearMap.range Q.toLin'`）である。原文 Step 1（直和分解 `ℂ^n = im Q ⊕ ker Q`）と
Step 2（適合基底での対角形）は、mathlib では
`IsIdempotentElem.isProj_range`（冪等元は像への射影）と
`LinearMap.IsProj.trace` にまとまっている。 -/
theorem trace_of_idempotent (Q : Matrix n n ℂ) (hQ : Q * Q = Q) :
    Q.trace = (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q)) : ℂ) := by
  have hidem : IsIdempotentElem (Matrix.toLin' Q) := by
    have h : Matrix.toLin' Q * Matrix.toLin' Q = Matrix.toLin' Q := by
      rw [Module.End.mul_eq_comp, ← Matrix.toLin'_mul, hQ]
    exact h
  have hproj := LinearMap.IsIdempotentElem.isProj_range _ hidem
  have h2 := hproj.trace (R := ℂ)
  rw [← Matrix.trace_toLin'_eq Q, h2]

/-- **人手 `trace_of_idempotent` の準備**: `Q^2 = QQ`。人手の 4 行と 1 対 1 の `calc`
（`def_exp` (1) の冪 `A^{m+1} := A^m A` は mathlib の `pow_succ`、`A^0 := I` は `pow_zero`。
`identity_matrix_is_left_unit_of_mat_mult` は具体版の添字が `Fin m` に限るので、必要十分版 `NecSuf.one_mul_matrix` の
係数 `ℂ`・添字 `n` の特殊化を引く）。 -/
theorem idempotent_sq_eq_mul_self (Q : Matrix n n ℂ) : Q ^ 2 = Q * Q :=
  calc Q ^ 2
      = Q ^ 1 * Q := pow_succ Q 1                          -- `def_exp` (1) の `A^{m+1} := A^m A` を `m = 1` に
    _ = (Q ^ 0 * Q) * Q := by rw [pow_succ Q 0]            -- `def_exp` (1) の `A^{m+1} := A^m A` を `m = 0` に
    _ = (1 * Q) * Q := by rw [pow_zero]                    -- `def_exp` (1) の `A^0 := I`
    _ = Q * Q := by rw [NecSuf.one_mul_matrix]             -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手の準備の結び: 仮定 `Q^2 = Q` から `QQ = Q`。 -/
theorem idempotent_mul_self_of_sq (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) : Q * Q = Q :=
  (idempotent_sq_eq_mul_self Q).symm.trans hQ

/-- **人手 `trace_of_idempotent` の Step 1 の 1 本目の鎖**: `(Qx + (x − Qx))_k = x_k`。人手の 7 行と 1 対 1 の `calc`。
`def_matrix_sum`・`def_matrix_difference` の具体版 `matrix_sum_apply`・`matrix_sub_apply` は添字が `Fin m` に限るので、
添字 `n` の数ベクトルでは定義そのもの（`Pi.add_apply`・`Pi.sub_apply`）で開く。`def_complex_difference` は `sub_eq_add_neg`、
`complex_zero_plus_is_original` は具体版が無く `zero_add`。 -/
theorem idempotent_decomposition_apply (Q : Matrix n n ℂ) (x : n → ℂ) (k : n) :
    (Q *ᵥ x + (x - Q *ᵥ x)) k = x k :=
  calc (Q *ᵥ x + (x - Q *ᵥ x)) k
      = (Q *ᵥ x) k + (x - Q *ᵥ x) k := Pi.add_apply _ _ _            -- `def_matrix_sum`
    _ = (Q *ᵥ x) k + (x k - (Q *ᵥ x) k) := by rw [Pi.sub_apply]       -- `def_matrix_difference`
    _ = (Q *ᵥ x) k + (x k + -(Q *ᵥ x) k) := by rw [sub_eq_add_neg]    -- `def_complex_difference`（`z → x_k, w → (Qx)_k`）
    _ = (Q *ᵥ x) k + (-(Q *ᵥ x) k + x k) := by rw [add_comm (x k)]    -- `complex_numbers_form_a_field` の和の可換律
    _ = ((Q *ᵥ x) k + -(Q *ᵥ x) k) + x k := (add_assoc _ _ _).symm    -- `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
    _ = 0 + x k := by rw [add_neg_cancel]                              -- `complex_numbers_form_a_field` の加法逆元
    _ = x k := zero_add _                                               -- `complex_zero_plus_is_original`（`z → x_k`）

/-- 人手 Step 1 の「行列の等号は成分ごとであることから `x = Qx + (x − Qx)`」。 -/
theorem idempotent_decomposition (Q : Matrix n n ℂ) (x : n → ℂ) : x = Q *ᵥ x + (x - Q *ᵥ x) :=
  (funext (idempotent_decomposition_apply Q x)).symm

/-- **人手 Step 1 の 2 本目の鎖**: `QQ = Q` なら `Q(x − Qx) = 0`（`x − Qx ∈ ker Q`）。人手の 4 行と 1 対 1 の `calc`。
`mat_mult_vector_difference` と `mat_mult_associative`（数ベクトルへの作用）は Lean の具体版が無いので、
mathlib の `Matrix.mulVec_sub`・`Matrix.mulVec_mulVec` を 1 回ずつ使う。`matrix_difference_zero_iff_equal` の数ベクトルの具体版
`vec_sub_eq_zero_iff` は添字が `Fin m` に限るので、必要十分版 `NecSuf.sub_eq_zero_iff_vec` の係数 `ℂ`・添字 `n` の特殊化を引く。 -/
theorem idempotent_sub_mem_ker (Q : Matrix n n ℂ) (hQQ : Q * Q = Q) (x : n → ℂ) :
    Q *ᵥ (x - Q *ᵥ x) = 0 :=
  calc Q *ᵥ (x - Q *ᵥ x)
      = Q *ᵥ x - Q *ᵥ (Q *ᵥ x) := Matrix.mulVec_sub _ _ _               -- `mat_mult_vector_difference`
    _ = Q *ᵥ x - (Q * Q) *ᵥ x := by rw [Matrix.mulVec_mulVec]            -- `mat_mult_associative`
    _ = Q *ᵥ x - Q *ᵥ x := by rw [hQQ]                                   -- 準備の `QQ = Q`
    _ = 0 := (NecSuf.sub_eq_zero_iff_vec _ _).mpr rfl                    -- `matrix_difference_zero_iff_equal` の `⇐` を `A = B = Qx` に

/-- **人手 Step 1 の 3 本目の鎖**: `y = Qx` かつ `Qy = 0` なら `y = 0`（`im Q ∩ ker Q = {0}`）。人手の 5 行と 1 対 1 の `calc`。 -/
theorem idempotent_range_inter_ker_eq_zero (Q : Matrix n n ℂ) (hQQ : Q * Q = Q) (x y : n → ℂ)
    (hx : Q *ᵥ x = y) (hy : Q *ᵥ y = 0) : y = 0 :=
  calc y
      = Q *ᵥ x := hx.symm                                   -- `x` の取り方
    _ = (Q * Q) *ᵥ x := by rw [hQQ]                         -- 準備の `QQ = Q`
    _ = Q *ᵥ (Q *ᵥ x) := (Matrix.mulVec_mulVec _ _ _).symm  -- `mat_mult_associative`
    _ = Q *ᵥ y := by rw [hx]                                -- `Qx = y`
    _ = 0 := hy                                             -- `y ∈ ker Q`

/-- **人手 `trace_of_idempotent` の主張の前半（Step 1）**: `Q^2 = Q` なら `ℂ^n = im Q ⊕ ker Q`。
人手の `im Q = {Qx}`・`ker Q = {x | Qx = 0}` は、`x ↦ Qx` の線型写像 `Matrix.toLin' Q` の `range`・`ker` である。
和が全体であることは `idempotent_decomposition`・`idempotent_sub_mem_ker`、交わりが `{0}` であることは
`idempotent_range_inter_ker_eq_zero` で示し、`QQ = Q` は準備の `idempotent_mul_self_of_sq` から引く。 -/
theorem isCompl_range_ker_of_idempotent (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) :
    IsCompl (LinearMap.range (Matrix.toLin' Q)) (LinearMap.ker (Matrix.toLin' Q)) := by
  have hQQ := idempotent_mul_self_of_sq Q hQ
  constructor
  · rw [Submodule.disjoint_def]
    intro y hyr hyk
    obtain ⟨x, hx⟩ := LinearMap.mem_range.mp hyr
    rw [Matrix.toLin'_apply] at hx
    rw [LinearMap.mem_ker, Matrix.toLin'_apply] at hyk
    exact idempotent_range_inter_ker_eq_zero Q hQQ x y hx hyk
  · rw [codisjoint_iff, eq_top_iff]
    intro x _
    rw [idempotent_decomposition Q x]
    refine Submodule.add_mem_sup (LinearMap.mem_range.mpr ⟨x, Matrix.toLin'_apply Q x⟩) ?_
    rw [LinearMap.mem_ker, Matrix.toLin'_apply]
    exact idempotent_sub_mem_ker Q hQQ x

end TraceIdempotent

/-! ## `Mat(2^M, ℂ)` での `tr(I)` -/

/-- 本プロジェクトの表現 `TensorPow M = Mat(Conf M, ℂ)` では
添字集合の濃度が `2^M` なので `tr(I) = 2^M`（原文
`trace_of_number_operator_product` の `k = 0` の場合）。 -/
theorem trace_one_tensorPow (M : ℕ) : (1 : TensorPow M).trace = ((2 ^ M : ℕ) : ℂ) := by
  rw [Matrix.trace_one]
  congr 1
  simp [Conf]

end Ising2D
