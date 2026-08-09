/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

`sum_eq_sum_of_inverse` に `β := 𝔖_L`、`γ := 𝔄_L`、`M := ℤ[x][t]`、`s := 𝔖^𝒪_L`、
`i := res`、`j := gl`、`f := φ ↦ Π_O W_O(ch(U), φ)`、`g := α ↦ Π_O W_O(ch(U), α(O))` を
代入すると「χ_U は軌道ごとの置換の組にわたる和である」が得られる。

要るのは `res` と `gl` が互いに逆であることと、取り替えた先で項が一致すること
（`gl(α)↾_O = α(O)`）だけであり、**軌道であることも順序 `≺` もこの代入には現れない**。

`hright` の代入について 1 つ断っておく。必要十分版が要求するのは
`i (j c) (hj c) = c` であり、ここへ渡すのは `restrictionFamily_glue`
（`res(gl(α)) = α`）である。両者は `restrictionFamily` へ渡す
`OrbitPreserving` の証明が違うが、`OrbitPreserving` は Prop なので
どの証明を渡しても同じ組を指す（Lean の証明の定義的無関係性）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilySum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFamilySum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「χ_U は軌道ごとの置換の組にわたる和である」を、必要十分版から導いたもの。 -/
theorem charPoly_shiftMatrix_eq_sum_family_from_necSuf (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) := by
  classical
  have hj : ∀ α : OrbitPermFamily L, gluePermOf α ∈ orbitPreservingFinset L :=
    fun α => mem_orbitPreservingFinset.mpr (gluePermOf_orbitPreserving α)
  have hfg : ∀ α : OrbitPermFamily L,
      (∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑(gluePermOf α))
        = ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) := by
    intro α
    refine Finset.prod_congr rfl ?_
    intro O _
    refine orbitFactor_congr _ ?_
    intro τ hτ
    rw [ambientOf_apply O.1 (α O) hτ]
    have h : restrictionFamily (gluePermOf_orbitPreserving α) O = α O :=
      congrFun (restrictionFamily_glue α) O
    calc gluePermOf α τ
        = (restrictionFamily (gluePermOf_orbitPreserving α) O ⟨τ, hτ⟩).1 := rfl
      _ = (α O ⟨τ, hτ⟩).1 := by rw [h]
  calc charPoly L (shiftMatrix L)
      = ∑ φ ∈ orbitPreservingFinset L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ :=
        charPoly_shiftMatrix_eq_sum_orbitFactor L
    _ = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) :=
        NecSuf.AlgebraicEigenvalue.sum_eq_sum_of_inverse
          (orbitPreservingFinset L)
          (fun φ hφ => restrictionFamily (mem_orbitPreservingFinset.mp hφ))
          gluePermOf hj
          (fun _ hφ => glue_restrictionFamily (mem_orbitPreservingFinset.mp hφ))
          (fun α => restrictionFamily_glue α)
          _ _ hfg

end Ising2DLambda.AlgebraicEigenvalue
