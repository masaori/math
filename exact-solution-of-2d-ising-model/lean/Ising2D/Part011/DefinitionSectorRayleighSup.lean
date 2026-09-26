/-
# `c_+(M) := sup 𝓡_+`（偶セクターでの Rayleigh 商の上限）の定義

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_010a_definition_sector_rayleigh_sup`、ラベル **`def_sector_rayleigh_sup`**）

人手の定義:

  `𝓡_+ := { xᵀWx | x ∈ 𝓕^{(+)} ∩ ℝ^{2^M}, ‖x‖ = 1 }`,  `c_+(M) := sup 𝓡_+`

と、上限が定まること（`𝓡_+` が空でなく上に有界であること）。

## 人手証明との対応

| 人手 | 本ファイル |
| --- | --- |
| `𝓡_+`, `c_+(M)` | `evenSectorSet W ε`, `evenSectorRayleighSup W ε`（`ε` は実行列。Ising では `epsilonR M`） |
| 上に有界（`𝓡_+ ⊆ 𝓡`） | `evenSectorSet_subset` / `evenSectorSet_bddAbove` |
| 空でない（単位ベクトル `x^{(+)}` の構成） | `evenUnit` / `epsilonR_mulVec_evenUnit` / `vecNormSq_evenUnit` / `evenSectorSet_epsilonR_nonempty` |

## 人手証明と 1 対 1 にならない箇所

* `𝓡` が上に有界であることの根拠は、人手が成分の絶対値の和 `∑|W_ij|` を挙げるのに対し、
  Lean は章 011 の `Definition006_RayleighSup.lean` と同じく半正定値行列の評価
  `xᵀWx ≤ ‖x‖² tr W` を使う（`rayleighSet_bddAbove`）。
* 単位ベクトル `x^{(+)} = a_+⊠⋯⊠a_+` は、人手が確かめた「各成分が `2^{-M/2}`」の形
  （定数ベクトル `evenUnit`）で直接定義した。`ε x^{(+)} = x^{(+)}` は、人手が
  `ε = σ^x⊠⋯⊠σ^x` とクロネッカー積の積の規則で示すのに対し、Lean は `ε` が符号反転 `π` の
  置換行列であること（`epsilonR_mulVec_apply`）と成分が定数であることから示す。

必要十分版はない（`sSup` は ℝ の完備性そのものなので、ほどく余地がない。章 011 の
`Definition006_RayleighSup.lean` と同じ）。
-/
import Ising2D.Part011.Definition006_RayleighSup
import Ising2D.Part011.ClaimEpsilonIsRealSymmetric

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

section General

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手本文 `def_sector_rayleigh_sup` の `𝓡_+`**:
`{xᵀWx | x ∈ 𝓕^{(+)} ∩ ℝ^{2^M}, ‖x‖ = 1}`（`𝓕^{(+)} ∩ ℝ^{2^M}` は `ε x = x` を満たす実ベクトル）。 -/
def evenSectorSet (W ε : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = x ∧ vecNormSq x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- **人手本文 `def_sector_rayleigh_sup` の `c_+(M) := sup 𝓡_+`**。 -/
noncomputable def evenSectorRayleighSup (W ε : Matrix n n ℝ) : ℝ := sSup (evenSectorSet W ε)

/-- 人手の「`𝓕^{(+)} ∩ ℝ^{2^M} ⊆ ℝ^{2^M}` より `𝓡_+ ⊆ 𝓡`」。 -/
theorem evenSectorSet_subset (W ε : Matrix n n ℝ) : evenSectorSet W ε ⊆ rayleighSet W := by
  rintro r ⟨x, _, hx, rfl⟩
  exact ⟨x, hx, rfl⟩

/-- 人手の「`𝓡_+` は上に有界」（`𝓡_+ ⊆ 𝓡` と `𝓡` の有界性）。 -/
theorem evenSectorSet_bddAbove [Nonempty n] {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (ε : Matrix n n ℝ) :
    BddAbove (evenSectorSet W ε) :=
  (rayleighSet_bddAbove hW hpsd).mono (evenSectorSet_subset W ε)

/-- 偶セクターの単位ベクトルに対する `xᵀWx ≤ c_+(M)`（上限の定義そのもの）。 -/
theorem le_evenSectorRayleighSup [Nonempty n] {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) {ε : Matrix n n ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = x) (hx1 : vecNormSq x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ evenSectorRayleighSup W ε :=
  le_csSup (evenSectorSet_bddAbove hW hpsd ε) ⟨x, hx, hx1, rfl⟩

end General

/-! ## `𝓡_+` は空でない（Ising の `ε`） -/

variable {M : ℕ}

/-- 人手の `x^{(+)} = a_+⊠⋯⊠a_+`: 各成分が `2^{-M/2} = (1/√2)^M` の実ベクトル。 -/
noncomputable def evenUnit (M : ℕ) : Conf M → ℝ := fun _ => ((Real.sqrt 2)⁻¹) ^ M

/-- 人手の `ε x^{(+)} = x^{(+)}`（`x^{(+)} ∈ 𝓕^{(+)} ∩ ℝ^{2^M}`）。 -/
theorem epsilonR_mulVec_evenUnit : epsilonR M *ᵥ evenUnit M = evenUnit M := by
  funext k
  rw [epsilonR_mulVec_apply]
  rfl

/-- 人手の `‖x^{(+)}‖² = ∑_I (2^{-M/2})² = 2^M · 2^{-M} = 1`。 -/
theorem vecNormSq_evenUnit : vecNormSq (evenUnit M) = 1 := by
  rw [vecNormSq_eq_sum]
  simp only [evenUnit, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  have hcard : (Fintype.card (Conf M) : ℝ) = 2 ^ M := by
    simp [Conf]
  rw [hcard, ← pow_mul, mul_comm M 2, pow_mul, inv_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2),
    inv_pow, mul_inv_cancel₀ (pow_ne_zero _ (by norm_num))]

/-- **人手 `def_sector_rayleigh_sup` の「`𝓡_+ ≠ ∅`」**: `(x^{(+)})ᵀWx^{(+)} ∈ 𝓡_+`。 -/
theorem evenSectorSet_epsilonR_nonempty (W : Matrix (Conf M) (Conf M) ℝ) :
    (evenSectorSet W (epsilonR M)).Nonempty :=
  ⟨_, evenUnit M, epsilonR_mulVec_evenUnit, vecNormSq_evenUnit, rfl⟩

end Ising2D
