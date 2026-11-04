/-
# `ε Q̌_ε = η_ε Q̌_ε` と符号の反転則（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_002_claim_epsilon_eigenvalue_on_check_Q`、ラベル **`epsilon_eigenvalue_on_check_Q`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル。(2) の Step 1 と Step 3 の前半の数ベクトルの鎖は
`Ising2D/NecSuf/SignReversalOnGeneratorVector.lean`）の
`Ising2D.NecSuf.projOn_insert_mul_cre` / `NecSuf.cre_mul_projOn_ne_zero`。
**符号の反転則 (2) はその 2 つの系である。**

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `∃! η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε` | `Ising2D.CheckFermi.eta` / `eta_mem` / `epsilon_mul_Qproj` / `eta_unique` |
| (1) の鎖: `Q̌_ε q = q`（4 行）・`Q̌_ε(εq) = εq`（4 行）・`q = (ηη)q`（7 行）・`(ηη − 1)q = O`（4 行）・`(η − 1)(η + 1) = 0`（4 行）・`(εQ̌_ε)x = (ηQ̌_ε)x`（9 行）・列ごとの `εQ̌_ε = ηQ̌_ε`（7 行）・一意性（6 行） | `exists_eta_with_generator`・`Qproj_mulVec_generator`・`Qproj_mulVec_epsilon_mulVec_generator`・`generator_eq_eta_mul_eta_smul`・`eta_mul_eta_sub_one_smul_generator`・`eta_mem_of_mul_self_sub_one`・`epsilon_mul_Qproj_mulVec`・`epsilon_mul_Qproj_eq_smul_of_mulVec`・`smul_generator_eq_eta_smul`（各 calc が人手の鎖と同じ行。`mat_mult_associative` の行は、Lean の数ベクトルが 1 列の行列でないので mathlib の `Matrix.mulVec_mulVec`） |
| (2) の冒頭: `im Q̌_ε` の `0` でない元 `q` を取り、冪等性で `Q̌_ε q = q`、5 行の鎖で `εq = η_ε q` | **まだ人手どおりの鎖が無い**（Step 1・Step 3 の補題は `Q̌_ε q = q`・`εq = ηq` を仮定で受ける。`exists_generator_of_eta` の `q` は (1) が選んだ生成元で、人手の「任意の `0` でない元」と違う。`eta_insert` を組み替えるときに置く） |
| (2) Step 1: `ň_μ q = 0`（6 行）・`ψ̌_{M+1−μ}(ψ̌_μ^† q) = q`（6 行）・背理法（3 行）で `ψ̌_μ^† q ≠ 0` | `nOp_mulVec_generator_eq_zero`・`ann_mulVec_cre_mulVec_generator`・`cre_mulVec_generator_ne_zero` |
| (2) Step 3 の前半: `ε(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`（9 行） | `epsilon_mulVec_cre_mulVec_generator` |
| (2) 反転則 `η_{ε[μ→1]} = -η_ε` | `Ising2D.CheckFermi.eta_insert`（いまは行列 `ψ̌_μ^† Q̌_ε` の上で必要十分版の系として閉じる。人手の数ベクトルの鎖へは Step 2 を置いてから組み替える） |
| (3) `η_ε = η_{(1,…,1)}(-1)^{M-\|ε\|}` | `Ising2D.CheckFermi.eta_eq_eta_univ_mul` |
| (4) `ε = η_{(1,…,1)}(-1)^M ∏(I - 2ň_μ)` | `Ising2D.CheckFermi.epsilon_eq_parityProd` |

## 1 次元性が効いている場所（必要十分版で判明したこと）

人手証明は (1)(2) の両方で「`im Q̌_ε` は 1 次元」を使うが、**1 次元性が本当に要るのは
(1)（`η_ε` の存在）だけ**である。(2) の Step 1・Step 2 は必要十分版
（環の計算だけ）で閉じており、1 次元性を使わない。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.CheckFermiInput
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatColumnwiseFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.NecSuf.SignReversalOnGeneratorVector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 補助: 行列の等号判定とスカラーの一意性 -/

/-- `Q ≠ 0` なら `η Q = η' Q ⇒ η = η'`（人手証明 (1) の「一意に定まる」）。 -/
theorem smul_cancel_of_matrix_ne_zero {n : Type*} [Fintype n] {Q : Matrix n n ℂ} (hQ : Q ≠ 0)
    {η η' : ℂ} (h : η • Q = η' • Q) : η = η' := by
  obtain ⟨i, j, hij⟩ : ∃ i j, Q i j ≠ 0 := by
    by_contra hc
    push_neg at hc
    exact hQ (by ext i j; simp [hc i j])
  have hE := congrFun (congrFun h i) j
  simp only [Matrix.smul_apply, smul_eq_mul] at hE
  exact mul_right_cancel₀ hij hE

namespace CheckFermi

variable (F : CheckFermi M)

theorem Qproj_eq (T : Finset (Fin M)) :
    F.Qproj T = NecSuf.projOn (NecSuf.num F.cre F.ann) F.commute_nOp_nOp Finset.univ T := rfl

/-- `w ∈ im Q̌_ε` なら `Q̌_ε w = w`（冪等性）。下流（`TheoremCPlusEqualsLambda.lean` ほか）が使う `exists_Qproj_generator` の形のための補題で、
人手の (1) の鎖は下の `Qproj_mulVec_generator` である。 -/
theorem Qproj_mulVec_of_mem_range {T : Finset (Fin M)} {w : Conf M → ℂ}
    (h : ∃ y, F.Qproj T *ᵥ y = w) : F.Qproj T *ᵥ w = w := by
  obtain ⟨y, rfl⟩ := h
  rw [Matrix.mulVec_mulVec, F.Qproj_mul_self]

/-! ## 原文 (1): `im Q̌_ε` は 1 次元 -/

/-- **原文 `check_joint_eigenspace_decomposition` (4) の帰結**:
`tr(Q̌_ε) = 1` と冪等性から `dim im Q̌_ε = 1`。 -/
theorem finrank_range_Qproj (T : Finset (Fin M)) :
    Module.finrank ℂ (LinearMap.range (Matrix.toLin' (F.Qproj T))) = 1 := by
  have h := trace_of_idempotent (F.Qproj T) (F.Qproj_mul_self T)
  rw [F.trace_Qproj T] at h
  exact_mod_cast h.symm

/-- **原文 (1) の冒頭**: `dim_ℂ im Q̌_ε = 1` なので `im Q̌_ε = ℂq` なる `q ≠ 0` が取れ、`q ∈ im Q̌_ε` なので `q = Q̌_ε x` なる
`x` が取れる。三つ目の成分が「`im Q̌_ε = ℂq`」の `⊆`（`Q̌_ε y = zq` なる `z ∈ ℂ` が取れること）である。
`dim = 1` から生成元を取る段は、mathlib の定理 `finrank_eq_one_iff'`（次元が 1 の空間は 1 つの非零元で張られる）を使う。 -/
theorem exists_Qproj_spanning_vector (T : Finset (Fin M)) :
    ∃ q : Conf M → ℂ, q ≠ 0 ∧ (∃ x : Conf M → ℂ, F.Qproj T *ᵥ x = q) ∧
      ∀ y : Conf M → ℂ, ∃ z : ℂ, F.Qproj T *ᵥ y = z • q := by
  obtain ⟨v, hv, hgen⟩ := finrank_eq_one_iff'.1 (F.finrank_range_Qproj T)
  have hmem : ∀ y : Conf M → ℂ, F.Qproj T *ᵥ y ∈ LinearMap.range (Matrix.toLin' (F.Qproj T)) :=
    fun y => ⟨y, by simp only [Matrix.toLin'_apply]⟩
  obtain ⟨x, hx⟩ := v.2
  refine ⟨(v : Conf M → ℂ), ?_, ⟨x, by simpa only [Matrix.toLin'_apply] using hx⟩, ?_⟩
  · intro h
    exact hv (Subtype.ext h)
  · intro y
    obtain ⟨c, hc⟩ := hgen ⟨F.Qproj T *ᵥ y, hmem y⟩
    exact ⟨c, by simpa using congrArg Subtype.val hc.symm⟩

/-- **原文 (1)** の `Q̌_ε q = q` の 4 行の鎖。 -/
theorem Qproj_mulVec_generator {T : Finset (Fin M)} {q x : Conf M → ℂ} (hx : F.Qproj T *ᵥ x = q) :
    F.Qproj T *ᵥ q = q :=
  calc F.Qproj T *ᵥ q
      = F.Qproj T *ᵥ (F.Qproj T *ᵥ x) := by rw [hx]    -- `q = Q̌_ε x` の置き方
    _ = (F.Qproj T * F.Qproj T) *ᵥ x := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`。Lean の数ベクトルは 1 列の行列ではなく
                                                        -- `Conf M → ℂ` なので、mathlib の `Matrix.mulVec_mulVec`
    _ = F.Qproj T *ᵥ x := by rw [F.Qproj_mul_self T]   -- `check_joint_eigenspace_decomposition` (1) の `Q̌_ε^2 = Q̌_ε`
    _ = q := hx                                         -- `q = Q̌_ε x` の置き方

/-- 下流（`TheoremCPlusEqualsLambda.lean`）が使う形: `q ≠ 0`、`Q̌_ε q = q`、`im Q̌_ε ⊆ ℂq`。 -/
theorem exists_Qproj_generator (T : Finset (Fin M)) :
    ∃ q : Conf M → ℂ, q ≠ 0 ∧ F.Qproj T *ᵥ q = q ∧
      ∀ x : Conf M → ℂ, ∃ z : ℂ, F.Qproj T *ᵥ x = z • q := by
  obtain ⟨q, hq0, ⟨x, hx⟩, hspan⟩ := F.exists_Qproj_spanning_vector T
  exact ⟨q, hq0, F.Qproj_mulVec_generator hx, hspan⟩

/-! ## 原文 (1): `η_ε` の存在と一意性 -/

/-- **原文 (1)** の `Q̌_ε(εq) = εq` の 4 行の鎖（`ε q ∈ im Q̌_ε` を言うための式）。 -/
theorem Qproj_mulVec_epsilon_mulVec_generator {T : Finset (Fin M)} {q : Conf M → ℂ}
    (hqfix : F.Qproj T *ᵥ q = q) : F.Qproj T *ᵥ (epsilon M *ᵥ q) = epsilon M *ᵥ q :=
  calc F.Qproj T *ᵥ (epsilon M *ᵥ q)
      = (F.Qproj T * epsilon M) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = (epsilon M * F.Qproj T) *ᵥ q := by rw [(F.commute_epsilon_Qproj T).eq]
                                                        -- `epsilon_anticommutes_with_check_Z_Y` (4)
    _ = epsilon M *ᵥ (F.Qproj T *ᵥ q) := (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = epsilon M *ᵥ q := by rw [hqfix]                 -- 上で示した `Q̌_ε q = q`

/-- **原文 (1)** の `η^2 = 1` を示す 7 行の鎖（`q = (ηη)q`）。 -/
theorem generator_eq_eta_mul_eta_smul {q : Conf M → ℂ} {η : ℂ} (hεq : epsilon M *ᵥ q = η • q) :
    q = (η * η) • q :=
  calc q
      = (1 : TensorPow M) *ᵥ q := (identity_matrix_mulVec_tensorPow q).symm
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（右の因子が数ベクトル）
    _ = (epsilon M * epsilon M) *ᵥ q := by rw [epsilon_mul_self]
                                                        -- `epsilon_square_and_eigenvalues` の `ε^2 = I`
    _ = epsilon M *ᵥ (epsilon M *ᵥ q) := (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = epsilon M *ᵥ (η • q) := by rw [hεq]             -- `εq = ηq` の置き方
    _ = η • (epsilon M *ᵥ q) := Matrix.mulVec_smul _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor`
    _ = η • (η • q) := by rw [hεq]                      -- `εq = ηq` の置き方
    _ = (η * η) • q := smul_smul _ _ _                  -- `scalar_multiple_is_associative`

/-- **原文 (1)** の `(ηη − 1)q = O` の 4 行の鎖。 -/
theorem eta_mul_eta_sub_one_smul_generator {q : Conf M → ℂ} {η : ℂ} (hq2 : q = (η * η) • q) :
    (η * η - 1) • q = 0 :=
  calc (η * η - 1) • q
      = (η * η) • q - (1 : ℂ) • q := sub_smul _ _ _    -- `difference_of_scalar_multiples_of_one_matrix`
    _ = q - (1 : ℂ) • q := by rw [← hq2]                -- 上の式変形の `q = (ηη)q`
    _ = q - q := by rw [one_smul]                       -- `scalar_multiple_by_one`
    _ = 0 := (vec_sub_eq_zero_iff_tensorPow q q).mpr rfl
                                                        -- `matrix_difference_zero_iff_equal`（`⟸`。数ベクトル）

/-- **原文 (1)**: `ηη − 1 = 0` から `η ∈ {+1, −1}`。人手の `(η − 1)(η + 1)` の 4 行の鎖と、体 `ℂ` で積が `0` なら
因子のどちらかが `0`（`complex_numbers_form_a_field`）である。 -/
theorem eta_mem_of_mul_self_sub_one {η : ℂ} (hηη : η * η - 1 = 0) : η = 1 ∨ η = -1 := by
  have hfac : (η - 1) * (η + 1) = 0 :=
    calc (η - 1) * (η + 1)
        = (η - 1) * η + (η - 1) * 1 := mul_add _ _ _    -- `complex_numbers_form_a_field` の分配則
      _ = (η * η - η) + (η - 1) := by rw [sub_mul, one_mul, mul_one]
                                                        -- `complex_numbers_form_a_field` の分配則と乗法の単位元
      _ = η * η - 1 := sub_add_sub_cancel _ _ _         -- `complex_numbers_form_a_field` の加法の結合則と逆元
      _ = 0 := hηη                                      -- 上で示した `ηη − 1 = 0`
  rcases mul_eq_zero.1 hfac with h | h                  -- 体 `ℂ` では `η − 1 = 0` または `η + 1 = 0`
  · exact Or.inl (sub_eq_zero.1 h)
  · exact Or.inr (eq_neg_of_add_eq_zero_left h)

/-- `q ≠ 0` なら `aq = bq ⇒ a = b`（人手の「`εq = ηq` なる `η ∈ ℂ` が一意に定まる（`q ≠ 0`）」）。
`q_k ≠ 0` となる成分を取り、その成分で `ℂ` の積を約す（`def_matrix_scalar_multiple`・`complex_numbers_form_a_field`）。 -/
theorem smul_generator_cancel {q : Conf M → ℂ} (hq0 : q ≠ 0) {a b : ℂ} (h : a • q = b • q) : a = b := by
  obtain ⟨k, hk⟩ : ∃ k, q k ≠ 0 := by
    by_contra hc
    push_neg at hc
    exact hq0 (funext hc)
  have hk' : a * q k = b * q k := by
    have := congrFun h k
    rwa [Pi.smul_apply, Pi.smul_apply, smul_eq_mul, smul_eq_mul] at this
                                                        -- `def_matrix_scalar_multiple` の第 `k` 成分
  exact mul_right_cancel₀ hk hk'

/-- **原文 (1)** の「`x ∈ ℂ^{2^{M_col}}` について `(εQ̌_ε)x = (ηQ̌_ε)x`」の 9 行の鎖（`Q̌_ε x = cq` の `c` は仮定 `hspan` から取る）。 -/
theorem epsilon_mul_Qproj_mulVec {T : Finset (Fin M)} {q : Conf M → ℂ} {η : ℂ}
    (hspan : ∀ y : Conf M → ℂ, ∃ z : ℂ, F.Qproj T *ᵥ y = z • q) (hεq : epsilon M *ᵥ q = η • q)
    (x : Conf M → ℂ) : (epsilon M * F.Qproj T) *ᵥ x = (η • F.Qproj T) *ᵥ x := by
  obtain ⟨c, hc⟩ := hspan x                             -- `Q̌_ε x ∈ im Q̌_ε = ℂq` なので `Q̌_ε x = cq`
  calc (epsilon M * F.Qproj T) *ᵥ x
      = epsilon M *ᵥ (F.Qproj T *ᵥ x) := (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = epsilon M *ᵥ (c • q) := by rw [hc]              -- `Q̌_ε x = cq` の置き方
    _ = c • (epsilon M *ᵥ q) := Matrix.mulVec_smul _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor`
    _ = c • (η • q) := by rw [hεq]                      -- `εq = ηq` の置き方
    _ = (c * η) • q := smul_smul _ _ _                  -- `scalar_multiple_is_associative`
    _ = (η * c) • q := by rw [mul_comm c η]             -- `complex_numbers_form_a_field` の乗法の交換則
    _ = η • (c • q) := (smul_smul _ _ _).symm           -- `scalar_multiple_is_associative`
    _ = η • (F.Qproj T *ᵥ x) := by rw [hc]              -- `Q̌_ε x = cq` の置き方
    _ = (η • F.Qproj T) *ᵥ x := (smul_mulVec_tensorPow _ _ _).symm
                                                        -- `scalar_multiple_factors_out_of_left_factor`（右の因子が数ベクトル）

/-- **原文 (1)** の行列の等式 `εQ̌_ε = ηQ̌_ε` の 7 行の鎖（`N := 2^{M_col}`、`e_k` は `I` の第 `k` 列）。
人手の `I = [e_1 ⋯ e_N]` は、Lean では `e_k := (I の第 k 列)` と置くので `Matrix.of` の展開（`rfl`）である。 -/
theorem epsilon_mul_Qproj_eq_smul_of_mulVec {T : Finset (Fin M)} {η : ℂ}
    (hx : ∀ x : Conf M → ℂ, (epsilon M * F.Qproj T) *ᵥ x = (η • F.Qproj T) *ᵥ x) :
    epsilon M * F.Qproj T = η • F.Qproj T := by
  let e : Conf M → Conf M → ℂ := fun k j => (1 : TensorPow M) j k
                                                        -- `e_k` は `I` の第 `k` 列（`def_identity_matrix`）
  calc epsilon M * F.Qproj T
      = (epsilon M * F.Qproj T) * 1 := (mul_identity_matrix_tensorPow _).symm
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = (epsilon M * F.Qproj T) * Matrix.of (fun j k => e k j) := rfl
                                                        -- `I = [e_1 ⋯ e_N]`
    _ = Matrix.of (fun i k => ((epsilon M * F.Qproj T) *ᵥ e k) i) := mul_columns_tensorPow _ _
                                                        -- `mat_columnwise`
    _ = Matrix.of (fun i k => ((η • F.Qproj T) *ᵥ e k) i) := by
        exact congrArg Matrix.of (funext fun i => funext fun k => by rw [hx (e k)])
                                                        -- 上の等式を `N` 箇所へ同時適用
    _ = (η • F.Qproj T) * Matrix.of (fun j k => e k j) := (mul_columns_tensorPow _ _).symm
                                                        -- `mat_columnwise`
    _ = (η • F.Qproj T) * 1 := rfl                      -- `I = [e_1 ⋯ e_N]`
    _ = η • F.Qproj T := mul_identity_matrix_tensorPow _
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`

/-- **原文 (1)** の存在の部分: `ε Q̌_ε = η Q̌_ε` なる `η ∈ {±1}` と、それを定めた `q`（`q ≠ 0`、`Q̌_ε q = q`、`εq = ηq`）。
人手の (1) の存在の部分の段を上の補題で順に辿る。`q` を組で返すのは、一意性の鎖の最後の行 `εq = ηq` がこの `q` と `η` を使うためである。 -/
theorem exists_eta_with_generator (T : Finset (Fin M)) :
    ∃ η : ℂ, (η = 1 ∨ η = -1) ∧ epsilon M * F.Qproj T = η • F.Qproj T ∧
      ∃ q : Conf M → ℂ, q ≠ 0 ∧ F.Qproj T *ᵥ q = q ∧ epsilon M *ᵥ q = η • q := by
  obtain ⟨q, hq0, ⟨x, hx⟩, hspan⟩ := F.exists_Qproj_spanning_vector T
  have hqfix : F.Qproj T *ᵥ q = q := F.Qproj_mulVec_generator hx
                                                        -- `Q̌_ε q = q`
  have hmem := F.Qproj_mulVec_epsilon_mulVec_generator hqfix
                                                        -- `Q̌_ε(εq) = εq`
  obtain ⟨η, hη⟩ := hspan (epsilon M *ᵥ q)              -- `εq ∈ im Q̌_ε = ℂq`
  have hεq : epsilon M *ᵥ q = η • q := hmem.symm.trans hη
                                                        -- `εq = ηq` なる `η ∈ ℂ`
  have hO := eta_mul_eta_sub_one_smul_generator (generator_eq_eta_mul_eta_smul hεq)
                                                        -- `(ηη − 1)q = O`
  obtain ⟨k, hk⟩ : ∃ k, q k ≠ 0 := by                   -- `q ≠ 0` なので `q_k ≠ 0` となる `k` が取れる
    by_contra hc
    push_neg at hc
    exact hq0 (funext hc)
  have hk0 : (η * η - 1) * q k = 0 := by
    have := congrFun hO k
    rwa [Pi.smul_apply, smul_eq_mul, Pi.zero_apply] at this
                                                        -- 上の式の第 `k` 成分（`def_matrix_scalar_multiple`）
  have hηη : η * η - 1 = 0 := (mul_eq_zero.1 hk0).resolve_right hk
                                                        -- `complex_numbers_form_a_field` より `ℂ` は体
  exact ⟨η, eta_mem_of_mul_self_sub_one hηη,
    F.epsilon_mul_Qproj_eq_smul_of_mulVec (F.epsilon_mul_Qproj_mulVec hspan hεq), q, hq0, hqfix, hεq⟩

/-- **原文 (1)**: `ε Q̌_ε = η Q̌_ε` なる `η ∈ {±1}` が存在する。 -/
theorem exists_eta (T : Finset (Fin M)) :
    ∃ η : ℂ, (η = 1 ∨ η = -1) ∧ epsilon M * F.Qproj T = η • F.Qproj T := by
  obtain ⟨η, hpm, hmat, _⟩ := F.exists_eta_with_generator T
  exact ⟨η, hpm, hmat⟩

/-- **原文 (1) の `η_ε`**（選択関数として与える。人手の「この `η` を `η_ε` と書く」）。 -/
noncomputable def eta (T : Finset (Fin M)) : ℂ := (F.exists_eta_with_generator T).choose

theorem eta_mem (T : Finset (Fin M)) : F.eta T = 1 ∨ F.eta T = -1 :=
  (F.exists_eta_with_generator T).choose_spec.1

/-- **原文 (1)**: `ε Q̌_ε = η_ε Q̌_ε`。 -/
theorem epsilon_mul_Qproj (T : Finset (Fin M)) :
    epsilon M * F.Qproj T = F.eta T • F.Qproj T :=
  (F.exists_eta_with_generator T).choose_spec.2.1

/-- `η_ε` を定めた `q`（`q ≠ 0`、`Q̌_ε q = q`、`εq = η_ε q`）。 -/
theorem exists_generator_of_eta (T : Finset (Fin M)) :
    ∃ q : Conf M → ℂ, q ≠ 0 ∧ F.Qproj T *ᵥ q = q ∧ epsilon M *ᵥ q = F.eta T • q :=
  (F.exists_eta_with_generator T).choose_spec.2.2

/-- **原文 (1) の一意性**の 6 行の鎖: `εQ̌_ε = η'Q̌_ε` なら `η'q = ηq`（`q`・`η` は存在の部分で定めたもの）。 -/
theorem smul_generator_eq_eta_smul {T : Finset (Fin M)} {q : Conf M → ℂ} {η η' : ℂ}
    (hqfix : F.Qproj T *ᵥ q = q) (hεq : epsilon M *ᵥ q = η • q)
    (h : epsilon M * F.Qproj T = η' • F.Qproj T) : η' • q = η • q :=
  calc η' • q
      = η' • (F.Qproj T *ᵥ q) := by rw [hqfix]          -- 上で示した `Q̌_ε q = q`
    _ = (η' • F.Qproj T) *ᵥ q := (smul_mulVec_tensorPow _ _ _).symm
                                                        -- `scalar_multiple_factors_out_of_left_factor`
    _ = (epsilon M * F.Qproj T) *ᵥ q := by rw [h]       -- `η'` の仮定
    _ = epsilon M *ᵥ (F.Qproj T *ᵥ q) := (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = epsilon M *ᵥ q := by rw [hqfix]                 -- 上で示した `Q̌_ε q = q`
    _ = η • q := hεq                                    -- `εq = ηq` の置き方

/-- **原文 (1) の一意性**: `εQ̌_ε = η'Q̌_ε` なら `η' = η_ε`。上の 6 行の鎖と、`q ≠ 0` だから `εq = ηq` なる `η` が
一意に定まること（`smul_generator_cancel`）による。 -/
theorem eta_unique {T : Finset (Fin M)} {η : ℂ} (h : epsilon M * F.Qproj T = η • F.Qproj T) :
    η = F.eta T := by
  obtain ⟨q, hq0, hqfix, hεq⟩ := F.exists_generator_of_eta T
  exact smul_generator_cancel hq0 (F.smul_generator_eq_eta_smul hqfix hεq h)

/-! ## 原文 (2): 符号の反転則 -/

/-! 人手の (2) は `im Q̌_ε` の `0` でない元 `q`（`Q̌_ε q = q`、`εq = η_ε q`。`exists_generator_of_eta`）の上で計算する。
以下の 4 つは人手の Step 1 の 3 本の鎖と Step 3 の前半の鎖で、calc の各行が人手の各行に当たる。
数ベクトルの上の行のうち、`Matrix.mulVec_mulVec`（`mat_mult_associative`）・`Matrix.mulVec_smul`
（`scalar_multiple_factors_out_of_right_factor`）は (1) と同じく mathlib の定理で受け、`Oq = 0`・`A0 = 0`・`(−A)q = −(Aq)`・
`v − 0 = v`・`−v = (−1)v` も数ベクトルの版が本文の具体版に無いので mathlib の `Matrix.zero_mulVec`・`Matrix.mulVec_zero`・
`Matrix.neg_mulVec`・`sub_zero`・`neg_one_smul` で受ける。必要十分版は `Ising2D/NecSuf/SignReversalOnGeneratorVector.lean` で、
同じ行の calc である。 -/

/-- **原文 (2) Step 1** の `ň_μ q = 0` の 6 行の鎖（`ε_μ = 0`、すなわち `μ ∉ T`）。 -/
theorem nOp_mulVec_generator_eq_zero {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) {q : Conf M → ℂ}
    (hqfix : F.Qproj T *ᵥ q = q) : F.nOp μ *ᵥ q = 0 :=
  calc F.nOp μ *ᵥ q
      = F.nOp μ *ᵥ (F.Qproj T *ᵥ q) := by rw [hqfix]    -- `Q̌_ε q = q`
    _ = (F.nOp μ * F.Qproj T) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = ((if μ ∈ T then (1 : ℂ) else 0) • F.Qproj T) *ᵥ q := by rw [F.nOp_mul_Qproj μ T]
                                                        -- `check_joint_eigenspace_decomposition` (3)（`ε_μ` は `if μ ∈ T then 1 else 0`）
    _ = ((0 : ℂ) • F.Qproj T) *ᵥ q := by rw [if_neg hμ]  -- `ε_μ = 0`
    _ = (0 : TensorPow M) *ᵥ q := by rw [zero_smul_tensorPow]
                                                        -- `zero_scalar_multiple_is_zero_matrix`
    _ = 0 := Matrix.zero_mulVec q                       -- `zero_matrix_is_left_zero_of_mat_mult`（右の因子が数ベクトル）

/-- **原文 (2) Step 1** の `ψ̌_{M_col+1−μ}(ψ̌_μ^† q) = q` の 6 行の鎖（Lean の `ann μ` が人手の `ψ̌_{M_col+1−μ}`）。 -/
theorem ann_mulVec_cre_mulVec_generator {μ : Fin M} {q : Conf M → ℂ} (hn : F.nOp μ *ᵥ q = 0) :
    F.ann μ *ᵥ (F.cre μ *ᵥ q) = q :=
  calc F.ann μ *ᵥ (F.cre μ *ᵥ q)
      = (F.ann μ * F.cre μ) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = (1 - F.nOp μ) *ᵥ q := by rw [F.ann_mul_cre μ]   -- `check_number_operator_idempotent` (2)
    _ = (1 : TensorPow M) *ᵥ q - F.nOp μ *ᵥ q := (sub_mulVec_tensorPow _ _ _).symm
                                                        -- `matrix_difference_mul_vector`
    _ = q - F.nOp μ *ᵥ q := by rw [identity_matrix_mulVec_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = q - 0 := by rw [hn]                             -- 上の `ň_μ q = 0`
    _ = q := sub_zero q                                 -- `matrix_minus_zero_matrix`

/-- **原文 (2) Step 1**: `ψ̌_μ^† q ≠ 0`。上の 2 本の鎖と、仮に `ψ̌_μ^† q = 0` とした背理法の 3 行の鎖。 -/
theorem cre_mulVec_generator_ne_zero {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) {q : Conf M → ℂ}
    (hq0 : q ≠ 0) (hqfix : F.Qproj T *ᵥ q = q) : F.cre μ *ᵥ q ≠ 0 := by
  have h := F.ann_mulVec_cre_mulVec_generator (F.nOp_mulVec_generator_eq_zero hμ hqfix)
  intro h0                                              -- 仮に `ψ̌_μ^† q = 0` とする
  apply hq0
  calc q
      = F.ann μ *ᵥ (F.cre μ *ᵥ q) := h.symm              -- 上の式変形
    _ = F.ann μ *ᵥ 0 := by rw [h0]                      -- 仮定 `ψ̌_μ^† q = 0`
    _ = 0 := Matrix.mulVec_zero _                       -- `zero_matrix_is_right_zero_of_mat_mult`（右の因子が数ベクトル）

/-- **原文 (2) Step 3** の前半: `ε(ψ̌_μ^† q) = (−η)(ψ̌_μ^† q)` の 9 行の鎖（`η` は `εq = ηq` の `η`）。 -/
theorem epsilon_mulVec_cre_mulVec_generator {μ : Fin M} {q : Conf M → ℂ} {η : ℂ}
    (hεq : epsilon M *ᵥ q = η • q) :
    epsilon M *ᵥ (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q) :=
  calc epsilon M *ᵥ (F.cre μ *ᵥ q)
      = (epsilon M * F.cre μ) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = (-(F.cre μ * epsilon M)) *ᵥ q := by rw [F.epsilon_anticomm_cre μ]
                                                        -- `epsilon_anticommutes_with_check_Z_Y` (3)
    _ = -((F.cre μ * epsilon M) *ᵥ q) := Matrix.neg_mulVec _ _
                                                        -- `negation_factors_out_of_left_factor`
    _ = -(F.cre μ *ᵥ (epsilon M *ᵥ q)) := by rw [Matrix.mulVec_mulVec]
                                                        -- `mat_mult_associative`
    _ = -(F.cre μ *ᵥ (η • q)) := by rw [hεq]            -- (2) の冒頭の `εq = η_ε q`
    _ = -(η • (F.cre μ *ᵥ q)) := by rw [Matrix.mulVec_smul]
                                                        -- `scalar_multiple_factors_out_of_right_factor`
    _ = (-1 : ℂ) • (η • (F.cre μ *ᵥ q)) := (neg_one_smul ℂ _).symm
                                                        -- `negation_is_scalar_multiple_by_minus_one`
    _ = ((-1 : ℂ) * η) • (F.cre μ *ᵥ q) := smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative`
    _ = (-η) • (F.cre μ *ᵥ q) := by rw [neg_one_mul]    -- `multiply_by_minus_one`

/-! 上の 4 つを必要十分版 `Ising2D/NecSuf/SignReversalOnGeneratorVector.lean`（係数 `ℂ`、添字 `Conf M`）の特殊化として得る。 -/

theorem nOp_mulVec_generator_eq_zero_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hqfix : F.Qproj T *ᵥ q = q) : F.nOp μ *ᵥ q = 0 :=
  NecSuf.num_mulVec_eq_zero_of_fixed (fun x : ℂ => zero_mul x) hqfix (F.nOp_mul_Qproj μ T) (if_neg hμ)

theorem ann_mulVec_cre_mulVec_generator_of_necSuf {μ : Fin M} {q : Conf M → ℂ}
    (hn : F.nOp μ *ᵥ q = 0) : F.ann μ *ᵥ (F.cre μ *ᵥ q) = q :=
  NecSuf.ann_mulVec_cre_mulVec_eq_of_num_mulVec_eq_zero (F.ann_mul_cre μ) hn

theorem cre_mulVec_generator_ne_zero_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hq0 : q ≠ 0) (hqfix : F.Qproj T *ᵥ q = q) : F.cre μ *ᵥ q ≠ 0 :=
  NecSuf.cre_mulVec_ne_zero_of_ann_mulVec_cre_mulVec_eq
    (F.ann_mulVec_cre_mulVec_generator_of_necSuf (F.nOp_mulVec_generator_eq_zero_of_necSuf hμ hqfix)) hq0

theorem epsilon_mulVec_cre_mulVec_generator_of_necSuf {μ : Fin M} {q : Conf M → ℂ} {η : ℂ}
    (hεq : epsilon M *ᵥ q = η • q) :
    epsilon M *ᵥ (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q) :=
  NecSuf.mulVec_cre_mulVec_eq_neg_smul_of_anticomm (F.epsilon_anticomm_cre μ) hεq

/-- **原文 (2)**: `μ ∉ T` なら `η_{T∪{μ}} = -η_T`。

Step 1（`ψ̌_μ^† q ≠ 0`）と Step 2（`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`）は必要十分版
`NecSuf.cre_mul_projOn_ne_zero` / `NecSuf.projOn_insert_mul_cre` の系である。 -/
theorem eta_insert {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta (insert μ T) = -F.eta T := by
  set x : TensorPow M := F.cre μ * F.Qproj T with hx
  -- Step 1: `x ≠ 0`
  have hx0 : x ≠ 0 :=
    NecSuf.cre_mul_projOn_ne_zero F.cre F.ann F.commute_nOp_nOp F.nOp_mul_self
      F.acomm_cre_ann_self (Finset.mem_univ μ) hμ (F.Qproj_ne_zero T)
  -- Step 2: `Q̌_{T∪{μ}} x = x`
  have hstep2 : F.Qproj (insert μ T) * x = x :=
    NecSuf.projOn_insert_mul_cre F.cre F.ann F.commute_nOp_nOp F.nOp_mul_self
      (fun i j hij => F.commute_cre_nOp hij) F.cre_sq F.acomm_cre_ann_self
      (Finset.mem_univ μ) hμ
  -- Step 3: `ε x = -η_T x`
  have hstep3 : epsilon M * x = (-F.eta T) • x := by
    calc epsilon M * x = (epsilon M * F.cre μ) * F.Qproj T := by rw [hx, mul_assoc]
      _ = -(F.cre μ * (epsilon M * F.Qproj T)) := by
          rw [F.epsilon_anticomm_cre μ, neg_mul, mul_assoc]
      _ = -(F.cre μ * (F.eta T • F.Qproj T)) := by rw [F.epsilon_mul_Qproj T]
      _ = (-F.eta T) • x := by rw [hx, mul_smul_comm, neg_smul]
  -- 一方 `ε x = η_{T∪{μ}} x`
  have hother : epsilon M * x = F.eta (insert μ T) • x := by
    calc epsilon M * x = epsilon M * (F.Qproj (insert μ T) * x) := by rw [hstep2]
      _ = (epsilon M * F.Qproj (insert μ T)) * x := by rw [mul_assoc]
      _ = (F.eta (insert μ T) • F.Qproj (insert μ T)) * x := by rw [F.epsilon_mul_Qproj]
      _ = F.eta (insert μ T) • (F.Qproj (insert μ T) * x) := by rw [smul_mul_assoc]
      _ = F.eta (insert μ T) • x := by rw [hstep2]
  exact smul_cancel_of_matrix_ne_zero hx0 (hother.symm.trans hstep3)

/-! ## 原文 (3): `η_ε = η_{(1,…,1)}(-1)^{M-|ε|}` -/

theorem eta_univ_eq_aux (n : ℕ) :
    ∀ T : Finset (Fin M), Tᶜ.card = n → F.eta Finset.univ = (-1 : ℂ) ^ n * F.eta T := by
  induction n with
  | zero =>
      intro T hT
      have : T = Finset.univ := by
        have := Finset.card_eq_zero.1 hT
        have h2 : Tᶜᶜ = (∅ : Finset (Fin M))ᶜ := by rw [this]
        simpa using h2
      rw [this]; ring
  | succ n ih =>
      intro T hT
      obtain ⟨μ, hμ⟩ : ∃ μ, μ ∈ Tᶜ := Finset.card_pos.1 (by omega)
      have hμT : μ ∉ T := Finset.mem_compl.1 hμ
      have hcard : (insert μ T)ᶜ.card = n := by
        rw [Finset.compl_insert, Finset.card_erase_of_mem hμ, hT]
        omega
      have h1 := ih (insert μ T) hcard
      rw [h1, F.eta_insert hμT]
      ring

/-- **原文 (3)**: `η_ε = η_{(1,…,1)}(-1)^{M-|ε|}`（`(-1)^{-k} = (-1)^k` に注意）。 -/
theorem eta_eq_eta_univ_mul (T : Finset (Fin M)) :
    F.eta T = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by
  have hcompl : Tᶜ.card = M - T.card := by
    rw [Finset.card_compl]
    simp
  have h := F.eta_univ_eq_aux Tᶜ.card T rfl
  rw [hcompl] at h
  have hsq : ((-1 : ℂ) ^ (M - T.card)) * ((-1 : ℂ) ^ (M - T.card)) = 1 := by
    rw [← pow_add, ← two_mul, pow_mul]
    norm_num
  calc F.eta T = 1 * F.eta T := (one_mul _).symm
    _ = (((-1 : ℂ) ^ (M - T.card)) * ((-1 : ℂ) ^ (M - T.card))) * F.eta T := by rw [hsq]
    _ = ((-1 : ℂ) ^ (M - T.card)) * (((-1 : ℂ) ^ (M - T.card)) * F.eta T) := by ring
    _ = ((-1 : ℂ) ^ (M - T.card)) * F.eta Finset.univ := by rw [← h]
    _ = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by ring

/-! ## 原文 (4): `ε` はパリティ演算子 -/

/-- 原文の `∏_{μ}(I - 2ň_μ)`（因子は互いに可換なので `Finset.noncommProd` で書く）。 -/
noncomputable def parityFactor (i : Fin M) : TensorPow M := 1 - (2 : ℂ) • F.nOp i

theorem commute_parityFactor (i j : Fin M) : Commute (F.parityFactor i) (F.parityFactor j) := by
  unfold parityFactor
  exact Commute.sub_right (Commute.sub_left (Commute.one_left _)
      (Commute.smul_left (Commute.one_right _) 2))
    (Commute.smul_right (Commute.sub_left (Commute.one_left _)
      ((F.commute_nOp_nOp i j).smul_left 2)) 2)

/-- 原文の `∏_{μ=1}^{M}(I - 2ň_μ)`。 -/
noncomputable def parityProd : TensorPow M :=
  Finset.univ.noncommProd F.parityFactor fun i _ j _ _ => F.commute_parityFactor i j

theorem parityFactor_mul_Qproj (i : Fin M) (T : Finset (Fin M)) :
    F.parityFactor i * F.Qproj T = (if i ∈ T then (-1 : ℂ) else 1) • F.Qproj T := by
  rw [parityFactor, sub_mul, one_mul, smul_mul_assoc, F.nOp_mul_Qproj i T, smul_smul]
  by_cases h : i ∈ T <;> simp [h] <;> module

theorem parityProd_mul_Qproj (T : Finset (Fin M)) :
    F.parityProd * F.Qproj T = (-1 : ℂ) ^ T.card • F.Qproj T := by
  have key := NecSuf.noncommProd_mul_of_mul_eq_smul (𝕜 := ℂ) F.parityFactor
    F.commute_parityFactor (F.Qproj T)
    (fun i => if i ∈ T then (-1 : ℂ) else 1) (fun i => F.parityFactor_mul_Qproj i T) Finset.univ
  rw [parityProd, key]
  congr 1
  rw [← Finset.prod_filter_mul_prod_filter_not Finset.univ (fun i => i ∈ T)]
  have h1 : (Finset.univ.filter fun i : Fin M => i ∈ T) = T := by
    ext i; simp
  have h2 : ∀ i ∈ Finset.univ.filter fun i : Fin M => ¬ i ∈ T,
      (if i ∈ T then (-1 : ℂ) else 1) = 1 := by
    intro i hi
    rw [if_neg (Finset.mem_filter.1 hi).2]
  rw [h1, Finset.prod_congr rfl h2, Finset.prod_const_one, mul_one]
  rw [Finset.prod_congr rfl (fun i hi => if_pos hi), Finset.prod_const]

/-- 全部の `Q̌_ε` に右から掛けて一致すれば行列として一致する（`∑_ε Q̌_ε = I`）。 -/
theorem eq_of_mul_Qproj_eq {A B : TensorPow M}
    (h : ∀ T : Finset (Fin M), A * F.Qproj T = B * F.Qproj T) : A = B := by
  have hs : A * (∑ T : Finset (Fin M), F.Qproj T) = B * (∑ T : Finset (Fin M), F.Qproj T) := by
    rw [Finset.mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun T _ => h T
  rwa [F.sum_Qproj, mul_one, mul_one] at hs

/-- **原文 (4)**: `ε = η_{(1,…,1)}(-1)^M ∏_{μ}(I - 2ň_μ)`。 -/
theorem epsilon_eq_parityProd :
    epsilon M = (F.eta Finset.univ * (-1 : ℂ) ^ M) • F.parityProd := by
  refine F.eq_of_mul_Qproj_eq fun T => ?_
  rw [F.epsilon_mul_Qproj T, smul_mul_assoc, F.parityProd_mul_Qproj T, smul_smul,
    F.eta_eq_eta_univ_mul T]
  congr 1
  have hle : T.card ≤ M := by
    have := Finset.card_le_card (Finset.subset_univ T)
    simpa using this
  have : (-1 : ℂ) ^ (M - T.card) * ((-1 : ℂ) ^ T.card * (-1 : ℂ) ^ T.card)
      = (-1 : ℂ) ^ (M - T.card) := by
    rw [← pow_add, ← two_mul, pow_mul]
    norm_num
  calc F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card)
      = F.eta Finset.univ * ((-1 : ℂ) ^ (M - T.card) * ((-1 : ℂ) ^ T.card * (-1) ^ T.card)) := by
        rw [this]
    _ = F.eta Finset.univ * ((-1 : ℂ) ^ (M - T.card) * (-1 : ℂ) ^ T.card) * (-1 : ℂ) ^ T.card := by
        ring
    _ = F.eta Finset.univ * (-1 : ℂ) ^ M * (-1 : ℂ) ^ T.card := by
        rw [← pow_add]
        congr 3
        omega

end CheckFermi

end Ising2D
