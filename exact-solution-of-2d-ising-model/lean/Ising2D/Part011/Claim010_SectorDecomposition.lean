/-
# `c(M) = max(c₊(M), c₋(M))`（偶奇セクターへの分解）

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_010_claim_sector_decomposition_of_c`、ラベル **`sector_decomposition_of_rayleigh_sup`**）

人手証明の (1)（`εW = Wε` と `W` が `F^{(±)}` を保つこと）と (3)（`c(M) = max(c₊, c₋)`）を
形式化する。

人手証明の (2) の行列等式は
`Ising2D.physicalSymTransferR_map_mul_epsProj_eq_Vsym` で形式化済みである。
本ファイルは実行列上の Rayleigh 上限の分解だけを扱い、この複素行列等式から章 018 の
`EvenSectorBridge.hWV` への変換（`V^{(+)}` の実行列表示を含む）は扱わない。

## この主張に効いている構造（必要十分版を別に置かない理由）

この主張は「対合 `ε`（`ε² = 1`、対称）で `W` と可換なもの」があれば成り立ち、
`ε` が `σ^x` の積であることも、`W` が転送行列であることも効いていない。
本ファイルの定理はすでにその一般性で述べてある（`ε : Matrix n n ℝ` は
`ε.IsSymm`, `ε * ε = 1`, `ε * W = W * ε` しか仮定していない）ので、
これ以上ほどく余地がない（`sSup` は ℝ の完備性そのもの）。
-/
import Ising2D.Part011.Claim008_TracePowerSandwich

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- 人手証明の `{xᵀWx | x ∈ F^{(s)}, ‖x‖ = 1}`（`s = ±1`）。 -/
def sectorSet (W ε : Matrix n n ℝ) (s : ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = s • x ∧ vecNormSq x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- 人手証明の `c_±(M)`。 -/
noncomputable def sectorRayleighSup (W ε : Matrix n n ℝ) (s : ℝ) : ℝ := sSup (sectorSet W ε s)

/-- **(1) `W` は `F^{(±)}` を保つ**（人手証明 (1) の後半）。 -/
theorem sector_invariant {W ε : Matrix n n ℝ} (hcomm : ε * W = W * ε) {s : ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = s • x) : ε *ᵥ (W *ᵥ x) = s • (W *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, hcomm, ← Matrix.mulVec_mulVec, hx, Matrix.mulVec_smul]

/-- 異なる固有値の固有ベクトルは直交する（人手証明の `x₊ᵀx₋ = 0`）。 -/
theorem sector_orthogonal {ε : Matrix n n ℝ} (hε : ε.IsSymm) {u v : n → ℝ}
    (hu : ε *ᵥ u = u) (hv : ε *ᵥ v = -v) : u ⬝ᵥ v = 0 := by
  have h1 : u ⬝ᵥ ε *ᵥ v = (ε *ᵥ u) ⬝ᵥ v := mulVec_dotProduct_selfadjoint hε u v
  rw [hu, hv] at h1
  rw [dotProduct_neg] at h1
  linarith

/-- セクターは正のスカラー倍で閉じている。 -/
theorem sector_smul {ε : Matrix n n ℝ} {s c : ℝ} {x : n → ℝ} (hx : ε *ᵥ x = s • x) :
    ε *ᵥ (c • x) = s • (c • x) := by
  rw [Matrix.mulVec_smul, hx, smul_comm]

theorem sectorSet_subset (W ε : Matrix n n ℝ) (s : ℝ) :
    sectorSet W ε s ⊆ rayleighSet W := by
  rintro r ⟨x, _, hx, rfl⟩
  exact ⟨x, hx, rfl⟩

theorem sectorSet_bddAbove {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (ε : Matrix n n ℝ) (s : ℝ) :
    BddAbove (sectorSet W ε s) :=
  (rayleighSet_bddAbove hW hpsd).mono (sectorSet_subset W ε s)

theorem sectorRayleighSup_le {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (ε : Matrix n n ℝ) (s : ℝ) :
    sectorRayleighSup W ε s ≤ rayleighSup W := by
  rcases Set.eq_empty_or_nonempty (sectorSet W ε s) with hemp | hne
  · rw [sectorRayleighSup, hemp, Real.sSup_empty]
    exact rayleighSup_nonneg hW hpsd
  · refine csSup_le hne ?_
    intro r hr
    exact le_csSup (rayleighSet_bddAbove hW hpsd) (sectorSet_subset W ε s hr)

/-- セクター内の任意のベクトルに対する `xᵀWx ≤ c_s ‖x‖²`。 -/
theorem sector_quad_le {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) {ε : Matrix n n ℝ} {s : ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = s • x) :
    x ⬝ᵥ W *ᵥ x ≤ sectorRayleighSup W ε s * vecNormSq x := by
  rcases eq_or_ne x 0 with rfl | hx0
  · simp [vecNormSq]
  · have ha : 0 < vecNormSq x := vecNormSq_pos hx0
    set a := vecNormSq x with hadef
    set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
    have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
    have hc2 : c ^ 2 = a⁻¹ := by
      rw [hcdef, inv_pow, hsq]
    have hunit : vecNormSq (c • x) = 1 := by
      rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
    have hmem : (c • x) ⬝ᵥ W *ᵥ (c • x) ∈ sectorSet W ε s :=
      ⟨c • x, sector_smul hx, hunit, rfl⟩
    have hle : (c • x) ⬝ᵥ W *ᵥ (c • x) ≤ sectorRayleighSup W ε s :=
      le_csSup (sectorSet_bddAbove hW hpsd ε s) hmem
    rw [quad_smul, hc2] at hle
    calc x ⬝ᵥ W *ᵥ x = a * (a⁻¹ * (x ⬝ᵥ W *ᵥ x)) := by field_simp
      _ ≤ a * sectorRayleighSup W ε s := mul_le_mul_of_nonneg_left hle ha.le
      _ = sectorRayleighSup W ε s * a := by ring

/-! ## 射影 `P^{(±)} = (1 ± ε)/2` -/

/-- 人手証明の `P^{(+)}`。 -/
noncomputable def projPlus (ε : Matrix n n ℝ) : Matrix n n ℝ := (2 : ℝ)⁻¹ • ((1 : Matrix n n ℝ) + ε)

/-- 人手証明の `P^{(-)}`。 -/
noncomputable def projMinus (ε : Matrix n n ℝ) : Matrix n n ℝ := (2 : ℝ)⁻¹ • ((1 : Matrix n n ℝ) - ε)

theorem proj_add_eq_one (ε : Matrix n n ℝ) : projPlus ε + projMinus ε = 1 := by
  simp only [projPlus, projMinus, ← smul_add]
  rw [show (1 : Matrix n n ℝ) + ε + (1 - ε) = (2 : ℝ) • (1 : Matrix n n ℝ) by
    rw [two_smul]; abel]
  rw [smul_smul, inv_mul_cancel₀ (two_ne_zero), one_smul]

theorem projPlus_mulVec_eigen {ε : Matrix n n ℝ} (hεε : ε * ε = 1) (x : n → ℝ) :
    ε *ᵥ (projPlus ε *ᵥ x) = projPlus ε *ᵥ x := by
  rw [Matrix.mulVec_mulVec]
  congr 1
  simp only [projPlus, Matrix.mul_smul, Matrix.mul_add, Matrix.mul_one, hεε]
  congr 1
  abel

theorem projMinus_mulVec_eigen {ε : Matrix n n ℝ} (hεε : ε * ε = 1) (x : n → ℝ) :
    ε *ᵥ (projMinus ε *ᵥ x) = -(projMinus ε *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, ← Matrix.neg_mulVec]
  congr 1
  simp only [projMinus, Matrix.mul_smul, Matrix.mul_sub, Matrix.mul_one, hεε, ← smul_neg]
  congr 1
  abel

/-- **(3) `c(M) = max(c₊(M), c₋(M))`**（人手証明 `sector_decomposition_of_rayleigh_sup` (3)）。 -/
theorem sector_decomposition_of_rayleigh_sup {W ε : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hε : ε.IsSymm) (hεε : ε * ε = 1)
    (hcomm : ε * W = W * ε) :
    rayleighSup W = max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) := by
  refine le_antisymm ?_ ?_
  · -- `c(M) ≤ max(c₊, c₋)`
    refine csSup_le (rayleighSet_nonempty W) ?_
    rintro r ⟨x, hx, rfl⟩
    set xp := projPlus ε *ᵥ x with hxp
    set xm := projMinus ε *ᵥ x with hxm
    have hplus : ε *ᵥ xp = xp := projPlus_mulVec_eigen hεε x
    have hminus : ε *ᵥ xm = -xm := projMinus_mulVec_eigen hεε x
    have hplus' : ε *ᵥ xp = (1 : ℝ) • xp := by rw [hplus, one_smul]
    have hminus' : ε *ᵥ xm = (-1 : ℝ) • xm := by rw [hminus, neg_one_smul]
    have hWp : ε *ᵥ (W *ᵥ xp) = W *ᵥ xp := by
      have h := sector_invariant hcomm hplus'
      rwa [one_smul] at h
    have hWm : ε *ᵥ (W *ᵥ xm) = -(W *ᵥ xm) := by
      have h := sector_invariant hcomm hminus'
      rwa [neg_one_smul] at h
    have hsum : xp + xm = x := by
      rw [hxp, hxm, ← Matrix.add_mulVec, proj_add_eq_one, Matrix.one_mulVec]
    -- 直交性
    have hortho : xp ⬝ᵥ xm = 0 := sector_orthogonal hε hplus hminus
    have horthoW1 : xp ⬝ᵥ W *ᵥ xm = 0 := sector_orthogonal hε hplus hWm
    have horthoW2 : xm ⬝ᵥ W *ᵥ xp = 0 := by
      have h := sector_orthogonal hε hWp hminus
      rw [dotProduct_comm] at h
      exact h
    -- ノルムの分解
    have hnorm : vecNormSq x = vecNormSq xp + vecNormSq xm := by
      rw [← hsum]
      simp only [vecNormSq, add_dotProduct, dotProduct_add]
      rw [hortho, dotProduct_comm xm xp, hortho]
      ring
    -- 2 次形式の分解
    have hquad : x ⬝ᵥ W *ᵥ x = xp ⬝ᵥ W *ᵥ xp + xm ⬝ᵥ W *ᵥ xm := by
      rw [← hsum]
      simp only [Matrix.mulVec_add, add_dotProduct, dotProduct_add]
      rw [horthoW1, horthoW2]
      ring
    have hbp := sector_quad_le hW hpsd (s := (1 : ℝ)) (x := xp) hplus'
    have hbm := sector_quad_le hW hpsd (s := (-1 : ℝ)) (x := xm) hminus'
    have hnp : 0 ≤ vecNormSq xp := vecNormSq_nonneg xp
    have hnm : 0 ≤ vecNormSq xm := vecNormSq_nonneg xm
    have hmp : sectorRayleighSup W ε 1 ≤ max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) :=
      le_max_left _ _
    have hmm : sectorRayleighSup W ε (-1) ≤ max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) :=
      le_max_right _ _
    calc x ⬝ᵥ W *ᵥ x = xp ⬝ᵥ W *ᵥ xp + xm ⬝ᵥ W *ᵥ xm := hquad
      _ ≤ sectorRayleighSup W ε 1 * vecNormSq xp
            + sectorRayleighSup W ε (-1) * vecNormSq xm := add_le_add hbp hbm
      _ ≤ max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) * vecNormSq xp
            + max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) * vecNormSq xm :=
          add_le_add (mul_le_mul_of_nonneg_right hmp hnp)
            (mul_le_mul_of_nonneg_right hmm hnm)
      _ = max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) * vecNormSq x := by
          rw [hnorm]
          ring
      _ = max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) := by
          rw [hx, mul_one]
  · -- `max(c₊, c₋) ≤ c(M)`
    exact max_le (sectorRayleighSup_le hW hpsd ε 1) (sectorRayleighSup_le hW hpsd ε (-1))

end Ising2D
