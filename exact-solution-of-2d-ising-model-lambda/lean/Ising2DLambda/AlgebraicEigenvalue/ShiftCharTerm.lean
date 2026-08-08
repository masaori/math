/-
章「固有値の代数性」の「シフト行列の特性多項式の消えない項の同定」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 2 件
（`claim_shift_char_matrix_entry_zero` / `claim_shift_char_term_zero`）と
定義 1 件（`def_orbit_preserving_permutation`）と主張 2 件
（`claim_fixed_or_shift_preserves_orbit` / `claim_orbit_preserving_image`）に対応する。

  人手証明                                        このファイル
  ch(U)_{τ,τ'} = ι(κ(0))（τ'≠τ かつ τ'≠S(τ)）      charMatrix_shiftMatrix_eq_zero
  その置換の項は零元                                charTerm_shiftMatrix_eq_zero
  𝔖^𝒪_L（軌道を保つ置換）                          OrbitPreserving
  τ か S(τ) へ送る置換は軌道を保つ                   orbitPreserving_of_fixed_or_shift
  φ(O) = O                                        image_orbit_eq_of_orbitPreserving

mathlib の `Matrix.charpoly` / `Equiv.Perm.support` / 置換行列の既製定理は引いていない
（引くと「成分が零元だから項が消える」という人手証明の議論そのものが消える）。
使ったのは `Finset.prod_eq_zero`（人手証明の「有限積から 1 つの因子を括り出す」）と
`Finset.card_image_of_injective` / `Finset.eq_of_subset_of_card_le`
（人手証明の「包含と個数が等しいことから一致」）だけである。

住処: 人手証明のこれらのブロックは ℤ / ℕ を宣言している。
ここに ℝ / ℂ は現れない（係数は `Polynomial ℤ`、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.CharacteristicPolynomial
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrix
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitPartition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張「シフト行列の特性行列の成分は、列の添字が行の添字でもその像でもないとき
零元である」。

証明は人手証明どおり 3 段（`ch` の非対角の場合 → `U` の成分が `κ(0)` → 零元の逆元は零元）。 -/
theorem charMatrix_shiftMatrix_eq_zero {τ τ' : RowConfig L}
    (hτ : τ' ≠ τ) (hS : τ' ≠ rowShift L τ) :
    charMatrix L (shiftMatrix L) τ τ' = 0 := by
  classical
  calc charMatrix L (shiftMatrix L) τ τ'
      = constSecond (-(shiftMatrix L τ τ')) := by
        simp [charMatrix, (Ne.symm hτ)]
    _ = constSecond (-(constPoly 0)) := by simp [shiftMatrix, hS]
    _ = 0 := by simp [constSecond, constPoly]

/-- 人手証明の主張「行の添字にもその像にも当たらない値を取る置換の項は零元である」。

証明は人手証明どおり、有限積から `τ₁` の因子を括り出し、それが零元であることで結論する。 -/
theorem charTerm_shiftMatrix_eq_zero (φ : Equiv.Perm (RowConfig L)) {τ₁ : RowConfig L}
    (h₁ : φ τ₁ ≠ τ₁) (h₂ : φ τ₁ ≠ rowShift L τ₁) :
    constSecond (constPoly (permSign L φ)) *
        ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 := by
  classical
  have hprod : ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 :=
    Finset.prod_eq_zero (Finset.mem_univ τ₁) (charMatrix_shiftMatrix_eq_zero h₁ h₂)
  rw [hprod, mul_zero]

variable (L)

/-- 人手証明の定義「軌道を保つ置換」`𝔖^𝒪_L = { φ | 任意の τ で φ(τ) ∈ O(τ) }`。 -/
def OrbitPreserving (φ : Equiv.Perm (RowConfig L)) : Prop :=
  ∀ τ : RowConfig L, φ τ ∈ rowShiftOrbit L τ

variable {L}

/-- 人手証明の「恒等置換は軌道を保つ」（定義の中で述べてあること）。 -/
theorem orbitPreserving_one : OrbitPreserving L (1 : Equiv.Perm (RowConfig L)) :=
  fun τ => self_mem_rowShiftOrbit τ

/-- 人手証明の主張「各行配位をそれ自身かその像へ送る置換は軌道を保つ」。

場合分けは人手証明どおり 2 つ（`S^[0] = id` と `S^[1] = S ∘ S^[0]`）。 -/
theorem orbitPreserving_of_fixed_or_shift {φ : Equiv.Perm (RowConfig L)}
    (h : ∀ τ : RowConfig L, φ τ = τ ∨ φ τ = rowShift L τ) : OrbitPreserving L φ := by
  intro τ
  rcases h τ with hτ | hτ
  · -- φ(τ) = τ = S^[0](τ)
    exact mem_rowShiftOrbit.mpr ⟨0, hτ⟩
  · -- φ(τ) = S(τ) = S(S^[0](τ)) = S^[1](τ)
    exact mem_rowShiftOrbit.mpr ⟨1, hτ⟩

/-- 人手証明の主張「軌道を保つ置換は各軌道をそれ自身へ写す」。

証明は人手証明どおり 2 段。包含 `φ(O) ⊆ O` を `O(τ) = O` から出し、
`φ` が単射であることによる個数の一致で等号にする。 -/
theorem image_orbit_eq_of_orbitPreserving {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    O.image φ = O := by
  classical
  obtain ⟨τ₀, hτ₀⟩ := mem_rowShiftOrbitSet.mp hO
  subst hτ₀
  -- 第 1 段: 包含
  have hsub : (rowShiftOrbit L τ₀).image φ ⊆ rowShiftOrbit L τ₀ := by
    intro a ha
    obtain ⟨τ, hτ, rfl⟩ := Finset.mem_image.mp ha
    have hoτ : rowShiftOrbit L τ = rowShiftOrbit L τ₀ := rowShiftOrbit_eq_of_mem τ₀ hτ
    exact hoτ ▸ hφ τ
  -- 第 2 段: φ は単射なので個数が等しい
  have hcard : ((rowShiftOrbit L τ₀).image φ).card = (rowShiftOrbit L τ₀).card :=
    Finset.card_image_of_injective _ φ.injective
  exact Finset.eq_of_subset_of_card_le hsub (le_of_eq hcard.symm)

end Ising2DLambda.AlgebraicEigenvalue
