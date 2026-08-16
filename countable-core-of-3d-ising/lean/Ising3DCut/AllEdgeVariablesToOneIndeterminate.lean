import Ising3DCut.BoundaryResponsePolynomial

/-!
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版（第一歩）。

全ての辺変数 `X e` を単一の不定元 `X` へ置く環準同型 `allEdgesToOneIndeterminate` を定め、
各配位の破れ辺の単項式が `X ^ #B(σ)` へ写ること、したがって多変数分配多項式が
`Σ_σ X ^ #B(σ)` へ写ることを示す。第二歩（水準集合ごとに束ねて `Z_L(X)` に一致すること）は次の tick。
-/

namespace Ising3DCut

open MvPolynomial

section

variable {Configuration Edge : Type*}
variable [Fintype Configuration] [Fintype Edge] [DecidableEq Edge]

/-- 全ての辺変数を単一の不定元 `X` へ置く環準同型 `κ_L`。 -/
noncomputable def allEdgesToOneIndeterminate :
    MvPolynomial Edge ℤ →+* Polynomial ℤ :=
  eval₂Hom Polynomial.C fun _ ↦ Polynomial.X

/-- 各辺の不定元は単一の不定元 `X` へ写る。 -/
lemma allEdgesToOneIndeterminate_X (e : Edge) :
    allEdgesToOneIndeterminate (X e : MvPolynomial Edge ℤ) = Polynomial.X := by
  simp [allEdgesToOneIndeterminate]

/-- 配位の破れ辺の単項式は、環準同型が有限積を保つので `X ^ #B(σ)` へ写る。 -/
lemma allEdgesToOneIndeterminate_brokenMonomial (B : Finset Edge) :
    allEdgesToOneIndeterminate (∏ e ∈ B, (X e : MvPolynomial Edge ℤ)) =
      Polynomial.X ^ B.card := by
  rw [map_prod]
  simp [allEdgesToOneIndeterminate_X, Finset.prod_const]

/-- 多変数分配多項式は、環準同型が有限和を保つので破れ数の冪の有限和へ写る。 -/
theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial
    (broken : Configuration → Finset Edge) :
    allEdgesToOneIndeterminate (multivariatePartitionPolynomial broken) =
      ∑ σ : Configuration, (Polynomial.X : Polynomial ℤ) ^ (broken σ).card := by
  unfold multivariatePartitionPolynomial
  rw [map_sum]
  simp only [allEdgesToOneIndeterminate_brokenMonomial]

end

end Ising3DCut
