/-
# 冪等行列のトレースは像の次元（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/DefinitionTrace.lean` の
`trace_of_idempotent` とその準備・Step 1〜3 の補題（人手 `trace_of_idempotent`、`structured-latex/content/009_eigenvalues_of_V.ts`）。
具体版をこのファイルの特殊化として導くのは、同じフォルダの `ClaimTraceOfIdempotentFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備 `idempotent_sq_eq_mul_self`（4 段）・`idempotent_mul_self_of_sq` | 同名（同じ 4 段） |
| Step 1 の `idempotent_decomposition_apply`（7 段）・`idempotent_sub_mem_ker`（4 段）・`idempotent_range_inter_ker_eq_zero`（5 段）・`isCompl_range_ker_of_idempotent` | 同名（同じ段） |
| Step 2 の `idempotent_mulVec_of_eq_mulVec`（4 段）・`idempotentAdaptedBasis`・`idempotentDiag`・`idempotent_mul_columns_eq`（11 段） | 同名（同じ段） |
| Step 3 の `exists_inverse_of_basis_columns`・`trace_similarity_invariant_of_columns`（5 段）・`trace_of_idempotent`（9 段） | 同名（同じ段） |

段のコメントの根拠名（`complex_numbers_form_a_field` など）は具体版のものをそのまま残した。どの段がどの人手の行かを追うためである。

## 何が効いているか / 効いていないか

係数は可換環 `K` でよく、体である必要はない（具体版に無い段は `ker Q` の有限性を出す 2 つの補題だけ）。複素数であること（`i` の存在、代数的閉性、標数 `0`、絶対値やノルム）も、
零でない元の逆元も、どの段にも出ない。主張の右辺の自然数 `dim_K im Q` は `K` への像（`1_K` をその個数だけ足した元）である。

削れない仮定:
- **乗法の可換性**（`CommRing K`）: `Matrix.toLin'`（`x ↦ Qx` を `K` 上の線型写像にし、`im Q`・`ker Q` を `K` 加群の部分加群にする）と、
  Step 3 の 2 段目の巡回性 `tr(AB) = tr(BA)`（`Matrix.trace_mul_comm`。非可換な係数では `Σ A_{ij}B_{ji} = Σ B_{ji}A_{ij}` が崩れる）。
  `Submodule.prodEquivOfIsCompl` は環、`Basis.toMatrix_mul_toMatrix_flip` は可換半環までしか要らない。
- **`im Q` と `ker Q` が自由加群であること**（`Module.Free`）: Step 2 の「`im Q`・`ker Q` の基底を取る」（`Module.finBasis`）で使う。
  体ならインスタンスで出るので、具体版 `K := ℂ` はそのまま特殊化になる。体でない ℤ の上でも成り立つ（単項イデアル整域なので部分加群は自由）。
  `im Q` の自由性は主張が要る: `ℤ/6ℤ` の 1×1 行列 `Q = 3` は `3^2 = 3` で冪等だが、`tr(Q) = 3`、`im Q = 3ℤ/6ℤ` は自由でなく `finrank = 0` なので主張が崩れる。
  `ker Q` の自由性は主張には要らず、Step 2 の「`ker Q` の基底を取る」という手順が要るだけである（`Nontrivial K` と同じ扱い）。
- 有限性は仮定しない。`im Q` は有限な `n → K` の線型写像の像なので mathlib の `Module.Finite.range` で出る。`ker Q` は
  Step 1 の鎖から `ker Q = im(I − Q)`（`ker_toLin'_eq_range_one_sub`）なので同じく有限（`finite_ker_of_idempotent`）。
- `Nontrivial K`（`1 ≠ 0`）は主張には要らない（零環では `tr(Q) = 0 = finrank`）。`Module.finBasis` が基底の個数を `finrank` と結ぶのに
  `StrongRankCondition K` を要り、可換環ではそれが `Nontrivial K` から出る（`commRing_strongRankCondition`）ので置いた。

使っていない構造: 零でない元の逆元、順序、ノルム、極限、`K` の元の個数、`n` の添字の順序（添字の型は `Fintype` と `DecidableEq` だけ）。
`DecidableEq n` は単位行列 `I` と、`x ↦ Qx` の線型写像 `Matrix.toLin'`（`im Q`・`ker Q`）、`Pi.basisFun` を作るのに要る。
-/
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.Matrix.Basis
import Mathlib.LinearAlgebra.Projection
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.LinearAlgebra.FiniteDimensional.Defs
import Mathlib.LinearAlgebra.FreeModule.StrongRankCondition
import Ising2D.NecSuf.MatrixProductIdentityAndScalar
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference
import Ising2D.NecSuf.MatColumnwise

namespace Ising2D.NecSuf

open Matrix

section TraceIdempotent

variable {K : Type*} [CommRing K] {n : Type*} [Fintype n] [DecidableEq n]

theorem idempotent_sq_eq_mul_self (Q : Matrix n n K) : Q ^ 2 = Q * Q :=
  calc Q ^ 2
      = Q ^ 1 * Q := pow_succ Q 1                          -- `def_matrix_power` の `A^{m+1} := A^m A` を `m = 1` に
    _ = (Q ^ 0 * Q) * Q := by rw [pow_succ Q 0]            -- `def_matrix_power` の `A^{m+1} := A^m A` を `m = 0` に
    _ = (1 * Q) * Q := by rw [pow_zero]                    -- `def_matrix_power` の `A^0 := I`
    _ = Q * Q := by rw [Ising2D.NecSuf.one_mul_matrix]             -- `identity_matrix_is_left_unit_of_mat_mult`

theorem idempotent_mul_self_of_sq (Q : Matrix n n K) (hQ : Q ^ 2 = Q) : Q * Q = Q :=
  (idempotent_sq_eq_mul_self Q).symm.trans hQ

theorem idempotent_decomposition_apply (Q : Matrix n n K) (x : n → K) (k : n) :
    (Q *ᵥ x + (x - Q *ᵥ x)) k = x k :=
  calc (Q *ᵥ x + (x - Q *ᵥ x)) k
      = (Q *ᵥ x) k + (x - Q *ᵥ x) k := Pi.add_apply _ _ _            -- `def_matrix_sum`
    _ = (Q *ᵥ x) k + (x k - (Q *ᵥ x) k) := by rw [Pi.sub_apply]       -- `def_matrix_difference`
    _ = (Q *ᵥ x) k + (x k + -(Q *ᵥ x) k) := by rw [sub_eq_add_neg]    -- `def_complex_difference`（`z → x_k, w → (Qx)_k`）
    _ = (Q *ᵥ x) k + (-(Q *ᵥ x) k + x k) := by rw [add_comm (x k)]    -- `complex_numbers_form_a_field` の和の可換律
    _ = ((Q *ᵥ x) k + -(Q *ᵥ x) k) + x k := (add_assoc _ _ _).symm    -- `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
    _ = 0 + x k := by rw [add_neg_cancel]                              -- `complex_numbers_form_a_field` の加法の逆元
    _ = x k := zero_add _                                               -- `complex_zero_plus_is_original`（`z → x_k`）

theorem idempotent_decomposition (Q : Matrix n n K) (x : n → K) : x = Q *ᵥ x + (x - Q *ᵥ x) :=
  (funext (idempotent_decomposition_apply Q x)).symm

theorem idempotent_sub_mem_ker (Q : Matrix n n K) (hQQ : Q * Q = Q) (x : n → K) :
    Q *ᵥ (x - Q *ᵥ x) = 0 :=
  calc Q *ᵥ (x - Q *ᵥ x)
      = Q *ᵥ x - Q *ᵥ (Q *ᵥ x) := Matrix.mulVec_sub _ _ _               -- `mat_mult_vector_difference`
    _ = Q *ᵥ x - (Q * Q) *ᵥ x := by rw [Matrix.mulVec_mulVec]            -- `mat_mult_associative`
    _ = Q *ᵥ x - Q *ᵥ x := by rw [hQQ]                                   -- 準備の `QQ = Q`
    _ = 0 := (Ising2D.NecSuf.sub_eq_zero_iff_vec _ _).mpr rfl                    -- `matrix_difference_zero_iff_equal` の `⇐` を `A = B = Qx` に

theorem idempotent_range_inter_ker_eq_zero (Q : Matrix n n K) (hQQ : Q * Q = Q) (x y : n → K)
    (hx : Q *ᵥ x = y) (hy : Q *ᵥ y = 0) : y = 0 :=
  calc y
      = Q *ᵥ x := hx.symm                                   -- `x` の取り方
    _ = (Q * Q) *ᵥ x := by rw [hQQ]                         -- 準備の `QQ = Q`
    _ = Q *ᵥ (Q *ᵥ x) := (Matrix.mulVec_mulVec _ _ _).symm  -- `mat_mult_associative`
    _ = Q *ᵥ y := by rw [hx]                                -- `Qx = y`
    _ = 0 := hy                                             -- `y ∈ ker Q`

theorem isCompl_range_ker_of_idempotent (Q : Matrix n n K) (hQ : Q ^ 2 = Q) :
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

theorem idempotent_mulVec_of_eq_mulVec (Q : Matrix n n K) (hQQ : Q * Q = Q) (x v : n → K)
    (hv : v = Q *ᵥ x) : Q *ᵥ v = v :=
  calc Q *ᵥ v
      = Q *ᵥ (Q *ᵥ x) := by rw [hv]                         -- `v_j = Qx_j`
    _ = (Q * Q) *ᵥ x := Matrix.mulVec_mulVec _ _ _          -- `mat_mult_associative`
    _ = Q *ᵥ x := by rw [hQQ]                               -- 準備の `QQ = Q`
    _ = v := hv.symm                                        -- `v_j = Qx_j`

-- Step 2 の基底を取るのに要る `ker Q` の有限性（具体版には無い段。体の上ではインスタンスで出る）:
-- Step 1 の鎖から `ker Q = im(I − Q)` で、`im(I − Q)` は有限な `n → K` の線型写像の像なので有限。
theorem ker_toLin'_eq_range_one_sub (Q : Matrix n n K) (hQ : Q ^ 2 = Q) :
    LinearMap.ker (Matrix.toLin' Q) = LinearMap.range (Matrix.toLin' (1 - Q)) := by
  have hQQ := idempotent_mul_self_of_sq Q hQ
  ext x
  constructor
  · intro hx
    rw [LinearMap.mem_ker, Matrix.toLin'_apply] at hx
    exact ⟨x, by rw [Matrix.toLin'_apply, Matrix.sub_mulVec, Matrix.one_mulVec, hx, sub_zero]⟩
  · rintro ⟨y, rfl⟩
    rw [LinearMap.mem_ker, Matrix.toLin'_apply, Matrix.toLin'_apply, Matrix.sub_mulVec, Matrix.one_mulVec]
    exact idempotent_sub_mem_ker Q hQQ y

theorem finite_ker_of_idempotent (Q : Matrix n n K) (hQ : Q ^ 2 = Q) :
    Module.Finite K (LinearMap.ker (Matrix.toLin' Q)) :=
  Module.Finite.equiv (LinearEquiv.ofEq _ _ (ker_toLin'_eq_range_one_sub Q hQ).symm)

noncomputable def idempotentAdaptedBasis (Q : Matrix n n K) (hQ : Q ^ 2 = Q)
    [Nontrivial K]
    [Module.Free K (LinearMap.range (Matrix.toLin' Q))] [Module.Free K (LinearMap.ker (Matrix.toLin' Q))] :
    Module.Basis (Fin (Module.finrank K (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank K (LinearMap.ker (Matrix.toLin' Q)))) K (n → K) :=
  haveI := finite_ker_of_idempotent Q hQ
  (((Module.finBasis K (LinearMap.range (Matrix.toLin' Q))).prod
      (Module.finBasis K (LinearMap.ker (Matrix.toLin' Q)))).map
    (Submodule.prodEquivOfIsCompl _ _ (isCompl_range_ker_of_idempotent Q hQ))).reindex finSumFinEquiv

theorem idempotentAdaptedBasis_mem_range (Q : Matrix n n K) (hQ : Q ^ 2 = Q)
    [Nontrivial K]
    [Module.Free K (LinearMap.range (Matrix.toLin' Q))] [Module.Free K (LinearMap.ker (Matrix.toLin' Q))]
    (j : Fin (Module.finrank K (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank K (LinearMap.ker (Matrix.toLin' Q))))
    (hj : (j : ℕ) < Module.finrank K (LinearMap.range (Matrix.toLin' Q))) :
    idempotentAdaptedBasis Q hQ j ∈ LinearMap.range (Matrix.toLin' Q) := by
  obtain ⟨i, rfl⟩ : ∃ i, Fin.castAdd _ i = j := ⟨⟨j, hj⟩, rfl⟩
  simp [idempotentAdaptedBasis]

theorem idempotentAdaptedBasis_mem_ker (Q : Matrix n n K) (hQ : Q ^ 2 = Q)
    [Nontrivial K]
    [Module.Free K (LinearMap.range (Matrix.toLin' Q))] [Module.Free K (LinearMap.ker (Matrix.toLin' Q))]
    (j : Fin (Module.finrank K (LinearMap.range (Matrix.toLin' Q))
      + Module.finrank K (LinearMap.ker (Matrix.toLin' Q))))
    (hj : ¬ (j : ℕ) < Module.finrank K (LinearMap.range (Matrix.toLin' Q))) :
    idempotentAdaptedBasis Q hQ j ∈ LinearMap.ker (Matrix.toLin' Q) := by
  obtain ⟨i, rfl⟩ : ∃ i, Fin.natAdd _ i = j :=
    ⟨⟨j - Module.finrank K (LinearMap.range (Matrix.toLin' Q)), by omega⟩, Fin.ext (by simp; omega)⟩
  simp [idempotentAdaptedBasis]

def idempotentDiag (r s : ℕ) : Matrix (Fin (r + s)) (Fin (r + s)) K :=
  fun k l => if k = l ∧ (k : ℕ) < r then 1 else 0

theorem idempotent_mul_columns_eq (Q : Matrix n n K) (hQ : Q ^ 2 = Q)
    [Nontrivial K]
    [Module.Free K (LinearMap.range (Matrix.toLin' Q))] [Module.Free K (LinearMap.ker (Matrix.toLin' Q))] :
    Q * Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
      = Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
        * idempotentDiag (Module.finrank K (LinearMap.range (Matrix.toLin' Q)))
            (Module.finrank K (LinearMap.ker (Matrix.toLin' Q))) := by
  set r := Module.finrank K (LinearMap.range (Matrix.toLin' Q))
  set s := Module.finrank K (LinearMap.ker (Matrix.toLin' Q))
  set v := idempotentAdaptedBasis Q hQ
  set P : Matrix n (Fin (r + s)) K := Matrix.of (fun j l => v l j)
  set D := idempotentDiag (K := K) r s
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
        rw [show D k l = 0 from if_neg fun h => (Finset.ne_of_mem_erase hk) h.1]  -- `k ≠ l` では `D_{kl} = 0_K`
    _ = P i l * D l l + ∑ _k ∈ Finset.univ.erase l, (0 : K) := by
        simp only [mul_zero]                                                     -- `complex_times_zero_is_zero`
    _ = P i l * D l l := by rw [Finset.sum_const_zero, add_zero]               -- `0_K` は加法の単位元
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
    _ = (Q * P) i l := by rw [Ising2D.NecSuf.mul_cols_eq_cols_mulVec]                    -- `mat_columnwise`

theorem exists_inverse_of_basis_columns {ι : Type*} [Fintype ι] [DecidableEq ι]
    (v : Module.Basis ι K (n → K)) :
    ∃ P' : Matrix ι n K, P' * Matrix.of (fun j l => v l j) = 1 ∧ Matrix.of (fun j l => v l j) * P' = 1 := by
  have hP : Matrix.of (fun j l => v l j) = (Pi.basisFun K n).toMatrix v := by
    ext j l; simp [Module.Basis.toMatrix_apply]
  refine ⟨v.toMatrix (Pi.basisFun K n), ?_, ?_⟩
  · rw [hP, Module.Basis.toMatrix_mul_toMatrix_flip]
  · rw [hP, Module.Basis.toMatrix_mul_toMatrix_flip]

theorem trace_similarity_invariant_of_columns {ι : Type*} [Fintype ι]
    (P : Matrix ι n K) (P' : Matrix n ι K) (A : Matrix n n K) (h : P' * P = 1) :
    (P * (A * P')).trace = A.trace :=
  calc (P * (A * P')).trace
      = ((P * A) * P').trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = (P' * (P * A)).trace := Matrix.trace_mul_comm _ _  -- (2) を `A → PA`、`B → P'` に適用
    _ = ((P' * P) * A).trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = ((1 : Matrix n n K) * A).trace := by rw [h]        -- `P'P = I`
    _ = A.trace := by rw [Ising2D.NecSuf.one_mul_matrix]           -- `identity_matrix_is_left_unit_of_mat_mult`

theorem trace_of_idempotent (Q : Matrix n n K) (hQ : Q ^ 2 = Q)
    [Nontrivial K]
    [Module.Free K (LinearMap.range (Matrix.toLin' Q))] [Module.Free K (LinearMap.ker (Matrix.toLin' Q))] :
    Q.trace = (Module.finrank K (LinearMap.range (Matrix.toLin' Q)) : K) := by
  set r := Module.finrank K (LinearMap.range (Matrix.toLin' Q))
  set s := Module.finrank K (LinearMap.ker (Matrix.toLin' Q))
  set P : Matrix n (Fin (r + s)) K := Matrix.of (fun j l => idempotentAdaptedBasis Q hQ l j)
  set D := idempotentDiag (K := K) r s
  have hQP : Q * P = P * D := idempotent_mul_columns_eq Q hQ
  obtain ⟨P', hP'P, hPP'⟩ := exists_inverse_of_basis_columns (idempotentAdaptedBasis Q hQ)
  calc Q.trace
      = (P' * (Q * P)).trace := (trace_similarity_invariant_of_columns P' P Q hPP').symm
                                                            -- `trace_basic_properties` (4) を `P → P'`、`P' → P`、`A → Q` に。`PP' = I`
    _ = (P' * (P * D)).trace := by rw [hQP]                 -- Step 2 の `QP = PD`
    _ = ((P' * P) * D).trace := by rw [Matrix.mul_assoc]    -- `mat_mult_associative`
    _ = ((1 : Matrix (Fin (r + s)) (Fin (r + s)) K) * D).trace := by rw [hP'P]   -- `P'P = I`
    _ = D.trace := by rw [Ising2D.NecSuf.one_mul_matrix]            -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = ∑ k, D k k := rfl                                   -- `def_trace`
    _ = ∑ _k : Fin r, (1 : K) + ∑ _k : Fin s, (0 : K) := by -- `D` の定め方
        rw [Fin.sum_univ_add]
        congr 1
        · exact Finset.sum_congr rfl fun k _ => if_pos ⟨rfl, k.isLt⟩
        · exact Finset.sum_congr rfl fun k _ => if_neg fun h => by simp at h
    _ = ∑ _k : Fin r, (1 : K) := by rw [Finset.sum_const_zero, add_zero]   -- `0_K` は加法の単位元
    _ = (r : K) := by                                       -- `r` の定め方と、主張の右辺の読み方（`1_K` を `r` 個足した元）
        rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_one]

end TraceIdempotent

end Ising2D.NecSuf
