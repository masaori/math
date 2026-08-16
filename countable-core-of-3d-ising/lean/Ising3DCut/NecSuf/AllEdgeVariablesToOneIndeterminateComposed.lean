/-
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の必要十分版（合成）。
第一歩（`κ_L(𝒵_L) = Σ_σ X ^ #B(σ)`）と第二歩（水準集合で束ねる）を接ぐだけ。

  使っている性質                       なぜ削れないか
  `Fintype Configuration`               有限和と水準集合の切り出しのため（第一歩・第二歩と同じ）。
  破れ数の上界 `(broken σ).card ≤ N`    第二歩の和の範囲を有限に収めるため。
  係数環 `R` の `CommSemiring`          第一歩・第二歩の最小構造。

具体版が持っていた次の構造は仮定しない: 係数環が `ℤ`、箱型 `Config L`、`Fintype Edge`、
`DecidableEq Edge`、破れ集合の定義。
住処: 多変数・一変数多項式環（可換半環係数）と自然数の数え上げ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.AllEdgeVariablesToOneIndeterminate
import Ising3DCut.NecSuf.AllEdgeVariablesToOneIndeterminateStepTwo

namespace Ising3DCut.NecSuf

open Polynomial

theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_sum_levelSet_card_smul
    {Configuration Edge R : Type*} [CommSemiring R] [Fintype Configuration]
    (broken : Configuration → Finset Edge) (N : ℕ) (hN : ∀ σ, (broken σ).card ≤ N) :
    allEdgesToOneIndeterminate (multivariatePartitionPolynomial (R := R) broken) =
      ∑ m ∈ Finset.range (N + 1),
        (Finset.univ.filter fun σ : Configuration => (broken σ).card = m).card •
          (Polynomial.X : Polynomial R) ^ m := by
  rw [allEdgesToOneIndeterminate_multivariatePartitionPolynomial]
  exact sum_X_pow_eq_sum_levelSet_card_smul (fun σ => (broken σ).card) N hN

end Ising3DCut.NecSuf
