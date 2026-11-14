/-
章「複素行列環」の、{1,2} で添字づけた行列の積の成分と、部分集合全体で添字づけたクロネッカー積とその三つの主張の必要十分版。
具体版 `ComplexMatrixAlgebra/KroneckerProduct/KroneckerProduct.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。
{1,2}・o_T(k)・(2, id_2)・{1,2} が有限集合であること（`MembershipIndex.lean`）と P_M（`PowerSetNumbering/`）は ℂ を含まないので、
具体版と同じものを引く。

  本文のラベル                                                          このファイル                            使う K の性質
  claim_entry_of_product_of_matrices_indexed_by_two_element_set         entry_mul_two                           L（積を定めるためと、0 + a = a）
  def_kronecker_product_indexed_by_power_set                            kroneckerFactor・kroneckerProduct       なし（乗法と 1 の記号だけ）
  claim_product_of_kronecker_products_is_kronecker_product_of_products  mul_kroneckerProduct                    L・乗法の交換法則・a · 1 = a・
                                                                                                                a · 0 = 0
  claim_kronecker_product_of_identity_matrices_is_identity_matrix       kroneckerProduct_one                    a · 1 = a・乗法の結合法則・
                                                                                                                a · 0 = 0 · a・0 · a = 0
  claim_kronecker_product_is_linear_in_one_factor                       kroneckerProduct_linear_in_one_factor   左右の分配法則・乗法の結合法則・
                                                                                                                λ と λ' がどの元とも交換すること

L : `ValuedMapsLaws K` は積 `Mat.mul L hX` を定めるのに要る。積の主張の行で L から使うのは、二つの番号順の積の積の主張に渡す
1 · 1 = 1（`L.one_mul 1`）と乗法の結合法則、Π v^R_k = 1_K ·_K Π v^R_k の行の 1 · a = a、
部分集合全体の上の和の主張（`SumOverPowerSet.lean`）が使うものである。

削れなかった仮定:
- 乗法の交換法則・a · 1 = a・a · 0 = 0（積の主張）: 部分集合全体の上の和の主張（`SumOverPowerSet.lean` の冒頭）と、
  二つの番号順の積の積の主張（交換法則。α_m と Q_{m-1} の入れ替え）が要る。
- 0 + a = a（{1,2} の積の成分、積の主張）は仮定に置かない。線型結合 L_2 を開いた 0 +_K (A_{a,1} ·_K B_{1,b}) の 0 を消す行と、
  部分集合全体の上の和の主張の m = 0 の段が使うが、L の加法の交換法則と a + 0 = a から出る（`zero_add_of_valuedMapsLaws`）。
- 乗法の結合法則・a · 0 = 0 · a・0 · a = 0（単位行列）: 本文どおり 0 の因子の主張を使うので、その仮定（スカラー倍の主張を λ := 0 で当てる）を連れてくる。
  a · 1 = a は 1 の因子の主張の仮定である。
- λ・λ' の交換（一つの因子の線型性）: 一つの因子のスカラー倍の主張の仮定。λ がどの元とも交換しなければ、
  λ を番号順の積の前の部分の積の前へ出せない（`NecSuf/MathematicalToolkit/TensorProduct/OrderedProduct.lean`）。
  K 全体の乗法の交換法則は要らない。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.MembershipIndex
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.SumOverPowerSet

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet PowerSet.ext isFiniteSet_powerSet idxOne idxTwo
  idxOne_ne_idxTwo isNumbering_two isFiniteSet_two membershipIndex membershipIndex_of_mem membershipIndex_of_not_mem)

universe uK

variable {K : Type uK}

/-- 本文 `claim_entry_of_product_of_matrices_indexed_by_two_element_set` の必要十分版：
(A · B)_{a,b} = (A_{a,1} · B_{1,b}) + (A_{a,2} · B_{2,b})。 -/
theorem entry_mul_two [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (A B : Mat K (Idx 2)) (a b : Idx 2) :
    Mat.entry (Mat.mul L isFiniteSet_two A B) a b
      = Mat.entry A a idxOne * Mat.entry B idxOne b + Mat.entry A a idxTwo * Mat.entry B idxTwo b := by
  let S := coefficientsVec L
  calc Mat.entry (Mat.mul L isFiniteSet_two A B) a b
      = sumOverFiniteSet S isFiniteSet_two (fun z => Mat.entry A a z) (fun z => Mat.entry B z b) := rfl
    _ = linearCombination S 2 (numberedFamily (fun k : Idx 2 => k) (fun z => Mat.entry A a z) 0)
          (numberedFamily (fun k : Idx 2 => k) (fun z => Mat.entry B z b) S.zero) :=
        sumOverFiniteSet_eq S isFiniteSet_two _ _ 2 (fun k => k) isNumbering_two
    _ = S.add (S.add S.zero (S.smul (Mat.entry A a idxOne) (Mat.entry B idxOne b)))
          (S.smul (Mat.entry A a idxTwo) (Mat.entry B idxTwo b)) := rfl
    _ = (0 + Mat.entry A a idxOne * Mat.entry B idxOne b) + Mat.entry A a idxTwo * Mat.entry B idxTwo b := rfl
    _ = Mat.entry A a idxOne * Mat.entry B idxOne b + Mat.entry A a idxTwo * Mat.entry B idxTwo b := by
        rw [zero_add_of_valuedMapsLaws L (Mat.entry A a idxOne * Mat.entry B idxOne b)]

/-- 本文 `def_kronecker_product_indexed_by_power_set` の番号順の積の因子の必要十分版。 -/
noncomputable def kroneckerFactor {M : ℕ} (A : ℕ → Mat K (Idx 2)) (S T : PowerSet M) (k : ℕ) : K :=
  Mat.entry (A k) (membershipIndex S k) (membershipIndex T k)

/-- 本文 `def_kronecker_product_indexed_by_power_set` の必要十分版：(⊠ A_k)_{S,T} := Π_{k=1}^{M} (A_k)_{o_S(k),o_T(k)}。 -/
noncomputable def kroneckerProduct [Mul K] [One K] (M : ℕ) (A : ℕ → Mat K (Idx 2)) : Mat K (PowerSet M) :=
  fun p => orderedProduct M (kroneckerFactor A p.1 p.2)

theorem kroneckerProduct_entry [Mul K] [One K] (M : ℕ) (A : ℕ → Mat K (Idx 2)) (S T : PowerSet M) :
    Mat.entry (kroneckerProduct M A) S T = orderedProduct M (kroneckerFactor A S T) := rfl

/-- 本文 `claim_product_of_kronecker_products_is_kronecker_product_of_products` の必要十分版。 -/
theorem mul_kroneckerProduct [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (M : ℕ) (A B : ℕ → Mat K (Idx 2)) :
    Mat.mul L (isFiniteSet_powerSet M) (kroneckerProduct M A) (kroneckerProduct M B)
      = kroneckerProduct M (fun k => Mat.mul L isFiniteSet_two (A k) (B k)) := Mat.ext fun S T => by
  let V := coefficientsVec L
  let x : ℕ → K := fun k =>
    Mat.entry (A k) (membershipIndex S k) idxTwo * Mat.entry (B k) idxTwo (membershipIndex T k)
  let y : ℕ → K := fun k =>
    Mat.entry (A k) (membershipIndex S k) idxOne * Mat.entry (B k) idxOne (membershipIndex T k)
  -- （一）
  have h1 : ∀ (R : PowerSet M) (k : ℕ),
      kroneckerFactor A S R k * kroneckerFactor B R T k = selectedFactor x y R.1 k := by
    intro R k
    by_cases hk : k ∈ R.1
    · show Mat.entry (A k) (membershipIndex S k) (membershipIndex R k)
          * Mat.entry (B k) (membershipIndex R k) (membershipIndex T k) = selectedFactor x y R.1 k
      rw [membershipIndex_of_mem R k hk, selectedFactor_of_mem x y R.1 k hk]
    · show Mat.entry (A k) (membershipIndex S k) (membershipIndex R k)
          * Mat.entry (B k) (membershipIndex R k) (membershipIndex T k) = selectedFactor x y R.1 k
      rw [membershipIndex_of_not_mem R k hk, selectedFactor_of_not_mem x y R.1 k hk]
  -- （二）
  have h2 : ∀ R : PowerSet M,
      V.smul (Mat.entry (kroneckerProduct M A) S R) (Mat.entry (kroneckerProduct M B) R T)
        = V.smul 1 (orderedProduct M (selectedFactor x y R.1)) := fun R => calc
    V.smul (Mat.entry (kroneckerProduct M A) S R) (Mat.entry (kroneckerProduct M B) R T)
        = Mat.entry (kroneckerProduct M A) S R * Mat.entry (kroneckerProduct M B) R T := rfl
    _ = orderedProduct M (kroneckerFactor A S R) * orderedProduct M (kroneckerFactor B R T) := rfl
    _ = orderedProduct M (fun k => kroneckerFactor A S R k * kroneckerFactor B R T k) :=
        orderedProduct_mul (L.one_mul 1) L.mul_assoc hcomm M _ _
    _ = orderedProduct M (selectedFactor x y R.1) := congrArg (orderedProduct M) (funext (h1 R))
    _ = 1 * orderedProduct M (selectedFactor x y R.1) := by
        rw [L.one_mul (orderedProduct M (selectedFactor x y R.1))]
    _ = V.smul 1 (orderedProduct M (selectedFactor x y R.1)) := rfl
  -- （三）
  have h3 : ∀ k : ℕ, y k + x k
      = kroneckerFactor (fun k => Mat.mul L isFiniteSet_two (A k) (B k)) S T k := fun k => calc
    y k + x k
        = Mat.entry (A k) (membershipIndex S k) idxOne * Mat.entry (B k) idxOne (membershipIndex T k)
          + Mat.entry (A k) (membershipIndex S k) idxTwo * Mat.entry (B k) idxTwo (membershipIndex T k) := rfl
    _ = Mat.entry (Mat.mul L isFiniteSet_two (A k) (B k)) (membershipIndex S k) (membershipIndex T k) :=
        (entry_mul_two L (A k) (B k) (membershipIndex S k) (membershipIndex T k)).symm
  calc Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (kroneckerProduct M A) (kroneckerProduct M B)) S T
      = sumOverFiniteSet V (isFiniteSet_powerSet M) (fun R => Mat.entry (kroneckerProduct M A) S R)
          (fun R => Mat.entry (kroneckerProduct M B) R T) := rfl
    _ = sumOverFiniteSet V (isFiniteSet_powerSet M) (fun _ => 1)
          (fun R => orderedProduct M (selectedFactor x y R.1)) :=
        sumOverFiniteSet_congr V (isFiniteSet_powerSet M) _ _ _ _ h2
    _ = orderedProduct M (fun k => y k + x k) :=
        sumOverPowerSet_selected L hcomm hmul1 hmul0 M x y
    _ = orderedProduct M (kroneckerFactor (fun k => Mat.mul L isFiniteSet_two (A k) (B k)) S T) :=
        congrArg (orderedProduct M) (funext h3)
    _ = Mat.entry (kroneckerProduct M (fun k => Mat.mul L isFiniteSet_two (A k) (B k))) S T := rfl

/-- 本文 `claim_kronecker_product_of_identity_matrices_is_identity_matrix` の必要十分版：⊠ 1 = 1。 -/
theorem kroneckerProduct_one [Mul K] [One K] [Zero K] (hmul1 : ∀ a : K, a * 1 = a)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hzero_central : ∀ a : K, a * 0 = 0 * a)
    (hzero_mul : ∀ a : K, 0 * a = 0) (M : ℕ) :
    kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2))) = (Mat.one : Mat K (PowerSet M)) :=
  Mat.ext fun S T => by
  have hα : ∀ k : ℕ, kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T k
      = (kroneckerDelta (membershipIndex S k) (membershipIndex T k) : K) := fun _ => rfl
  by_cases hST : S = T
  · have h1 : ∀ s : ℕ, 0 < s → s ≤ M → kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T s = 1 := by
      intro s _ _
      rw [hα s, hST, kroneckerDelta, if_pos rfl]
    calc Mat.entry (kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2)))) S T
        = orderedProduct M (kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T) := rfl
      _ = partialOrderedProduct (kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T) 0 :=
          orderedProduct_of_unit_factors_after hmul1 M 0 (Nat.zero_le M) _ h1
      _ = 1 := rfl
      _ = (kroneckerDelta S T : K) := by rw [kroneckerDelta, if_pos hST]
      _ = Mat.entry (Mat.one : Mat K (PowerSet M)) S T := rfl
  · have hr : ∃ r : ℕ, 1 ≤ r ∧ r ≤ M ∧ ¬ (r ∈ S.1 ↔ r ∈ T.1) := by
      by_contra hno
      apply hST
      apply PowerSet.ext
      intro t ht1 htM
      by_contra hiff
      exact hno ⟨t, ht1, htM, hiff⟩
    obtain ⟨r, hr1, hrM, hiff⟩ := hr
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
    have hα0 : kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T r = 0 := by
      rw [hα r, kroneckerDelta, if_neg hne]
    calc Mat.entry (kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2)))) S T
        = orderedProduct M (kroneckerFactor (fun _ => (Mat.one : Mat K (Idx 2))) S T) := rfl
      _ = 0 := orderedProduct_of_zero_factor hmassoc hzero_central hzero_mul M r hr1 hrM _ hα0
      _ = (kroneckerDelta S T : K) := by rw [kroneckerDelta, if_neg hST]
      _ = Mat.entry (Mat.one : Mat K (PowerSet M)) S T := rfl

/-- 本文 `claim_kronecker_product_is_linear_in_one_factor` の必要十分版：
⊠ A''_k = (λ ∗ ⊠ A_k) + (λ' ∗ ⊠ A'_k)。 -/
theorem kroneckerProduct_linear_in_one_factor [Add K] [Mul K] [One K]
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (M r : ℕ) (hr1 : 1 ≤ r) (hrM : r ≤ M) (l l' : K)
    (hcentral : ∀ a : K, a * l = l * a) (hcentral' : ∀ a : K, a * l' = l' * a)
    (A A' A'' : ℕ → Mat K (Idx 2))
    (hne : ∀ k : ℕ, 1 ≤ k → k ≤ M → k ≠ r → A k = A' k ∧ A k = A'' k)
    (hr : A'' r = Mat.add (Mat.smul l (A r)) (Mat.smul l' (A' r))) :
    kroneckerProduct M A''
      = Mat.add (Mat.smul l (kroneckerProduct M A)) (Mat.smul l' (kroneckerProduct M A')) :=
  Mat.ext fun S T => by
  let α := kroneckerFactor A S T
  let α' := kroneckerFactor A' S T
  let α'' := kroneckerFactor A'' S T
  let β : ℕ → K := fun k => if k = r then l * α r else α k
  let β' : ℕ → K := fun k => if k = r then l' * α' r else α' k
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
  have hβr : α'' r = β r + β' r := by
    have hβ : β r = l * α r := if_pos rfl
    have hβ' : β' r = l' * α' r := if_pos rfl
    rw [hβ, hβ']
    show Mat.entry (A'' r) _ _ = _
    rw [hr]
    rfl
  have hβα : ∀ s : ℕ, 1 ≤ s → s ≤ M → s ≠ r → β s = α s := fun s _ _ hs => if_neg hs
  have hβα' : ∀ s : ℕ, 1 ≤ s → s ≤ M → s ≠ r → β' s = α' s := fun s _ _ hs => if_neg hs
  calc Mat.entry (kroneckerProduct M A'') S T
      = orderedProduct M α'' := rfl
    _ = orderedProduct M β + orderedProduct M β' :=
        orderedProduct_add_in_one_factor hldistrib hrdistrib M r hr1 hrM α'' β β' hβne hβr
    _ = l * orderedProduct M α + l' * orderedProduct M α' := by
        rw [orderedProduct_smul_in_one_factor hmassoc M r hr1 hrM l hcentral β α hβα (if_pos rfl),
          orderedProduct_smul_in_one_factor hmassoc M r hr1 hrM l' hcentral' β' α' hβα' (if_pos rfl)]
    _ = l * Mat.entry (kroneckerProduct M A) S T + l' * Mat.entry (kroneckerProduct M A') S T := rfl
    _ = Mat.entry (Mat.add (Mat.smul l (kroneckerProduct M A)) (Mat.smul l' (kroneckerProduct M A'))) S T := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
