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

`trace_of_idempotent` は上の理由に当たらない（準備・Step 1〜3 の鎖は ℂ 固有の性質を使わない）ので、
係数を可換環にし、`im Q`・`ker Q` が自由加群であることと `1 ≠ 0` だけを仮定した必要十分版 `Ising2D/NecSuf/TraceOfIdempotent.lean` を置き、
具体版をその特殊化として `ClaimTraceOfIdempotentFromNecSuf.lean` で導く。準備・Step 1〜3 の補題は、必要十分版でも同じ名前で同じ段である。
-/
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Trace
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Projection
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.LinearAlgebra.Matrix.Basis
-- 下の `simp [idempotentAdaptedBasis]` が生成する `Module.finBasis.congr_simp` は mathlib のこのモジュールにも在る。先に import して、
-- ライブラリの環境でその定数が mathlib のものとして数えられるようにする（`scripts/lean-concrete-general-theory/` は
-- 定数を最初に持つモジュールで分類するので、import の順でこのファイルの具体版の定数に数えられることがある）。
import Mathlib.LinearAlgebra.Determinant
import Ising2D.NecSuf.MatColumnwise
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

/-- `tr(I_n) = n`（右辺は `Fintype.card n` の `ℂ` への像）。人手 `trace_basic_properties` (3) は右辺を `Σ_{k=1}^{n} 1_ℂ` で述べる
（整数を `ℂ` の元へ移す写像が本文に無いため）ので、その具体版ではない。人手の形は `trace_identity_eq_sum_one`。 -/
theorem trace_one_eq_card : (1 : Matrix n n ℂ).trace = (Fintype.card n : ℂ) :=
  Matrix.trace_one

/-- 共役でトレースは変わらない（左辺を `(PA)Q` で受け取る旧い形。人手 `trace_basic_properties` (4) の形 `tr(P(AP'))` は
`trace_similarity_invariant`）。

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

/-- **人手 `trace_of_idempotent` の準備**: `Q^2 = QQ`。人手の 4 行と 1 対 1 の `calc`
（`def_matrix_power` の冪 `A^{m+1} := A^m A` は mathlib の `pow_succ`、`A^0 := I` は `pow_zero`。
`identity_matrix_is_left_unit_of_mat_mult` は具体版の添字が `Fin m` に限るので、必要十分版 `NecSuf.one_mul_matrix` の
係数 `ℂ`・添字 `n` の特殊化を引く）。 -/
theorem idempotent_sq_eq_mul_self (Q : Matrix n n ℂ) : Q ^ 2 = Q * Q :=
  calc Q ^ 2
      = Q ^ 1 * Q := pow_succ Q 1                          -- `def_matrix_power` の `A^{m+1} := A^m A` を `m = 1` に
    _ = (Q ^ 0 * Q) * Q := by rw [pow_succ Q 0]            -- `def_matrix_power` の `A^{m+1} := A^m A` を `m = 0` に
    _ = (1 * Q) * Q := by rw [pow_zero]                    -- `def_matrix_power` の `A^0 := I`
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
    _ = 0 + x k := by rw [add_neg_cancel]                              -- `complex_numbers_form_a_field` の加法の逆元
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

/-- **人手 `trace_of_idempotent` の Step 2 の `Qv_j = v_j`**（`v_j ∈ im Q`）: `QQ = Q` かつ `v = Qx` なら `Qv = v`。
人手の 4 行と 1 対 1 の `calc`（`mat_mult_associative` は上の `idempotent_sub_mem_ker` と同じく `Matrix.mulVec_mulVec`）。 -/
theorem idempotent_mulVec_of_eq_mulVec (Q : Matrix n n ℂ) (hQQ : Q * Q = Q) (x v : n → ℂ)
    (hv : v = Q *ᵥ x) : Q *ᵥ v = v :=
  calc Q *ᵥ v
      = Q *ᵥ (Q *ᵥ x) := by rw [hv]                         -- `v_j = Qx_j`
    _ = (Q * Q) *ᵥ x := Matrix.mulVec_mulVec _ _ _          -- `mat_mult_associative`
    _ = Q *ᵥ x := by rw [hQQ]                               -- 準備の `QQ = Q`
    _ = v := hv.symm                                        -- `v_j = Qx_j`

/-- **人手 Step 2 の基底 `v_1, …, v_n`**: `im Q` の基底 `v_1, …, v_r`（`r := dim_ℂ im Q`）と `ker Q` の基底
`v_{r+1}, …, v_n` を並べたもの。人手の「Step 1 の直和分解より `v_1, …, v_n` は `ℂ^n` の基底」は、Step 1 の
`isCompl_range_ker_of_idempotent` を `Submodule.prodEquivOfIsCompl` に渡して二つの基底をつなぐ段である。
人手の添字 `1, …, n` は Lean では `Fin (r + s)`（`s := dim_ℂ ker Q`）で、行列 `Q` の添字の型 `n` とは別の型になる。人手は `r + s = n` を暗に使って `P` を正方行列にするが、Lean は列の添字を `Fin (r + s)` に取るのでこの等式を使わずに済み、`P` は長方行列になる。
各部分空間の基底は `Module.finBasis`（人手の「基底を取る」）。 -/
noncomputable def idempotentAdaptedBasis (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) :
    Module.Basis (Fin (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q)))) ℂ (n → ℂ) :=
  (((Module.finBasis ℂ (LinearMap.range (Matrix.toLin' Q))).prod
      (Module.finBasis ℂ (LinearMap.ker (Matrix.toLin' Q)))).map
    (Submodule.prodEquivOfIsCompl _ _ (isCompl_range_ker_of_idempotent Q hQ))).reindex finSumFinEquiv

/-- 人手 Step 2: `j ≤ r` の `v_j` は `im Q` の元（Lean の添字は `0` 始まりなので `j < r`）。 -/
theorem idempotentAdaptedBasis_mem_range (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q)
    (j : Fin (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q))))
    (hj : (j : ℕ) < Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))) :
    idempotentAdaptedBasis Q hQ j ∈ LinearMap.range (Matrix.toLin' Q) := by
  obtain ⟨i, rfl⟩ : ∃ i, Fin.castAdd _ i = j := ⟨⟨j, hj⟩, rfl⟩
  simp [idempotentAdaptedBasis]

/-- 人手 Step 2: `j > r` の `v_j` は `ker Q` の元（Lean の添字では `r ≤ j`）。 -/
theorem idempotentAdaptedBasis_mem_ker (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q)
    (j : Fin (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q))))
    (hj : ¬ (j : ℕ) < Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))) :
    idempotentAdaptedBasis Q hQ j ∈ LinearMap.ker (Matrix.toLin' Q) := by
  obtain ⟨i, rfl⟩ : ∃ i, Fin.natAdd _ i = j :=
    ⟨⟨j - Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q)), by omega⟩, Fin.ext (by simp; omega)⟩
  simp [idempotentAdaptedBasis]

/-- 人手 Step 2 の `D`: `D_{kl} := 1_ℂ`（`k = l ≤ r`）、`0_ℂ`（それ以外）。添字は `Fin (r + s)` で、`k ≤ r` は `0` 始まりの `k < r`。 -/
def idempotentDiag (r s : ℕ) : Matrix (Fin (r + s)) (Fin (r + s)) ℂ :=
  fun k l => if k = l ∧ (k : ℕ) < r then 1 else 0

/-- **人手 `trace_of_idempotent` の Step 2**: `P := [v_1 ⋯ v_n]`（`mat_columnwise` の列に並べた行列）について `QP = PD`。
成分 `(i, l)` ごとに人手の 11 行と 1 対 1 の `calc`。`mat_columnwise` は具体版 `matrix_mul_columns` の添字が `Fin m` に限るので、
必要十分版 `NecSuf.mul_cols_eq_cols_mulVec` の特殊化を引く。`k = l` の項を分ける段は `Finset.add_sum_erase`
（人手の「加法の結合律・交換律」）、`complex_times_zero_is_zero` は `mul_zero`、積の単位元は `mul_one`。 -/
theorem idempotent_mul_columns_eq (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) :
    Q * Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
      = Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
        * idempotentDiag (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q)))
            (Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q))) := by
  set r := Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))
  set s := Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q))
  set v := idempotentAdaptedBasis Q hQ
  set P : Matrix n (Fin (r + s)) ℂ := Matrix.of (fun j l => v l j)
  set D := idempotentDiag r s
  have hQQ := idempotent_mul_self_of_sq Q hQ
  -- 人手 Step 2 の `j ≤ r` の `Qv_j = v_j` と `j > r` の `Qv_j = 0`
  have hQv : ∀ l : Fin (r + s), (l : ℕ) < r → Q *ᵥ v l = v l := fun l hl => by
    obtain ⟨x, hx⟩ := LinearMap.mem_range.mp (idempotentAdaptedBasis_mem_range Q hQ l hl)
    rw [Matrix.toLin'_apply] at hx
    exact idempotent_mulVec_of_eq_mulVec Q hQQ x (v l) hx.symm
  have hQv0 : ∀ l : Fin (r + s), ¬ (l : ℕ) < r → Q *ᵥ v l = 0 := fun l hl => by
    have h := idempotentAdaptedBasis_mem_ker Q hQ l hl
    rwa [LinearMap.mem_ker, Matrix.toLin'_apply] at h
  ext i l
  symm
  calc (P * D) i l
      = ∑ k, P i k * D k l := Matrix.mul_apply                                 -- `mat_mult`
    _ = P i l * D l l + ∑ k ∈ Finset.univ.erase l, P i k * D k l :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ l)).symm                    -- `k = l` の項を分ける
    _ = P i l * D l l + ∑ k ∈ Finset.univ.erase l, P i k * 0 := by
        congr 1
        refine Finset.sum_congr rfl fun k hk => ?_
        rw [show D k l = 0 from if_neg fun h => (Finset.ne_of_mem_erase hk) h.1]  -- `k ≠ l` では `D_{kl} = 0_ℂ`
    _ = P i l * D l l + ∑ _k ∈ Finset.univ.erase l, (0 : ℂ) := by
        simp only [mul_zero]                                                     -- `complex_times_zero_is_zero`
    _ = P i l * D l l := by rw [Finset.sum_const_zero, add_zero]               -- `0_ℂ` は加法の単位元
    _ = v l i * D l l := rfl                                                     -- `P` の定め方
    _ = (if (l : ℕ) < r then v l i * 1 else v l i * 0) := by                     -- `D` の定め方
        by_cases hl : (l : ℕ) < r
        · rw [if_pos hl]; exact congrArg _ (if_pos ⟨rfl, hl⟩)
        · rw [if_neg hl]; exact congrArg _ (if_neg fun h => hl h.2)
    _ = (if (l : ℕ) < r then v l i else 0) := by                                 -- 積の単位元と `complex_times_zero_is_zero`
        rw [mul_one, mul_zero]
    _ = (Q *ᵥ v l) i := by                                                       -- `l ≤ r` では `Qv_l = v_l`、`l > r` では `Qv_l = 0`
        by_cases hl : (l : ℕ) < r
        · rw [if_pos hl, hQv l hl]
        · rw [if_neg hl, hQv0 l hl, Pi.zero_apply]                              -- `def_zero_matrix`
    _ = Matrix.of (fun i l => (Q *ᵥ v l) i) i l := rfl                           -- `mat_columnwise` の、列に並べた行列の成分の定め方
    _ = (Q * P) i l := by rw [NecSuf.mul_cols_eq_cols_mulVec]                    -- `mat_columnwise`

/-- 人手 Step 3 の「`v_1, …, v_n` は `ℂ^n` の基底なので `P'P = PP' = I` を満たす `P'` が取れる」。
`P'` は基底 `v` による座標（`Basis.toMatrix`）で、二つの積が単位行列であることは mathlib の
`Basis.toMatrix_mul_toMatrix_flip`（人手はこの段を証明せずに使っている）。 -/
theorem exists_inverse_of_basis_columns {ι : Type*} [Fintype ι] [DecidableEq ι]
    (v : Module.Basis ι ℂ (n → ℂ)) :
    ∃ P' : Matrix ι n ℂ, P' * Matrix.of (fun j l => v l j) = 1 ∧ Matrix.of (fun j l => v l j) * P' = 1 := by
  have hP : Matrix.of (fun j l => v l j) = (Pi.basisFun ℂ n).toMatrix v := by
    ext j l; simp [Module.Basis.toMatrix_apply]
  refine ⟨v.toMatrix (Pi.basisFun ℂ n), ?_, ?_⟩
  · rw [hP, Module.Basis.toMatrix_mul_toMatrix_flip]
  · rw [hP, Module.Basis.toMatrix_mul_toMatrix_flip]

/-- **人手 `trace_basic_properties` (4)** を、行と列の添字の型が違う行列 `P : ι × n`、`P' : n × ι` へ当てる形:
`P'P = I` なら `tr(P(AP')) = tr(A)`。人手 Step 3 の `P`（行が `ℂ^n` の添字 `n`、列が基底の添字 `Fin (r + s)` の長方行列。`idempotentAdaptedBasis` の注を見よ）と `P'` へ、`P → P'`・`P' → P` と入れ替えて当てる。
手順は `trace_similarity_invariant` の 5 行と同じで、(2) の巡回性だけは `trace_cyclic` が正方行列に限るので
`Matrix.trace_mul_comm`（`trace_cyclic` の証明そのもの）を引く。 -/
theorem trace_similarity_invariant_of_columns {ι : Type*} [Fintype ι]
    (P : Matrix ι n ℂ) (P' : Matrix n ι ℂ) (A : Matrix n n ℂ) (h : P' * P = 1) :
    (P * (A * P')).trace = A.trace :=
  calc (P * (A * P')).trace
      = ((P * A) * P').trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = (P' * (P * A)).trace := Matrix.trace_mul_comm _ _  -- (2) を `A → PA`、`B → P'` に適用
    _ = ((P' * P) * A).trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = ((1 : Matrix n n ℂ) * A).trace := by rw [h]        -- `P'P = I`
    _ = A.trace := by rw [NecSuf.one_mul_matrix]           -- `identity_matrix_is_left_unit_of_mat_mult`

/-- **人手 `trace_of_idempotent`**: `Q^2 = Q` なら `tr(Q) = dim_ℂ (im Q)`（直和分解は `isCompl_range_ker_of_idempotent`）。
人手の `im Q = {Qx}` は `x ↦ Qx` の線型写像 `Matrix.toLin' Q` の像で、右辺の自然数は `ℂ` への像（`1_ℂ` をその個数だけ足した元）。
Step 3 の鎖を人手の 9 行と 1 対 1 の `calc` で書く（Step 2 は `idempotent_mul_columns_eq`、`P'` は `exists_inverse_of_basis_columns`）。
`Σ_{k=1}^{n} D_{kk}` を `Σ_{k=1}^{r}` と `Σ_{k=r+1}^{n}` に分ける段は `Fin.sum_univ_add`（人手の「`D` の定め方」の行に含まれる）。 -/
theorem trace_of_idempotent (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) :
    Q.trace = (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q)) : ℂ) := by
  set r := Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q))
  set s := Module.finrank ℂ (LinearMap.ker (Matrix.toLin' Q))
  set P : Matrix n (Fin (r + s)) ℂ := Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
  set D := idempotentDiag r s
  have hQP : Q * P = P * D := idempotent_mul_columns_eq Q hQ
  obtain ⟨P', hP'P, hPP'⟩ := exists_inverse_of_basis_columns (idempotentAdaptedBasis Q hQ)
  calc Q.trace
      = (P' * (Q * P)).trace := (trace_similarity_invariant_of_columns P' P Q hPP').symm
                                                            -- `trace_basic_properties` (4) を `P → P'`、`P' → P`、`A → Q` に。`PP' = I`
    _ = (P' * (P * D)).trace := by rw [hQP]                 -- Step 2 の `QP = PD`
    _ = ((P' * P) * D).trace := by rw [Matrix.mul_assoc]    -- `mat_mult_associative`
    _ = ((1 : Matrix (Fin (r + s)) (Fin (r + s)) ℂ) * D).trace := by rw [hP'P]   -- `P'P = I`
    _ = D.trace := by rw [NecSuf.one_mul_matrix]            -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = ∑ k, D k k := rfl                                   -- `def_trace`
    _ = ∑ _k : Fin r, (1 : ℂ) + ∑ _k : Fin s, (0 : ℂ) := by -- `D` の定め方
        rw [Fin.sum_univ_add]
        congr 1
        · exact Finset.sum_congr rfl fun k _ => if_pos ⟨rfl, k.isLt⟩
        · exact Finset.sum_congr rfl fun k _ => if_neg fun h => by simp at h
    _ = ∑ _k : Fin r, (1 : ℂ) := by rw [Finset.sum_const_zero, add_zero]   -- `0_ℂ` は加法の単位元
    _ = (r : ℂ) := by                                       -- `r` の定め方と、主張の右辺の読み方（`1_ℂ` を `r` 個足した元）
        rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_one]

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
