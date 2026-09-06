/-
# `c_+(M) = Λ^{(1/2)}_M`（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_009_theorem_c_plus_equals_Lambda_half`、
ラベル **`c_plus_equals_Lambda_half_integer`**）

**章 019 の `Ising2D.rayleighSup_eq_of_sectorRayleighSup_pos_eq` が仮定として受け取っていた
「`c_+(M) = Λ`」を埋めるのが本ファイルである。**

必要十分版は置かない。理由は章 011 の `Definition006_RayleighSup.lean` と同じで、
`sSup` は ℝ の完備性そのものであり、ほどく余地がないこと。本ファイルで新しく現れる
道具は「実行列・実ベクトルと複素行列・複素ベクトルの橋渡し」だけで、これは
章 019 の `epsilon_eq_ofReal_epsilonR` と同じ性質のものである。

## 章 011・017 から受け取る入力（`Ising2D.EvenSectorBridge`）

| 場 | 原文の主張 | 章 |
| --- | --- | --- |
| `hVr` | `V^{(+)}` は実行列（`V_plus_is_positive_definite` の表示 + `iH_is_real_symmetric`） | 017 |
| `hWV` | `W P^{(+)} = V^{(+)} P^{(+)}`（`symmetrized_transfer_matrix_on_sectors`） | 011 |
| `hWsymm`, `hWpsd` | `W` は実対称半正定値（`W_is_real_symmetric_positive_definite`） | 011 |

章 011 の物理的な実行列 `W` と、章 010 の Pauli 表示から作る複素行列の同一視は
`Ising2D.physicalSymTransferC_eq_map`、射影後の最終等式は
`Ising2D.physicalSymTransferR_map_mul_epsProj_eq_Vsym` で形式化済みである。
ただし、章 017 の `V^{(+)}` の実行列表示と組み合わせ、この複素行列等式を実ベクトル上の
`W *ᵥ x = Vr *ᵥ x` へ変換する接続は未形式化なので、本ファイルでは `hWV` を仮定として受け取る。
-/
import Ising2D.Part018.Theorem007_MaxEigenvectorEvenSector
import Ising2D.Part011.Claim010_SectorDecomposition

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 実ベクトルの複素化 -/

/-- 実ベクトルを複素ベクトルとみなす。 -/
def cvec {n : Type*} (x : n → ℝ) : n → ℂ := fun k => (x k : ℂ)

theorem cvec_ne_zero {n : Type*} {x : n → ℝ} (hx : x ≠ 0) : cvec x ≠ 0 := by
  intro h
  apply hx
  funext k
  have := congrFun h k
  simpa [cvec] using this

theorem star_cvec {n : Type*} (x : n → ℝ) : star (cvec x) = cvec x := by
  funext k
  simp [cvec, Complex.star_def]

theorem cvec_mulVec {n : Type*} [Fintype n] (A : Matrix n n ℝ) (x : n → ℝ) :
    (A.map (fun r : ℝ => (r : ℂ))) *ᵥ cvec x = cvec (A *ᵥ x) := by
  funext k
  simp only [Matrix.mulVec, dotProduct, Matrix.map_apply, cvec]
  rw [Complex.ofReal_sum]
  exact Finset.sum_congr rfl fun j _ => (Complex.ofReal_mul _ _).symm

theorem cvec_dotProduct {n : Type*} [Fintype n] (x y : n → ℝ) :
    cvec x ⬝ᵥ cvec y = ((x ⬝ᵥ y : ℝ) : ℂ) := by
  simp only [dotProduct, cvec]
  rw [Complex.ofReal_sum]
  exact Finset.sum_congr rfl fun j _ => (Complex.ofReal_mul _ _).symm

theorem cvec_smul {n : Type*} (c : ℝ) (x : n → ℝ) : cvec (c • x) = (c : ℂ) • cvec x := by
  funext k
  simp [cvec]

/-- `x^* x = ‖x‖²`（複素ベクトル）。 -/
theorem star_dotProduct_self {n : Type*} [Fintype n] (v : n → ℂ) :
    star v ⬝ᵥ v = ((∑ k, Complex.normSq (v k) : ℝ) : ℂ) := by
  rw [dotProduct, Complex.ofReal_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Pi.star_apply, Complex.star_def, Complex.normSq_eq_conj_mul_self]

/-! ## 章 011・017 から受け取る入力 -/

/-- 実行列 `W`（章 011）と複素行列 `V^{(+)}`（章 017）の橋渡し。 -/
structure EvenSectorBridge (M : ℕ) (F : CheckFermi M) (D : VPlusData M F) where
  /-- 章 011 の対称化転送行列 `W` -/
  W : Matrix (Conf M) (Conf M) ℝ
  hWsymm : W.IsSymm
  hWpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x
  /-- `V^{(+)}` の実行列としての表示 -/
  Vr : Matrix (Conf M) (Conf M) ℝ
  hVr : D.V = Vr.map (fun r : ℝ => (r : ℂ))
  /-- 人手証明 Step 0: `𝓕^{(+)}` の上で `W` と `V^{(+)}` は一致する -/
  hWV : ∀ x : Conf M → ℝ, epsilonR M *ᵥ x = x → W *ᵥ x = Vr *ᵥ x

namespace EvenSectorBridge

variable {F : CheckFermi M} {D : VPlusData M F} (B : EvenSectorBridge M F D)

/-! ## Step 1: `c_+(M) ≤ Λ̌_max` -/

/-- `x^* Q̌_ε x = ‖Q̌_ε x‖²`（人手証明 `check_number_operator_is_hermitian` (4)）。 -/
theorem quad_Qproj (x : Conf M → ℝ) (T : Finset (Fin M)) :
    cvec x ⬝ᵥ (F.Qproj T *ᵥ cvec x)
      = ((∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k) : ℝ) : ℂ) := by
  set u := F.Qproj T *ᵥ cvec x with hu
  have h1 : F.Qproj T *ᵥ cvec x = F.Qproj T *ᵥ u := by
    rw [hu, Matrix.mulVec_mulVec, F.Qproj_mul_self]
  have hstar : star u = star (cvec x) ᵥ* F.Qproj T := by
    rw [hu, Matrix.star_mulVec, F.Qproj_conjTranspose]
  calc cvec x ⬝ᵥ (F.Qproj T *ᵥ cvec x)
      = star (cvec x) ⬝ᵥ (F.Qproj T *ᵥ u) := by rw [star_cvec, ← h1]
    _ = (star (cvec x) ᵥ* F.Qproj T) ⬝ᵥ u := by rw [Matrix.dotProduct_mulVec]
    _ = star u ⬝ᵥ u := by rw [hstar]
    _ = _ := star_dotProduct_self u

/-- `∑_ε ‖Q̌_ε x‖² = ‖x‖²`。 -/
theorem sum_quad_Qproj (x : Conf M → ℝ) :
    ∑ T : Finset (Fin M), (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k))
      = vecNormSq x := by
  have hC : ((∑ T : Finset (Fin M), (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k)) : ℝ) : ℂ)
      = ((vecNormSq x : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum]
    calc ∑ T : Finset (Fin M), ((∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k) : ℝ) : ℂ)
        = ∑ T : Finset (Fin M), cvec x ⬝ᵥ (F.Qproj T *ᵥ cvec x) :=
          Finset.sum_congr rfl fun T _ => (quad_Qproj x T).symm
      _ = cvec x ⬝ᵥ ((∑ T : Finset (Fin M), F.Qproj T) *ᵥ cvec x) := by
          rw [Matrix.sum_mulVec, dotProduct_sum]
      _ = cvec x ⬝ᵥ cvec x := by rw [F.sum_Qproj, Matrix.one_mulVec]
      _ = ((vecNormSq x : ℝ) : ℂ) := by rw [cvec_dotProduct]; rfl
  exact_mod_cast hC

/-- 人手証明 Step 1 の展開: `x^T V^{(+)} x = ∑_ε Λ̌_ε ‖Q̌_ε x‖²`。 -/
theorem quad_Vr_eq_sum (x : Conf M → ℝ) :
    x ⬝ᵥ B.Vr *ᵥ x
      = ∑ T : Finset (Fin M),
          checkLambda D.C D.gam T * (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k)) := by
  have hV : D.V *ᵥ cvec x
      = ∑ T : Finset (Fin M),
          ((checkLambda D.C D.gam T : ℝ) : ℂ) • (F.Qproj T *ᵥ cvec x) := by
    conv_lhs => rw [show D.V = D.V * 1 from (mul_one _).symm, ← F.sum_Qproj]
    rw [Finset.mul_sum, Matrix.sum_mulVec]
    exact Finset.sum_congr rfl fun T _ => by rw [D.hV T, Matrix.smul_mulVec]
  have hC : ((x ⬝ᵥ B.Vr *ᵥ x : ℝ) : ℂ)
      = ((∑ T : Finset (Fin M),
          checkLambda D.C D.gam T
            * (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k)) : ℝ) : ℂ) := by
    have h1 : ((x ⬝ᵥ B.Vr *ᵥ x : ℝ) : ℂ) = cvec x ⬝ᵥ (D.V *ᵥ cvec x) := by
      rw [B.hVr, cvec_mulVec, cvec_dotProduct]
    rw [h1, hV, dotProduct_sum, Complex.ofReal_sum]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [dotProduct_smul, smul_eq_mul, quad_Qproj x T, Complex.ofReal_mul]
  exact_mod_cast hC

/-- **人手証明 Step 1**: `x ∈ 𝓕^{(+)} ∩ ℝ^{2^M}`, `‖x‖ = 1` なら `x^T W x ≤ Λ̌_max`。 -/
theorem quad_le_lamMax {x : Conf M → ℝ} (hx : epsilonR M *ᵥ x = x) (hn : vecNormSq x = 1) :
    x ⬝ᵥ B.W *ᵥ x ≤ D.lamMax := by
  rw [B.hWV x hx, B.quad_Vr_eq_sum x]
  have hnn : ∀ T : Finset (Fin M),
      0 ≤ ∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k) :=
    fun T => Finset.sum_nonneg fun k _ => Complex.normSq_nonneg _
  calc ∑ T : Finset (Fin M),
        checkLambda D.C D.gam T * (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k))
      ≤ ∑ T : Finset (Fin M),
          D.lamMax * (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k)) :=
        Finset.sum_le_sum fun T _ =>
          mul_le_mul_of_nonneg_right (D.checkLambda_le_lamMax T) (hnn T)
    _ = D.lamMax * ∑ T : Finset (Fin M), (∑ k, Complex.normSq ((F.Qproj T *ᵥ cvec x) k)) := by
        rw [Finset.mul_sum]
    _ = D.lamMax := by rw [sum_quad_Qproj x, hn, mul_one]

/-! ## Step 2: 実の最大固有ベクトルの存在 -/

/-- 複素ベクトルの実部。 -/
def reVec {n : Type*} (v : n → ℂ) : n → ℝ := fun k => (v k).re

theorem cvec_reVec_add {n : Type*} (v : n → ℂ) (k : n) :
    (cvec (reVec v) k) = ((v k).re : ℂ) := rfl

/-- 実行列の固有ベクトルの実部も固有ベクトル（固有値が実のとき）。 -/
theorem reVec_eigen {n : Type*} [Fintype n] {A : Matrix n n ℝ} {v : n → ℂ} {lam : ℝ}
    (h : (A.map (fun r : ℝ => (r : ℂ))) *ᵥ v = (lam : ℂ) • v) :
    A *ᵥ reVec v = lam • reVec v := by
  funext k
  have hk := congrFun h k
  have hL : ((A.map (fun r : ℝ => (r : ℂ))) *ᵥ v) k = ∑ j, ((A k j : ℂ) * v j) := rfl
  rw [hL] at hk
  have := congrArg Complex.re hk
  simp only [Complex.add_re, Pi.smul_apply, smul_eq_mul, Complex.mul_re, Complex.ofReal_re,
    Complex.ofReal_im, zero_mul, sub_zero, Complex.re_sum] at this
  simpa [Matrix.mulVec, dotProduct, reVec] using this

/-- **人手証明 Step 2**: `Λ̌_max` の固有ベクトルで実のものが存在し、偶セクターに属する。 -/
theorem exists_real_max_eigenvector (htr : 0 < ((epsilon M * D.V).trace).re) :
    ∃ y : Conf M → ℝ, y ≠ 0 ∧ B.Vr *ᵥ y = D.lamMax • y ∧ epsilonR M *ᵥ y = y := by
  obtain ⟨q, hq0, hqfix, _⟩ := F.exists_Qproj_generator (Finset.univ : Finset (Fin M))
  -- `V^{(+)} q = Λ̌_max q`
  have hVq0 : D.V *ᵥ q = ((D.lamMax : ℝ) : ℂ) • q :=
    calc D.V *ᵥ q = D.V *ᵥ (F.Qproj Finset.univ *ᵥ q) := by rw [hqfix]
      _ = (D.V * F.Qproj Finset.univ) *ᵥ q := by rw [Matrix.mulVec_mulVec]
      _ = (((checkLambda D.C D.gam (Finset.univ : Finset (Fin M)) : ℝ) : ℂ)
            • F.Qproj Finset.univ) *ᵥ q := by rw [D.hV]
      _ = ((D.lamMax : ℝ) : ℂ) • q := by
          rw [Matrix.smul_mulVec, hqfix]; rfl
  have hVq : ∀ c : ℂ, D.V *ᵥ (c • q) = ((D.lamMax : ℝ) : ℂ) • (c • q) := by
    intro c
    rw [Matrix.mulVec_smul, hVq0, smul_comm]
  -- `ε (c q) = c q`
  have hεq : ∀ c : ℂ, epsilon M *ᵥ (c • q) = c • q := by
    intro c
    rw [Matrix.mulVec_smul, D.mem_evenSector_of_mem_range_univ htr hqfix]
  -- 実部を取る
  have hmain : ∀ c : ℂ, reVec (c • q) ≠ 0 →
      ∃ y : Conf M → ℝ, y ≠ 0 ∧ B.Vr *ᵥ y = D.lamMax • y ∧ epsilonR M *ᵥ y = y := by
    intro c hc
    refine ⟨reVec (c • q), hc, ?_, ?_⟩
    · exact reVec_eigen (by rw [← B.hVr]; exact hVq c)
    · have h1 : (epsilonR M).map (fun r : ℝ => (r : ℂ)) = epsilon M := by
        funext l k
        rw [Matrix.map_apply, ← epsilon_eq_ofReal_epsilonR]
      have h2 : ((epsilonR M).map (fun r : ℝ => (r : ℂ))) *ᵥ (c • q)
          = ((1 : ℝ) : ℂ) • (c • q) := by
        rw [h1, hεq c]
        simp
      have := reVec_eigen (A := epsilonR M) h2
      rwa [one_smul] at this
  -- どちらかの実部は `0` でない
  by_cases h1 : reVec ((1 : ℂ) • q) = 0
  · refine hmain (-Complex.I) ?_
    intro h2
    apply hq0
    funext k
    have e1 : (q k).re = 0 := by
      have := congrFun h1 k
      simpa [reVec] using this
    have e2 : (q k).im = 0 := by
      have := congrFun h2 k
      simp only [reVec, Pi.smul_apply, smul_eq_mul, Complex.mul_re, Complex.neg_re,
        Complex.I_re, Complex.neg_im, Complex.I_im, neg_zero, zero_mul, neg_mul, one_mul,
        zero_sub, neg_neg, Pi.zero_apply] at this
      exact this
    exact Complex.ext e1 e2
  · exact hmain 1 h1

/-! ## Step 3: `c_+(M) = Λ̌_max` -/

/-- **人手証明 `c_plus_equals_Lambda_half_integer` そのもの**: `c_+(M) = Λ̌_max`。

さらに上限は達成される（`x_0` が最大値を与える）。 -/
theorem c_plus_equals_lamMax (htr : 0 < ((epsilon M * D.V).trace).re) :
    sectorRayleighSup B.W (epsilonR M) 1 = D.lamMax := by
  obtain ⟨y, hy0, hyeig, hyeps⟩ := B.exists_real_max_eigenvector htr
  -- `x_0 = y / ‖y‖`
  have ha : 0 < vecNormSq y := vecNormSq_pos hy0
  set a := vecNormSq y with hadef
  set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
  have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
  have hc2 : c ^ 2 = a⁻¹ := by rw [hcdef, inv_pow, hsq]
  have hunit : vecNormSq (c • y) = 1 := by
    rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
  have hsec : epsilonR M *ᵥ (c • y) = (1 : ℝ) • (c • y) := by
    rw [Matrix.mulVec_smul, hyeps, one_smul]
  -- `x_0^T W x_0 = Λ̌_max`
  have hquad : (c • y) ⬝ᵥ B.W *ᵥ (c • y) = D.lamMax := by
    rw [quad_smul, B.hWV y hyeps, hyeig]
    rw [dotProduct_smul, smul_eq_mul, hc2]
    rw [show y ⬝ᵥ y = a from rfl]
    field_simp
  refine le_antisymm ?_ ?_
  · refine csSup_le ⟨_, ⟨c • y, hsec, hunit, rfl⟩⟩ ?_
    rintro r ⟨x, hxs, hxn, rfl⟩
    rw [one_smul] at hxs
    exact B.quad_le_lamMax hxs hxn
  · rw [← hquad]
    exact le_csSup (sectorSet_bddAbove B.hWsymm B.hWpsd (epsilonR M) 1)
      ⟨c • y, hsec, hunit, rfl⟩

/-- 上限が偶セクターの実単位ベクトルで**達成される**こと（人手証明の最後の一文）。 -/
theorem exists_maximizer (htr : 0 < ((epsilon M * D.V).trace).re) :
    ∃ x0 : Conf M → ℝ, epsilonR M *ᵥ x0 = x0 ∧ vecNormSq x0 = 1 ∧
      x0 ⬝ᵥ B.W *ᵥ x0 = sectorRayleighSup B.W (epsilonR M) 1 := by
  obtain ⟨y, hy0, hyeig, hyeps⟩ := B.exists_real_max_eigenvector htr
  have ha : 0 < vecNormSq y := vecNormSq_pos hy0
  set a := vecNormSq y with hadef
  set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
  have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
  have hc2 : c ^ 2 = a⁻¹ := by rw [hcdef, inv_pow, hsq]
  have hunit : vecNormSq (c • y) = 1 := by
    rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
  refine ⟨c • y, by rw [Matrix.mulVec_smul, hyeps], hunit, ?_⟩
  rw [B.c_plus_equals_lamMax htr, quad_smul, B.hWV y hyeps, hyeig, dotProduct_smul, smul_eq_mul,
    hc2, show y ⬝ᵥ y = a from rfl]
  field_simp

end EvenSectorBridge

end Ising2D
