import Mathlib

/-!
人手証明「境界応答多項式」の Lean 具体版。

有限な配位型と辺型、各配位の破れ辺集合を固定し、辺ごとの多変数分配多項式を
有限和として作る。内箱に接する辺の有限集合を `active` とし、それ以外の変数を
`1` に送る有限代入を環準同型として構成する。
-/

namespace Ising3DCut

open MvPolynomial

section

variable {Configuration Edge : Type*}
variable [Fintype Configuration] [Fintype Edge] [DecidableEq Edge]

/-- 各配位の破れ辺に対応する不定元の積を、全配位について足した多変数分配多項式。 -/
noncomputable def multivariatePartitionPolynomial
    (broken : Configuration → Finset Edge) : MvPolynomial Edge ℤ :=
  ∑ σ : Configuration, ∏ e ∈ broken σ, X e

/-- `active` に属する辺変数を保ち、それ以外の辺変数を `1` に置く有限代入。 -/
noncomputable def boundarySpecialization (active : Finset Edge) :
    MvPolynomial Edge ℤ →+* MvPolynomial {e : Edge // e ∈ active} ℤ :=
  eval₂Hom C fun e ↦ if h : e ∈ active then X ⟨e, h⟩ else 1

/-- 保持する辺の不定元は、同じ辺を添字とする不定元へ移る。 -/
lemma boundarySpecialization_X_of_mem (active : Finset Edge) (e : Edge)
    (he : e ∈ active) :
    boundarySpecialization active (X e) = X (⟨e, he⟩ : {a : Edge // a ∈ active}) := by
  simp [boundarySpecialization, he]

/-- 保持しない辺の不定元は `1` へ移る。 -/
lemma boundarySpecialization_X_of_not_mem (active : Finset Edge) (e : Edge)
    (he : e ∉ active) :
    boundarySpecialization active (X e) = 1 := by
  simp [boundarySpecialization, he]

/-- 有限代入は加法を保存する。 -/
lemma boundarySpecialization_add (active : Finset Edge) (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P + Q) =
      boundarySpecialization active P + boundarySpecialization active Q := by
  exact map_add (boundarySpecialization active) P Q

/-- 有限代入は乗法を保存する。 -/
lemma boundarySpecialization_mul (active : Finset Edge) (P Q : MvPolynomial Edge ℤ) :
    boundarySpecialization active (P * Q) =
      boundarySpecialization active P * boundarySpecialization active Q := by
  exact map_mul (boundarySpecialization active) P Q

/-- 有限代入は単位元を保存する。 -/
lemma boundarySpecialization_one (active : Finset Edge) :
    boundarySpecialization active (1 : MvPolynomial Edge ℤ) = 1 := by
  exact map_one (boundarySpecialization active)

/-- 境界応答多項式は、多変数分配多項式の有限代入像である。 -/
noncomputable def boundaryResponsePolynomial
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    MvPolynomial {e : Edge // e ∈ active} ℤ :=
  boundarySpecialization active (multivariatePartitionPolynomial broken)

lemma boundaryResponsePolynomial_eq_specialization
    (broken : Configuration → Finset Edge) (active : Finset Edge) :
    boundaryResponsePolynomial broken active =
      boundarySpecialization active (multivariatePartitionPolynomial broken) := by
  rfl

/-- 外箱の拡大に対する安定性。広い外箱の配位を、内箱を含む元の外箱上の配位 `σ` と外側の値 `τ`
の組として与える（人手証明の「配位の分解の全単射」を、配位型を積型にとることで表す）。
各配位の破れ辺の代入像が `σ` だけで決まるなら、境界応答多項式は外側の配位数倍になる。 -/
theorem boundaryResponsePolynomial_outer_box_stability
    {Outer : Type*} [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken' : Configuration × Outer → Finset Edge) (active : Finset Edge)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      boundarySpecialization active (∏ e ∈ broken' (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e)) :
    boundaryResponsePolynomial broken' active =
      (Fintype.card Outer) • boundaryResponsePolynomial broken active := by
  unfold boundaryResponsePolynomial multivariatePartitionPolynomial
  rw [map_sum, map_sum, Fintype.sum_prod_type]
  simp_rw [h]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun σ _ ↦ ?_
  simp [Finset.sum_const, Finset.card_univ]

/-- 境界応答多項式は外箱に依存しない。共通の外箱上の配位 `σ` に外側の値 `τ₁`／`τ₂` を添えた
二つの外箱について、安定性を二度適用し、外側の配位数（自然数冪に当たる）を掛け合わせて
`#(V_{L₂}) • R_{L₁} = #(V_{L₁}) • R_{L₂}` を得る（配位数は `Configuration × Outer` の個数）。 -/
theorem boundaryResponsePolynomial_outer_box_independence
    {Outer₁ Outer₂ : Type*} [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge)
    (broken₂ : Configuration × Outer₂ → Finset Edge) (active : Finset Edge)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      boundarySpecialization active (∏ e ∈ broken₁ (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e))
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      boundarySpecialization active (∏ e ∈ broken₂ (σ, τ), X e) =
        boundarySpecialization active (∏ e ∈ broken σ, X e)) :
    (Fintype.card (Configuration × Outer₂)) • boundaryResponsePolynomial broken₁ active =
      (Fintype.card (Configuration × Outer₁)) • boundaryResponsePolynomial broken₂ active := by
  -- 安定性の一度目（外箱 L₁）と二度目（外箱 L₂）
  rw [boundaryResponsePolynomial_outer_box_stability broken broken₁ active h₁,
    boundaryResponsePolynomial_outer_box_stability broken broken₂ active h₂]
  -- 配位数の積 #C · #O₂ · #O₁ = #C · #O₁ · #O₂
  rw [Fintype.card_prod, Fintype.card_prod, smul_smul, smul_smul]
  congr 1
  ring

/-- 辺変数を 1 に置かない境界応答多項式の外箱依存性。広い外箱の辺型 `Edge''` から元の外箱の辺型 `Edge`
への環準同型 `π`（人手証明の代入 `π_{L'',L}`。外箱を広げて増えた辺の変数だけを `1` に置く）が、
各配位の破れ辺の単項式を元の外箱上の配位 `σ` の破れ辺の単項式へ送るなら、
`π (Z̃_{L''}) = #(外側の配位) • Z̃_L` が成り立つ（配位の有限和の分割 1 論法。安定性と同じ手順）。 -/
theorem fullBoundaryResponse_outer_edges_to_one
    {Edge'' Outer : Type*} [Fintype Edge''] [DecidableEq Edge''] [Fintype Outer]
    (broken : Configuration → Finset Edge)
    (broken'' : Configuration × Outer → Finset Edge'')
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (h : ∀ σ : Configuration, ∀ τ : Outer,
      π (∏ e ∈ broken'' (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    π (multivariatePartitionPolynomial broken'') =
      (Fintype.card Outer) • multivariatePartitionPolynomial broken := by
  unfold multivariatePartitionPolynomial
  -- 環準同型による有限和の分配と、積型上の有限和の分解
  rw [map_sum, Fintype.sum_prod_type]
  simp_rw [h]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun σ _ ↦ ?_
  simp [Finset.sum_const, Finset.card_univ]

end

end Ising3DCut
