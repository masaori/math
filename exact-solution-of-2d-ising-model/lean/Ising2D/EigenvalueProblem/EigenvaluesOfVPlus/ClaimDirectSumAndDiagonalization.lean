/-
# 同時固有空間分解の直和形と `V̌'`・`V^{(+)}` の対角化可能性（具体版）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
- `check_joint_eigenspace_decomposition` (5)（`evenEigen_005_claim_...`）
- `eigenvalues_of_check_Vprime`（`evenEigen_006_claim_...`）の「`V̌'` は対角化可能」
- `eigenvalues_of_V_plus`（`evenEigen_010_theorem_...`）の「`V^{(+)}` は対角化可能」

**必要十分版**は `Ising2D/NecSuf/JointEigenspaceDecomposition.lean`。
章 009（`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimDirectSumAndDiagonalizationOfV.lean`）と
**まったく同じ必要十分版の特殊化**であり、違いは同時固有空間の次元
（章 009 の `2^{M-m}` が `m = M` により `1` になる）だけである。

半整数運動量では `tr(Q̌_ε) = 1` なので、直和成分はすべて 1 次元であり、
固有ベクトルからなる基底は「各 `ε` にちょうど 1 本」という形になる
（`ClaimCheckJointEigenspace.lean` の `trace_Qproj` 参照）。

人手 `eigenvalues_of_V_plus` (1) の対角化可能性の段落と 1 対 1 の具体版は `exists_eigenBasis_VPlus_of_joint_eigenspaces`、
固有値がどれもある `(Λ̌_ε)_ℂ` に等しいことの鎖の具体版は `checkBigLambda_smul_Qproj_mulVec_of_eigenvalue`・
`Qproj_mulVec_eq_zero_of_ne_eigenvalue`・`exists_checkBigLambda_eq_of_eigenvalue` である。
(2) の「固有値はどれも正の実数 `Λ̌_ε` を `ℂ` へ移した元」は、それと `checkBigLambda_pos`（`TheoremEigenvaluesVPlus.lean`）を合わせた `eigenvalue_VPlus_eq_positive_real` である。
基底の構成の必要十分版は既存の `NecSuf.exists_eigenBasis_of_matrix_proj`（同じ `collectedBasis` の手順で、各成分が 1 次元であることは使わない。
その特殊化が `exists_eigenBasis_VPlus`）。固有値の鎖の必要十分版は置いていない。鎖は `NecSuf.eq_proj_of_eigen` の中の `hchain` と同じ行で、
`λ` を一般にした形と背理法の段を `NecSuf` に足すかは状態台帳に残した。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremEigenvaluesVPlus
import Ising2D.NecSuf.JointEigenspaceDecomposition
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.TheoremMaxEigenvalueSimple

namespace Ising2D

open Matrix
open Module (Basis)

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-! ## 原文 (5) の `DirectSum.IsInternal` 形 -/

/-- **原文 `check_joint_eigenspace_decomposition` (5)**:
`ℂ^{2^M} = ⊕_ε im Q̌_ε`（`Submodule` の族としての内部直和）。 -/
theorem isInternal_range_Qproj :
    DirectSum.IsInternal fun T : Finset (CheckIdx M) =>
      LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  NecSuf.isInternal_range_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj

/-- 原文 (5) 前半（`im Q̌_ε` たちが全体を張る）を `Submodule` の言葉で述べた版。 -/
theorem iSup_range_Qproj_eq_top :
    (⨆ T : Finset (CheckIdx M), LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T))) = ⊤ :=
  NecSuf.iSup_range_proj_eq_top
    (p := fun T : Finset (CheckIdx M) => Matrix.toLinAlgEquiv' (F.Qproj T))
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-- 原文 (5) 後半（直和性）を `Submodule` の言葉で述べた版。 -/
theorem iSupIndep_range_Qproj :
    iSupIndep fun T : Finset (CheckIdx M) =>
      LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  NecSuf.iSupIndep_range_proj
    (p := fun T : Finset (CheckIdx M) => Matrix.toLinAlgEquiv' (F.Qproj T))
    (fun _ _ h => by rw [← map_mul, F.Qproj_mul_Qproj_of_ne h, map_zero])
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-! ## `V̌'` の対角化可能性（原文 `eigenvalues_of_check_Vprime`） -/

/-- **原文 `eigenvalues_of_check_Vprime` の「`V̌'` は対角化可能」**:
`V̌'` の固有ベクトルからなる `ℂ^{2^M}` の基底が存在し、表現行列は対角行列である。 -/
theorem exists_eigenBasis_Vprime (g : CheckIdx M → ℝ) :
    ∃ (b : Basis (Conf M) ℂ (Conf M → ℂ)) (lam : Conf M → ℂ),
      (∀ a, ∃ T : Finset (CheckIdx M), lam a = ((Real.exp (F.gval g T) : ℝ) : ℂ)) ∧
      (∀ a, (F.Vprime g).mulVec (b a) = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' (F.Vprime g)) = Matrix.diagonal lam :=
  NecSuf.exists_eigenBasis_of_matrix_proj
    (A := F.Vprime g) (Q := F.Qproj) (c := fun T => ((Real.exp (F.gval g T) : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

/-- **原文 `eigenvalues_of_check_Vprime` の「相似変換で対角化できる」形**。 -/
theorem exists_conj_diagonal_Vprime (g : CheckIdx M → ℝ) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧ P' * F.Vprime g * P = Matrix.diagonal lam :=
  NecSuf.exists_conj_diagonal_of_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

end CheckFermiSetup

/-! ## `V^{(+)}` の対角化可能性（原文 `eigenvalues_of_V_plus`） -/

section EigenVPlus

variable {M : ℕ}

/-- **原文 `eigenvalues_of_V_plus` (1) の対角化可能性の段落（具体版）**: 人手の主張文のとおり、各 `ε` について
`im Q̌_ε` の 0 でない元 `v ε` を**どう取っても**、`v` は `V^{(+)}` の固有ベクトルからなる `ℂ^{2^{M_col}}` の基底であり
（`b ε = v ε` を満たす `Basis` がある）、`v ε` は `(Λ̌_ε)_ℂ` に属する。
人手の段落と 1 対 1 に、`check_joint_eigenspace_decomposition` (5) の直和 `isInternal_range_Qproj` の各成分 `im Q̌_ε` に、
(4) の `dim im Q̌_ε = 1`（`finrank_range_Qproj`）から `v ε` 1 本の基底（mathlib の `FiniteDimensional.basisSingleton`。1 次元の空間では
0 でない元 1 本が基底）を取り、それらを合わせた基底（`DirectSum.IsInternal.collectedBasis`。添字は `Σ ε, Unit` で、
`Equiv.sigmaPUnit` で `ε` の集合へ付け替える）を作る。固有ベクトルであることは段落の後の鎖 `VPlus_mulVec_of_mem_range`。
添字が `ε` の集合 `Finset (CheckIdx M)`（`{0,1}^𝓜̌` を `ε_μ = 1` の `μ` の集合で表した Lean の型）そのものなので、
「各 `ε` が 1 本ずつ」はこの添字の付け方で、「`2^{M_col}` 本」は `card_eps_index` である。
人手の段落は直和と基底の言葉を本文で定めずに使っており、Lean はそれを mathlib の `DirectSum.IsInternal`・`Basis` で読む。 -/
theorem exists_eigenBasis_VPlus_of_joint_eigenspaces {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g)
    (v : Finset (CheckIdx (r + 1)) → Conf (r + 1) → ℂ)
    (hvmem : ∀ T, v T ∈ LinearMap.range (Matrix.toLin' (F.Qproj T))) (hv0 : ∀ T, v T ≠ 0) :
    (∃ b : Basis (Finset (CheckIdx (r + 1))) ℂ (Conf (r + 1) → ℂ), ∀ T, b T = v T) ∧
      ∀ T, (VPlus (r + 1) s2 K1 K2star).mulVec (v T) = ((checkBigLambda F g s2 T : ℝ) : ℂ) • v T := by
  -- (4) の `dim_ℂ im Q̌_ε = 1`（`finrank_range_Qproj` は `ℂ` の元としての等式なので、自然数へ戻す）
  have hfin : ∀ T : Finset (CheckIdx (r + 1)),
      Module.finrank ℂ (LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T))) = 1 := fun T => by
    have h := F.finrank_range_Qproj T
    exact_mod_cast h
  -- 各 `im Q̌_ε` の、`v ε` 1 本の基底（1 次元なので 1 本）
  let w : ∀ T : Finset (CheckIdx (r + 1)), LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
    fun T => ⟨v T, hvmem T⟩
  have hw0 : ∀ T, w T ≠ 0 := fun T h => hv0 T (congrArg Subtype.val h)
  let bT : ∀ T : Finset (CheckIdx (r + 1)),
      Basis Unit ℂ (LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T))) :=
    fun T => FiniteDimensional.basisSingleton Unit (hfin T) (w T) (hw0 T)
  refine ⟨?_, fun T => ?_⟩
  · -- (5) の直和から、それらを合わせた `ℂ^{2^{M_col}}` の基底
    refine ⟨(F.isInternal_range_Qproj.collectedBasis bT).reindex (Equiv.sigmaPUnit _), fun T => ?_⟩
    simp [Basis.reindex_apply, Equiv.sigmaPUnit, DirectSum.IsInternal.collectedBasis_coe, bT, w]
  · -- 段落の後の鎖: `y = Q̌_ε x` と書いて `VPlus_mulVec_of_mem_range`
    obtain ⟨x, hx⟩ := hvmem T
    rw [← hx, Matrix.toLin'_apply]
    exact VPlus_mulVec_of_mem_range F g hK1 hK2 hs2 hVeq T x

/-- **原文 `eigenvalues_of_V_plus` (1) の「固有値はどれもある `(Λ̌_ε)_ℂ` に等しい」の最初の鎖**:
`V^{(+)}x = λx` なら `(Λ̌_ε)_ℂ(Q̌_εx) = λ(Q̌_εx)`。人手の 5 行と 1 対 1 の calc
（`max_eigenvalue_of_V_plus_simple` (3) の `checkBigLambda_smul_Qproj_mulVec_of_eigen` の `Λ̌_max` を一般の `λ ∈ ℂ` にしたもの）。
Lean の数ベクトルは 1 列の行列ではなく `Conf M → ℂ` なので、`q → 1`・`p → 1` で引く人手の主張は
mathlib の `Matrix.smul_mulVec`・`Matrix.mulVec_mulVec`・`Matrix.mulVec_smul` で書く。 -/
theorem checkBigLambda_smul_Qproj_mulVec_of_eigenvalue (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {lam : ℂ} {x : Conf M → ℂ} (hx : (VPlus M s2 K1 K2star).mulVec x = lam • x)
    (T : Finset (CheckIdx M)) :
    ((checkBigLambda F g s2 T : ℝ) : ℂ) • (F.Qproj T).mulVec x = lam • (F.Qproj T).mulVec x :=
  calc ((checkBigLambda F g s2 T : ℝ) : ℂ) • (F.Qproj T).mulVec x
      = (((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T).mulVec x :=
        (Matrix.smul_mulVec _ _ _).symm
                                                        -- `scalar_multiple_factors_out_of_left_factor`（`p → 1`）を右辺から左辺へ
    _ = (F.Qproj T * VPlus M s2 K1 K2star).mulVec x := by
        rw [Qproj_mul_VPlus F g hK1 hK2 hs2 hVeq T]
                                                        -- (1) の第二の鎖を右辺から左辺へ
    _ = (F.Qproj T).mulVec ((VPlus M s2 K1 K2star).mulVec x) :=
        (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`（`q → 1`）
    _ = (F.Qproj T).mulVec (lam • x) := by rw [hx]     -- `V^{(+)}x = λx`
    _ = lam • (F.Qproj T).mulVec x := Matrix.mulVec_smul _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor`（`p → 1`）

/-- **原文 `eigenvalues_of_V_plus` (1) の `d_ε(Q̌_εx) = O` の 4 行と `Q̌_εx = O` の 5 行**:
`(Λ̌_ε)_ℂ ≠ λ` なら `Q̌_εx = O`。`d_ε := (Λ̌_ε)_ℂ − λ ≠ 0` は人手と同じく加法の群構造（`sub_eq_zero`）から出す。
`max_eigenvalue_of_V_plus_simple` (3) の `Qproj_mulVec_eq_zero_of_eigen` と同じ行で、`d ≠ 0` の出どころだけが違う
（あちらは (2) の狭義の不等号、ここは仮定 `(Λ̌_ε)_ℂ ≠ λ`）。
`difference_of_scalar_multiples_of_one_matrix`・`scalar_multiple_by_one`・`scalar_multiple_is_associative`・
`scalar_multiple_of_zero_matrix`（いずれも `n → 1`）は数ベクトルの型の具体版が無いので、mathlib の
`sub_smul`・`one_smul`・`mul_smul`・`smul_zero` で受ける（`Qproj_mulVec_eq_zero_of_eigen` と同じ）。 -/
theorem Qproj_mulVec_eq_zero_of_ne_eigenvalue (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {lam : ℂ} {x : Conf M → ℂ} (hx : (VPlus M s2 K1 K2star).mulVec x = lam • x)
    {T : Finset (CheckIdx M)} (hne : ((checkBigLambda F g s2 T : ℝ) : ℂ) ≠ lam) :
    (F.Qproj T).mulVec x = 0 := by
  have hchain := checkBigLambda_smul_Qproj_mulVec_of_eigenvalue F g hK1 hK2 hs2 hVeq hx T
                                                        -- 上の鎖の両端の等式 `(Λ̌_ε)_ℂ(Q̌_εx) = λ(Q̌_εx)`
  set a : ℂ := ((checkBigLambda F g s2 T : ℝ) : ℂ)
  set v : Conf M → ℂ := (F.Qproj T).mulVec x
  set d : ℂ := a - lam with hd_def                      -- `d_ε := (Λ̌_ε)_ℂ − λ`（`def_complex_difference`）
  have hd : d ≠ 0 := fun h => hne (sub_eq_zero.1 h)    -- `complex_numbers_form_a_field` の加法の群構造
  have hdv : d • v = 0 :=
    calc d • v
        = (a - lam) • v := by rw [hd_def]               -- `d_ε` の置き方
      _ = a • v - lam • v := sub_smul _ _ _             -- `difference_of_scalar_multiples_of_one_matrix` を右辺から左辺へ
      _ = lam • v - lam • v := by rw [hchain]           -- 上の鎖の両端の等式
      _ = 0 := sub_self _                               -- `matrix_difference_zero_iff_equal` の `⟸`
  calc v
      = (1 : ℂ) • v := (one_smul ℂ v).symm              -- `scalar_multiple_by_one` を右辺から左辺へ
    _ = (d⁻¹ * d) • v := by rw [inv_mul_cancel₀ hd]     -- `d_ε^{-1}d_ε = 1_ℂ`（`complex_numbers_form_a_field` の逆元）を右辺から左辺へ
    _ = d⁻¹ • (d • v) := mul_smul _ _ _                 -- `scalar_multiple_is_associative` を右辺から左辺へ
    _ = d⁻¹ • (0 : Conf M → ℂ) := by rw [hdv]          -- 上の鎖 `d_ε(Q̌_εx) = O`
    _ = 0 := smul_zero _                                -- `scalar_multiple_of_zero_matrix`

/-- **原文 `eigenvalues_of_V_plus` (1) の「`V^{(+)}` の固有値はどれも、ある `ε` の `(Λ̌_ε)_ℂ` に等しい」**:
`x ≠ 0`、`V^{(+)}x = λx`（`def_eigenvector`・`def_eigenvalue`）なら、`(Λ̌_ε)_ℂ = λ` を満たす `ε` がある。
人手と同じく、全ての `ε` で `(Λ̌_ε)_ℂ ≠ λ` と仮定し、`Qproj_mulVec_eq_zero_of_ne_eigenvalue` で全ての `Q̌_εx = O` を出し、
`x = Ix = (Σ_ε Q̌_ε)x = Σ_ε Q̌_εx = Q̌_{(1,…,1)}x` の 4 行（`max_eigenvalue_of_V_plus_simple` (3) と同じ calc
`colVec_eq_Qproj_mul_of_zero`）と最後の `= O` で `x = O` を導いて矛盾させる。
4 行の calc へは、`eq_Qproj_univ_mulVec_of_eigen` と同じく、数ベクトルを 1 列の行列へ送る単射 `Matrix.replicateCol (Fin 1)` と
語から部分集合への全単射 `finsetOfBinWord` で運ぶ（運ぶ段は人手の証明の行ではない）。人手の `M_col` が Lean の `r + 1`。 -/
theorem exists_checkBigLambda_eq_of_eigenvalue {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g)
    {lam : ℂ} {x : Conf (r + 1) → ℂ} (hx0 : x ≠ 0)
    (hx : (VPlus (r + 1) s2 K1 K2star).mulVec x = lam • x) :
    ∃ T : Finset (CheckIdx (r + 1)), ((checkBigLambda F g s2 T : ℝ) : ℂ) = lam := by
  by_contra hall
  push Not at hall                                      -- 全ての `ε` について `(Λ̌_ε)_ℂ ≠ λ` と仮定する
  have hz : ∀ T : Finset (CheckIdx (r + 1)), (F.Qproj T).mulVec x = 0 :=
    fun T => Qproj_mulVec_eq_zero_of_ne_eigenvalue F g hK1 hK2 hs2 hVeq hx (hall T)
                                                        -- 全ての `ε` について `Q̌_εx = O`
  obtain ⟨ε₀, hε₀⟩ := CheckFermiSetup.finsetOfBinWord_bijective.2 (Finset.univ : Finset (CheckIdx (r + 1)))
                                                        -- 人手の `(1,…,1)` に当たる語 `ε₀`（運ぶ段）
  apply hx0
  apply Matrix.replicateCol_injective (ι := Fin 1)
  calc Matrix.replicateCol (Fin 1) x
      = F.Qproj (CheckFermiSetup.finsetOfBinWord ε₀) * Matrix.replicateCol (Fin 1) x := by
        refine colVec_eq_Qproj_mul_of_zero F ε₀ _ (fun ε _ => ?_)
        rw [← Matrix.replicateCol_mulVec, hz _]
        ext a b
        simp
                                                        -- 1 列の行列へ送り（運ぶ段）、人手の 4 行の calc を使う
    _ = Matrix.replicateCol (Fin 1) ((F.Qproj Finset.univ).mulVec x) := by
        rw [hε₀, Matrix.replicateCol_mulVec]           -- 数ベクトルへ戻す（運ぶ段）
    _ = Matrix.replicateCol (Fin 1) (0 : Conf (r + 1) → ℂ) := by rw [hz Finset.univ]
                                                        -- 上で示した `Q̌_εx = O`（`ε → (1,…,1)`）

/-- **原文 `eigenvalues_of_V_plus` (2) の最初の段落の結び**: `V^{(+)}` の固有値はどれも、正の実数 `Λ̌_ε` を
`inclusion_rr_to_cc` で `ℂ` へ移した `(Λ̌_ε)_ℂ` である。人手と同じく、(1) の「固有値はどれもある `(Λ̌_ε)_ℂ` に等しい」
（`exists_checkBigLambda_eq_of_eigenvalue`）と上の `checkBigLambda_pos` を合わせる。 -/
theorem eigenvalue_VPlus_eq_positive_real {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g)
    {lam : ℂ} {x : Conf (r + 1) → ℂ} (hx0 : x ≠ 0)
    (hx : (VPlus (r + 1) s2 K1 K2star).mulVec x = lam • x) :
    ∃ T : Finset (CheckIdx (r + 1)),
      0 < checkBigLambda F g s2 T ∧ ((checkBigLambda F g s2 T : ℝ) : ℂ) = lam := by
  obtain ⟨T, hT⟩ := exists_checkBigLambda_eq_of_eigenvalue F g hK1 hK2 hs2 hVeq hx0 hx
                                                        -- (1): 固有値はどれもある `(Λ̌_ε)_ℂ` に等しい
  exact ⟨T, checkBigLambda_pos F g hs2 T, hT⟩          -- 上の正値性（`ε → T`）

/-- 人手 (1) の「総個数 `2^{M_col}`」: 基底の添字（`ε` の集合）の個数。 -/
theorem card_eps_index (r : ℕ) : Fintype.card (Finset (CheckIdx (r + 1))) = 2 ^ (r + 1) := by
  rw [Fintype.card_finset, CheckIdx.card]

/-- **原文 `eigenvalues_of_V_plus` の「`V^{(+)}` は対角化可能」**（必要十分版
`NecSuf.exists_eigenBasis_of_matrix_proj` の特殊化）:
`V^{(+)}` の固有ベクトルからなる基底が存在し、固有値は `Λ̌_ε` である。
人手の段落と 1 対 1 の具体版は上の `exists_eigenBasis_VPlus_of_joint_eigenspaces` である。 -/
theorem exists_eigenBasis_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    ∃ (b : Basis (Conf M) ℂ (Conf M → ℂ)) (lam : Conf M → ℂ),
      (∀ a, ∃ T : Finset (CheckIdx M), lam a = ((checkBigLambda F g s2 T : ℝ) : ℂ)) ∧
      (∀ a, (VPlus M s2 K1 K2star).mulVec (b a) = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' (VPlus M s2 K1 K2star))
        = Matrix.diagonal lam :=
  NecSuf.exists_eigenBasis_of_matrix_proj
    (A := VPlus M s2 K1 K2star) (Q := F.Qproj)
    (c := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj
    (VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq)

/-- **原文 `eigenvalues_of_V_plus` の「相似変換で対角化できる」形**。 -/
theorem exists_conj_diagonal_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧
        P' * VPlus M s2 K1 K2star * P = Matrix.diagonal lam :=
  NecSuf.exists_conj_diagonal_of_matrix_proj
    (Q := F.Qproj) (c := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj
    (VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq)

end EigenVPlus

end Ising2D
