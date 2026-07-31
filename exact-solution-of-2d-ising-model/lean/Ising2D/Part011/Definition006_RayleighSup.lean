/-
# `c(M) := sup_{‖x‖=1} xᵀ W x` の定義

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_006_definition_rayleigh_sup`、ラベル **`def_rayleigh_sup`**）

人手証明のとおり、**`c(M)` は最大固有値ではなく Rayleigh 商の上限として定義する。**
上限が達成されること（固有値の存在・スペクトル定理）はここでも以降でも一切使わない。

上に有界であることの根拠として、人手証明は `|xᵀWx| ≤ ‖W‖‖x‖²`（行列ノルム）を挙げているが、
本形式化では既に用意した `Ising2D.psd_quad_le_normSq_mul_trace`（半正定値行列に対する
`xᵀAx ≤ ‖x‖² tr A`）を使う。どちらでも「上に有界な空でない実数集合は上限をもつ」という
結論は同じであり、後者の方が本章の中で閉じている。

必要十分版はない（`sSup` は ℝ の完備性そのものなので、ほどく余地がない）。
-/
import Ising2D.Part011.TraceBound

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- スカラー倍に対する 2 次形式の振る舞い `(cx)ᵀA(cx) = c²(xᵀAx)`。 -/
theorem quad_smul (A : Matrix n n ℝ) (c : ℝ) (x : n → ℝ) :
    (c • x) ⬝ᵥ A *ᵥ (c • x) = c ^ 2 * (x ⬝ᵥ A *ᵥ x) := by
  rw [Matrix.mulVec_smul, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul]
  ring

/-- 人手証明の `𝓡 = {xᵀWx | ‖x‖ = 1}`。 -/
def rayleighSet (W : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, vecNormSq x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- 人手証明の `c(M) := sup 𝓡`。 -/
noncomputable def rayleighSup (W : Matrix n n ℝ) : ℝ := sSup (rayleighSet W)

variable [Nonempty n]

theorem rayleighSet_nonempty (W : Matrix n n ℝ) : (rayleighSet W).Nonempty := by
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  exact ⟨_, ⟨Pi.single i 1, vecNormSq_single i, rfl⟩⟩

theorem rayleighSet_bddAbove {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) : BddAbove (rayleighSet W) := by
  refine ⟨W.trace, ?_⟩
  rintro r ⟨x, hx, rfl⟩
  have h := psd_quad_le_normSq_mul_trace hW hpsd x
  rwa [hx, one_mul] at h

/-- 単位ベクトルに対する `xᵀWx ≤ c(M)`。 -/
theorem le_rayleighSup {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) {x : n → ℝ} (hx : vecNormSq x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ rayleighSup W :=
  le_csSup (rayleighSet_bddAbove hW hpsd) ⟨x, hx, rfl⟩

/-- 人手証明の `xᵀWx ≤ c(M)‖x‖²`（任意の `x`）。 -/
theorem quad_le_rayleighSup_mul {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ rayleighSup W * vecNormSq x := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp [vecNormSq]
  · have ha : 0 < vecNormSq x := vecNormSq_pos hx
    set a := vecNormSq x with hadef
    set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
    have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
    have hsqrt_pos : 0 < Real.sqrt a := Real.sqrt_pos.mpr ha
    have hc2 : c ^ 2 = a⁻¹ := by
      rw [hcdef, inv_pow, hsq]
    have hunit : vecNormSq (c • x) = 1 := by
      rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
    have hle := le_rayleighSup hW hpsd hunit
    rw [quad_smul, hc2] at hle
    calc x ⬝ᵥ W *ᵥ x = a * (a⁻¹ * (x ⬝ᵥ W *ᵥ x)) := by
          field_simp
      _ ≤ a * rayleighSup W := by
          exact mul_le_mul_of_nonneg_left hle ha.le
      _ = rayleighSup W * a := by ring

theorem rayleighSup_nonneg {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) : 0 ≤ rayleighSup W := by
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  exact le_trans (hpsd (Pi.single i 1)) (le_rayleighSup hW hpsd (vecNormSq_single i))

theorem rayleighSup_pos {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) : 0 < rayleighSup W := by
  have hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x := by
    intro x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · exact (hpd x hx).le
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  have hne : (Pi.single i 1 : n → ℝ) ≠ 0 := by
    intro h
    have hu := vecNormSq_single (n := n) i
    rw [h] at hu
    simp [vecNormSq] at hu
  exact lt_of_lt_of_le (hpd _ hne) (le_rayleighSup hW hpsd (vecNormSq_single i))

end Ising2D
