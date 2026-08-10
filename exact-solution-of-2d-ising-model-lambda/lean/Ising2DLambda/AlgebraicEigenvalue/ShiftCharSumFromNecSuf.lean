/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

2 つの主張それぞれについて代入する。

1. `eq_zero_of_not_of_forall_or` に `P τ := (φ τ = τ)`、`Q τ := (φ τ = S(τ))`、
   `H := OrbitPreserving L φ` を代入すると「軌道を保たない置換の項は零元である」が得られる。
   要るのは前セクションの 2 主張（項が零元であること・τ か S(τ) へ送る置換は軌道を保つこと）
   だけであり、**行列も置換の符号もこの代入には現れない**。
2. `sum_eq_sum_subset_congr` に `β := 𝔖_L`、`M := ℤ[x][t]`、`s := 𝔖^𝒪_L`、
   `f := φ ↦ ι(κ(sgn φ))·Π_τ ch(U)_{τ,φ(τ)}`、`g := φ ↦ Π_O W_O(ch(U), φ)` を代入すると
   「χ_U は軌道を保つ置換にわたる、軌道ごとの因子の積の和である」が得られる。
   要るのは「𝔖^𝒪_L の外で項が零元であること」と「𝔖^𝒪_L の中で項が分解できること」だけで、
   **軌道であることも順序 `≺` もこの代入には現れない**。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「軌道を保たない置換の項は零元である」を、必要十分版から導いたもの。 -/
theorem charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving_from_necSuf
    {φ : Equiv.Perm (RowConfig L)} (hφ : ¬ OrbitPreserving L φ) :
    constSecond (constPoly (permSign L φ)) *
        ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 :=
  NecSuf.AlgebraicEigenvalue.eq_zero_of_not_of_forall_or
    (P := fun τ => φ τ = τ) (Q := fun τ => φ τ = rowShift L τ)
    (fun _ h₁ h₂ => charTerm_shiftMatrix_eq_zero φ h₁ h₂)
    orbitPreserving_of_fixed_or_shift hφ

/-- 主張「χ_U は軌道を保つ置換にわたる、軌道ごとの因子の積の和である」を、
必要十分版から導いたもの。 -/
theorem charPoly_shiftMatrix_eq_sum_orbitFactor_from_necSuf (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∑ φ ∈ orbitPreservingFinset L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ := by
  classical
  have hout : ∀ φ : Equiv.Perm (RowConfig L), φ ∉ orbitPreservingFinset L →
      constSecond (constPoly (permSign L φ)) *
        ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 := by
    intro φ hφ
    exact charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving
      (fun h => hφ (mem_orbitPreservingFinset.mpr h))
  have hcongr : ∀ φ ∈ orbitPreservingFinset L,
      constSecond (constPoly (permSign L φ)) *
          ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ)
        = ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ := by
    intro φ hmem
    have hφ : OrbitPreserving L φ := mem_orbitPreservingFinset.mp hmem
    rw [term_eq_prod_orbitFactor (charMatrix L (shiftMatrix L)) hφ]
    refine Finset.prod_congr rfl ?_
    intro O _
    rw [orbitRestrictionAmbient_eq_coe hφ O.2]
  exact NecSuf.AlgebraicEigenvalue.sum_eq_sum_subset_congr
    (orbitPreservingFinset L) _ _ hout hcongr

end Ising2DLambda.AlgebraicEigenvalue
