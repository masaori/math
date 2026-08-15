/-
人手証明「境界応答多項式」（測定量の選び直し）の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                                  なぜ削れないか
  `Fintype Configuration`                          多変数分配多項式を配位についての有限和で作るため。
  `DecidableEq Edge`                                保持する辺かどうかで変数の像を場合分けするため。
  係数環 `R` の `CommSemiring`                     多変数多項式環と、変数の像を指定する環準同型
                                                   `eval₂Hom` を作るのに必要な最小の構造。

具体版が持っていた次の構造は仮定しない: 係数環が `ℤ` であること、`Fintype Edge`
（破れ辺集合は各配位で有限集合として与えられ、辺の型全体の有限性は使わない）。
証明手順は具体版と同じ（有限和の定義、変数の像の場合分け、加法・乗法・単位元の保存、
代入像としての境界応答多項式）。

住処: 有限型上の多変数多項式環（可換半環係数）。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.MvPolynomial.Eval

namespace Ising3DCut.NecSuf

open MvPolynomial

variable {Configuration Edge R : Type*} [CommSemiring R]
variable [Fintype Configuration] [DecidableEq Edge]

/-- 各配位の破れ辺の不定元の積を全配位について足した多変数分配多項式。 -/
noncomputable def multivariatePartitionPolynomial
    (broken : Configuration → Finset Edge) : MvPolynomial Edge R :=
  ∑ σ : Configuration, ∏ e ∈ broken σ, X e

/-- `active` に属する辺変数を保ち、それ以外を `1` に置く有限代入。 -/
noncomputable def boundarySpecialization (active : Finset Edge) :
    MvPolynomial Edge R →+* MvPolynomial {e : Edge // e ∈ active} R :=
  eval₂Hom C fun e ↦ if h : e ∈ active then X ⟨e, h⟩ else 1

lemma boundarySpecialization_X_of_mem (active : Finset Edge) (e : Edge)
    (he : e ∈ active) :
    boundarySpecialization (R := R) active (X e) =
      X (⟨e, he⟩ : {a : Edge // a ∈ active}) := by
  simp [boundarySpecialization, he]

lemma boundarySpecialization_X_of_not_mem (active : Finset Edge) (e : Edge)
    (he : e ∉ active) :
    boundarySpecialization (R := R) active (X e) = 1 := by
  simp [boundarySpecialization, he]

lemma boundarySpecialization_add (active : Finset Edge) (P Q : MvPolynomial Edge R) :
    boundarySpecialization active (P + Q) =
      boundarySpecialization active P + boundarySpecialization active Q :=
  map_add (boundarySpecialization active) P Q

lemma boundarySpecialization_mul (active : Finset Edge) (P Q : MvPolynomial Edge R) :
    boundarySpecialization active (P * Q) =
      boundarySpecialization active P * boundarySpecialization active Q :=
  map_mul (boundarySpecialization active) P Q

lemma boundarySpecialization_one (active : Finset Edge) :
    boundarySpecialization (R := R) active 1 = 1 :=
  map_one (boundarySpecialization active)

/-- 境界応答多項式は多変数分配多項式の有限代入像である。 -/
noncomputable def boundaryResponsePolynomial
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    MvPolynomial {e : Edge // e ∈ active} R :=
  boundarySpecialization active (multivariatePartitionPolynomial broken)

lemma boundaryResponsePolynomial_eq_specialization
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    boundaryResponsePolynomial (R := R) broken active =
      boundarySpecialization active (multivariatePartitionPolynomial broken) := rfl

/-- 外箱の拡大に対する安定性（必要十分版）。係数環は可換半環 `R`、辺型の有限性は不要。
広い外箱の配位を元の外箱上の配位 `σ` と外側の値 `τ` の組で表し、各配位の破れ辺の代入像が
`σ` だけで決まるなら、境界応答多項式は外側の配位数倍になる。 -/
theorem boundaryResponsePolynomial_outer_box_stability
    {Outer : Type*} [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken' : Configuration × Outer → Finset Edge) (active : Finset Edge)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      boundarySpecialization (R := R) active (∏ e ∈ broken' (σ, τ), X e) =
        boundarySpecialization (R := R) active (∏ e ∈ broken σ, X e)) :
    boundaryResponsePolynomial (R := R) broken' active =
      (Fintype.card Outer) • boundaryResponsePolynomial (R := R) broken active := by
  unfold boundaryResponsePolynomial multivariatePartitionPolynomial
  rw [map_sum, map_sum, Fintype.sum_prod_type]
  simp_rw [h]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun σ _ ↦ ?_
  simp [Finset.sum_const, Finset.card_univ]

end Ising3DCut.NecSuf
