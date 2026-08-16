/-
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の第一歩
（`κ_L(𝒵_L) = Σ_σ X ^ #B(σ)`）の必要十分版。

  使っている性質                       なぜ削れないか
  `Fintype Configuration`               多変数分配多項式を配位についての有限和で作るため。
  係数環 `R` の `CommSemiring`          多変数多項式環・一変数多項式環と、変数の像を指定する
                                        環準同型 `eval₂Hom` を作るのに必要な最小の構造。

具体版が持っていた次の構造は仮定しない: 係数環が `ℤ` であること、`Fintype Edge`、
`DecidableEq Edge`（変数の像は一様に `X` なので場合分けが無い）。
証明手順は具体版と同じ（各不定元の像、環準同型が有限積・有限和を保つこと）。

住処: 多変数多項式環と一変数多項式環（可換半環係数）。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.BoundaryResponsePolynomial
import Mathlib.Algebra.Polynomial.Basic

namespace Ising3DCut.NecSuf

open MvPolynomial

variable {Configuration Edge R : Type*} [CommSemiring R] [Fintype Configuration]

/-- 全ての辺変数を単一の不定元 `X` へ置く環準同型 `κ_L`。 -/
noncomputable def allEdgesToOneIndeterminate :
    MvPolynomial Edge R →+* Polynomial R :=
  eval₂Hom Polynomial.C fun _ ↦ Polynomial.X

lemma allEdgesToOneIndeterminate_X (e : Edge) :
    allEdgesToOneIndeterminate (X e : MvPolynomial Edge R) = Polynomial.X := by
  simp [allEdgesToOneIndeterminate]

lemma allEdgesToOneIndeterminate_brokenMonomial (B : Finset Edge) :
    allEdgesToOneIndeterminate (∏ e ∈ B, (X e : MvPolynomial Edge R)) =
      Polynomial.X ^ B.card := by
  rw [map_prod]
  simp [allEdgesToOneIndeterminate_X, Finset.prod_const]

theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial
    (broken : Configuration → Finset Edge) :
    allEdgesToOneIndeterminate (multivariatePartitionPolynomial (R := R) broken) =
      ∑ σ : Configuration, (Polynomial.X : Polynomial R) ^ (broken σ).card := by
  unfold multivariatePartitionPolynomial
  rw [map_sum]
  simp only [allEdgesToOneIndeterminate_brokenMonomial]

end Ising3DCut.NecSuf
