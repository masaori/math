/-
# 符号つきのセクターの上限 `c_±(M)` と `c(M) = max(c_+(M), c_-(M))`（**必要十分版**の側の定義。形式化の記録）

対応する人手の主張は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避した
`sector_decomposition_of_rayleigh_sup` である（`(−)` セクターを本文から外したため）。

具体版の同じ定義と性質は、退避先 `Ising2D/RoutesNotAdopted/MinusSector/ClaimRayleighSupSectorDecomposition.lean` の
`Ising2D.sectorSet`・`sectorRayleighSup`・`sector_invariant`・`sector_orthogonal`・`sector_smul`・`sectorSet_subset`・
`sectorSet_bddAbove`・`sectorRayleighSup_le`・`sector_quad_le`・`projPlus`・`projMinus`・`proj_add_eq_one`・
`projPlus_mulVec_eigen`・`projMinus_mulVec_eigen`・`sector_decomposition_of_rayleigh_sup` である。
このファイルは、それらを具体版と同じ式・同じ手順で必要十分版の側に置く。具体版とこのファイルの定義が同じ集合・同じ値であることと、
具体版の `sector_decomposition_of_rayleigh_sup` がこのファイルの特殊化であることは、
導出 `RoutesNotAdopted/MinusSector/ClaimRayleighSupSectorDecompositionFromNecSuf.lean` だけが述べる。

このファイルを置くのは、`(−)` セクターの必要十分版 `PermSector.lean` が具体版を参照せずに済むようにするためである
（具体版と必要十分版は互いを参照しない。`lean/README.md`）。ノルム・`𝓡`・`c(M)` は、必要十分版の側の
`vecNorm'`（`RealVectorNorm.lean`）・`rayleighSet'`・`rayleighSup'`（`RayleighSupAndSectorRayleighSup.lean`）を使う。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `sectorSet`・`sectorRayleighSup`（`{xᵀWx \| εx = sx, ‖x‖ = 1}` とその上限） | `sectorSet'`・`sectorRayleighSup'`（同じ式） | `ℝ`（`sSup` と平方根のノルム） |
| `sector_invariant`（`εW = Wε` なら `W` はセクターを保つ） | `sector_invariant'`（同じ手順） | `εW = Wε` だけ |
| `sector_orthogonal`（`εu = u`・`εv = -v` なら `uᵀv = 0`） | `sector_orthogonal'`（同じ手順） | `ε` が対称であること |
| `sector_smul`・`sectorSet_subset`・`sectorSet_bddAbove` | 同じ名前に `'`（同じ手順） | なし（`𝓡` の上界 `Σ_iΣ_j\|W_ij\|` から有界） |
| `sectorRayleighSup_le`（`c_s(M) ≤ c(M)`） | `sectorRayleighSup'_le`（同じ手順） | `W` の半正定値性と `n` が空でないこと（空のセクターの上限 `0` と `c(M) ≥ 0` を比べる段。具体版と同じ） |
| `sector_quad_le`（セクターの `x` に `xᵀWx ≤ c_s(M)‖x‖²`） | `sector_quad_le'`（同じ手順） | なし |
| `projPlus`・`projMinus`・`proj_add_eq_one`・`projPlus_mulVec_eigen`・`projMinus_mulVec_eigen` | 同じ名前に `'`（同じ式・同じ手順） | `ε² = 1`（射影の像がセクターに入る段） |
| `sector_decomposition_of_rayleigh_sup`（`c(M) = max(c_+(M), c_-(M))`） | `sector_decomposition_of_rayleigh_sup'`（同じ手順） | `W` の半正定値性、`ε` が対称、`ε² = 1`、`εW = Wε` |

* 具体版はもとから任意の添字の型 `n` と任意の実行列 `W`・`ε` について述べてあり、Ising 模型の構造を含まない。
  このファイルで係数を `ℝ` から上げないのは、`sSup` が `ℝ` の完備性そのもので、ノルムが `ℝ` の平方根だからである。
* `W` の対称性は使っていない（具体版と同じ）。
-/
import Ising2D.NecSuf.RayleighSupAndSectorRayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- `{xᵀWx | x ∈ F^{(s)}, ‖x‖ = 1}`（`s = ±1`。具体版 `Ising2D.sectorSet` と同じ式）。 -/
def sectorSet' (W ε : Matrix n n ℝ) (s : ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = s • x ∧ vecNorm' x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- `c_±(M)`（具体版 `Ising2D.sectorRayleighSup` と同じ式）。 -/
noncomputable def sectorRayleighSup' (W ε : Matrix n n ℝ) (s : ℝ) : ℝ := sSup (sectorSet' W ε s)

/-- `W` は `F^{(±)}` を保つ（具体版 `Ising2D.sector_invariant` と同じ手順）。 -/
theorem sector_invariant' {W ε : Matrix n n ℝ} (hcomm : ε * W = W * ε) {s : ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = s • x) : ε *ᵥ (W *ᵥ x) = s • (W *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, hcomm, ← Matrix.mulVec_mulVec, hx, Matrix.mulVec_smul]

/-- 異なる固有値の固有ベクトルは直交する（具体版 `Ising2D.sector_orthogonal` と同じ手順）。 -/
theorem sector_orthogonal' {ε : Matrix n n ℝ} (hε : ε.IsSymm) {u v : n → ℝ}
    (hu : ε *ᵥ u = u) (hv : ε *ᵥ v = -v) : u ⬝ᵥ v = 0 := by
  have h1 : u ⬝ᵥ ε *ᵥ v = (ε *ᵥ u) ⬝ᵥ v := mulVec_dotProduct_selfadjoint' hε u v
  rw [hu, hv] at h1
  rw [dotProduct_neg] at h1
  linarith

/-- セクターはスカラー倍で閉じている（具体版 `Ising2D.sector_smul` と同じ手順）。 -/
theorem sector_smul' {ε : Matrix n n ℝ} {s c : ℝ} {x : n → ℝ} (hx : ε *ᵥ x = s • x) :
    ε *ᵥ (c • x) = s • (c • x) := by
  rw [Matrix.mulVec_smul, hx, smul_comm]

/-- `𝓡_s ⊆ 𝓡`（具体版 `Ising2D.sectorSet_subset` と同じ手順）。 -/
theorem sectorSet'_subset (W ε : Matrix n n ℝ) (s : ℝ) :
    sectorSet' W ε s ⊆ rayleighSet' W := by
  rintro r ⟨x, _, hx, rfl⟩
  exact ⟨x, hx, rfl⟩

/-- `𝓡_s` は上に有界（具体版 `Ising2D.sectorSet_bddAbove` と同じ手順: `𝓡_s ⊆ 𝓡` と `𝓡` の有界性）。 -/
theorem sectorSet'_bddAbove (W ε : Matrix n n ℝ) (s : ℝ) :
    BddAbove (sectorSet' W ε s) :=
  (rayleighSet'_bddAbove W).mono (sectorSet'_subset W ε s)

/-- `c_s(M) ≤ c(M)`（具体版 `Ising2D.sectorRayleighSup_le` と同じ手順。
空のセクターでは上限が `0` なので、`c(M) ≥ 0` に `W` の半正定値性が要る）。 -/
theorem sectorRayleighSup'_le {W : Matrix n n ℝ}
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (ε : Matrix n n ℝ) (s : ℝ) :
    sectorRayleighSup' W ε s ≤ rayleighSup' W := by
  rcases Set.eq_empty_or_nonempty (sectorSet' W ε s) with hemp | hne
  · rw [sectorRayleighSup', hemp, Real.sSup_empty]
    exact rayleighSup'_nonneg hpsd
  · refine csSup_le hne ?_
    intro r hr
    exact le_csSup (rayleighSet'_bddAbove W) (sectorSet'_subset W ε s hr)

/-- セクター内の任意のベクトルに対する `xᵀWx ≤ c_s ‖x‖²`（具体版 `Ising2D.sector_quad_le` と同じ手順）。 -/
theorem sector_quad_le' {W : Matrix n n ℝ} {ε : Matrix n n ℝ} {s : ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = s • x) :
    x ⬝ᵥ W *ᵥ x ≤ sectorRayleighSup' W ε s * vecNormSq' x := by
  rcases eq_or_ne x 0 with rfl | hx0
  · simp [vecNormSq']
  · have ha : 0 < vecNormSq' x := vecNormSq'_pos hx0
    set a := vecNormSq' x with hadef
    set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
    have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
    have hc2 : c ^ 2 = a⁻¹ := by
      rw [hcdef, inv_pow, hsq]
    have hunit : vecNormSq' (c • x) = 1 := by
      rw [vecNormSq'_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
    have hmem : (c • x) ⬝ᵥ W *ᵥ (c • x) ∈ sectorSet' W ε s :=
      ⟨c • x, sector_smul' hx, vecNorm'_eq_one_of_vecNormSq'_eq_one hunit, rfl⟩
    have hle : (c • x) ⬝ᵥ W *ᵥ (c • x) ≤ sectorRayleighSup' W ε s :=
      le_csSup (sectorSet'_bddAbove W ε s) hmem
    rw [quad_smul', hc2] at hle
    calc x ⬝ᵥ W *ᵥ x = a * (a⁻¹ * (x ⬝ᵥ W *ᵥ x)) := by field_simp
      _ ≤ a * sectorRayleighSup' W ε s := mul_le_mul_of_nonneg_left hle ha.le
      _ = sectorRayleighSup' W ε s * a := by ring

/-! ## 射影 `P^{(±)} = (1 ± ε)/2` -/

/-- `P^{(+)}`（具体版 `Ising2D.projPlus` と同じ式）。 -/
noncomputable def projPlus' (ε : Matrix n n ℝ) : Matrix n n ℝ := (2 : ℝ)⁻¹ • ((1 : Matrix n n ℝ) + ε)

/-- `P^{(-)}`（具体版 `Ising2D.projMinus` と同じ式）。 -/
noncomputable def projMinus' (ε : Matrix n n ℝ) : Matrix n n ℝ := (2 : ℝ)⁻¹ • ((1 : Matrix n n ℝ) - ε)

/-- `P^{(+)} + P^{(-)} = 1`（具体版 `Ising2D.proj_add_eq_one` と同じ手順）。 -/
theorem proj_add_eq_one' (ε : Matrix n n ℝ) : projPlus' ε + projMinus' ε = 1 := by
  simp only [projPlus', projMinus', ← smul_add]
  rw [show (1 : Matrix n n ℝ) + ε + (1 - ε) = (2 : ℝ) • (1 : Matrix n n ℝ) by
    rw [two_smul]; abel]
  rw [smul_smul, inv_mul_cancel₀ (two_ne_zero), one_smul]

/-- `ε P^{(+)} x = P^{(+)} x`（具体版 `Ising2D.projPlus_mulVec_eigen` と同じ手順）。 -/
theorem projPlus'_mulVec_eigen {ε : Matrix n n ℝ} (hεε : ε * ε = 1) (x : n → ℝ) :
    ε *ᵥ (projPlus' ε *ᵥ x) = projPlus' ε *ᵥ x := by
  rw [Matrix.mulVec_mulVec]
  congr 1
  simp only [projPlus', Matrix.mul_smul, Matrix.mul_add, Matrix.mul_one, hεε]
  congr 1
  abel

/-- `ε P^{(-)} x = -P^{(-)} x`（具体版 `Ising2D.projMinus_mulVec_eigen` と同じ手順）。 -/
theorem projMinus'_mulVec_eigen {ε : Matrix n n ℝ} (hεε : ε * ε = 1) (x : n → ℝ) :
    ε *ᵥ (projMinus' ε *ᵥ x) = -(projMinus' ε *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, ← Matrix.neg_mulVec]
  congr 1
  simp only [projMinus', Matrix.mul_smul, Matrix.mul_sub, Matrix.mul_one, hεε, ← smul_neg]
  congr 1
  abel

/-- **ノートの `sector_decomposition_of_rayleigh_sup` (3) の必要十分版** `c(M) = max(c_+(M), c_-(M))`
（具体版 `Ising2D.sector_decomposition_of_rayleigh_sup` と同じ手順）。 -/
theorem sector_decomposition_of_rayleigh_sup' {W ε : Matrix n n ℝ}
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hε : ε.IsSymm) (hεε : ε * ε = 1)
    (hcomm : ε * W = W * ε) :
    rayleighSup' W = max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) := by
  refine le_antisymm ?_ ?_
  · -- `c(M) ≤ max(c₊, c₋)`
    refine csSup_le (rayleighSet'_nonempty W) ?_
    rintro r ⟨x, hx, rfl⟩
    set xp := projPlus' ε *ᵥ x with hxp
    set xm := projMinus' ε *ᵥ x with hxm
    have hplus : ε *ᵥ xp = xp := projPlus'_mulVec_eigen hεε x
    have hminus : ε *ᵥ xm = -xm := projMinus'_mulVec_eigen hεε x
    have hplus' : ε *ᵥ xp = (1 : ℝ) • xp := by rw [hplus, one_smul]
    have hminus' : ε *ᵥ xm = (-1 : ℝ) • xm := by rw [hminus, neg_one_smul]
    have hWp : ε *ᵥ (W *ᵥ xp) = W *ᵥ xp := by
      have h := sector_invariant' hcomm hplus'
      rwa [one_smul] at h
    have hWm : ε *ᵥ (W *ᵥ xm) = -(W *ᵥ xm) := by
      have h := sector_invariant' hcomm hminus'
      rwa [neg_one_smul] at h
    have hsum : xp + xm = x := by
      rw [hxp, hxm, ← Matrix.add_mulVec, proj_add_eq_one', Matrix.one_mulVec]
    -- 直交性
    have hortho : xp ⬝ᵥ xm = 0 := sector_orthogonal' hε hplus hminus
    have horthoW1 : xp ⬝ᵥ W *ᵥ xm = 0 := sector_orthogonal' hε hplus hWm
    have horthoW2 : xm ⬝ᵥ W *ᵥ xp = 0 := by
      have h := sector_orthogonal' hε hWp hminus
      rw [dotProduct_comm] at h
      exact h
    -- ノルムの分解
    have hnorm : vecNormSq' x = vecNormSq' xp + vecNormSq' xm := by
      rw [← hsum]
      simp only [vecNormSq', add_dotProduct, dotProduct_add]
      rw [hortho, dotProduct_comm xm xp, hortho]
      ring
    -- 2 次形式の分解
    have hquad : x ⬝ᵥ W *ᵥ x = xp ⬝ᵥ W *ᵥ xp + xm ⬝ᵥ W *ᵥ xm := by
      rw [← hsum]
      simp only [Matrix.mulVec_add, add_dotProduct, dotProduct_add]
      rw [horthoW1, horthoW2]
      ring
    have hbp := sector_quad_le' (W := W) (s := (1 : ℝ)) (x := xp) hplus'
    have hbm := sector_quad_le' (W := W) (s := (-1 : ℝ)) (x := xm) hminus'
    have hnp : 0 ≤ vecNormSq' xp := vecNormSq'_nonneg xp
    have hnm : 0 ≤ vecNormSq' xm := vecNormSq'_nonneg xm
    have hmp : sectorRayleighSup' W ε 1 ≤ max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) :=
      le_max_left _ _
    have hmm : sectorRayleighSup' W ε (-1) ≤ max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) :=
      le_max_right _ _
    calc x ⬝ᵥ W *ᵥ x = xp ⬝ᵥ W *ᵥ xp + xm ⬝ᵥ W *ᵥ xm := hquad
      _ ≤ sectorRayleighSup' W ε 1 * vecNormSq' xp
            + sectorRayleighSup' W ε (-1) * vecNormSq' xm := add_le_add hbp hbm
      _ ≤ max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) * vecNormSq' xp
            + max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) * vecNormSq' xm :=
          add_le_add (mul_le_mul_of_nonneg_right hmp hnp)
            (mul_le_mul_of_nonneg_right hmm hnm)
      _ = max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) * vecNormSq' x := by
          rw [hnorm]
          ring
      _ = max (sectorRayleighSup' W ε 1) (sectorRayleighSup' W ε (-1)) := by
          rw [vecNormSq'_eq_one_of_vecNorm'_eq_one hx, mul_one]
  · -- `max(c₊, c₋) ≤ c(M)`
    exact max_le (sectorRayleighSup'_le hpsd ε 1) (sectorRayleighSup'_le hpsd ε (-1))

end Ising2D.NecSuf
