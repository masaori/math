/-
# `ε Q̌_ε = η_ε Q̌_ε` と符号の反転則（必要十分版からの導出）

具体版 `ClaimEpsilonEigenvalueOnCheckQ.lean` の鎖を、必要十分版の特殊化として得る。人手のラベルは
`epsilon_eigenvalue_on_check_Q`。使う必要十分版は、(2) の冒頭・Step 1・Step 2 の後半・Step 3 の数ベクトルの鎖が
`Ising2D/NecSuf/SignReversalOnGeneratorVector.lean`、Step 2 の前半が `Ising2D/NecSuf/ParityFermion.lean`（`NecSuf.num_mul_cre'`・
`NecSuf.commute_defFactor_of_commute'`）、(3) の帰納法が `Ising2D/NecSuf/SignAfterReplacingComponents.lean`、
(4) の前半が `Ising2D/NecSuf/FactorsActingAsScalarsOnProjection.lean`、(4) の後半が
`Ising2D/NecSuf/ParityFormFromSignsOnProjections.lean` である。
`eta_insert_of_necSuf` は、具体版 `eta_insert` と同じ組み方で、冒頭の `εq = η_ε q`・Step 1〜3 の鎖を
必要十分版の特殊化に替えたもの（`q` を取る段・`Q̌_ε q = q`・`M = 1`・最後に約す段は具体版と共通）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonEigenvalueOnCheckQ
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.NecSuf.SignReversalOnGeneratorVector
import Ising2D.NecSuf.SignAfterReplacingComponents
import Ising2D.NecSuf.FactorsActingAsScalarsOnProjection
import Ising2D.NecSuf.ParityFormFromSignsOnProjections

namespace Ising2D

open Matrix

variable {M : ℕ}

namespace CheckFermi

variable (F : CheckFermi M)

theorem nOp_mulVec_generator_eq_zero_of_necSuf {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T)
    {q : Conf M → ℂ} (hqfix : F.Qproj T *ᵥ q = q) : F.nOp μ *ᵥ q = 0 :=
  NecSuf.num_mulVec_eq_zero_of_fixed hqfix (F.nOp_mul_Qproj_of_notMem hμ)

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

/-- 具体版 `nOp_mul_cre` の 13 行の鎖が、同じ行の必要十分版 `NecSuf.num_mul_cre'` の特殊化として得られること。 -/
theorem nOp_mul_cre_of_necSuf (μ : Fin M) : F.nOp μ * F.cre μ = F.cre μ :=
  NecSuf.num_mul_cre' (fun x y => sub_eq_add_neg x y) (fun x => zero_mul x) (fun x => sub_zero x) F.cre F.ann μ
    (F.ann_mul_cre μ) (F.cre_sq μ)

/-- 具体版 `commute_defFactor_of_commute` の可換性が、同じ並びの必要十分版 `NecSuf.commute_defFactor_of_commute'` の特殊化として得られること。 -/
theorem commute_defFactor_of_commute_of_necSuf (T : Finset (Fin M)) (ν : Fin M) {X : TensorPow M}
    (hn : X * F.nOp ν = F.nOp ν * X) : X * F.defFactor T ν = F.defFactor T ν * X :=
  NecSuf.commute_defFactor_of_commute' (fun x y => sub_eq_add_neg x y) hn (epsVal T ν = 1)

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

/-- `parityFactor_mul_Qproj` を必要十分版 `NecSuf.one_sub_smul_mul_eq_sub_smul_mul'` の特殊化として。 -/
theorem parityFactor_mul_Qproj_of_necSuf (μ : Fin M) (T : Finset (Fin M)) :
    F.parityFactor μ * F.Qproj T = F.Qproj T - (2 : ℂ) • (F.nOp μ * F.Qproj T) :=
  NecSuf.one_sub_smul_mul_eq_sub_smul_mul' (2 : ℂ) (F.nOp μ) (F.Qproj T)

/-- `parityFactor_mul_Qproj_of_mem` を必要十分版 `NecSuf.sub_smul_mul_eq_smul_of_mul_eq'` の特殊化として。 -/
theorem parityFactor_mul_Qproj_of_mem_of_necSuf {μ : Fin M} {T : Finset (Fin M)} (hμ : μ ∈ T) :
    F.parityFactor μ * F.Qproj T = (-1 : ℂ) • F.Qproj T := by
  rw [F.parityFactor_mul_Qproj_of_necSuf μ T]
  exact NecSuf.sub_smul_mul_eq_smul_of_mul_eq' (2 : ℂ) (-1 : ℂ) (by norm_num) (F.nOp_mul_Qproj_of_mem hμ)

/-- `parityFactor_mul_Qproj_of_notMem` を必要十分版 `NecSuf.sub_smul_mul_eq_self_of_mul_eq_zero'` の特殊化として。 -/
theorem parityFactor_mul_Qproj_of_notMem_of_necSuf {μ : Fin M} {T : Finset (Fin M)} (hμ : μ ∉ T) :
    F.parityFactor μ * F.Qproj T = F.Qproj T := by
  rw [F.parityFactor_mul_Qproj_of_necSuf μ T]
  exact NecSuf.sub_smul_mul_eq_self_of_mul_eq_zero' (2 : ℂ) (F.nOp_mul_Qproj_of_notMem hμ)

/-- `finProdLeft_mul_Qproj` を必要十分版 `NecSuf.finProdLeft_mul_eq_pow_smul'` の特殊化として
（Lean の `(finsetOfWord e).card` と必要十分版の `NecSuf.wordCount' e` は同じ数で、定義から一致する）。 -/
theorem finProdLeft_mul_Qproj_of_necSuf (T : Finset (Fin M)) (r : ℕ) (A : Fin (r + 1) → TensorPow M)
    (e : Fin (r + 1) → Fin 2) (h1 : ∀ j, e j = 1 → A j * F.Qproj T = (-1 : ℂ) • F.Qproj T)
    (h0 : ∀ j, e j = 0 → A j * F.Qproj T = F.Qproj T) :
    NecSuf.finProdLeft r A * F.Qproj T = (-1 : ℂ) ^ (finsetOfWord e).card • F.Qproj T :=
  NecSuf.finProdLeft_mul_eq_pow_smul' (F.Qproj T) (-1 : ℂ) r A e h1 h0

/-- `neg_one_pow_mul_self` を必要十分版 `NecSuf.neg_one_pow_mul_self'` の特殊化として。 -/
theorem neg_one_pow_mul_self_of_necSuf (k : ℕ) : (-1 : ℂ) ^ k * (-1 : ℂ) ^ k = 1 :=
  NecSuf.neg_one_pow_mul_self' k

/-- `epsilon_mul_Qproj_eq_smul_parityProd_mul` を必要十分版 `NecSuf.mul_eq_smul_mul_of_sign_pow'` の特殊化として。 -/
theorem epsilon_mul_Qproj_eq_smul_parityProd_mul_of_necSuf (T : Finset (Fin M)) :
    epsilon M * F.Qproj T = (F.eta Finset.univ * (-1 : ℂ) ^ M) • (F.parityProd * F.Qproj T) := by
  have hle : T.card ≤ M := by
    have := Finset.card_le_card (Finset.subset_univ T)
    simpa using this
  exact NecSuf.mul_eq_smul_mul_of_sign_pow' (epsilon M) F.parityProd (F.Qproj T) (F.eta Finset.univ) (F.eta T)
    M T.card hle (F.epsilon_mul_Qproj T) (F.eta_eq_eta_univ_mul T) (F.parityProd_mul_Qproj T)

/-- `epsilon_eq_parityProd_succ` を必要十分版 `NecSuf.eq_smul_of_mul_eq_smul_mul'` の特殊化として
（各 `ε` の仮定は 7 行の鎖の特殊化 `epsilon_mul_Qproj_eq_smul_parityProd_mul_of_necSuf`）。 -/
theorem epsilon_eq_parityProd_succ_of_necSuf {r : ℕ} (F : CheckFermi (r + 1)) :
    epsilon (r + 1) = (F.eta Finset.univ * (-1 : ℂ) ^ (r + 1)) • NecSuf.finProdLeft r F.parityFactor :=
  NecSuf.eq_smul_of_mul_eq_smul_mul' r (epsilon (r + 1)) F.parityProd _ (fun ε => F.Qproj (finsetOfWord ε))
    (binWordSum_Qproj F) (fun ε => F.epsilon_mul_Qproj_eq_smul_parityProd_mul_of_necSuf (finsetOfWord ε))

end CheckFermi

end Ising2D
