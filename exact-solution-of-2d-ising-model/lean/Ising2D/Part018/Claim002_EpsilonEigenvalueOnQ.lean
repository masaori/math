/-
# `ε Q̌_ε = η_ε Q̌_ε` と符号の反転則（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_002_claim_epsilon_eigenvalue_on_check_Q`、ラベル **`epsilon_eigenvalue_on_check_Q`**）

抽象版は `Ising2D/Abstract/ParityFermion.lean`（同じラベル）の
`Ising2D.Abstract.projOn_insert_mul_cre` / `Abstract.cre_mul_projOn_ne_zero`。
**符号の反転則 (2) はその 2 つの系である。**

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `∃! η_ε ∈ {±1}, ε Q̌_ε = η_ε Q̌_ε` | `Ising2D.CheckFermi.eta` / `eta_mem` / `epsilon_mul_Qproj` / `eta_unique` |
| (2) 反転則 `η_{ε[μ→1]} = -η_ε` | `Ising2D.CheckFermi.eta_insert` |
| (3) `η_ε = η_{(1,…,1)}(-1)^{M-\|ε\|}` | `Ising2D.CheckFermi.eta_eq_eta_univ_mul` |
| (4) `ε = η_{(1,…,1)}(-1)^M ∏(I - 2ň_μ)` | `Ising2D.CheckFermi.epsilon_eq_parityProd` |

## 1 次元性が効いている場所（抽象版で判明したこと）

人手証明は (1)(2) の両方で「`im Q̌_ε` は 1 次元」を使うが、**1 次元性が本当に要るのは
(1)（`η_ε` の存在）だけ**である。(2) の Step 1・Step 2 は抽象版
（環の計算だけ）で閉じており、1 次元性を使わない。
-/
import Ising2D.Part018.Setup

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 補助: 行列の等号判定とスカラーの一意性 -/

/-- `mulVec` が一致すれば行列も一致する。 -/
theorem matrix_eq_of_mulVec_eq {n : Type*} [Fintype n] [DecidableEq n]
    {A B : Matrix n n ℂ} (h : ∀ x : n → ℂ, A *ᵥ x = B *ᵥ x) : A = B := by
  apply Matrix.toLin'.injective
  refine LinearMap.ext fun x => ?_
  simp only [Matrix.toLin'_apply]
  exact h x

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
    F.Qproj T = Abstract.projOn (Abstract.num F.cre F.ann) F.commute_nOp_nOp Finset.univ T := rfl

/-- `w ∈ im Q̌_ε` なら `Q̌_ε w = w`（冪等性）。 -/
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

/-- **原文 (1) の `q`**: `im Q̌_ε` の生成元。 -/
theorem exists_Qproj_generator (T : Finset (Fin M)) :
    ∃ q : Conf M → ℂ, q ≠ 0 ∧ F.Qproj T *ᵥ q = q ∧
      ∀ x : Conf M → ℂ, ∃ z : ℂ, F.Qproj T *ᵥ x = z • q := by
  obtain ⟨v, hv, hgen⟩ := finrank_eq_one_iff'.1 (F.finrank_range_Qproj T)
  have hmem : ∀ x : Conf M → ℂ, F.Qproj T *ᵥ x ∈ LinearMap.range (Matrix.toLin' (F.Qproj T)) :=
    fun x => ⟨x, by simp only [Matrix.toLin'_apply]⟩
  obtain ⟨y, hy⟩ := v.2
  refine ⟨(v : Conf M → ℂ), ?_, ?_, ?_⟩
  · intro h
    exact hv (Subtype.ext h)
  · refine F.Qproj_mulVec_of_mem_range ⟨y, ?_⟩
    simpa only [Matrix.toLin'_apply] using hy
  · intro x
    obtain ⟨c, hc⟩ := hgen ⟨F.Qproj T *ᵥ x, hmem x⟩
    exact ⟨c, by simpa using congrArg Subtype.val hc.symm⟩

/-! ## 原文 (1): `η_ε` の存在と一意性 -/

/-- **原文 (1)**: `ε Q̌_ε = η Q̌_ε` なる `η ∈ {±1}` が存在する。 -/
theorem exists_eta (T : Finset (Fin M)) :
    ∃ η : ℂ, (η = 1 ∨ η = -1) ∧ epsilon M * F.Qproj T = η • F.Qproj T := by
  obtain ⟨q, hq0, hqfix, hspan⟩ := F.exists_Qproj_generator T
  -- `ε q ∈ im Q̌_ε` （`ε` と `Q̌_ε` が可換だから）
  have hmem : F.Qproj T *ᵥ (epsilon M *ᵥ q) = epsilon M *ᵥ q := by
    rw [Matrix.mulVec_mulVec, ← (F.commute_epsilon_Qproj T).eq, ← Matrix.mulVec_mulVec, hqfix]
  obtain ⟨z, hz⟩ := hspan (epsilon M *ᵥ q)
  have hεq : epsilon M *ᵥ q = z • q := by rw [← hz, hmem]
  -- `ε² = 1` より `z² = 1`
  have hz2 : z * z = 1 := by
    have h1 : epsilon M *ᵥ (epsilon M *ᵥ q) = q := by
      rw [Matrix.mulVec_mulVec, epsilon_mul_self, Matrix.one_mulVec]
    rw [hεq, Matrix.mulVec_smul, hεq, smul_smul] at h1
    have := congrFun h1
    obtain ⟨k, hk⟩ : ∃ k, q k ≠ 0 := by
      by_contra hc
      push_neg at hc
      exact hq0 (funext hc)
    have h2 := this k
    simp only [Pi.smul_apply, smul_eq_mul] at h2
    field_simp at h2
    rw [← sq]
    exact h2
  refine ⟨z, ?_, ?_⟩
  · rcases mul_self_eq_one_iff.1 hz2 with h | h
    · exact Or.inl h
    · exact Or.inr h
  · refine matrix_eq_of_mulVec_eq fun x => ?_
    obtain ⟨c, hc⟩ := hspan x
    rw [← Matrix.mulVec_mulVec, hc, Matrix.mulVec_smul, hεq, smul_smul, Matrix.smul_mulVec,
      hc, smul_smul]
    ring_nf

/-- **原文 (1) の `η_ε`**（選択関数として与える）。 -/
noncomputable def eta (T : Finset (Fin M)) : ℂ := (F.exists_eta T).choose

theorem eta_mem (T : Finset (Fin M)) : F.eta T = 1 ∨ F.eta T = -1 :=
  (F.exists_eta T).choose_spec.1

/-- **原文 (1)**: `ε Q̌_ε = η_ε Q̌_ε`。 -/
theorem epsilon_mul_Qproj (T : Finset (Fin M)) :
    epsilon M * F.Qproj T = F.eta T • F.Qproj T :=
  (F.exists_eta T).choose_spec.2

/-- **原文 (1) の一意性**。 -/
theorem eta_unique {T : Finset (Fin M)} {η : ℂ} (h : epsilon M * F.Qproj T = η • F.Qproj T) :
    η = F.eta T :=
  smul_cancel_of_matrix_ne_zero (F.Qproj_ne_zero T) (h.symm.trans (F.epsilon_mul_Qproj T))

/-! ## 原文 (2): 符号の反転則 -/

/-- **原文 (2)**: `μ ∉ T` なら `η_{T∪{μ}} = -η_T`。

Step 1（`ψ̌_μ^† q ≠ 0`）と Step 2（`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`）は抽象版
`Abstract.cre_mul_projOn_ne_zero` / `Abstract.projOn_insert_mul_cre` の系である。 -/
theorem eta_insert {T : Finset (Fin M)} {μ : Fin M} (hμ : μ ∉ T) :
    F.eta (insert μ T) = -F.eta T := by
  set x : TensorPow M := F.cre μ * F.Qproj T with hx
  -- Step 1: `x ≠ 0`
  have hx0 : x ≠ 0 :=
    Abstract.cre_mul_projOn_ne_zero F.cre F.ann F.commute_nOp_nOp F.nOp_mul_self
      F.acomm_cre_ann_self (Finset.mem_univ μ) hμ (F.Qproj_ne_zero T)
  -- Step 2: `Q̌_{T∪{μ}} x = x`
  have hstep2 : F.Qproj (insert μ T) * x = x :=
    Abstract.projOn_insert_mul_cre F.cre F.ann F.commute_nOp_nOp F.nOp_mul_self
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
  have key := Abstract.noncommProd_mul_of_mul_eq_smul (𝕜 := ℂ) F.parityFactor
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
