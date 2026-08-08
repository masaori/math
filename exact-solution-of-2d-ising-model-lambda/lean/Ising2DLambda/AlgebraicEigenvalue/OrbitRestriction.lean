/-
章「固有値の代数性」の「軌道を保つ置換の、軌道への制限」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_restriction`）と主張 2 件
（`claim_orbit_restriction_bijective` / `claim_orbit_restriction_determines`）に対応する。

  人手証明                                このファイル
  φ↾_O : O → O                           orbitRestriction
  行き先が O に収まること                  mem_of_orbitPreserving
  φ↾_O は O から O への全単射              orbitRestriction_bijective
  制限がすべて一致すれば φ = ψ             eq_of_orbitRestriction_eq

mathlib の `Equiv.Perm.subtypePerm` と群作用の軌道の一般論は引いていない
（引くと「像で閉じているから制限が定まる」「単射性と全射性を別々に見る」という
人手証明の議論が既製の構成の性質へ置き換わる）。使ったのは `Finset.mem_image` と
`Equiv.ext` だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharTerm

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明が定義の中で示している段「行き先が O に収まること」。

`claim_orbit_preserving_image`（`image_orbit_eq_of_orbitPreserving`）から出す。 -/
theorem mem_of_orbitPreserving {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) :
    φ τ ∈ O := by
  classical
  have h : O.image φ = O := image_orbit_eq_of_orbitPreserving hφ hO
  have hmem := Finset.mem_image_of_mem φ hτ
  rwa [h] at hmem

/-- 人手証明の定義「軌道を保つ置換の、軌道への制限」`φ↾_O : O → O`。 -/
def orbitRestriction {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    (τ : {τ : RowConfig L // τ ∈ O}) : {τ : RowConfig L // τ ∈ O} :=
  ⟨φ τ.1, mem_of_orbitPreserving hφ hO τ.2⟩

@[simp]
theorem orbitRestriction_val {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    (τ : {τ : RowConfig L // τ ∈ O}) : (orbitRestriction hφ hO τ).1 = φ τ.1 := rfl

/-- 人手証明の主張「軌道への制限はその軌道の上の全単射である」。

証明は人手証明どおり、単射性と全射性を別々に示す。単射性は `φ` が単射であることから、
全射性は `claim_orbit_preserving_image` から逆像 `τ₃` を 1 つ取ることによる。 -/
theorem orbitRestriction_bijective {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    Function.Bijective (orbitRestriction hφ hO) := by
  classical
  have himage : O.image φ = O := image_orbit_eq_of_orbitPreserving hφ hO
  constructor
  · -- 単射性: (φ↾_O)(τ₁) = (φ↾_O)(τ₂) → φ(τ₁) = φ(τ₂) → τ₁ = τ₂
    intro τ₁ τ₂ hτ
    have h₁ : φ τ₁.1 = φ τ₂.1 := congrArg Subtype.val hτ
    exact Subtype.ext (φ.injective h₁)
  · -- 全射性: τ' ∈ O = O.image φ なので φ(τ₃) = τ' を満たす τ₃ ∈ O が取れる
    intro τ'
    have hmem : τ'.1 ∈ O.image φ := by rw [himage]; exact τ'.2
    obtain ⟨τ₃, hτ₃O, hτ₃⟩ := Finset.mem_image.mp hmem
    exact ⟨⟨τ₃, hτ₃O⟩, Subtype.ext hτ₃⟩

/-- 人手証明の主張「制限の全体が一致する軌道を保つ置換は一致する」。

証明は人手証明どおり、任意の τ について τ ∈ O(τ) ∈ 𝒪_L を取り、
`φ(τ) = (φ↾_{O(τ)})(τ) = (ψ↾_{O(τ)})(τ) = ψ(τ)` と 3 段でつなぐ。 -/
theorem eq_of_orbitRestriction_eq {φ ψ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) (hψ : OrbitPreserving L ψ)
    (heq : ∀ (O : Finset (RowConfig L)) (hO : O ∈ rowShiftOrbitSet L),
      orbitRestriction hφ hO = orbitRestriction hψ hO) : φ = ψ := by
  classical
  apply Equiv.ext
  intro τ
  -- τ ∈ O(τ) ∈ 𝒪_L
  have hO : rowShiftOrbit L τ ∈ rowShiftOrbitSet L := mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩
  have hτ : τ ∈ rowShiftOrbit L τ := self_mem_rowShiftOrbit τ
  calc φ τ = (orbitRestriction hφ hO ⟨τ, hτ⟩).1 := rfl
    _ = (orbitRestriction hψ hO ⟨τ, hτ⟩).1 := by rw [heq]
    _ = ψ τ := rfl

end Ising2DLambda.AlgebraicEigenvalue
