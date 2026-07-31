/-
# `𝓜̌`（半整数運動量の添字集合）の定義（**具体版**）

対応する人手証明のラベル: `def_check_index_set`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_003a_definition_check_index_set`）

**必要十分版は無い。** この主張は整数の不等式と `θ~_μ = 2π(μ-1/2)/M` という実数の値だけを
扱っており、取り払える構造が残っていない（環・体・加群のどれも登場しない）。
必要十分版で得られる知見（何が本質的か）は「添字を `{1,…,M}` に絞ると
合同式 `μ+ν ≡ 1 (mod M)` が等式 `ν = M+1-μ` に落ちる」ことだが、
これは (5) の主張そのものである。

## 原文の定義

  `𝓜̌ := {1, 2, …, M} ⊂ ℤ`

と、後で繰り返し使う 5 つの性質 (1)〜(5)。

## 形式化の方針

集合そのものではなく、述語 `Ising2D.CheckIndex M μ ⟺ 1 ≤ μ ≤ M` として持つ
（原文の `μ ∈ 𝓜̌` に 1 対 1 で対応する）。
-/
import Ising2D.Part013.Definition003_HalfIntegerModes

namespace Ising2D

variable {M : ℕ}

/-- **原文の `μ ∈ 𝓜̌ = {1,…,M}`**。 -/
def CheckIndex (M : ℕ) (μ : ℤ) : Prop := 1 ≤ μ ∧ μ ≤ (M : ℤ)

theorem checkIndex_iff (M : ℕ) (μ : ℤ) : CheckIndex M μ ↔ (1 ≤ μ ∧ μ ≤ (M : ℤ)) := Iff.rfl

/-! ## (1) 相異なる `M` 個の運動量 -/

/-- 原文の `θ~_ν - θ~_μ = (2π/M)(ν - μ)`。 -/
theorem thetaTilde_sub (M : ℕ) (μ ν : ℤ) :
    thetaTilde M ν - thetaTilde M μ = 2 * Real.pi * ((ν : ℝ) - (μ : ℝ)) / M := by
  rw [thetaTilde, thetaTilde]
  ring

/-- **(1) 前半**: `μ ≠ ν` なら `θ~_μ ≠ θ~_ν`（`μ, ν ∈ ℤ` 全体で成り立つ）。 -/
theorem thetaTilde_ne (hM : M ≠ 0) {μ ν : ℤ} (h : μ ≠ ν) :
    thetaTilde M μ ≠ thetaTilde M ν := by
  have hMR : (0 : ℝ) < (M : ℝ) := by
    exact_mod_cast Nat.pos_of_ne_zero hM
  intro heq
  have hsub : 2 * Real.pi * ((ν : ℝ) - (μ : ℝ)) / M = 0 := by
    rw [← thetaTilde_sub, heq, sub_self]
  have hne : ((ν : ℝ) - (μ : ℝ)) ≠ 0 := by
    intro h0
    exact h (by exact_mod_cast (sub_eq_zero.1 h0).symm)
  have hnum : 2 * Real.pi * ((ν : ℝ) - (μ : ℝ)) = 0 :=
    (div_eq_zero_iff.1 hsub).resolve_right hMR.ne'
  rcases mul_eq_zero.1 hnum with h1 | h1
  · rcases mul_eq_zero.1 h1 with h2 | h2
    · norm_num at h2
    · exact Real.pi_ne_zero h2
  · exact hne h1

/-- **(1) 後半**: `μ ∈ 𝓜̌` なら `0 < θ~_μ < 2π`。 -/
theorem thetaTilde_pos (hM : M ≠ 0) {μ : ℤ} (hμ : CheckIndex M μ) : 0 < thetaTilde M μ := by
  have hMR : (0 : ℝ) < (M : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have h1 : (1 : ℝ) ≤ (μ : ℝ) := by exact_mod_cast hμ.1
  have hpi : 0 < Real.pi := Real.pi_pos
  rw [thetaTilde]
  apply div_pos _ hMR
  nlinarith

/-- **(1) 後半**: `μ ∈ 𝓜̌` なら `θ~_μ < 2π`。 -/
theorem thetaTilde_lt_two_pi (hM : M ≠ 0) {μ : ℤ} (hμ : CheckIndex M μ) :
    thetaTilde M μ < 2 * Real.pi := by
  have hMR : (0 : ℝ) < (M : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have h2 : (μ : ℝ) ≤ (M : ℝ) := by exact_mod_cast hμ.2
  have hpi : 0 < Real.pi := Real.pi_pos
  rw [thetaTilde, div_lt_iff₀ hMR]
  nlinarith

/-! ## (2) 共役添字の閉性 -/

/-- **(2)**: `μ ∈ 𝓜̌ ⟹ M+1-μ ∈ 𝓜̌`。 -/
theorem checkIndex_conj {μ : ℤ} (hμ : CheckIndex M μ) : CheckIndex M ((M : ℤ) + 1 - μ) := by
  obtain ⟨h1, h2⟩ := hμ
  exact ⟨by omega, by omega⟩

/-! ## (3) 共役添字の言い換え -/

/-- **(3)**: `(M+1-μ) - (1-μ) = M`、すなわち `1-μ ≡ M+1-μ (mod M)`。 -/
theorem conj_index_sub (M : ℕ) (μ : ℤ) : ((M : ℤ) + 1 - μ) - (1 - μ) = (M : ℤ) := by ring

/-! ## (4) 自己共役点 -/

/-- **(4) 前半**: `M+1-μ = μ ⟺ 2μ = M+1`（`μ ∈ ℤ` なので `M` は奇数でなければならない）。 -/
theorem conj_index_self_iff (M : ℕ) (μ : ℤ) : (M : ℤ) + 1 - μ = μ ↔ 2 * μ = (M : ℤ) + 1 := by
  omega

/-- **(4) 後半**: 自己共役点では `θ~_μ = π`。 -/
theorem thetaTilde_of_self_conj (hM : M ≠ 0) {μ : ℤ} (h : 2 * μ = (M : ℤ) + 1) :
    thetaTilde M μ = Real.pi := by
  have hMR : (M : ℝ) ≠ 0 := by
    exact_mod_cast Nat.cast_ne_zero.mpr hM
  have hR : 2 * (μ : ℝ) = (M : ℝ) + 1 := by exact_mod_cast h
  rw [thetaTilde]
  field_simp
  linarith

/-! ## (5) 対の判定（合同式が消える） -/

/-- **(5)**: `μ, ν ∈ 𝓜̌` なら `μ+ν ≡ 1 (mod M) ⟺ ν = M+1-μ`。

原文どおり、`1 ≤ μ+ν-1 ≤ 2M-1` の範囲にある `M` の倍数が `M` だけであることによる。 -/
theorem dvd_add_sub_one_iff (hM : M ≠ 0) {μ ν : ℤ} (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    ((M : ℤ) ∣ (μ + ν - 1)) ↔ ν = (M : ℤ) + 1 - μ := by
  have hMpos : (0 : ℤ) < (M : ℤ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  constructor
  · rintro ⟨l, hl⟩
    have hl1 : l = 1 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · have hle : l ≤ 0 := by omega
        have h0 : (M : ℤ) * l ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (le_of_lt hMpos) hle
        have := hμ.1
        have := hν.1
        linarith
      · have hge : (2 : ℤ) ≤ l := by omega
        have h2 : (M : ℤ) * 2 ≤ (M : ℤ) * l :=
          mul_le_mul_of_nonneg_left hge (le_of_lt hMpos)
        have := hμ.2
        have := hν.2
        linarith
    rw [hl1, mul_one] at hl
    omega
  · rintro rfl
    exact ⟨1, by ring⟩

/-- **(5) のデルタ版**: `μ, ν ∈ 𝓜̌` では `δ^M_{(μ+ν,1)} = δ_{ν, M+1-μ}`（通常のクロネッカー）。 -/
theorem deltaMod_add_one_eq (hM : M ≠ 0) {μ ν : ℤ} (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    deltaMod M (μ + ν) 1 = if ν = (M : ℤ) + 1 - μ then 1 else 0 := by
  classical
  rw [deltaMod]
  by_cases h : ν = (M : ℤ) + 1 - μ
  · rw [if_pos ((dvd_add_sub_one_iff hM hμ hν).2 h), if_pos h]
  · rw [if_neg (fun hd => h ((dvd_add_sub_one_iff hM hμ hν).1 hd)), if_neg h]

end Ising2D
