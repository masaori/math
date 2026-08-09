/-
章「固有値の代数性」の「シフト行列の特性多項式を、軌道を保つ置換にわたる和へ絞ること」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 2 件
（`claim_non_orbit_preserving_term_zero` / `claim_shift_char_sum_orbit_preserving`）に対応する。

  人手証明                                          このファイル
  𝔖^𝒪_L（和の添字にするため Finset で持つ）         orbitPreservingFinset
  φ ∉ 𝔖^𝒪_L ならば項は零元                          charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving
  χ_U = Σ_{φ∈𝔖^𝒪_L} Π_O W_O(ch(U), φ↾_O)           charPoly_shiftMatrix_eq_sum_orbitFactor

`𝔖^𝒪_L` は前のセクションでは述語 `OrbitPreserving` として持っていた。和の添字にするには
Finset が要るので、`univ` をその述語で絞ったものとして置き、両者が同じ集合であることを
`mem_orbitPreservingFinset` で示す（新しい概念を増やしていない）。

`W_O` の第 2 引数の持ち方について。前のセクションと同じく ambient の写像として受けるが、
そこで使った `orbitRestrictionAmbient hφ hO` は `φ` そのもの（写像として等しい）である。
これを `orbitRestrictionAmbient_eq_coe` で示し、和の中では `⇑φ` を書く
（`hφ` を summand の中で持ち回すのを避けるため）。`W_O` が `O` の外の値に依らないことは
`orbitFactor_congr` で別に示す（持ち方が値を漏らしていないことの検査）。

mathlib の `Matrix.charpoly` / `Equiv.Perm.sign` / 置換行列の既製定理は引いていない。
使ったのは `Finset.sum_subset`（人手証明の「有限和から零元である項を落としても値は
変わらない」）と `Finset.sum_congr`（同「和の各項へ前セクションの分解を当てる」）だけである。

住処: 人手証明のこれらのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（係数は ℤ[x][t]、符号は ℤ、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTermFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の `𝔖^𝒪_L` を、和の添字にできる形（Finset）で持ったもの。

`OrbitPreserving`（述語）と同じ集合であることは `mem_orbitPreservingFinset`。 -/
noncomputable def orbitPreservingFinset (L : ℕ) [NeZero L] :
    Finset (Equiv.Perm (RowConfig L)) :=
  letI := Classical.decPred (OrbitPreserving L)
  Finset.univ.filter (OrbitPreserving L)

theorem mem_orbitPreservingFinset {φ : Equiv.Perm (RowConfig L)} :
    φ ∈ orbitPreservingFinset L ↔ OrbitPreserving L φ := by
  letI := Classical.decPred (OrbitPreserving L)
  rw [orbitPreservingFinset, Finset.mem_filter]
  exact ⟨fun h => h.2, fun h => ⟨Finset.mem_univ _, h⟩⟩

/-- `W_O(B,ψ)` は写像の `O` の中での値だけで決まる（ambient の写像として持ったことが
値を漏らしていないことの検査）。人手証明の `ψ : O → O` に対応する。 -/
theorem orbitFactor_congr (B : SecondRowMatrix L) {O : Finset (RowConfig L)}
    {g g' : RowConfig L → RowConfig L} (h : ∀ τ ∈ O, g τ = g' τ) :
    orbitFactor L B O g = orbitFactor L B O g' := by
  unfold orbitFactor
  rw [orbitPermSign_congr h]
  exact congrArg _ (Finset.prod_congr rfl (fun τ hτ => by rw [h τ hτ]))

/-- 前のセクションの `φ↾_O`（ambient の形）は `φ` そのものである。

`O` の中では制限の値、外では `φ` の値を取る写像なので、どちらの枝でも `φ τ` になる。 -/
theorem orbitRestrictionAmbient_eq_coe {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    orbitRestrictionAmbient hφ hO = ⇑φ := by
  classical
  funext τ
  unfold orbitRestrictionAmbient
  by_cases h : τ ∈ O
  · simp [h]
  · simp [h]

/-- 人手証明の主張「軌道を保たない置換の項は零元である」。

証明は人手証明どおり、`claim_fixed_or_shift_preserves_orbit` の対偶で
`φ(τ₁) ≠ τ₁` かつ `φ(τ₁) ≠ S(τ₁)` を満たす `τ₁` を取り、前の主張を当てる。 -/
theorem charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving {φ : Equiv.Perm (RowConfig L)}
    (hφ : ¬ OrbitPreserving L φ) :
    constSecond (constPoly (permSign L φ)) *
        ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 := by
  classical
  -- 対偶: 軌道を保たないので「各 τ で φ(τ) = τ または φ(τ) = S(τ)」は成り立たない。
  have hnot : ¬ ∀ τ : RowConfig L, φ τ = τ ∨ φ τ = rowShift L τ :=
    fun h => hφ (orbitPreserving_of_fixed_or_shift h)
  obtain ⟨τ₁, hτ₁⟩ := not_forall.mp hnot
  exact charTerm_shiftMatrix_eq_zero φ (fun h => hτ₁ (Or.inl h)) (fun h => hτ₁ (Or.inr h))

/-- 人手証明の主張「χ_U は軌道を保つ置換にわたる、軌道ごとの因子の積の和である」。

人手証明の式変形の 4 段をそのまま辿る（定義 → 行列式の定義 → 和を 𝔖^𝒪_L へ狭める →
各項を軌道ごとの因子の積へ置き換える）。 -/
theorem charPoly_shiftMatrix_eq_sum_orbitFactor (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∑ φ ∈ orbitPreservingFinset L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ := by
  classical
  calc charPoly L (shiftMatrix L)
      = secondDeterminant L (charMatrix L (shiftMatrix L)) := rfl
    _ = ∑ φ : Equiv.Perm (RowConfig L),
          constSecond (constPoly (permSign L φ)) *
            ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) := rfl
    _ = ∑ φ ∈ orbitPreservingFinset L,
          constSecond (constPoly (permSign L φ)) *
            ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) := by
        refine (Finset.sum_subset (Finset.subset_univ _) ?_).symm
        intro φ _ hφ
        exact charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving
          (fun h => hφ (mem_orbitPreservingFinset.mpr h))
    _ = ∑ φ ∈ orbitPreservingFinset L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ := by
        refine Finset.sum_congr rfl ?_
        intro φ hmem
        have hφ : OrbitPreserving L φ := mem_orbitPreservingFinset.mp hmem
        rw [term_eq_prod_orbitFactor (charMatrix L (shiftMatrix L)) hφ]
        refine Finset.prod_congr rfl ?_
        intro O _
        rw [orbitRestrictionAmbient_eq_coe hφ O.2]

end Ising2DLambda.AlgebraicEigenvalue
