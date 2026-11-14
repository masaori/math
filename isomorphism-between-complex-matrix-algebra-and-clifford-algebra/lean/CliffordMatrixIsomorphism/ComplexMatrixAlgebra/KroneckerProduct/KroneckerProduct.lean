/-
章「複素行列環」の、{1,2} で添字づけた行列の積の成分と、部分集合全体で添字づけたクロネッカー積とその三つの主張の具体版。
人手証明と 1 対 1 に対応させる。mathlib の `Matrix`・`Matrix.kronecker`・`Finset.prod` は使わない。

  本文のラベル                                                          このファイル
  claim_entry_of_product_of_matrices_indexed_by_two_element_set         entry_mul_two（前提の isFiniteSet_two は
                                                                        `MembershipIndex.lean`）
  def_kronecker_product_indexed_by_power_set                            kroneckerFactor（(A_k)_{o_S(k),o_T(k)} の族）・
                                                                        kroneckerProduct・kroneckerProduct_entry
  claim_product_of_kronecker_products_is_kronecker_product_of_products  mul_kroneckerProduct
  claim_kronecker_product_of_identity_matrices_is_identity_matrix       kroneckerProduct_one
  claim_kronecker_product_is_linear_in_one_factor                       kroneckerProduct_linear_in_one_factor

{1,2} は `Idx 2` で、その二元は `idxOne`・`idxTwo`、番号付け (2, id_2) は `isNumbering_two`、
{1,2} が有限集合であることは `isFiniteSet_two`（どれも ℂ を含まないので `MembershipIndex.lean` に置き、両版が引く）。Mat_{1,2}(ℂ) の積は `Mat.mul isFiniteSet_two`、
Mat_{P_M}(ℂ) の積は `Mat.mul (isFiniteSet_powerSet M)` である。単位行列 1_{Mat_{1,2}} の δ は `Idx 2`（ℕ の部分型）の等号の判定、
1_{Mat_{P_M}} の δ は `PowerSet.lean` の `Classical.decEq` を使う。
番号付けた行列の族 A_1,…,A_M は `ℕ → Mat (Idx 2)` で表し、1,…,M の外の値は使わない。

本文が引くほかのブロックは、次の宣言を引く。
  def_ordered_product_in_complex_numbers                       orderedProduct・partialOrderedProduct
  claim_product_of_two_ordered_products_in_complex_numbers     orderedProduct_mul
  claim_ordered_product_with_unit_factors_after_index          orderedProduct_of_unit_factors_after
  claim_ordered_product_with_zero_factor_is_zero               orderedProduct_of_zero_factor
  claim_ordered_product_is_additive_in_one_factor              orderedProduct_add_in_one_factor
  claim_ordered_product_is_homogeneous_in_one_factor           orderedProduct_smul_in_one_factor
  claim_sum_over_finite_set_depends_only_on_terms              sumOverFiniteSet_congr
  claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers
                                                               sumOverPowerSet_selected
本文が「各 k で（一）。def_ordered_product_in_complex_numbers」とする行（番号順の積の因子を各番号で取り替える行）は、
因子の族がすべての k で等しいので、族の等式 `funext` を `orderedProduct M` に渡す行である。

本文の主張とクロネッカー積の定義は M ≥ 1 を前提に置くが、証明は M ≥ 1 を使わない（M = 0 でも同じ式で成り立つ）ので、任意の M で書く。

必要十分版は `NecSuf/ComplexMatrixAlgebra/KroneckerProduct/KroneckerProduct.lean`、導出版は `KroneckerProductFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.MembershipIndex
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.SumOverPowerSet
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Definitions

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

/-- 本文 `claim_entry_of_product_of_matrices_indexed_by_two_element_set`：
(A ·_{Mat_{1,2}} B)_{a,b} = (A_{a,1} ·_ℂ B_{1,b}) +_ℂ (A_{a,2} ·_ℂ B_{2,b})。 -/
theorem entry_mul_two (A B : Mat (Idx 2)) (a b : Idx 2) :
    Mat.entry (Mat.mul isFiniteSet_two A B) a b
      = Mat.entry A a idxOne * Mat.entry B idxOne b + Mat.entry A a idxTwo * Mat.entry B idxTwo b := by
  let S := complexNumbersVectorSpace
  calc Mat.entry (Mat.mul isFiniteSet_two A B) a b
      = sumOverFiniteSet S isFiniteSet_two (fun z => Mat.entry A a z) (fun z => Mat.entry B z b) := rfl
    _ = linearCombination S 2 (numberedFamily (fun k : Idx 2 => k) (fun z => Mat.entry A a z) 0)
          (numberedFamily (fun k : Idx 2 => k) (fun z => Mat.entry B z b) S.zero) :=
        sumOverFiniteSet_eq S isFiniteSet_two _ _ 2 (fun k => k) isNumbering_two
    _ = S.add (S.add S.zero (S.smul (Mat.entry A a idxOne) (Mat.entry B idxOne b)))
          (S.smul (Mat.entry A a idxTwo) (Mat.entry B idxTwo b)) := rfl
    _ = (0 + Mat.entry A a idxOne * Mat.entry B idxOne b) + Mat.entry A a idxTwo * Mat.entry B idxTwo b := rfl
    _ = Mat.entry A a idxOne * Mat.entry B idxOne b + Mat.entry A a idxTwo * Mat.entry B idxTwo b := by
        rw [zero_add (Mat.entry A a idxOne * Mat.entry B idxOne b)]

/-- 本文 `def_kronecker_product_indexed_by_power_set` の番号順の積の因子：k に (A_k)_{o_S(k),o_T(k)} を与える族。 -/
noncomputable def kroneckerFactor {M : ℕ} (A : ℕ → Mat (Idx 2)) (S T : PowerSet M) (k : ℕ) : ℂ :=
  Mat.entry (A k) (membershipIndex S k) (membershipIndex T k)

/-- 本文 `def_kronecker_product_indexed_by_power_set`：(⊠_{k=1}^{M} A_k)_{S,T} := Π_{ℂ,k=1}^{M} (A_k)_{o_S(k),o_T(k)}。 -/
noncomputable def kroneckerProduct (M : ℕ) (A : ℕ → Mat (Idx 2)) : Mat (PowerSet M) :=
  fun p => orderedProduct M (kroneckerFactor A p.1 p.2)

theorem kroneckerProduct_entry (M : ℕ) (A : ℕ → Mat (Idx 2)) (S T : PowerSet M) :
    Mat.entry (kroneckerProduct M A) S T = orderedProduct M (kroneckerFactor A S T) := rfl

/-- 本文 `claim_product_of_kronecker_products_is_kronecker_product_of_products`：
(⊠ A_k) ·_{Mat_{P_M}} (⊠ B_k) = ⊠ (A_k ·_{Mat_{1,2}} B_k)。 -/
theorem mul_kroneckerProduct (M : ℕ) (A B : ℕ → Mat (Idx 2)) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerProduct M A) (kroneckerProduct M B)
      = kroneckerProduct M (fun k => Mat.mul isFiniteSet_two (A k) (B k)) := Mat.ext fun S T => by
  let V := complexNumbersVectorSpace
  -- x_k := (A_k)_{o_S(k),2} ·_ℂ (B_k)_{2,o_T(k)}、y_k := (A_k)_{o_S(k),1} ·_ℂ (B_k)_{1,o_T(k)}
  let x : ℕ → ℂ := fun k =>
    Mat.entry (A k) (membershipIndex S k) idxTwo * Mat.entry (B k) idxTwo (membershipIndex T k)
  let y : ℕ → ℂ := fun k =>
    Mat.entry (A k) (membershipIndex S k) idxOne * Mat.entry (B k) idxOne (membershipIndex T k)
  -- （一）(A_k)_{o_S(k),o_R(k)} ·_ℂ (B_k)_{o_R(k),o_T(k)} = v^R_k
  have h1 : ∀ (R : PowerSet M) (k : ℕ),
      kroneckerFactor A S R k * kroneckerFactor B R T k = selectedFactor x y R.1 k := by
    intro R k
    by_cases hk : k ∈ R.1
    · -- k ∈ R なら o_R(k) = 2
      show Mat.entry (A k) (membershipIndex S k) (membershipIndex R k)
          * Mat.entry (B k) (membershipIndex R k) (membershipIndex T k) = selectedFactor x y R.1 k
      rw [membershipIndex_of_mem R k hk, selectedFactor_of_mem x y R.1 k hk]
    · -- k ∉ R なら o_R(k) = 1
      show Mat.entry (A k) (membershipIndex S k) (membershipIndex R k)
          * Mat.entry (B k) (membershipIndex R k) (membershipIndex T k) = selectedFactor x y R.1 k
      rw [membershipIndex_of_not_mem R k hk, selectedFactor_of_not_mem x y R.1 k hk]
  -- （二）𝔸_{S,R} ·_{ℂ^vec} 𝔹_{R,T} = 1_ℂ ·_{ℂ^vec} Π_{ℂ,k=1}^{M} v^R_k
  have h2 : ∀ R : PowerSet M,
      V.smul (Mat.entry (kroneckerProduct M A) S R) (Mat.entry (kroneckerProduct M B) R T)
        = V.smul 1 (orderedProduct M (selectedFactor x y R.1)) := fun R => calc
    V.smul (Mat.entry (kroneckerProduct M A) S R) (Mat.entry (kroneckerProduct M B) R T)
        = Mat.entry (kroneckerProduct M A) S R * Mat.entry (kroneckerProduct M B) R T := rfl
    _ = orderedProduct M (kroneckerFactor A S R) * orderedProduct M (kroneckerFactor B R T) := rfl
    _ = orderedProduct M (fun k => kroneckerFactor A S R k * kroneckerFactor B R T k) :=
        orderedProduct_mul M _ _
    _ = orderedProduct M (selectedFactor x y R.1) := congrArg (orderedProduct M) (funext (h1 R))
    _ = 1 * orderedProduct M (selectedFactor x y R.1) := by
        rw [one_mul (orderedProduct M (selectedFactor x y R.1))]
    _ = V.smul 1 (orderedProduct M (selectedFactor x y R.1)) := rfl
  -- （三）y_k +_ℂ x_k = (A_k ·_{Mat_{1,2}} B_k)_{o_S(k),o_T(k)}
  have h3 : ∀ k : ℕ, y k + x k
      = kroneckerFactor (fun k => Mat.mul isFiniteSet_two (A k) (B k)) S T k := fun k => calc
    y k + x k
        = Mat.entry (A k) (membershipIndex S k) idxOne * Mat.entry (B k) idxOne (membershipIndex T k)
          + Mat.entry (A k) (membershipIndex S k) idxTwo * Mat.entry (B k) idxTwo (membershipIndex T k) := rfl
    _ = Mat.entry (Mat.mul isFiniteSet_two (A k) (B k)) (membershipIndex S k) (membershipIndex T k) :=
        (entry_mul_two (A k) (B k) (membershipIndex S k) (membershipIndex T k)).symm
  calc Mat.entry (Mat.mul (isFiniteSet_powerSet M) (kroneckerProduct M A) (kroneckerProduct M B)) S T
      = sumOverFiniteSet V (isFiniteSet_powerSet M) (fun R => Mat.entry (kroneckerProduct M A) S R)
          (fun R => Mat.entry (kroneckerProduct M B) R T) := rfl
    _ = sumOverFiniteSet V (isFiniteSet_powerSet M) (fun _ => 1)
          (fun R => orderedProduct M (selectedFactor x y R.1)) :=
        sumOverFiniteSet_congr V (isFiniteSet_powerSet M) _ _ _ _ h2
    _ = orderedProduct M (fun k => y k + x k) := sumOverPowerSet_selected M x y
    _ = orderedProduct M (kroneckerFactor (fun k => Mat.mul isFiniteSet_two (A k) (B k)) S T) :=
        congrArg (orderedProduct M) (funext h3)
    _ = Mat.entry (kroneckerProduct M (fun k => Mat.mul isFiniteSet_two (A k) (B k))) S T := rfl

/-- 本文 `claim_kronecker_product_of_identity_matrices_is_identity_matrix`：⊠_{k=1}^{M} 1_{Mat_{1,2}} = 1_{Mat_{P_M}}。 -/
theorem kroneckerProduct_one (M : ℕ) :
    kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2))) = (Mat.one : Mat (PowerSet M)) :=
  Mat.ext fun S T => by
  -- α_k := (A_k)_{o_S(k),o_T(k)} = δ_{o_S(k),o_T(k)}
  have hα : ∀ k : ℕ, kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T k
      = kroneckerDelta (membershipIndex S k) (membershipIndex T k) := fun _ => rfl
  by_cases hST : S = T
  · -- S = T の場合：すべての k で α_k = 1_ℂ
    have h1 : ∀ s : ℕ, 0 < s → s ≤ M → kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T s = 1 := by
      intro s _ _
      rw [hα s, hST, kroneckerDelta, if_pos rfl]
    calc Mat.entry (kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2)))) S T
        = orderedProduct M (kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T) := rfl
      _ = partialOrderedProduct (kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T) 0 :=
          orderedProduct_of_unit_factors_after M 0 (Nat.zero_le M) _ h1
      _ = 1 := rfl
      _ = kroneckerDelta S T := by rw [kroneckerDelta, if_pos hST]
      _ = Mat.entry (Mat.one : Mat (PowerSet M)) S T := rfl
  · -- S ≠ T の場合：k ∈ S と k ∈ T が同値でない r ∈ {1,…,M} がある
    have hr : ∃ r : ℕ, 1 ≤ r ∧ r ≤ M ∧ ¬ (r ∈ S.1 ↔ r ∈ T.1) := by
      by_contra hno
      apply hST
      apply PowerSet.ext
      intro t ht1 htM
      by_contra hiff
      exact hno ⟨t, ht1, htM, hiff⟩
    obtain ⟨r, hr1, hrM, hiff⟩ := hr
    -- o_S(r) と o_T(r) の一方は 2、他方は 1 なので α_r = 0_ℂ
    have hne : membershipIndex S r ≠ membershipIndex T r := by
      by_cases hrS : r ∈ S.1
      · have hrT : r ∉ T.1 := fun h => hiff ⟨fun _ => h, fun _ => hrS⟩
        rw [membershipIndex_of_mem S r hrS, membershipIndex_of_not_mem T r hrT]
        exact fun h => idxOne_ne_idxTwo h.symm
      · have hrT : r ∈ T.1 := by
          by_contra hrT
          exact hiff ⟨fun h => absurd h hrS, fun h => absurd h hrT⟩
        rw [membershipIndex_of_not_mem S r hrS, membershipIndex_of_mem T r hrT]
        exact idxOne_ne_idxTwo
    have hα0 : kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T r = 0 := by
      rw [hα r, kroneckerDelta, if_neg hne]
    calc Mat.entry (kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2)))) S T
        = orderedProduct M (kroneckerFactor (fun _ => (Mat.one : Mat (Idx 2))) S T) := rfl
      _ = 0 := orderedProduct_of_zero_factor M r hr1 hrM _ hα0
      _ = kroneckerDelta S T := by rw [kroneckerDelta, if_neg hST]
      _ = Mat.entry (Mat.one : Mat (PowerSet M)) S T := rfl

/-- 本文 `claim_kronecker_product_is_linear_in_one_factor`：k ≠ r で A_k = A'_k = A''_k、
A''_r = (λ ∗ A_r) + (λ' ∗ A'_r) なら ⊠ A''_k = (λ ∗ ⊠ A_k) + (λ' ∗ ⊠ A'_k)。 -/
theorem kroneckerProduct_linear_in_one_factor (M r : ℕ) (hr1 : 1 ≤ r) (hrM : r ≤ M) (l l' : ℂ)
    (A A' A'' : ℕ → Mat (Idx 2))
    (hne : ∀ k : ℕ, 1 ≤ k → k ≤ M → k ≠ r → A k = A' k ∧ A k = A'' k)
    (hr : A'' r = Mat.add (Mat.smul l (A r)) (Mat.smul l' (A' r))) :
    kroneckerProduct M A''
      = Mat.add (Mat.smul l (kroneckerProduct M A)) (Mat.smul l' (kroneckerProduct M A')) :=
  Mat.ext fun S T => by
  -- α_k、α'_k、α''_k
  let α := kroneckerFactor A S T
  let α' := kroneckerFactor A' S T
  let α'' := kroneckerFactor A'' S T
  -- β_k := α_k（k ≠ r）、β_r := λ ·_ℂ α_r。β'_k := α'_k（k ≠ r）、β'_r := λ' ·_ℂ α'_r
  let β : ℕ → ℂ := fun k => if k = r then l * α r else α k
  let β' : ℕ → ℂ := fun k => if k = r then l' * α' r else α' k
  -- k ≠ r なら α''_k = β_k = β'_k
  have hβne : ∀ s : ℕ, 1 ≤ s → s ≤ M → s ≠ r → α'' s = β s ∧ α'' s = β' s := by
    intro s hs1 hsM hs
    have h := hne s hs1 hsM hs
    have hβ : β s = α s := if_neg hs
    have hβ' : β' s = α' s := if_neg hs
    refine ⟨?_, ?_⟩
    · show Mat.entry (A'' s) _ _ = β s
      rw [hβ, ← h.2]
      rfl
    · show Mat.entry (A'' s) _ _ = β' s
      rw [hβ', ← h.2, h.1]
      rfl
  -- α''_r = β_r +_ℂ β'_r
  have hβr : α'' r = β r + β' r := by
    have hβ : β r = l * α r := if_pos rfl
    have hβ' : β' r = l' * α' r := if_pos rfl
    rw [hβ, hβ']
    show Mat.entry (A'' r) _ _ = _
    rw [hr]
    rfl
  -- k ≠ r なら β_k = α_k、β_r = λ ·_ℂ α_r（β' も同じ）
  have hβα : ∀ s : ℕ, 1 ≤ s → s ≤ M → s ≠ r → β s = α s := fun s _ _ hs => if_neg hs
  have hβα' : ∀ s : ℕ, 1 ≤ s → s ≤ M → s ≠ r → β' s = α' s := fun s _ _ hs => if_neg hs
  calc Mat.entry (kroneckerProduct M A'') S T
      = orderedProduct M α'' := rfl
    _ = orderedProduct M β + orderedProduct M β' :=
        orderedProduct_add_in_one_factor M r hr1 hrM α'' β β' hβne hβr
    _ = l * orderedProduct M α + l' * orderedProduct M α' := by
        rw [orderedProduct_smul_in_one_factor M r hr1 hrM l β α hβα (if_pos rfl),
          orderedProduct_smul_in_one_factor M r hr1 hrM l' β' α' hβα' (if_pos rfl)]
    _ = l * Mat.entry (kroneckerProduct M A) S T + l' * Mat.entry (kroneckerProduct M A') S T := rfl
    _ = Mat.entry (Mat.add (Mat.smul l (kroneckerProduct M A)) (Mat.smul l' (kroneckerProduct M A'))) S T := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
