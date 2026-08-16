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

/-- 辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較。共通の外箱 `L₀`（辺型 `Edge`、配位型
`Configuration`）を含む二つの外箱 `L₁`, `L₂`（辺型 `Edge₁`, `Edge₂`、外側の点の値の型 `Outer₁`, `Outer₂`。
互いの包含は仮定しない）について、増えた辺の変数を `1` に置く代入 `π₁ : L₁ → L₀`, `π₂ : L₂ → L₀` を経由すると
`#(C × O₂) • π₁(R̃₁) = #(C × O₁) • π₂(R̃₂)` が成り立つ（人手証明
`claim_full_boundary_response_common_outer_box_comparison`。外箱依存性の 2 回適用と 2 冪の積）。 -/
theorem fullBoundaryResponse_common_outer_box_comparison
    {Edge₁ Edge₂ Outer₁ Outer₂ : Type*} [Fintype Edge₁] [DecidableEq Edge₁]
    [Fintype Edge₂] [DecidableEq Edge₂] [Fintype Outer₁] [Fintype Outer₂]
    (broken : Configuration → Finset Edge)
    (broken₁ : Configuration × Outer₁ → Finset Edge₁)
    (broken₂ : Configuration × Outer₂ → Finset Edge₂)
    (π₁ : MvPolynomial Edge₁ ℤ →+* MvPolynomial Edge ℤ)
    (π₂ : MvPolynomial Edge₂ ℤ →+* MvPolynomial Edge ℤ)
    (h₁ : ∀ σ : Configuration, ∀ τ : Outer₁,
      π₁ (∏ e ∈ broken₁ (σ, τ), X e) = ∏ e ∈ broken σ, X e)
    (h₂ : ∀ σ : Configuration, ∀ τ : Outer₂,
      π₂ (∏ e ∈ broken₂ (σ, τ), X e) = ∏ e ∈ broken σ, X e) :
    (Fintype.card (Configuration × Outer₂)) • π₁ (multivariatePartitionPolynomial broken₁) =
      (Fintype.card (Configuration × Outer₁)) • π₂ (multivariatePartitionPolynomial broken₂) := by
  -- 外箱依存性の一度目（外箱 L₁）と二度目（外箱 L₂）
  rw [fullBoundaryResponse_outer_edges_to_one broken broken₁ π₁ h₁,
    fullBoundaryResponse_outer_edges_to_one broken broken₂ π₂ h₂]
  -- 配位数の積 #C · #O₂ · #O₁ = #C · #O₁ · #O₂
  rw [Fintype.card_prod, Fintype.card_prod, smul_smul, smul_smul]
  congr 1
  ring

/-- 辺変数を 1 に置かない境界応答多項式の各辺変数についての次数は高々 1（人手証明
`claim_full_boundary_response_degree_at_most_one`）。各配位の単項式は破れ辺の有限集合上の相異なる
不定元の積なので各変数の指数は高々 1 であり、有限和の次数は各項の次数の最大値以下である。 -/
theorem fullBoundaryResponse_degreeOf_le_one
    (broken : Configuration → Finset Edge) (e₀ : Edge) :
    degreeOf e₀ (multivariatePartitionPolynomial broken) ≤ 1 := by
  unfold multivariatePartitionPolynomial
  -- 有限和の次数は各項の次数の最大値以下
  refine (degreeOf_sum_le e₀ _ _).trans (Finset.sup_le fun σ _ ↦ ?_)
  -- 相異なる不定元の積の次数は高々 1
  refine (degreeOf_prod_le e₀ _ _).trans ?_
  calc ∑ e ∈ broken σ, degreeOf e₀ (X e : MvPolynomial Edge ℤ)
      = ∑ e ∈ broken σ, if e₀ = e then 1 else 0 := by
        exact Finset.sum_congr rfl fun e _ ↦ degreeOf_X e₀ e
    _ ≤ 1 := by
        rw [Finset.sum_ite_eq]; split_ifs <;> simp

/-- 辺変数を 1 に置かない境界応答多項式は各辺の変数に真に依存する（人手証明
`claim_full_boundary_response_degree_exactly_one`）の第一歩。辺 `e₀` を破る配位 `τ` の単項式は
指数 `∑ e ∈ broken τ, single e 1` の単項式（係数 1）であり、その `e₀` での指数は 1 である。 -/
theorem brokenMonomial_exponent_at_broken_edge
    (broken : Configuration → Finset Edge) (e₀ : Edge) (τ : Configuration)
    (hτ : e₀ ∈ broken τ) :
    (∏ e ∈ broken τ, (X e : MvPolynomial Edge ℤ)) =
        monomial (∑ e ∈ broken τ, Finsupp.single e 1) 1 ∧
      (∑ e ∈ broken τ, Finsupp.single e 1) e₀ = 1 := by
  refine ⟨?_, ?_⟩
  · -- 相異なる不定元の積は指数の和の単項式
    rw [monomial_sum_index, C_1, one_mul]
    rfl
  · -- e₀ での指数は e₀ ∈ broken τ なら 1
    rw [Finsupp.finsetSum_apply]
    simp [Finsupp.single_apply, hτ]

/-- 同じ主張の第二歩。辺 `e₀` を破る配位 `τ` の単項式の、辺変数を 1 に置かない境界応答多項式に
おける係数は 1 以上である（同じ破れ辺集合をもつ配位の個数であり、`τ` 自身が数えられる）。 -/
theorem fullBoundaryResponse_one_le_coeff_brokenMonomial
    (broken : Configuration → Finset Edge) (τ : Configuration) :
    1 ≤ coeff (∑ e ∈ broken τ, Finsupp.single e 1) (multivariatePartitionPolynomial broken) := by
  unfold multivariatePartitionPolynomial
  rw [coeff_sum]
  have hmono : ∀ σ : Configuration, (∏ e ∈ broken σ, (X e : MvPolynomial Edge ℤ)) =
      monomial (∑ e ∈ broken σ, Finsupp.single e 1) 1 := fun σ ↦ by
    rw [monomial_sum_index, C_1, one_mul]; rfl
  simp_rw [hmono, coeff_monomial]
  -- τ の項は 1、他の項は 0 以上
  calc (1 : ℤ)
      = if (∑ e ∈ broken τ, Finsupp.single e 1) = (∑ e ∈ broken τ, Finsupp.single e 1)
          then 1 else 0 := by simp
    _ ≤ ∑ σ, if (∑ e ∈ broken σ, Finsupp.single e 1) = (∑ e ∈ broken τ, Finsupp.single e 1)
          then 1 else 0 :=
        Finset.single_le_sum (f := fun σ ↦ if (∑ e ∈ broken σ, Finsupp.single e 1) =
            (∑ e ∈ broken τ, Finsupp.single e 1) then (1 : ℤ) else 0)
          (fun σ _ ↦ by split_ifs <;> simp) (Finset.mem_univ τ)

/-- 辺変数を 1 に置かない境界応答多項式は各辺の変数に真に依存する（人手証明
`claim_full_boundary_response_degree_exactly_one`）。辺 `e₀` を破る配位 `τ` があれば、
`τ` の単項式の係数は 1 以上（第二歩）で `e₀` での指数は 1（第一歩）なので次数は 1 以上、
高々 1（`fullBoundaryResponse_degreeOf_le_one`）と合わせてちょうど 1 である。 -/
theorem fullBoundaryResponse_degreeOf_eq_one
    (broken : Configuration → Finset Edge) (e₀ : Edge) (τ : Configuration)
    (hτ : e₀ ∈ broken τ) :
    degreeOf e₀ (multivariatePartitionPolynomial broken) = 1 := by
  refine le_antisymm (fullBoundaryResponse_degreeOf_le_one broken e₀) ?_
  -- τ の単項式の指数 m は support に属する（係数が 1 以上なので非零）
  have hcoeff := fullBoundaryResponse_one_le_coeff_brokenMonomial broken τ
  have hsupp : (∑ e ∈ broken τ, Finsupp.single e 1) ∈
      (multivariatePartitionPolynomial broken).support := by
    rw [mem_support_iff]; exact ne_of_gt (lt_of_lt_of_le zero_lt_one hcoeff)
  -- support の元の e₀ での指数は次数以下
  have hle := monomial_le_degreeOf e₀ hsupp
  rwa [(brokenMonomial_exponent_at_broken_edge broken e₀ τ hτ).2] at hle


/-- 辺変数を 1 に置かない境界応答多項式の全次数は辺の総数以下（人手証明
`claim_full_boundary_response_total_degree_is_edge_count` の前半）。各配位の単項式は破れ辺の
有限集合上の相異なる不定元の積なので全次数は破れ辺の個数 `#(broken σ) ≤ #Edge` であり、
有限和の全次数は各項の全次数の最大値以下である。 -/
theorem fullBoundaryResponse_totalDegree_le_card_edge
    (broken : Configuration → Finset Edge) :
    (multivariatePartitionPolynomial broken).totalDegree ≤ Fintype.card Edge := by
  unfold multivariatePartitionPolynomial
  -- 有限和の全次数は各項の全次数の最大値以下
  refine (totalDegree_finsetSum _ _).trans (Finset.sup_le fun σ _ ↦ ?_)
  -- 相異なる不定元の積の全次数は不定元の個数
  refine (totalDegree_finsetProd _ _).trans ?_
  calc ∑ e ∈ broken σ, (X e : MvPolynomial Edge ℤ).totalDegree
      = ∑ e ∈ broken σ, 1 := Finset.sum_congr rfl fun e _ ↦ totalDegree_X e
    _ = (broken σ).card := by simp
    _ ≤ Fintype.card Edge := Finset.card_le_univ _

/-- 辺変数を 1 に置かない境界応答多項式の全次数は辺の総数に等しい（人手証明
`claim_full_boundary_response_total_degree_is_edge_count`）。全ての辺を破る配位 `τ` があれば、
その単項式 `∏ e, X e` の係数は 1 以上（`fullBoundaryResponse_one_le_coeff_brokenMonomial`）で
指数の和は `#Edge` なので全次数は `#Edge` 以上、高々 `#Edge` と合わせてちょうど `#Edge` である
（人手証明では係数が `Ω_L(#E_L) ≥ 2` だが、下界には非零で足りる）。 -/
theorem fullBoundaryResponse_totalDegree_eq_card_edge
    (broken : Configuration → Finset Edge) (τ : Configuration)
    (hτ : broken τ = Finset.univ) :
    (multivariatePartitionPolynomial broken).totalDegree = Fintype.card Edge := by
  refine le_antisymm (fullBoundaryResponse_totalDegree_le_card_edge broken) ?_
  -- τ の単項式の指数 m は support に属する（係数が 1 以上なので非零）
  have hcoeff := fullBoundaryResponse_one_le_coeff_brokenMonomial broken τ
  have hsupp : (∑ e ∈ broken τ, Finsupp.single e 1) ∈
      (multivariatePartitionPolynomial broken).support := by
    rw [mem_support_iff]; exact ne_of_gt (lt_of_lt_of_le zero_lt_one hcoeff)
  -- support の元の指数の和は全次数以下
  have hle := le_totalDegree hsupp
  -- 全ての辺を破る配位の指数の和は #Edge
  have hdeg : ((∑ e ∈ broken τ, Finsupp.single e 1).sum fun _ n ↦ n) = Fintype.card Edge := by
    rw [hτ, ← Finsupp.sum_finset_sum_index (fun _ ↦ rfl) (fun _ _ _ ↦ rfl)]
    simp [Finsupp.sum_single_index]
  rwa [hdeg] at hle

/-- 辺変数を 1 に置かない境界応答多項式の全変数を 1 に置いた値は配位の総数（人手証明
`claim_full_boundary_response_value_at_one`）。全ての辺変数を `1` に置く環準同型 `ε_L`（`eval fun _ ↦ 1`）は
有限和と有限積を保ち、各配位の単項式 `∏ e ∈ broken σ, X e` を `1` へ写すので、像は配位の個数
`#Configuration` に等しい（人手証明では `2^{#V_L}`）。 -/
theorem fullBoundaryResponse_eval_one_eq_card_configuration
    (broken : Configuration → Finset Edge) :
    (eval fun _ : Edge ↦ (1 : ℤ)) (multivariatePartitionPolynomial broken) =
      Fintype.card Configuration := by
  unfold multivariatePartitionPolynomial
  -- 環準同型による有限和・有限積の分配、各不定元は 1 へ
  rw [map_sum]
  simp only [map_prod, eval_X, Finset.prod_const_one, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, mul_one]

/-- 増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい（人手証明
`claim_full_boundary_response_outer_edges_to_one_then_value_at_one` の前半）。広い外箱の辺型 `Edge''` から
元の外箱の辺型 `Edge` への環準同型 `π`（`π_{L'',L}`）が各不定元 `X e` を全変数を 1 に置くと `1` になる元へ送るなら、
環準同型として `ε_L ∘ π = ε_{L''}`（両者が各不定元で `1` をとること、および ℤ からの環準同型の一意性と
多変数多項式環の普遍性 `MvPolynomial.ringHom_ext`）。 -/
theorem eval_one_comp_outer_edges_to_one
    {Edge'' : Type*}
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (hπ : ∀ e : Edge'', (eval fun _ : Edge ↦ (1 : ℤ)) (π (X e)) = 1) :
    (eval fun _ : Edge ↦ (1 : ℤ)).comp π = eval fun _ : Edge'' ↦ (1 : ℤ) := by
  refine MvPolynomial.ringHom_ext (fun r ↦ ?_) (fun e ↦ ?_)
  · -- 定数項：ℤ からの環準同型は一意
    exact RingHom.congr_fun
      (RingHom.ext_int (((eval fun _ : Edge ↦ (1 : ℤ)).comp π).comp C)
        ((eval fun _ : Edge'' ↦ (1 : ℤ)).comp C)) r
  · -- 不定元：両者とも 1
    simp [hπ e]

/-- 同上の後半：`ε_L (π (Z̃_{L''})) = #(Configuration × Outer)`（人手証明では `2^{#V_{L''}}`）。
前半の環準同型の等式と、全変数を 1 に置いた値が配位の総数であること。 -/
theorem fullBoundaryResponse_outer_edges_to_one_then_eval_one
    {Edge'' Outer : Type*} [Fintype Outer]
    (broken'' : Configuration × Outer → Finset Edge'')
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (hπ : ∀ e : Edge'', (eval fun _ : Edge ↦ (1 : ℤ)) (π (X e)) = 1) :
    (eval fun _ : Edge ↦ (1 : ℤ)) (π (multivariatePartitionPolynomial broken'')) =
      Fintype.card (Configuration × Outer) := by
  have h := RingHom.congr_fun (eval_one_comp_outer_edges_to_one π hπ)
    (multivariatePartitionPolynomial broken'')
  rw [RingHom.comp_apply] at h
  rw [h]
  unfold multivariatePartitionPolynomial
  rw [map_sum]
  simp only [map_prod, eval_X, Finset.prod_const_one, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, mul_one]

/-- 各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る（人手証明
`claim_full_boundary_response_monomial_maps_to_monomial_under_outer_edges_to_one`）。元の外箱の辺型 `Edge` を
広い外箱の辺型 `Edge''` へ埋め込む単射 `ι` と、環準同型 `π`（`π_{L'',L}`）が `X (ι e)` を `X e` へ、
`ι` の像に無い辺の不定元を `1` へ送るとき、破れ辺集合 `B : Finset Edge''` の単項式は
`B` の `ι` による逆像（`B ∩ E_L`）上の単項式へ写る。環準同型が有限積を保つこと、`B` を `ι` の像に
入る辺と入らない辺へ分けること（`Finset.prod_preimage`）、不定元の行き先の場合分けの 1 論法。 -/
theorem brokenMonomial_maps_to_monomial_under_outer_edges_to_one
    {Edge'' : Type*} (ι : Edge → Edge'') (hι : Function.Injective ι)
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (hin : ∀ e : Edge, π (X (ι e)) = X e)
    (hout : ∀ e'' : Edge'', e'' ∉ Set.range ι → π (X e'') = 1)
    (B : Finset Edge'') :
    π (∏ e ∈ B, X e) = ∏ e ∈ B.preimage ι hι.injOn, X e := by
  -- 環準同型は有限積を保つ
  rw [map_prod]
  -- 像に無い辺の因子は 1 なので、積は ι の逆像上の積に等しい
  rw [← Finset.prod_preimage ι B hι.injOn (fun e'' ↦ π (X e'')) (fun e'' _ he'' ↦ hout e'' he'')]
  -- 像に入る辺の不定元の行き先
  exact Finset.prod_congr rfl fun e _ ↦ hin e

/-- 増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和（人手証明
`claim_full_boundary_response_outer_edges_to_one_is_sum_of_inner_monomials`）。前主張と同じ `ι`・`π` の下で、
環準同型 `π` が有限和を保つこと（`map_sum`）と、各項へ前主張
`brokenMonomial_maps_to_monomial_under_outer_edges_to_one` を項ごとに適用すること（`Finset.sum_congr`）の 1 論法。 -/
theorem fullBoundaryResponse_outer_edges_to_one_is_sum_of_inner_monomials
    {Edge'' Outer : Type*} [Fintype Outer]
    (broken'' : Configuration × Outer → Finset Edge'')
    (ι : Edge → Edge'') (hι : Function.Injective ι)
    (π : MvPolynomial Edge'' ℤ →+* MvPolynomial Edge ℤ)
    (hin : ∀ e : Edge, π (X (ι e)) = X e)
    (hout : ∀ e'' : Edge'', e'' ∉ Set.range ι → π (X e'') = 1) :
    π (multivariatePartitionPolynomial broken'') =
      ∑ σ : Configuration × Outer, ∏ e ∈ (broken'' σ).preimage ι hι.injOn, X e := by
  unfold multivariatePartitionPolynomial
  -- 環準同型は有限和を保つ
  rw [map_sum]
  -- 各項へ前主張を適用
  exact Finset.sum_congr rfl fun σ _ ↦
    brokenMonomial_maps_to_monomial_under_outer_edges_to_one ι hι π hin hout (broken'' σ)

end

end Ising3DCut
