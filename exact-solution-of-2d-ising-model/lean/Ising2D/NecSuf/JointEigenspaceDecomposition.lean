/-
# 直交冪等族による内部直和分解と対角化可能性（**必要十分版**）

対応する人手証明のラベル:
- `joint_eigenspace_decomposition` (5)（`structured-latex/content/009_eigenvalues_of_V.ts`、
  `eigenvalues_of_V_008_claim_joint_eigenspace_decomposition`）
- `check_joint_eigenspace_decomposition` (5)（`structured-latex/content/017_even_sector_eigenvalues.ts`、
  `evenEigen_005_claim_check_joint_eigenspace_decomposition`）
- `eigenvalues_of_Vprime` / `eigenvalues_of_V` の「`V'`（`V`）は対角化可能」
  （`eigenvalues_of_V_009_claim_eigenvalues_of_Vprime`,
  `eigenvalues_of_V_011_claim_eigenvalues_of_V`）
- `eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus` の「対角化可能」
  （`evenEigen_006_claim_eigenvalues_of_check_Vprime`,
  `evenEigen_008_claim_eigenvalues_of_V_plus`）

具体版:
- 章 009: `Ising2D/Part009/Claim008_JointEigenspace.lean`,
  `Ising2D/Part009/Claim009_EigenvaluesVprime.lean`
- 章 017: `Ising2D/Part017/Claim005_CheckJointEigenspace.lean`,
  `Ising2D/Part017/Claim006_EigenvaluesCheckVprime.lean`

**章 009 と章 017 は同じ構造なので、本ファイルの必要十分版 1 本を両章の特殊化として使う。**

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明 (5) は `ℂ^{2^M} = ⊕_ε im Q_ε` を「任意の `x` が `x = ∑_ε Q_ε x` と書ける」と
「`∑_ε y_ε = 0` かつ `y_ε ∈ im Q_ε` なら各 `y_ε = 0`」の 2 つで示している。
この 2 つに効いているのは

1. **台が環上の加群であること**（線型構造だけ。行列であることも有限次元性も不要）、
2. **射影の族 `p : ι → End R V` が有限個で、直交（`i ≠ j ⇒ p_i p_j = 0`）かつ
   総和が恒等（`∑_i p_i = 1`）であること**

の 2 つだけである。**冪等性 `p_i^2 = p_i`（人手証明 (1) 後半）は仮定に要らず、
直交性と総和条件から従う**（`idem_of_ortho_of_sum_eq_one`）。
個数演算子であることも CAR も、複素数であることも効いていない。

対角化可能性（固有ベクトルからなる基底の存在）に追加で効いているのは、

3. **係数が体であること**（各 `im p_i` に基底が取れるため）、
4. **`f p_i = c_i p_i`**（人手証明 Step 1・Step 3 の形）

だけである。`f` が指数関数であることも、`c_i` が正の実数であることも効いていない。
-/
import Mathlib.Algebra.DirectSum.Module
import Mathlib.LinearAlgebra.Basis.VectorSpace
import Mathlib.LinearAlgebra.Matrix.Basis
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Dimension.Finite
import Mathlib.FieldTheory.Finiteness

namespace Ising2D.NecSuf

open Matrix
open Module (End Basis)

/-! ## 直交冪等族から内部直和分解へ（人手証明 (5)） -/

section IsInternal

variable {R : Type*} [Ring R] {V : Type*} [AddCommGroup V] [Module R V]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 人手証明 (2) `∑_ε Q_ε = I` を「任意の `x` が `x = ∑_ε Q_ε x` と書ける」形にしたもの
（人手証明 (5) 前半にあたる）。 -/
theorem sum_proj_apply {p : ι → End R V} (hsum : ∑ i, p i = 1) (x : V) :
    ∑ i, p i x = x := by
  rw [← LinearMap.sum_apply, hsum, Module.End.one_apply]

/-- **人手証明 (1) 後半は仮定に要らない**: 直交性 (1) 前半と総和条件 (2) から冪等性が従う。

必要十分版を書いてはじめて分かること: 原文が (1) で 2 つに分けて主張している性質のうち、
冪等性は独立な仮定ではない。 -/
theorem idem_of_ortho_of_sum_eq_one {p : ι → End R V}
    (hortho : ∀ i j, i ≠ j → p i * p j = 0) (hsum : ∑ i, p i = 1) (i : ι) :
    p i * p i = p i := by
  have h : p i * ∑ j, p j = p i := by rw [hsum, mul_one]
  rw [Finset.mul_sum] at h
  rw [Finset.sum_eq_single i (fun j _ hj => hortho i j (Ne.symm hj)) (by simp)] at h
  exact h

/-- `i ≠ j` なら `im p_j ⊆ ker p_i`。人手証明 (1) 前半 `Q_ε Q_{ε'} = 0` の言い換え。 -/
theorem range_le_ker_of_ne {p : ι → End R V} (hortho : ∀ i j, i ≠ j → p i * p j = 0)
    {i j : ι} (hij : i ≠ j) : LinearMap.range (p j) ≤ LinearMap.ker (p i) := by
  rintro x ⟨y, rfl⟩
  have h : (p i * p j) y = (0 : End R V) y := by rw [hortho i j hij]
  simpa [Module.End.mul_apply] using h

/-- 人手証明 (5) 後半（直和性）: `im p_i` たちは独立。

人手証明の「`∑ y_ε = 0` かつ `y_ε ∈ im Q_ε` なら各 `y_ε = 0`」を、mathlib の
`iSupIndep`（`im p_i` と他の `im p_j` たちの張る空間が交わらない）の形で述べたもの。 -/
theorem iSupIndep_range_proj {p : ι → End R V}
    (hortho : ∀ i j, i ≠ j → p i * p j = 0) (hsum : ∑ i, p i = 1) :
    iSupIndep fun i => LinearMap.range (p i) := by
  intro i
  rw [Submodule.disjoint_def]
  rintro x ⟨y, rfl⟩ hmem
  have hker : (⨆ (j) (_ : j ≠ i), LinearMap.range (p j)) ≤ LinearMap.ker (p i) :=
    iSup_le fun j => iSup_le fun hj => range_le_ker_of_ne hortho (Ne.symm hj)
  have h0 : p i (p i y) = 0 := hker hmem
  rwa [← Module.End.mul_apply, idem_of_ortho_of_sum_eq_one hortho hsum i] at h0

/-- 人手証明 (5) 前半（張ること）: `im p_i` たちは全体を張る。 -/
theorem iSup_range_proj_eq_top {p : ι → End R V} (hsum : ∑ i, p i = 1) :
    (⨆ i, LinearMap.range (p i)) = ⊤ := by
  refine top_unique fun x _ => ?_
  rw [← sum_proj_apply hsum x]
  exact Submodule.sum_mem _ fun i _ =>
    Submodule.mem_iSup_of_mem i (LinearMap.mem_range_self _ x)

/-- **人手証明 `joint_eigenspace_decomposition` (5) の `DirectSum.IsInternal` 形（必要十分版）**:
直交する射影の族の像は内部直和分解を与える。 -/
theorem isInternal_range_proj {p : ι → End R V}
    (hortho : ∀ i j, i ≠ j → p i * p j = 0) (hsum : ∑ i, p i = 1) :
    DirectSum.IsInternal fun i => LinearMap.range (p i) :=
  DirectSum.isInternal_submodule_of_iSupIndep_of_iSup_eq_top
    (iSupIndep_range_proj hortho hsum) (iSup_range_proj_eq_top hsum)

end IsInternal

/-! ## 固有ベクトルからなる基底と対角化（人手証明 `eigenvalues_of_Vprime` Step 4） -/

section Diagonalize

variable {K : Type*} [Field K] {V : Type*} [AddCommGroup V] [Module K V]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 人手証明 Step 4: `f p_i = c_i p_i` なら `im p_i` の元はすべて固有値 `c_i` の固有ベクトル。 -/
theorem eigen_of_mem_range_proj {p : ι → End K V} {f : End K V} {c : ι → K}
    (hf : ∀ i, f * p i = c i • p i) {i : ι} {x : V} (hx : x ∈ LinearMap.range (p i)) :
    f x = c i • x := by
  obtain ⟨y, rfl⟩ := hx
  have h : (f * p i) y = (c i • p i) y := by rw [hf i]
  simpa [Module.End.mul_apply] using h

/-- **固有ベクトルからなる基底**: 各 `im p_i` の基底を集めたものは `V` の基底であり、
その各元は `f` の固有ベクトルである（固有値は属する `im p_i` の添字だけで決まる）。 -/
theorem collectedBasis_eigen {p : ι → End K V} {f : End K V} {c : ι → K}
    (hf : ∀ i, f * p i = c i • p i)
    (h : DirectSum.IsInternal fun i => LinearMap.range (p i))
    {α : ι → Type*} (v : ∀ i, Basis (α i) K (LinearMap.range (p i))) (a : Σ i, α i) :
    f (h.collectedBasis v a) = c a.1 • h.collectedBasis v a :=
  eigen_of_mem_range_proj hf (h.collectedBasis_mem v a)

/-- **対角化**: 上の基底に関する `f` の表現行列は対角行列 `diag(c_{a.1})` である。 -/
theorem toMatrix_collectedBasis_eq_diagonal {p : ι → End K V} {f : End K V} {c : ι → K}
    (hf : ∀ i, f * p i = c i • p i)
    (h : DirectSum.IsInternal fun i => LinearMap.range (p i))
    {α : ι → Type*} (v : ∀ i, Basis (α i) K (LinearMap.range (p i)))
    [Fintype (Σ i, α i)] [DecidableEq (Σ i, α i)] :
    LinearMap.toMatrix (h.collectedBasis v) (h.collectedBasis v) f
      = Matrix.diagonal fun a : Σ i, α i => c a.1 := by
  ext a b
  rw [LinearMap.toMatrix_apply, collectedBasis_eigen hf h v b, map_smul,
    Matrix.diagonal_apply, Basis.repr_self]
  by_cases hab : a = b
  · subst hab; simp
  · simp [hab]

end Diagonalize

/-! ## 行列版（具体版への橋渡し） -/

section MatrixVersion

variable {K : Type*} [Field K] {n : Type*} [Fintype n] [DecidableEq n]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **行列の直交冪等族の像による内部直和分解**（人手証明 (5) の行列版）。

行列 `Q_i` を線型写像 `x ↦ Q_i x` と見て `isInternal_range_proj` を特殊化したもの。 -/
theorem isInternal_range_matrix_proj {Q : ι → Matrix n n K}
    (hortho : ∀ i j, i ≠ j → Q i * Q j = 0) (hsum : ∑ i, Q i = 1) :
    DirectSum.IsInternal fun i => LinearMap.range (Matrix.toLinAlgEquiv' (Q i)) := by
  refine isInternal_range_proj (p := fun i => Matrix.toLinAlgEquiv' (Q i)) ?_ ?_
  · intro i j hij
    rw [← map_mul, hortho i j hij, map_zero]
  · rw [← map_sum, hsum, map_one]

/-- **行列の対角化可能性**（人手証明 `eigenvalues_of_Vprime` Step 4 の結論の行列版）。

`A Q_i = c_i Q_i` を満たす直交冪等族 `Q_i` があれば、`A` の固有ベクトルからなる基底が取れ、
その基底に関する表現行列は対角行列になる。 -/
theorem exists_eigenBasis_of_matrix_proj {A : Matrix n n K} {Q : ι → Matrix n n K} {c : ι → K}
    (hortho : ∀ i j, i ≠ j → Q i * Q j = 0) (hsum : ∑ i, Q i = 1)
    (hA : ∀ i, A * Q i = c i • Q i) :
    ∃ (b : Basis n K (n → K)) (lam : n → K),
      (∀ a, ∃ i, lam a = c i) ∧
      (∀ a, A *ᵥ b a = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' A) = Matrix.diagonal lam := by
  classical
  have h : DirectSum.IsInternal
      fun i => LinearMap.range (Matrix.toLinAlgEquiv' (Q i) : End K (n → K)) :=
    isInternal_range_matrix_proj hortho hsum
  have hf : ∀ i, (Matrix.toLinAlgEquiv' A : End K (n → K)) * Matrix.toLinAlgEquiv' (Q i)
      = c i • Matrix.toLinAlgEquiv' (Q i) := by
    intro i
    rw [← map_mul, hA i, map_smul]
  -- 各成分の基底として `Basis.ofVectorSpace` を取る
  let v : ∀ i, Basis
      (Basis.ofVectorSpaceIndex K (LinearMap.range (Matrix.toLinAlgEquiv' (Q i) : End K (n → K))))
      K (LinearMap.range (Matrix.toLinAlgEquiv' (Q i) : End K (n → K))) :=
    fun i => Basis.ofVectorSpace K _
  haveI : ∀ i, Fintype
      (Basis.ofVectorSpaceIndex K
        (LinearMap.range (Matrix.toLinAlgEquiv' (Q i) : End K (n → K)))) :=
    fun i => FiniteDimensional.fintypeBasisIndex (v i)
  -- 集めた基底を、添字を `n` へ付け替えて使う（次元は等しいので添字の同型が取れる）
  let e := (h.collectedBasis v).indexEquiv (Pi.basisFun K n)
  refine ⟨(h.collectedBasis v).reindex e, fun a => c (e.symm a).1,
    fun a => ⟨(e.symm a).1, rfl⟩, fun a => ?_, ?_⟩
  · have := collectedBasis_eigen hf h v (e.symm a)
    simpa [Basis.reindex_apply, Matrix.toLinAlgEquiv'_apply] using this
  · ext a b
    rw [LinearMap.toMatrix_apply, Basis.reindex_apply,
      collectedBasis_eigen hf h v (e.symm b), map_smul, Finsupp.smul_apply,
      Basis.repr_reindex_apply, Basis.repr_self, Matrix.diagonal_apply]
    by_cases hab : a = b
    · subst hab; simp
    · have hne : e.symm b ≠ e.symm a := fun hc => hab (e.symm.injective hc).symm
      simp [hab, Finsupp.single_apply, hne]

/-- **相似変換による対角化**（`exists_eigenBasis_of_matrix_proj` の行列だけで述べた形）:
`P⁻¹ A P` が対角行列になる可逆行列 `P` が存在する。 -/
theorem exists_conj_diagonal_of_matrix_proj {A : Matrix n n K} {Q : ι → Matrix n n K} {c : ι → K}
    (hortho : ∀ i j, i ≠ j → Q i * Q j = 0) (hsum : ∑ i, Q i = 1)
    (hA : ∀ i, A * Q i = c i • Q i) :
    ∃ (P P' : Matrix n n K) (lam : n → K),
      P * P' = 1 ∧ P' * P = 1 ∧ P' * A * P = Matrix.diagonal lam := by
  classical
  obtain ⟨b, lam, _, _, hdiag⟩ := exists_eigenBasis_of_matrix_proj hortho hsum hA
  refine ⟨(Pi.basisFun K n).toMatrix b, b.toMatrix (Pi.basisFun K n), lam,
    Basis.toMatrix_mul_toMatrix_flip _ _, Basis.toMatrix_mul_toMatrix_flip _ _, ?_⟩
  have hAe : LinearMap.toMatrix (Pi.basisFun K n) (Pi.basisFun K n)
      (Matrix.toLinAlgEquiv' A) = A := by
    ext i j
    simp [Matrix.toLinAlgEquiv'_apply, Matrix.mulVec_single]
  calc b.toMatrix (Pi.basisFun K n) * A * (Pi.basisFun K n).toMatrix b
      = b.toMatrix (Pi.basisFun K n)
          * LinearMap.toMatrix (Pi.basisFun K n) (Pi.basisFun K n) (Matrix.toLinAlgEquiv' A)
          * (Pi.basisFun K n).toMatrix b := by rw [hAe]
    _ = LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' A) :=
        _root_.basis_toMatrix_mul_linearMap_toMatrix_mul_basis_toMatrix
          (b := b) (b' := Pi.basisFun K n) (c := b) (c' := Pi.basisFun K n) _
    _ = Matrix.diagonal lam := hdiag

end MatrixVersion

end Ising2D.NecSuf
