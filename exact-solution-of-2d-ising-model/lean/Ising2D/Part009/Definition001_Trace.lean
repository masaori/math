/-
# トレースの定義と基本性質（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `def_trace`（`eigenvalues_of_V_001_definition_trace`）
- `trace_basic_properties`（`eigenvalues_of_V_002_claim_trace_properties`）
- `trace_of_idempotent`（`eigenvalues_of_V_003_claim_trace_of_idempotent`）

原文の `tr(A) := ∑_{k=1}^n A_{kk}` は mathlib の `Matrix.trace`
（`Matrix.trace A = ∑ i, A i i`）と**定義そのものが一致する**ので、
以降は `Matrix.trace` をそのまま使う（`trace_eq_sum_diag` で一致を明示する）。

抽象版は置かない。理由: 原文 (1)(2)(3) は mathlib の
`Matrix.trace_add` / `trace_smul` / `trace_mul_comm` / `trace_one` が
既に任意の可換半環について述べており、これ以上取り払える構造が無い。
(4) も (2) の系である。なお (2) の巡回性という**性質だけ**を仮定にした抽象版は
`Ising2D/Abstract/NumberOperator.lean` の `tau_num_mul_add_self` と
`Ising2D/Abstract/JointEigenspace.lean` の `two_pow_smul_tau_projOn` にある
（そこでは `τ` の値域すら任意の可換群でよいことが分かる）。
-/
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Trace
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Projection
import Mathlib.Data.Complex.Basic
import Ising2D.Basic

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

/-- 原文 Step 1 の直和分解 `ℂ^n = im Q ⊕ ker Q`（冪等性からの帰結）。 -/
theorem isCompl_range_ker_of_idempotent (Q : Matrix n n ℂ) (hQ : Q * Q = Q) :
    IsCompl (LinearMap.range (Matrix.toLin' Q)) (LinearMap.ker (Matrix.toLin' Q)) := by
  have hidem : IsIdempotentElem (Matrix.toLin' Q) := by
    have h : Matrix.toLin' Q * Matrix.toLin' Q = Matrix.toLin' Q := by
      rw [Module.End.mul_eq_comp, ← Matrix.toLin'_mul, hQ]
    exact h
  exact LinearMap.IsIdempotentElem.isCompl hidem

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
