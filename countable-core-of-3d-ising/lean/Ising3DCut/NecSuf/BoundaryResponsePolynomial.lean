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

/-- 境界応答多項式は外箱に依存しない（必要十分版）。係数環は可換半環 `R`、`Fintype Edge` は不要。
安定性を二度適用し、外側の配位数を掛け合わせて `#(C×O₂) • R₁ = #(C×O₁) • R₂` を得る。 -/
theorem boundaryResponsePolynomial_outer_box_independence
    {Outer₁ Outer₂ : Type*} [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge)
    (broken₂ : Configuration × Outer₂ → Finset Edge) (active : Finset Edge)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      boundarySpecialization (R := R) active (∏ e ∈ broken₁ (σ, τ), X e) =
        boundarySpecialization (R := R) active (∏ e ∈ broken σ, X e))
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      boundarySpecialization (R := R) active (∏ e ∈ broken₂ (σ, τ), X e) =
        boundarySpecialization (R := R) active (∏ e ∈ broken σ, X e)) :
    (Fintype.card (Configuration × Outer₂)) • boundaryResponsePolynomial (R := R) broken₁ active =
      (Fintype.card (Configuration × Outer₁)) • boundaryResponsePolynomial (R := R) broken₂ active := by
  rw [boundaryResponsePolynomial_outer_box_stability broken broken₁ active h₁,
    boundaryResponsePolynomial_outer_box_stability broken broken₂ active h₂]
  rw [Fintype.card_prod, Fintype.card_prod, smul_smul, smul_smul]
  congr 1
  ring

/-- 辺変数を 1 に置かない境界応答多項式の外箱依存性（必要十分版）。係数環は可換半環 `R`、
辺型の有限性は不要（`DecidableEq Edge''` も不要）。環準同型 `π`（外箱を広げて増えた辺の変数だけを `1` に置く代入）が
各配位の破れ辺の単項式を元の外箱上の配位の単項式へ送るなら、`π (Z̃_{L''}) = #(外側の配位) • Z̃_L`。 -/
theorem fullBoundaryResponse_outer_edges_to_one
    {Edge'' Outer : Type*} [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken'' : Configuration × Outer → Finset Edge'')
    (π : MvPolynomial Edge'' R →+* MvPolynomial Edge R)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      π (∏ e ∈ broken'' (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    π (multivariatePartitionPolynomial (R := R) broken'') =
      (Fintype.card Outer) • multivariatePartitionPolynomial (R := R) broken := by
  unfold multivariatePartitionPolynomial
  rw [map_sum, Fintype.sum_prod_type]
  simp_rw [h]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun σ _ ↦ ?_
  simp [Finset.sum_const, Finset.card_univ]

/-- 辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較（必要十分版）。係数環は可換半環 `R`、
二つの外箱の辺型 `Edge₁`, `Edge₂` の有限性・可判定同値性は不要。増えた辺の変数を `1` に置く代入
`π₁`, `π₂` が各配位の破れ辺の単項式を共通の外箱上の配位の単項式へ送るなら、外箱依存性の 2 回適用と
配位数の積の可換性で `#(C × O₂) • π₁(Z̃₁) = #(C × O₁) • π₂(Z̃₂)`。 -/
theorem fullBoundaryResponse_common_outer_box_comparison
    {Edge₁ Edge₂ Outer₁ Outer₂ : Type*} [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge₁)
    (broken₂ : Configuration × Outer₂ → Finset Edge₂)
    (π₁ : MvPolynomial Edge₁ R →+* MvPolynomial Edge R)
    (π₂ : MvPolynomial Edge₂ R →+* MvPolynomial Edge R)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      π₁ (∏ e ∈ broken₁ (σ, τ), X e) = ∏ e ∈ broken σ, X e)
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      π₂ (∏ e ∈ broken₂ (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    (Fintype.card (Configuration × Outer₂)) • π₁ (multivariatePartitionPolynomial (R := R) broken₁) =
      (Fintype.card (Configuration × Outer₁)) • π₂ (multivariatePartitionPolynomial (R := R) broken₂) := by
  rw [fullBoundaryResponse_outer_edges_to_one broken broken₁ π₁ h₁,
    fullBoundaryResponse_outer_edges_to_one broken broken₂ π₂ h₂]
  rw [Fintype.card_prod, Fintype.card_prod, smul_smul, smul_smul]
  congr 1
  ring

end Ising3DCut.NecSuf
