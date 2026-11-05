/-
# `ε Q̌_ε = η_ε Q̌_ε` と符号の反転則（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_002_claim_epsilon_eigenvalue_on_check_Q`、ラベル **`epsilon_eigenvalue_on_check_Q`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル。(2) の冒頭・Step 1・Step 2 の後半・Step 3 の数ベクトルの鎖は
`Ising2D/NecSuf/SignReversalOnGeneratorVector.lean`、(3) の帰納法は `Ising2D/NecSuf/SignAfterReplacingComponents.lean`、(4) の前半は `Ising2D/NecSuf/FactorsActingAsScalarsOnProjection.lean`）。符号の反転則 (2) の具体版 `eta_insert` は人手と同じ数ベクトルの鎖で組み、
同じ組み方で冒頭の `εq = η_ε q`・Step 1〜3 の鎖を必要十分版の特殊化に替えたものが `eta_insert_of_necSuf` である
（`q` を取る段・`Q̌_ε q = q`・`M = 1`・最後に約す段は具体版と共通）。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `∃! η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε` | `Ising2D.CheckFermi.eta` / `eta_mem` / `epsilon_mul_Qproj` / `eta_unique` |
| (1) の鎖: `Q̌_ε q = q`（4 行）・`Q̌_ε(εq) = εq`（4 行）・`q = (ηη)q`（7 行）・`(ηη − 1)q = O`（4 行）・`(η − 1)(η + 1) = 0`（4 行）・`(εQ̌_ε)x = (ηQ̌_ε)x`（9 行）・列ごとの `εQ̌_ε = ηQ̌_ε`（7 行）・一意性（6 行） | `exists_eta_with_generator`・`Qproj_mulVec_generator`・`Qproj_mulVec_epsilon_mulVec_generator`・`generator_eq_eta_mul_eta_smul`・`eta_mul_eta_sub_one_smul_generator`・`eta_mem_of_mul_self_sub_one`・`epsilon_mul_Qproj_mulVec`・`epsilon_mul_Qproj_eq_smul_of_mulVec`・`smul_generator_eq_eta_smul`（各 calc が人手の鎖と同じ行。`mat_mult_associative` の行は、Lean の数ベクトルが 1 列の行列でないので mathlib の `Matrix.mulVec_mulVec`） |
| (2) の冒頭: `im Q̌_ε` の `0` でない元 `q` を取り、冪等性で `Q̌_ε q = q`、5 行の鎖で `εq = η_ε q` | `eta_insert` の冒頭（`q` は `exists_ne_zero_mem_range_Qproj` の `q = Q̌_ε x`。1 次元性は使わない）・`Qproj_mulVec_generator`・`epsilon_mulVec_generator_eq_eta_smul` |
| (2) Step 1: `ň_μ q = 0`（6 行）・`ψ̌_{M+1−μ}(ψ̌_μ^† q) = q`（6 行）・背理法（3 行）で `ψ̌_μ^† q ≠ 0` | `nOp_mulVec_generator_eq_zero`・`ann_mulVec_cre_mulVec_generator`・`cre_mulVec_generator_ne_zero` |
| (2) Step 2 の前半: `ň_μψ̌_μ^† = ψ̌_μ^†`（13 行）・`A_μ^ε = I − ň_μ`・`A_μ^{ε'} = ň_μ`（8 行ずつ）・`ν ≠ μ` で `A_ν^{ε'} = A_ν^ε`・`XA_ν^δ = A_ν^δX`（3 式と 5 行）と、その `X → ň_κ`・`X → A_κ^δ`・`X → ψ̌_μ^†` | `nOp_mul_cre`・`defFactor_of_notMem`・`defFactor_of_mem`・`defFactor_insert_of_ne`・`commute_defFactor_of_commute`・`nOp_mul_defFactor`・`defFactor_mul_defFactor`・`cre_mul_defFactor_of_ne`（必要十分版の特殊化は `nOp_mul_cre_of_necSuf`（`NecSuf.num_mul_cre'`）・`commute_defFactor_of_commute_of_necSuf`（`NecSuf.commute_defFactor_of_commute'`）） |
| (2) Step 2 の後半: `Π' := ∏_{ν≠μ}A_ν` と `ψ̌_μ^†Π' = Π'ψ̌_μ^†`、`A_μ^ε q = q`（5 行）・`Π'q = q`（5 行）・`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`（10 行）の 3 本の鎖 | `cre_mul_omittingDefFactor`・`defFactor_mulVec_generator_of_notMem`・`omittingDefFactor_mulVec_generator`・`omittingDefFactor_insert`・`Qproj_insert_mulVec_cre_mulVec_generator`（`Π'` は `NecSuf.finProdLeftOmitting r μ (F.defFactor T)`、人手の `M_col` が Lean の `r + 2`。必要十分版の特殊化は `*_of_necSuf`） |
| (2) Step 3 の前半: `ε(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`（9 行） | `epsilon_mulVec_cre_mulVec_generator` |
| (2) Step 3 の後半: `η_{ε'}(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`（6 行） | `eta_insert_smul_cre_mulVec_generator` |
| (2) `ψ̌_μ^† q ≠ 0` の 0 でない成分を比べて `η_{ε[μ→1]} = -η_ε` | `Ising2D.CheckFermi.eta_insert`（`smul_generator_cancel`。Step 2 は `M` を限らない形 `Qproj_insert_mulVec_cre_mulVec_of_notMem` で受け、人手の範囲外の `M = 1` は `Qproj_insert_mulVec_cre_mulVec_generator_one`） |
| (3) `η_ε = η_{(1,…,1)}(-1)^{M-\|ε\|}`: `k := M_col − \|ε\|` の帰納法（`k = 0` の 4 行、`k ≥ 1` で `ε_μ = 0` の `μ` を取り、(2) の両辺に `−1` を掛けた `η_ε = −η_{ε'}` から始まる 7 行の鎖） | `Ising2D.CheckFermi.eta_eq_eta_univ_mul`・`eta_eq_eta_univ_mul_of_sub_card`・`eta_eq_neg_eta_insert`（必要十分版の特殊化は `eta_eq_eta_univ_mul_of_necSuf`・`eta_eq_neg_eta_insert_of_necSuf`） |
| (4) の前半: `(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε`（10 行）・`P_kQ̌_ε = p_kQ̌_ε` の `k` の帰納法（`k = 1` と `k → k+1` の 8 行）・`p_{M_col} = (−1)^{\|ε\|}` | `parityFactor_mul_Qproj`・`finProdLeft_mul_Qproj`（人手の鎖と同じ行の calc。`P_k` は左から掛ける有限積 `NecSuf.finProdLeft`）・`prod_one_sub_two_mul_indicator`・`parityProd_mul_Qproj`（必要十分版の特殊化は `*_of_necSuf`） |
| (4) `ε = η_{(1,…,1)}(-1)^M ∏(I - 2ň_μ)` | `Ising2D.CheckFermi.epsilon_eq_parityProd`（後半の 7 行・9 行の鎖はまだ人手と 1 対 1 でない） |

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
import Ising2D.NecSuf.SignAfterReplacingComponents
import Ising2D.NecSuf.FactorsActingAsScalarsOnProjection
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesOmittingOneIndexFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteProductsOfCommutingMatricesFromNecSuf

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

/-! 人手の (2) は `im Q̌_ε` の `0` でない元 `q`（`Q̌_ε q = q`、`εq = η_ε q`。下の `eta_insert` の冒頭で取る）の上で計算する。
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

/-! 人手の (2) Step 2 の前半: `ň_μψ̌_μ^† = ψ̌_μ^†`（13 行）、`Q̌_δ` の因子 `A_ν^δ := δ_νň_ν + (1 − δ_ν)(I − ň_ν)`
（Lean の `defFactor`。`δ ∈ {ε, ε'}` の `ε` は Lean の `T`、`ε' := ε[μ→1]` は `insert μ T`）の値 `A_μ^ε = I − ň_μ`・
`A_μ^{ε'} = ň_μ`（8 行ずつ）と `ν ≠ μ` での `A_ν^{ε'} = A_ν^ε`、可換性 `XA_ν^δ = A_ν^δX`（5 行）とその 3 つの使い方である。
`mat_mult_associative` の行は (1) と同じく mathlib で受ける（(1) の数ベクトルの行は `Matrix.mulVec_mulVec`、ここは行列どうしの積なので `mul_assoc`）。 -/

/-- **原文 (2) Step 2 冒頭**の `ň_μψ̌_μ^† = ψ̌_μ^†` の 13 行の鎖。 -/
theorem nOp_mul_cre (μ : Fin M) : F.nOp μ * F.cre μ = F.cre μ :=
  calc F.nOp μ * F.cre μ
      = (F.cre μ * F.ann μ) * F.cre μ := rfl            -- `def_check_number_operator`
    _ = F.cre μ * (F.ann μ * F.cre μ) := mul_assoc _ _ _
                                                        -- `mat_mult_associative`
    _ = F.cre μ * (1 - F.nOp μ) := by rw [F.ann_mul_cre μ]
                                                        -- `check_number_operator_idempotent` (2)
    _ = F.cre μ * (1 + -F.nOp μ) := by rw [sub_eq_add_neg_tensorPow (1 : TensorPow M) (F.nOp μ)]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.cre μ * 1 + F.cre μ * (-F.nOp μ) := mul_add_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = F.cre μ * 1 + -(F.cre μ * F.nOp μ) := by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor`
    _ = F.cre μ * 1 - F.cre μ * F.nOp μ := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.cre μ - F.cre μ * F.nOp μ := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = F.cre μ - F.cre μ * (F.cre μ * F.ann μ) := rfl  -- `def_check_number_operator`
    _ = F.cre μ - (F.cre μ * F.cre μ) * F.ann μ := by rw [mul_assoc]
                                                        -- `mat_mult_associative`
    _ = F.cre μ - 0 * F.ann μ := by rw [F.cre_sq μ]     -- `check_number_operator_idempotent` (1) の `(ψ̌_μ^†)^2 = O`
    _ = F.cre μ - 0 := by rw [zero_matrix_mul_tensorPow]
                                                        -- `zero_matrix_is_left_zero_of_mat_mult`
    _ = F.cre μ := matrix_sub_zero_matrix_tensorPow _   -- `matrix_minus_zero_matrix`

/-- 上の 13 行の鎖が、同じ行の必要十分版 `NecSuf.num_mul_cre'` の特殊化として得られること。 -/
theorem nOp_mul_cre_of_necSuf (μ : Fin M) : F.nOp μ * F.cre μ = F.cre μ :=
  NecSuf.num_mul_cre' (fun x y => sub_eq_add_neg x y) (fun x => zero_mul x) (fun x => sub_zero x) F.cre F.ann μ
    (F.ann_mul_cre μ) (F.cre_sq μ)

/-- **原文 (2) Step 2** の `A_μ^ε = I − ň_μ` の 8 行の鎖（`ε_μ = 0`、すなわち `μ ∉ T`）。 -/
theorem defFactor_of_notMem {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.defFactor T μ = 1 - F.nOp μ :=
  calc F.defFactor T μ
      = (0 : ℂ) • F.nOp μ + ((1 : ℂ) - 0) • (1 - F.nOp μ) := by
        rw [defFactor, if_neg hμ]                       -- `ε_μ = 0`
    _ = (0 : ℂ) • F.nOp μ + ((1 : ℂ) + -0) • (1 - F.nOp μ) := by
        rw [sub_eq_add_neg (1 : ℂ) 0]                   -- `def_complex_difference`
    _ = (0 : ℂ) • F.nOp μ + ((1 : ℂ) + (-1) * 0) • (1 - F.nOp μ) :=
        congrArg (fun c : ℂ => (0 : ℂ) • F.nOp μ + ((1 : ℂ) + c) • (1 - F.nOp μ)) (neg_one_mul (0 : ℂ)).symm
                                                        -- `multiply_by_minus_one`
    _ = (0 : ℂ) • F.nOp μ + ((1 : ℂ) + 0) • (1 - F.nOp μ) := by
        rw [mul_zero (-1 : ℂ)]                          -- `complex_times_zero_is_zero`
    _ = (0 : ℂ) • F.nOp μ + (1 : ℂ) • (1 - F.nOp μ) := by
        rw [add_zero (1 : ℂ)]                           -- `complex_numbers_form_a_field` の加法の単位元
    _ = 0 + (1 : ℂ) • (1 - F.nOp μ) := by
        rw [zero_smul_tensorPow]                        -- `zero_scalar_multiple_is_zero_matrix`
    _ = 0 + (1 - F.nOp μ) := by
        rw [one_smul_tensorPow]                         -- `scalar_multiple_by_one`
    _ = 1 - F.nOp μ := zero_matrix_add_matrix_tensorPow _
                                                        -- `zero_matrix_plus_matrix`

/-- **原文 (2) Step 2** の `A_μ^{ε'} = ň_μ` の 8 行の鎖（`ε'_μ = 1`、すなわち `μ ∈ T'`。使うのは `T' = insert μ T`）。 -/
theorem defFactor_of_mem {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∈ T) :
    F.defFactor T μ = F.nOp μ :=
  calc F.defFactor T μ
      = (1 : ℂ) • F.nOp μ + ((1 : ℂ) - 1) • (1 - F.nOp μ) := by
        rw [defFactor, if_pos hμ]                       -- `ε'_μ = 1`
    _ = (1 : ℂ) • F.nOp μ + ((1 : ℂ) + -1) • (1 - F.nOp μ) := by
        rw [sub_eq_add_neg (1 : ℂ) 1]                   -- `def_complex_difference`
                                                        -- （人手の `−(1_ℂ)`。Lean では定数 `−1_ℂ` と同じ項 `-1` で、次の 2 段で同じ項 `-1` へ戻る）
    _ = (1 : ℂ) • F.nOp μ + ((1 : ℂ) + (-1) * 1) • (1 - F.nOp μ) :=
        congrArg (fun c : ℂ => (1 : ℂ) • F.nOp μ + ((1 : ℂ) + c) • (1 - F.nOp μ)) (neg_one_mul (1 : ℂ)).symm
                                                        -- `multiply_by_minus_one`
    _ = (1 : ℂ) • F.nOp μ + ((1 : ℂ) + -1) • (1 - F.nOp μ) := by
        rw [mul_one (-1 : ℂ)]                           -- `complex_numbers_form_a_field` の乗法の単位元
    _ = (1 : ℂ) • F.nOp μ + (0 : ℂ) • (1 - F.nOp μ) := by
        rw [add_neg_cancel (1 : ℂ)]                     -- `complex_numbers_form_a_field` の加法の逆元
    _ = F.nOp μ + (0 : ℂ) • (1 - F.nOp μ) := by
        rw [one_smul_tensorPow]                         -- `scalar_multiple_by_one`
    _ = F.nOp μ + 0 := by
        rw [zero_smul_tensorPow]                        -- `zero_scalar_multiple_is_zero_matrix`
    _ = F.nOp μ := matrix_add_zero_matrix_tensorPow _  -- `matrix_plus_zero_matrix`

/-- **原文 (2) Step 2** の「`ν ≠ μ` では `ε'_ν = ε_ν` なので `A_ν^{ε'} = A_ν^ε`」（`ε' = ε[μ→1]` は `insert μ T`）。 -/
theorem defFactor_insert_of_ne (T : Finset (Fin M)) {μ ν : Fin M} (hν : ν ≠ μ) :
    F.defFactor (insert μ T) ν = F.defFactor T ν := by
  have h : (ν ∈ insert μ T) = (ν ∈ T) := propext (by rw [Finset.mem_insert]; exact or_iff_right hν)
                                                        -- `ε'_ν = ε_ν`（`ε[μ→1]` の定義）
  simp only [defFactor, h]

/-- **原文 (2) Step 2** の可換性: `Xň_ν = ň_νX` なら `XA_ν^δ = A_ν^δX`。前半の 3 式（`have` の `h1`・`h2`・`h3`。
`XI = X = IX` は `hI`）と 5 行の鎖である。 -/
theorem commute_defFactor_of_commute (T : Finset (Fin M)) (ν : Fin M) {X : TensorPow M}
    (hn : X * F.nOp ν = F.nOp ν * X) : X * F.defFactor T ν = F.defFactor T ν * X := by
  have hI : X * 1 = 1 * X :=
    calc X * 1 = X := mul_identity_matrix_tensorPow _   -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = 1 * X := (identity_matrix_mul_tensorPow _).symm
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
  have h1 : X * (1 - F.nOp ν) = (1 - F.nOp ν) * X :=
    mul_sub_eq_sub_mul_of_commute_tensorPow _ _ _ hI hn
                                                        -- `commuting_with_difference`
  have h2 : X * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν)
      = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν) * X :=
    mul_smul_comm_of_commute_tensorPow _ _ _ hn         -- `commuting_with_scalar_multiple`（`c → δ_ν`）
  have h3 : X * ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν))
      = ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * X :=
    mul_smul_comm_of_commute_tensorPow _ _ _ h1         -- `commuting_with_scalar_multiple`（`c → 1 − δ_ν`）
  calc X * F.defFactor T ν
      = X * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν
          + (1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) := rfl
                                                        -- `A_ν^δ` の置き方
    _ = X * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν)
          + X * ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) :=
        mul_add_matrix_tensorPow _ _ _                  -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν) * X
          + ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * X := by
        rw [h2, h3]                                     -- 上の 2 式
    _ = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν
          + (1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * X :=
        (add_mul_matrix_tensorPow _ _ _).symm           -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = F.defFactor T ν * X := rfl                      -- `A_ν^δ` の置き方

/-- 上の可換性が、同じ並びの必要十分版 `NecSuf.commute_defFactor_of_commute'` の特殊化として得られること。 -/
theorem commute_defFactor_of_commute_of_necSuf (T : Finset (Fin M)) (ν : Fin M) {X : TensorPow M}
    (hn : X * F.nOp ν = F.nOp ν * X) : X * F.defFactor T ν = F.defFactor T ν * X :=
  NecSuf.commute_defFactor_of_commute' (fun x y => sub_eq_add_neg x y) hn _ _

/-- **原文 (2) Step 2**: 可換性を `X → ň_κ` に使う（`check_number_operators_commute` (2)。`κ = ν` では両辺が同じ積 `ň_νň_ν`）。 -/
theorem nOp_mul_defFactor (T : Finset (Fin M)) (κ ν : Fin M) :
    F.nOp κ * F.defFactor T ν = F.defFactor T ν * F.nOp κ :=
  F.commute_defFactor_of_commute T ν (F.commute_nOp_nOp κ ν).eq

/-- **原文 (2) Step 2** の因子の可換性: 可換性を `X → A_κ^δ` に使う（仮定 `A_κ^δň_ν = ň_νA_κ^δ` は上の式の左右を入れ替えたもの）。 -/
theorem defFactor_mul_defFactor (T : Finset (Fin M)) (κ ν : Fin M) :
    F.defFactor T κ * F.defFactor T ν = F.defFactor T ν * F.defFactor T κ :=
  F.commute_defFactor_of_commute T ν (F.nOp_mul_defFactor T ν κ).symm

/-- **原文 (2) Step 2**: `ν ≠ μ` なら可換性を `X → ψ̌_μ^†` に使う（`check_number_operators_commute` (1) の `ψ̌_μ^†ň_ν = ň_νψ̌_μ^†`）。 -/
theorem cre_mul_defFactor_of_ne (T : Finset (Fin M)) {μ ν : Fin M} (hν : ν ≠ μ) :
    F.cre μ * F.defFactor T ν = F.defFactor T ν * F.cre μ :=
  F.commute_defFactor_of_commute T ν (F.commute_cre_nOp (Ne.symm hν)).eq

/-! 人手の (2) Step 2 の後半: `Π' := ∏_{ν≠μ}A_ν`（`def_finite_product_of_matrices_omitting_one_index`（`r → M_col`、`ν → μ`）。
Lean は `NecSuf.finProdLeftOmitting r μ (F.defFactor T)`。人手の `M_col ∈ ℤ_{≥2}` が Lean の `r + 2` で、人手の添字は 1 始まり、Lean の `Fin` は 0 始まりである。
Lean の `μ` は人手の `μ` から 1 を引いた値である。人手の `A_j` は Lean の `A (j − 1)` である。人手の `s(j)` は Lean の `μ.succAbove (j − 1)` に 1 を足した値である）と、
`ψ̌_μ^†Π' = Π'ψ̌_μ^†`、`A_μ^ε q = q`（5 行）・`Π'q = q`（5 行）・`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`（10 行）である。
人手の `Q̌_δ = ∏_{ν=1}^{M_col}A_ν^δ`（`Q̌_δ` の定義）は、Lean の `Qproj` の定義とつなぐ等式 `Qproj_eq_finProdLeft_defFactor` で受ける。
`Π'` は `δ = ε` の因子で作る（人手の `A_ν` は `ν ≠ μ` での `A_ν^{ε'} = A_ν^ε` の共通の値）。 -/

/-- **原文 (2) Step 2**: `ψ̌_μ^†Π' = Π'ψ̌_μ^†`。`matrix_commuting_with_each_factor_commutes_with_finite_product`
（`X → ψ̌_μ^†`、`A_j → A_{s(j)}`。`s(j) ≠ μ` なので仮定は上の `ψ̌_μ^†A_ν = A_νψ̌_μ^†`（`ν → s(j)`））。 -/
theorem cre_mul_omittingDefFactor {r : ℕ} (F : CheckFermi (r + 2)) (T : Finset (Fin (r + 2))) (μ : Fin (r + 2)) :
    F.cre μ * NecSuf.finProdLeftOmitting r μ (F.defFactor T)
      = NecSuf.finProdLeftOmitting r μ (F.defFactor T) * F.cre μ :=
  commute_finProdLeft_tensorPow r (F.cre μ) (fun j => F.defFactor T (μ.succAbove j))
    (fun j => F.cre_mul_defFactor_of_ne T (Fin.succAbove_ne μ j))

/-- **原文 (2) Step 2** の `A_μ^ε q = q` の 5 行の鎖（`ε_μ = 0`、すなわち `μ ∉ T`。`ň_μ q = 0` は Step 1 の鎖）。 -/
theorem defFactor_mulVec_generator_of_notMem {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hn : F.nOp μ *ᵥ q = 0) : F.defFactor T μ *ᵥ q = q :=
  calc F.defFactor T μ *ᵥ q
      = (1 - F.nOp μ) *ᵥ q := by rw [F.defFactor_of_notMem hμ]
                                                        -- 上の `A_μ^ε = I − ň_μ`
    _ = (1 : TensorPow M) *ᵥ q - F.nOp μ *ᵥ q := (sub_mulVec_tensorPow _ _ _).symm
                                                        -- `matrix_difference_mul_vector`
    _ = q - F.nOp μ *ᵥ q := by rw [identity_matrix_mulVec_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = q - 0 := by rw [hn]                             -- Step 1 の `ň_μ q = 0`
    _ = q := sub_zero q                                 -- `matrix_minus_zero_matrix`

/-- **原文 (2) Step 2** の `Π'q = q` の 5 行の鎖。 -/
theorem omittingDefFactor_mulVec_generator {r : ℕ} (F : CheckFermi (r + 2)) {T : Finset (Fin (r + 2))}
    {μ : Fin (r + 2)} {q : Conf (r + 2) → ℂ} (hA : F.defFactor T μ *ᵥ q = q)
    (hqfix : F.Qproj T *ᵥ q = q) : NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q = q :=
  calc NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q
      = NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ (F.defFactor T μ *ᵥ q) := by rw [hA]
                                                        -- 上の `A_μ^ε q = q`
    _ = (NecSuf.finProdLeftOmitting r μ (F.defFactor T) * F.defFactor T μ) *ᵥ q :=
        Matrix.mulVec_mulVec _ _ _                      -- `mat_mult_associative`
    _ = NecSuf.finProdLeft (r + 1) (F.defFactor T) *ᵥ q := by
        rw [finProdLeft_eq_omitting_mul_tensorPow r μ (F.defFactor T)
          (fun j _ => F.defFactor_mul_defFactor T μ j)]
                                                        -- `moving_one_factor_of_finite_product_to_the_end` と因子の可換性
    _ = F.Qproj T *ᵥ q := by rw [Qproj_eq_finProdLeft_defFactor F T]
                                                        -- `Q̌_ε` の定義
    _ = q := hqfix                                      -- `Q̌_ε q = q`

/-- 人手の「`ν ≠ μ` で `A_ν^{ε'} = A_ν`」を `Π'` の全ての因子へ同時に使ったもの: `∏_{ν≠μ}A_ν^{ε'} = Π'`。 -/
theorem omittingDefFactor_insert {r : ℕ} (F : CheckFermi (r + 2)) (T : Finset (Fin (r + 2))) (μ : Fin (r + 2)) :
    NecSuf.finProdLeftOmitting r μ (F.defFactor (insert μ T))
      = NecSuf.finProdLeftOmitting r μ (F.defFactor T) :=
  congrArg (NecSuf.finProdLeft r) (funext fun j => F.defFactor_insert_of_ne T (Fin.succAbove_ne μ j))

/-- **原文 (2) Step 2** の `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q` の 10 行の鎖（`ε' := ε[μ→1]` は `insert μ T`）。 -/
theorem Qproj_insert_mulVec_cre_mulVec_generator {r : ℕ} (F : CheckFermi (r + 2)) {T : Finset (Fin (r + 2))}
    {μ : Fin (r + 2)} {q : Conf (r + 2) → ℂ}
    (hP : NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q = q) :
    F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q :=
  calc F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q)
      = NecSuf.finProdLeft (r + 1) (F.defFactor (insert μ T)) *ᵥ (F.cre μ *ᵥ q) := by
        rw [Qproj_eq_finProdLeft_defFactor F (insert μ T)]
                                                        -- `Q̌_{ε'}` の定義
    _ = (NecSuf.finProdLeftOmitting r μ (F.defFactor T) * F.defFactor (insert μ T) μ) *ᵥ (F.cre μ *ᵥ q) := by
        rw [finProdLeft_eq_omitting_mul_tensorPow r μ (F.defFactor (insert μ T))
          (fun j _ => F.defFactor_mul_defFactor (insert μ T) μ j), F.omittingDefFactor_insert T μ]
                                                        -- `moving_one_factor_of_finite_product_to_the_end` と因子の可換性、
                                                        -- `ν ≠ μ` で `A_ν^{ε'} = A_ν`
    _ = (NecSuf.finProdLeftOmitting r μ (F.defFactor T) * F.nOp μ) *ᵥ (F.cre μ *ᵥ q) := by
        rw [F.defFactor_of_mem (Finset.mem_insert_self μ T)]
                                                        -- 上の `A_μ^{ε'} = ň_μ`
    _ = NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ (F.nOp μ *ᵥ (F.cre μ *ᵥ q)) :=
        (Matrix.mulVec_mulVec _ _ _).symm               -- `mat_mult_associative`
    _ = NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ ((F.nOp μ * F.cre μ) *ᵥ q) := by
        rw [Matrix.mulVec_mulVec q (F.nOp μ) (F.cre μ)]                       -- `mat_mult_associative`
    _ = NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ (F.cre μ *ᵥ q) := by
        rw [F.nOp_mul_cre μ]                            -- Step 2 冒頭の `ň_μψ̌_μ^† = ψ̌_μ^†`
    _ = (NecSuf.finProdLeftOmitting r μ (F.defFactor T) * F.cre μ) *ᵥ q :=
        Matrix.mulVec_mulVec _ _ _                      -- `mat_mult_associative`
    _ = (F.cre μ * NecSuf.finProdLeftOmitting r μ (F.defFactor T)) *ᵥ q := by
        rw [F.cre_mul_omittingDefFactor T μ]            -- 上の `ψ̌_μ^†Π' = Π'ψ̌_μ^†`
    _ = F.cre μ *ᵥ (NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q) :=
        (Matrix.mulVec_mulVec _ _ _).symm               -- `mat_mult_associative`
    _ = F.cre μ *ᵥ q := by rw [hP]                      -- 上の `Π'q = q`

/-! 上の 3 本の鎖を必要十分版 `Ising2D/NecSuf/SignReversalOnGeneratorVector.lean`（係数 `ℂ`、添字 `Conf M`）の特殊化として得る。 -/

theorem defFactor_mulVec_generator_of_notMem_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hn : F.nOp μ *ᵥ q = 0) : F.defFactor T μ *ᵥ q = q :=
  NecSuf.mulVec_eq_of_eq_one_sub_of_mulVec_eq_zero (F.defFactor_of_notMem hμ) hn

theorem omittingDefFactor_mulVec_generator_of_necSuf {r : ℕ} (F : CheckFermi (r + 2)) {T : Finset (Fin (r + 2))}
    {μ : Fin (r + 2)} {q : Conf (r + 2) → ℂ} (hA : F.defFactor T μ *ᵥ q = q)
    (hqfix : F.Qproj T *ᵥ q = q) : NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q = q :=
  NecSuf.finProdLeftOmitting_mulVec_eq_of_fixed r μ (F.defFactor T)
    (fun j _ => F.defFactor_mul_defFactor T μ j) hA (by rw [← Qproj_eq_finProdLeft_defFactor F T]; exact hqfix)

theorem Qproj_insert_mulVec_cre_mulVec_generator_of_necSuf {r : ℕ} (F : CheckFermi (r + 2))
    {T : Finset (Fin (r + 2))} {μ : Fin (r + 2)} {q : Conf (r + 2) → ℂ}
    (hP : NecSuf.finProdLeftOmitting r μ (F.defFactor T) *ᵥ q = q) :
    F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q := by
  rw [Qproj_eq_finProdLeft_defFactor F (insert μ T)]
  exact NecSuf.finProdLeft_mulVec_cre_mulVec_eq_of_omitting_mulVec_eq r μ (F.defFactor (insert μ T))
    (F.defFactor T) (fun j _ => F.defFactor_mul_defFactor (insert μ T) μ j)
    (fun j => F.defFactor_insert_of_ne T (Fin.succAbove_ne μ j))
    (F.defFactor_of_mem (Finset.mem_insert_self μ T)) (F.nOp_mul_cre μ) (F.cre_mul_omittingDefFactor T μ) hP

/-! 人手の (2) の冒頭の `εq = η_ε q`（5 行）と Step 3 の後半（6 行）。 -/

/-- **原文 (2) の冒頭**の `εq = η_ε q` の 5 行の鎖（`Q̌_ε q = q` は冪等性から）。 -/
theorem epsilon_mulVec_generator_eq_eta_smul {T : Finset (Fin M)} {q : Conf M → ℂ}
    (hqfix : F.Qproj T *ᵥ q = q) : epsilon M *ᵥ q = F.eta T • q :=
  calc epsilon M *ᵥ q
      = epsilon M *ᵥ (F.Qproj T *ᵥ q) := by rw [hqfix]  -- `Q̌_ε q = q`
    _ = (epsilon M * F.Qproj T) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = (F.eta T • F.Qproj T) *ᵥ q := by rw [F.epsilon_mul_Qproj T]
                                                        -- (1)
    _ = F.eta T • (F.Qproj T *ᵥ q) := smul_mulVec_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_left_factor`
    _ = F.eta T • q := by rw [hqfix]                    -- `Q̌_ε q = q`

/-- **原文 (2) Step 3** の後半: (1) を `ε' := ε[μ→1]`（Lean の `insert μ T`）に使った
`η_{ε'}(ψ̌_μ^† q) = (−η)(ψ̌_μ^† q)` の 6 行の鎖（最後の行の「上の式変形」は Step 3 の前半 `epsilon_mulVec_cre_mulVec_generator`）。 -/
theorem eta_insert_smul_cre_mulVec_generator {T : Finset (Fin M)} {μ : Fin M} {q : Conf M → ℂ} {η : ℂ}
    (h2 : F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q)
    (h3 : epsilon M *ᵥ (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q)) :
    F.eta (insert μ T) • (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q) :=
  calc F.eta (insert μ T) • (F.cre μ *ᵥ q)
      = F.eta (insert μ T) • (F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q)) := by rw [h2]
                                                        -- Step 2 の `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`
    _ = (F.eta (insert μ T) • F.Qproj (insert μ T)) *ᵥ (F.cre μ *ᵥ q) :=
        (smul_mulVec_tensorPow _ _ _).symm              -- `scalar_multiple_factors_out_of_left_factor`
    _ = (epsilon M * F.Qproj (insert μ T)) *ᵥ (F.cre μ *ᵥ q) := by rw [F.epsilon_mul_Qproj]
                                                        -- (1) の `εQ̌_{ε'} = η_{ε'}Q̌_{ε'}`
    _ = epsilon M *ᵥ (F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q)) := (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = epsilon M *ᵥ (F.cre μ *ᵥ q) := by rw [h2]       -- Step 2 の `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`
    _ = (-η) • (F.cre μ *ᵥ q) := h3                     -- 上の式変形

/-- `epsilon_mulVec_generator_eq_eta_smul` を `NecSuf.mulVec_eq_smul_of_fixed_of_mul_eq_smul` の特殊化として。 -/
theorem epsilon_mulVec_generator_eq_eta_smul_of_necSuf {T : Finset (Fin M)} {q : Conf M → ℂ}
    (hqfix : F.Qproj T *ᵥ q = q) : epsilon M *ᵥ q = F.eta T • q :=
  NecSuf.mulVec_eq_smul_of_fixed_of_mul_eq_smul hqfix (F.epsilon_mul_Qproj T)

/-- `eta_insert_smul_cre_mulVec_generator` を `NecSuf.smul_eq_of_fixed_of_mul_eq_smul` の特殊化として。 -/
theorem eta_insert_smul_cre_mulVec_generator_of_necSuf {T : Finset (Fin M)} {μ : Fin M} {q : Conf M → ℂ}
    {η : ℂ} (h2 : F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q)
    (h3 : epsilon M *ᵥ (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q)) :
    F.eta (insert μ T) • (F.cre μ *ᵥ q) = (-η) • (F.cre μ *ᵥ q) :=
  NecSuf.smul_eq_of_fixed_of_mul_eq_smul h2 (F.epsilon_mul_Qproj (insert μ T)) h3

/-- `M = 1` の `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`。**人手証明の範囲外**: 人手の (2) は `M_col ∈ ℤ_{≥2}` の下で述べ
（`epsilon_anticommutes_with_check_Z_Y` の仮定）、Step 2 の `Π'`（`def_finite_product_of_matrices_omitting_one_index`）も
`M_col ≥ 2` を要する。Lean の (2)・(3)・(4) は `M` を限らずに述べてきたので、`M = 1` だけを、`Π'` が因子を持たない場合の
10 行の鎖の縮めた形（`Q̌_{ε'}` は因子 `A_μ^{ε'}` 1 つ、`A_μ^{ε'} = ň_μ`、`ň_μψ̌_μ^† = ψ̌_μ^†`）で埋める。 -/
theorem Qproj_insert_mulVec_cre_mulVec_generator_one (F : CheckFermi 1) (T : Finset (Fin 1)) (μ : Fin 1)
    (q : Conf 1 → ℂ) : F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q :=
  calc F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q)
      = NecSuf.finProdLeft 0 (F.defFactor (insert μ T)) *ᵥ (F.cre μ *ᵥ q) := by
        rw [Qproj_eq_finProdLeft_defFactor F (insert μ T)]
                                                        -- `Q̌_{ε'}` の定義
    _ = F.defFactor (insert μ T) μ *ᵥ (F.cre μ *ᵥ q) := by rw [Subsingleton.elim μ 0]; rfl
                                                        -- 因子 1 つの有限積（`Fin 1` の元は `μ` だけ）
    _ = F.nOp μ *ᵥ (F.cre μ *ᵥ q) := by rw [F.defFactor_of_mem (Finset.mem_insert_self μ T)]
                                                        -- `A_μ^{ε'} = ň_μ`
    _ = (F.nOp μ * F.cre μ) *ᵥ q := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`
    _ = F.cre μ *ᵥ q := by rw [F.nOp_mul_cre μ]          -- Step 2 冒頭の `ň_μψ̌_μ^† = ψ̌_μ^†`

/-- **原文 (2) Step 2** の結論を `M` を限らずに述べたもの: `μ ∉ T`・`Q̌_ε q = q` なら `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`。
`M = r + 2`（人手の `M_col ≥ 2`）では人手の 3 本の鎖（`defFactor_mulVec_generator_of_notMem`・`omittingDefFactor_mulVec_generator`・
`Qproj_insert_mulVec_cre_mulVec_generator`。`ň_μ q = 0` は Step 1 の鎖）、`M = 1` は上の人手の範囲外の補題、`M = 0` は `μ` が無い。 -/
theorem Qproj_insert_mulVec_cre_mulVec_of_notMem {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hqfix : F.Qproj T *ᵥ q = q) :
    F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q := by
  have hn := F.nOp_mulVec_generator_eq_zero hμ hqfix   -- Step 1 の `ň_μ q = 0`
  rcases M with _ | _ | r
  · exact μ.elim0
  · exact Qproj_insert_mulVec_cre_mulVec_generator_one F T μ q
  · exact F.Qproj_insert_mulVec_cre_mulVec_generator
      (F.omittingDefFactor_mulVec_generator (F.defFactor_mulVec_generator_of_notMem hμ hn) hqfix)

/-- 人手の (2) の冒頭の「`im Q̌_ε` の `0` でない元を 1 つ取る」: `Q̌_ε x = q`・`q ≠ 0` なる `q`。
`im Q̌_ε` の 1 次元性は使わず、`Q̌_ε ≠ 0`（`Qproj_ne_zero`。`tr Q̌_ε = 1` から）の `0` でない第 `j` 列 `q := Q̌_ε e_j` を取る
（`e_j` は `I` の第 `j` 列。`Q̌_ε e_j` の第 `i` 成分は `Q̌_ε` の `(i, j)` 成分）。 -/
theorem exists_ne_zero_mem_range_Qproj (T : Finset (Fin M)) :
    ∃ q : Conf M → ℂ, q ≠ 0 ∧ ∃ x : Conf M → ℂ, F.Qproj T *ᵥ x = q := by
  obtain ⟨i, j, hij⟩ : ∃ i j, F.Qproj T i j ≠ 0 := by   -- `Q̌_ε ≠ 0` なので `0` でない成分がある
    by_contra hc
    push_neg at hc
    exact F.Qproj_ne_zero T (by ext i j; simp [hc i j])
  refine ⟨F.Qproj T *ᵥ Pi.single j 1, fun h => hij ?_, Pi.single j 1, rfl⟩
  have := congrFun h i
  simpa [Matrix.mulVec_single_one] using this           -- 第 `i` 成分は `Q̌_ε` の `(i, j)` 成分

/-- **原文 (2)**: `μ ∉ T`（`ε_μ = 0`）なら `η_{ε[μ→1]} = -η_ε`（`ε[μ→1]` は Lean の `insert μ T`）。

人手どおり `im Q̌_ε` の `0` でない元 `q` を 1 つ取り（`q = Q̌_ε x`。`exists_ne_zero_mem_range_Qproj`。1 次元性は使わない）、冪等性で `Q̌_ε q = q`、冒頭の 5 行で `εq = η_ε q`、Step 1 で `ψ̌_μ^† q ≠ 0`、Step 2 で
`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`、Step 3 の前半と後半で `η_{ε'}(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)` を出し、
`ψ̌_μ^† q ≠ 0` の 0 でない成分を比べて（(1) の `ηη − 1 = 0` の段と同じ `smul_generator_cancel`）`η_{ε'} = −η_ε`。 -/
theorem eta_insert {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta (insert μ T) = -F.eta T := by
  obtain ⟨q, hq0, x, hx⟩ := F.exists_ne_zero_mem_range_Qproj T
                                                        -- `im Q̌_ε` の `0` でない元 `q`（`q = Q̌_ε x`）
  have hqfix : F.Qproj T *ᵥ q = q := F.Qproj_mulVec_generator hx
                                                        -- `check_joint_eigenspace_decomposition` (1) の冪等性
  have hεq := F.epsilon_mulVec_generator_eq_eta_smul hqfix
                                                        -- (2) の冒頭の `εq = η_ε q`
  have h1 := F.cre_mulVec_generator_ne_zero hμ hq0 hqfix
                                                        -- Step 1: `ψ̌_μ^† q ≠ 0`
  have h2 := F.Qproj_insert_mulVec_cre_mulVec_of_notMem hμ hqfix
                                                        -- Step 2: `Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`
  have h3 := F.eta_insert_smul_cre_mulVec_generator h2 (F.epsilon_mulVec_cre_mulVec_generator hεq)
                                                        -- Step 3: `η_{ε'}(ψ̌_μ^† q) = (−η_ε)(ψ̌_μ^† q)`
  exact smul_generator_cancel h1 h3                     -- 0 でない成分を比べる

/-- `eta_insert` と同じ組み方で、(2) の冒頭の `εq = η_ε q`・Step 1・Step 2（`M = r + 2`）・Step 3 の鎖を必要十分版の特殊化
（`*_of_necSuf`）に替えたもの。`q` を取る段、`Q̌_ε q = q`（(1) の鎖 `Qproj_mulVec_generator`）、`M = 1` の人手の範囲外の補題、
最後に 0 でない成分で約す段（`smul_generator_cancel`）は具体版と共通である（約す段の必要十分版 `NecSuf.smul_left_cancel_of_ne_zero`
は成分を比べない別の手順なので使わない）。 -/
theorem eta_insert_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta (insert μ T) = -F.eta T := by
  obtain ⟨q, hq0, x, hx⟩ := F.exists_ne_zero_mem_range_Qproj T
  have hqfix : F.Qproj T *ᵥ q = q := F.Qproj_mulVec_generator hx
  have hεq := F.epsilon_mulVec_generator_eq_eta_smul_of_necSuf hqfix
  have h1 := F.cre_mulVec_generator_ne_zero_of_necSuf hμ hq0 hqfix
  have h2 : F.Qproj (insert μ T) *ᵥ (F.cre μ *ᵥ q) = F.cre μ *ᵥ q := by
    have hn := F.nOp_mulVec_generator_eq_zero_of_necSuf hμ hqfix
    rcases M with _ | _ | r
    · exact μ.elim0
    · exact Qproj_insert_mulVec_cre_mulVec_generator_one F T μ q
    · exact F.Qproj_insert_mulVec_cre_mulVec_generator_of_necSuf
        (F.omittingDefFactor_mulVec_generator_of_necSuf
          (F.defFactor_mulVec_generator_of_notMem_of_necSuf hμ hn) hqfix)
  have h3 := F.eta_insert_smul_cre_mulVec_generator_of_necSuf h2
    (F.epsilon_mulVec_cre_mulVec_generator_of_necSuf hεq)
  exact smul_generator_cancel h1 h3

/-! ## 原文 (3): `η_ε = η_{(1,…,1)}(-1)^{M-|ε|}` -/

/-- (3) の帰納法の段の 1 行目の根拠: (2) の `η_{ε'} = −η_ε` の両辺に `−1` を掛けて `η_ε = −η_{ε'}`
（`−x = (−1)x` なので、両辺の符号を反転することと同じ）。 -/
theorem eta_eq_neg_eta_insert {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta T = -F.eta (insert μ T) :=
  calc F.eta T = -(-F.eta T) := (neg_neg _).symm        -- 符号反転を二回すると元に戻る
    _ = -F.eta (insert μ T) := by rw [F.eta_insert hμ]  -- (2)

/-- **原文 (3) の `k := M_col − |ε| ∈ {0,1,…,M_col}` についての帰納法**。人手の `ε` は Lean の `T`（`ε_μ = 1` の `μ` の集合）、
`ε[μ→1]` は `insert μ T`、`(1,…,1)` は `Finset.univ`、`|ε|` は `T.card` である。`|ε| ≤ M_col` なので、
人手の整数の差 `M_col − |ε|` と Lean の自然数の差 `M - T.card` は一致する。

`k = 0`: 全ての `μ` で `ε_μ = 1`、すなわち `ε = (1,…,1)` で、`η_ε = η_{(1,…,1)} = η_{(1,…,1)}(−1)^0`（人手の 1 行を、乗法の単位元・`z^0 = 1`・`0 = M_col − |ε|` を補った 4 行にした）。
`k ≥ 1`: `ε_μ = 0` の `μ` を取り、`ε' := ε[μ→1]`（`|ε'| = |ε| + 1`）について人手の 7 行の鎖。 -/
theorem eta_eq_eta_univ_mul_of_sub_card (k : ℕ) :
    ∀ T : Finset (Fin M), M - T.card = k → F.eta T = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by
  induction k with
  | zero =>
      intro T hk
      -- `k = 0` なら全ての `μ` で `ε_μ = 1`、すなわち `ε = (1,…,1)`
      have hT : T = Finset.univ := by
        apply Finset.eq_univ_of_card
        have hle : T.card ≤ M := by simpa using Finset.card_le_univ T
        rw [Fintype.card_fin]
        omega
      calc F.eta T = F.eta Finset.univ := by rw [hT]     -- `ε = (1,…,1)`
        _ = F.eta Finset.univ * 1 := (mul_one _).symm    -- `complex_numbers_form_a_field` の乗法の単位元
        _ = F.eta Finset.univ * (-1 : ℂ) ^ 0 := by rw [pow_zero]
                                                          -- `def_power_of_complex_number` の `z^0 := 1_ℂ`
        _ = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by rw [hk]
                                                          -- `0 = M_col − |ε|`
  | succ k ih =>
      intro T hk
      -- `k ≥ 1` より `ε_μ = 0` なる `μ` が取れる
      obtain ⟨μ, hμ⟩ : ∃ μ, μ ∉ T := by
        by_contra hall
        have hT : T = Finset.univ :=
          Finset.eq_univ_iff_forall.2 fun μ => by_contra fun hμ => hall ⟨μ, hμ⟩
        rw [hT, Finset.card_univ, Fintype.card_fin, Nat.sub_self] at hk
        omega
      -- `|ε'| = |ε| + 1`、すなわち `M_col − |ε'| = k − 1`
      have hcard : (insert μ T).card = T.card + 1 := Finset.card_insert_of_notMem hμ
      have hk' : M - (insert μ T).card = k := by rw [hcard]; omega
      have hpos : 1 ≤ M - T.card := by omega
      calc F.eta T = -F.eta (insert μ T) := F.eta_eq_neg_eta_insert hμ
                                                          -- (2)
        _ = -(F.eta Finset.univ * (-1 : ℂ) ^ (M - (insert μ T).card)) := by rw [ih (insert μ T) hk']
                                                          -- 帰納法の仮定
        _ = -(F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card - 1)) := by rw [hcard, Nat.sub_add_eq]
                                                          -- `|ε'| = |ε| + 1`
        _ = (-1) * (F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card - 1)) := (neg_one_mul _).symm
                                                          -- `multiply_by_minus_one`
        _ = (F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card - 1)) * (-1) := mul_comm _ _
                                                          -- `complex_numbers_form_a_field` の乗法の交換則
        _ = F.eta Finset.univ * ((-1 : ℂ) ^ (M - T.card - 1) * (-1)) := mul_assoc _ _ _
                                                          -- `complex_numbers_form_a_field` の乗法の結合則
        _ = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by rw [← pow_succ, Nat.sub_add_cancel hpos]
                                                          -- `def_power_of_complex_number` の `z^{m+1} = z^m z`

/-- **原文 (3)**: `η_ε = η_{(1,…,1)}(-1)^{M-|ε|}`。`k := M_col − |ε|` で帰納法 `eta_eq_eta_univ_mul_of_sub_card` を使う。 -/
theorem eta_eq_eta_univ_mul (T : Finset (Fin M)) :
    F.eta T = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) :=
  F.eta_eq_eta_univ_mul_of_sub_card (M - T.card) T rfl

/-- `eta_eq_neg_eta_insert` を必要十分版 `NecSuf.eq_neg_of_insert` の特殊化として。 -/
theorem eta_eq_neg_eta_insert_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta T = -F.eta (insert μ T) :=
  NecSuf.eq_neg_of_insert (η := F.eta) (fun _ _ h => F.eta_insert h) hμ

/-- **原文 (3)** を必要十分版 `NecSuf.eq_univ_mul_neg_one_pow`（値の集合は `Monoid` と `HasDistribNeg` だけ）の
特殊化として（`Fintype.card (Fin M) = M`）。 -/
theorem eta_eq_eta_univ_mul_of_necSuf (T : Finset (Fin M)) :
    F.eta T = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := by
  have h := NecSuf.eq_univ_mul_neg_one_pow (η := F.eta) (fun _ _ h => F.eta_insert h) T
  rw [Fintype.card_fin] at h
  exact h

/-! ## 原文 (4): `ε` はパリティ演算子 -/

/-- 原文 (4) の因子 `I − 2ň_μ`（`2ň_μ` は `ň_μ` のスカラー倍）。 -/
noncomputable def parityFactor (μ : Fin M) : TensorPow M := 1 - (2 : ℂ) • F.nOp μ

/-- **原文 (4) の前半の 10 行の鎖**: `(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε`。人手の `ε_μ ∈ {0,1}` は Lean の
`if μ ∈ T then 1 else 0`（`check_joint_eigenspace_decomposition` (3) の `ň_μQ̌_ε = ε_μQ̌_ε` の Lean の形）である。 -/
theorem parityFactor_mul_Qproj (μ : Fin M) (T : Finset (Fin M)) :
    F.parityFactor μ * F.Qproj T = ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0)) • F.Qproj T :=
  calc F.parityFactor μ * F.Qproj T
      = (1 + -((2 : ℂ) • F.nOp μ)) * F.Qproj T := by
        rw [parityFactor, sub_eq_add_neg_tensorPow]     -- `matrix_difference_is_sum_with_negation`
    _ = 1 * F.Qproj T + -((2 : ℂ) • F.nOp μ) * F.Qproj T := add_mul_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = 1 * F.Qproj T + -(((2 : ℂ) • F.nOp μ) * F.Qproj T) := by
        rw [neg_mul_matrix_tensorPow]                   -- `negation_factors_out_of_left_factor`
    _ = 1 * F.Qproj T - ((2 : ℂ) • F.nOp μ) * F.Qproj T := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.Qproj T - ((2 : ℂ) • F.nOp μ) * F.Qproj T := by
        rw [identity_matrix_mul_tensorPow]              -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = F.Qproj T - (2 : ℂ) • (F.nOp μ * F.Qproj T) := by
        rw [smul_mul_matrix_tensorPow]                  -- `scalar_multiple_factors_out_of_left_factor`
    _ = F.Qproj T - (2 : ℂ) • ((if μ ∈ T then (1 : ℂ) else 0) • F.Qproj T) := by
        rw [F.nOp_mul_Qproj μ T]                        -- `check_joint_eigenspace_decomposition` (3)
    _ = (1 : ℂ) • F.Qproj T - (2 : ℂ) • ((if μ ∈ T then (1 : ℂ) else 0) • F.Qproj T) := by
        rw [one_smul_tensorPow]                         -- `scalar_multiple_by_one`
    _ = (1 : ℂ) • F.Qproj T - ((2 : ℂ) * (if μ ∈ T then (1 : ℂ) else 0)) • F.Qproj T := by
        rw [smul_smul]                                  -- `scalar_multiple_is_associative`（具体版が無く mathlib の `smul_smul`）
    _ = ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0)) • F.Qproj T := smul_sub_smul_tensorPow _ _ _
                                                        -- `difference_of_scalar_multiples_of_one_matrix`

/-- **原文 (4) の `P_kQ̌_ε = p_kQ̌_ε` の `k` についての帰納法**。人手の `P_k := ∏_{μ=1}^{k}(I − 2ň_μ)`
（`def_finite_product_of_matrices`。左から掛ける）は Lean の `NecSuf.finProdLeft r A`、`p_k := ∏_{μ=1}^{k}(1 − 2ε_μ)`
（`def_finite_product_of_complex_numbers`）は `∏ j, a j` で、人手の `k` が Lean の `r + 1` である。
人手が「上の式（`μ → k+1`）」として引く 10 行の鎖を、仮定 `h`（各因子 `A_j` について `A_jQ̌_ε = a_jQ̌_ε`）として受ける。

`k = 1`: 人手の「上の式（`μ → 1`）」を、有限積の定義の 2 行で挟んだ 3 行にした。`k → k+1`: 人手の 8 行と同じ行の calc。 -/
theorem finProdLeft_mul_Qproj (T : Finset (Fin M)) :
    ∀ (r : ℕ) (A : Fin (r + 1) → TensorPow M) (a : Fin (r + 1) → ℂ),
      (∀ j, A j * F.Qproj T = a j • F.Qproj T) →
      NecSuf.finProdLeft r A * F.Qproj T = (∏ j, a j) • F.Qproj T
  | 0, A, a, h =>
    calc NecSuf.finProdLeft 0 A * F.Qproj T
        = A 0 * F.Qproj T := rfl                        -- `def_finite_product_of_matrices`
      _ = a 0 • F.Qproj T := h 0                        -- 上の式（`μ → 1`）
      _ = (∏ j, a j) • F.Qproj T := by rw [Fin.prod_univ_one]
                                                        -- `def_finite_product_of_complex_numbers`
  | r + 1, A, a, h =>
    calc NecSuf.finProdLeft (r + 1) A * F.Qproj T
        = (NecSuf.finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))) * F.Qproj T := rfl
                                                        -- `def_finite_product_of_matrices`
      _ = NecSuf.finProdLeft r (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 1)) * F.Qproj T) :=
          Matrix.mul_assoc _ _ _                        -- `mat_mult_associative`（具体版が無く mathlib の `Matrix.mul_assoc`）
      _ = NecSuf.finProdLeft r (fun j => A (Fin.castSucc j)) * (a (Fin.last (r + 1)) • F.Qproj T) := by
          rw [h (Fin.last (r + 1))]                     -- 上の式（`μ → k+1`）
      _ = a (Fin.last (r + 1)) • (NecSuf.finProdLeft r (fun j => A (Fin.castSucc j)) * F.Qproj T) :=
          mul_smul_matrix_tensorPow _ _ _               -- `scalar_multiple_factors_out_of_right_factor`
      _ = a (Fin.last (r + 1)) • ((∏ j, a (Fin.castSucc j)) • F.Qproj T) := by
          rw [finProdLeft_mul_Qproj T r _ _ (fun j => h (Fin.castSucc j))]
                                                        -- 帰納法の仮定
      _ = (a (Fin.last (r + 1)) * ∏ j, a (Fin.castSucc j)) • F.Qproj T := smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative`（具体版が無く mathlib の `smul_smul`）
      _ = ((∏ j, a (Fin.castSucc j)) * a (Fin.last (r + 1))) • F.Qproj T := by
          rw [mul_comm (a (Fin.last (r + 1)))]          -- `complex_numbers_form_a_field` の乗法の交換則
      _ = (∏ j, a j) • F.Qproj T := by rw [Fin.prod_univ_castSucc a]
                                                        -- `def_finite_product_of_complex_numbers`

/-- `parityFactor_mul_Qproj` を必要十分版 `NecSuf.one_sub_smul_mul_eq_smul'` の特殊化として。 -/
theorem parityFactor_mul_Qproj_of_necSuf (μ : Fin M) (T : Finset (Fin M)) :
    F.parityFactor μ * F.Qproj T = ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0)) • F.Qproj T :=
  NecSuf.one_sub_smul_mul_eq_smul' (2 : ℂ) _ (F.nOp μ) (F.Qproj T) (F.nOp_mul_Qproj μ T)

/-- `finProdLeft_mul_Qproj` を必要十分版 `NecSuf.finProdLeft_mul_eq_prod_smul'` の特殊化として。 -/
theorem finProdLeft_mul_Qproj_of_necSuf (T : Finset (Fin M)) (r : ℕ) (A : Fin (r + 1) → TensorPow M)
    (a : Fin (r + 1) → ℂ) (h : ∀ j, A j * F.Qproj T = a j • F.Qproj T) :
    NecSuf.finProdLeft r A * F.Qproj T = (∏ j, a j) • F.Qproj T :=
  NecSuf.finProdLeft_mul_eq_prod_smul' (F.Qproj T) r A a h

/-- 原文 (4) の `P := P_{M_col} = ∏_{μ=1}^{M_col}(I − 2ň_μ)`（`def_finite_product_of_matrices`。左から掛ける）。
人手の `M_col ≥ 1` が Lean の `r + 1` である。人手の範囲外の `M = 0` では因子が無いので単位行列と置く。 -/
noncomputable def parityProd : TensorPow M :=
  match M, F with
  | 0, _ => 1
  | r + 1, F => NecSuf.finProdLeft r F.parityFactor

/-- 原文 (4) の「`1 − 2ε_μ` は `ε_μ = 1` なら `−1`、`ε_μ = 0` なら `+1` なので、`p_{M_col}` は `−1` を `|ε|` 個、
`+1` を残りの個数だけ掛けたものであり `p_{M_col} = (−1)^{|ε|}`」。 -/
theorem prod_one_sub_two_mul_indicator (T : Finset (Fin M)) :
    ∏ μ, ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0)) = (-1 : ℂ) ^ T.card := by
  -- `ε_μ = 1` なら `1 − 2ε_μ = −1`、`ε_μ = 0` なら `1 − 2ε_μ = +1`
  have hfac : ∀ μ, ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0)) = if μ ∈ T then -1 else 1 := by
    intro μ
    by_cases hμ : μ ∈ T
    · rw [if_pos hμ, if_pos hμ]; norm_num
    · rw [if_neg hμ, if_neg hμ]; norm_num
  have hfilter : (Finset.univ.filter fun μ : Fin M => μ ∈ T) = T := by
    ext μ; simp
  calc ∏ μ, ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0))
      = ∏ μ, (if μ ∈ T then (-1 : ℂ) else 1) := Finset.prod_congr rfl fun μ _ => hfac μ
                                                        -- 各因子は `ε_μ = 1` なら `−1`、`ε_μ = 0` なら `+1`
    _ = (∏ μ ∈ Finset.univ.filter (fun μ : Fin M => μ ∈ T), (-1 : ℂ))
          * ∏ μ ∈ Finset.univ.filter (fun μ : Fin M => μ ∉ T), (1 : ℂ) := Finset.prod_ite _ _
                                                        -- `−1` の因子と `+1` の因子に分ける
    _ = (∏ μ ∈ T, (-1 : ℂ)) * 1 := by rw [hfilter, Finset.prod_const_one]
                                                        -- `ε_μ = 1` の `μ` の集合は `T`、`+1` の積は `1`
    _ = (-1 : ℂ) ^ T.card := by rw [Finset.prod_const, mul_one]
                                                        -- `−1` を `|ε|` 個掛けたもの

/-- 原文 (4) の `PQ̌_ε = p_{M_col}Q̌_ε = (−1)^{|ε|}Q̌_ε`（`P_kQ̌_ε = p_kQ̌_ε` の `k = M_col` と `p_{M_col} = (−1)^{|ε|}`）。
人手の範囲外の `M = 0` では `ε` は空の語で `|ε| = 0`、`P = I` である。 -/
theorem parityProd_mul_Qproj (T : Finset (Fin M)) :
    F.parityProd * F.Qproj T = (-1 : ℂ) ^ T.card • F.Qproj T := by
  match M, F, T with
  | 0, F, T =>
    have hT : T = ∅ := Finset.eq_empty_of_isEmpty T
    calc F.parityProd * F.Qproj T
        = 1 * F.Qproj T := rfl                          -- 因子が無いので `P = I`
      _ = F.Qproj T := identity_matrix_mul_tensorPow _  -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = (1 : ℂ) • F.Qproj T := (one_smul_tensorPow _).symm
                                                        -- `scalar_multiple_by_one`
      _ = (-1 : ℂ) ^ T.card • F.Qproj T := by rw [hT, Finset.card_empty, pow_zero]
                                                        -- `|ε| = 0`
  | r + 1, F, T =>
    calc F.parityProd * F.Qproj T
        = NecSuf.finProdLeft r F.parityFactor * F.Qproj T := rfl
                                                        -- `P := P_{M_col}`
      _ = (∏ μ, ((1 : ℂ) - 2 * (if μ ∈ T then (1 : ℂ) else 0))) • F.Qproj T :=
          F.finProdLeft_mul_Qproj T r _ _ fun μ => F.parityFactor_mul_Qproj μ T
                                                        -- `P_kQ̌_ε = p_kQ̌_ε`（`k = M_col`。因子 `A := I − 2ň_μ`、係数 `a := 1 − 2ε_μ`）
      _ = (-1 : ℂ) ^ T.card • F.Qproj T := by rw [prod_one_sub_two_mul_indicator]
                                                        -- `p_{M_col} = (−1)^{|ε|}`

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
