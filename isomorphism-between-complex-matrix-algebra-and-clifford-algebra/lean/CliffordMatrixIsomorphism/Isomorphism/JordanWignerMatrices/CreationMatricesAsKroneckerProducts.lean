/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、生成作用素・消滅作用素の行列を
クロネッカー積で書く三つの主張の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                      このファイル
  claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count
                                                                    partialOrderedProduct_pauliZ_diagonal（帰納法の主張）・
                                                                    partialOrderedProduct_pauliZ_diagonal_eq_sign
  claim_creation_operator_matrix_is_kronecker_product               creationFactor（A_k）・creationMatrix_eq_kroneckerProduct
  claim_annihilation_operator_matrix_is_kronecker_product           annihilationFactor（A'_k）・annihilationMatrix_eq_kroneckerProduct

表し方:
- 番号付けた行列の族 A_k・A'_k は `ℕ → Mat (Idx 2)` で、場合分け（k < m、k = m、k > m）を `if` で書く（1,…,M の外の値は使わない）。
- 本文の帰納法の段 i ∈ {2,…,M} は、i = j + 2（i - 1 = j + 1）と書く（`CountAndSign.lean` と同じ約束）。
  帰納法の主張は j := i - 1 についての `partialOrderedProduct_pauliZ_diagonal` で、主張そのものはそれを i - 1 で読んだもの。
- 本文の「-_ℂ 1_ℂ と -1_ℂ はどちらも 1_ℂ の加法の逆元」の行は、Lean ではどちらも ℂ の `-1` なので `rfl` である。
- 番号順の積の定義 P_m = P_{m-1} ·_ℂ α_m（m ≥ 1）の行は `partialOrderedProduct_of_pos`（m = (m - 1) + 1 として定義を開く）。
- 本文が「各 k で準備の等式。def_ordered_product_in_complex_numbers」とする行は、因子の族がすべての k で等しいので、
  族の等式 `funext` を `orderedProduct M` に渡す行である。
- 部分積の主張は i ≤ M を使わない（i ≥ 1 だけを使う）ので、i ≤ M を仮定に置かない。

本文が引く主張は次の宣言を引く。
  claim_ordered_product_with_unit_factors_after_index   orderedProduct_of_unit_factors_after
  claim_ordered_product_with_zero_factor_is_zero        orderedProduct_of_zero_factor

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/CreationMatricesAsKroneckerProducts.lean`、
導出版は `CreationMatricesAsKroneckerProductsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.PauliMatrices
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatrices

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-- 本文 `def_ordered_product_in_complex_numbers`：m ≥ 1 なら P_m = P_{m-1} ·_ℂ α_m。 -/
theorem partialOrderedProduct_of_pos (a : ℕ → ℂ) (m : ℕ) (hm : 1 ≤ m) :
    partialOrderedProduct a m = partialOrderedProduct a (m - 1) * a m := by
  obtain ⟨j, rfl⟩ : ∃ j, m = j + 1 := ⟨m - 1, by omega⟩
  rfl

/-! ### z の Pauli 行列の対角成分の部分積 -/

/-- 本文 `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count` の帰納法の主張（j := i - 1）：
k ∈ {1,…,j} で α_k = (σz)_{o_{M,T}(k),o_{M,T}(k)} なら P_j = ς(N_{j+1}(T))。 -/
theorem partialOrderedProduct_pauliZ_diagonal {M : ℕ} (T : PowerSet M) (α : ℕ → ℂ) :
    ∀ j : ℕ, (∀ k : ℕ, 1 ≤ k → k ≤ j → α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k)) →
      partialOrderedProduct α j = sign (countBelow T (j + 1))
  | 0, _ => calc
    partialOrderedProduct α 0 = 1 := rfl
    _ = sign 0 := rfl
    _ = sign (countBelow T 1) := by rw [countBelow_one]
  | j + 1, hα => by
    -- 帰納法の仮定：α についての仮定は k ∈ {1,…,j} でも成り立つ
    have ih := partialOrderedProduct_pauliZ_diagonal T α j (fun k hk1 hkj => hα k hk1 (by omega))
    obtain ⟨z11, _, _, z22⟩ := pauliZ_entries
    by_cases hmem : j + 1 ∈ T.1
    · -- i - 1 ∈ T のとき、o_{M,T}(i-1) = 2
      calc partialOrderedProduct α (j + 1)
          = partialOrderedProduct α j * α (j + 1) := rfl
        _ = sign (countBelow T (j + 1)) * α (j + 1) := by rw [ih]
        _ = sign (countBelow T (j + 1))
              * Mat.entry pauliZ (membershipIndex T (j + 1)) (membershipIndex T (j + 1)) := by
            rw [hα (j + 1) (by omega) (le_refl _)]
        _ = sign (countBelow T (j + 1)) * Mat.entry pauliZ idxTwo idxTwo := by
            rw [membershipIndex_of_mem T (j + 1) hmem]
        _ = sign (countBelow T (j + 1)) * (-1) := by rw [z22]
        _ = (-1) * sign (countBelow T (j + 1)) := mul_comm _ _
        _ = (-1) * sign (countBelow T (j + 1)) := rfl
        _ = sign (countBelow T (j + 1) + 1) := (sign_succ _).symm
        _ = sign (countBelow T (j + 2)) := by rw [countBelow_succ_succ_of_mem T j hmem]
    · -- i - 1 ∉ T のとき、o_{M,T}(i-1) = 1
      calc partialOrderedProduct α (j + 1)
          = partialOrderedProduct α j * α (j + 1) := rfl
        _ = sign (countBelow T (j + 1)) * α (j + 1) := by rw [ih]
        _ = sign (countBelow T (j + 1))
              * Mat.entry pauliZ (membershipIndex T (j + 1)) (membershipIndex T (j + 1)) := by
            rw [hα (j + 1) (by omega) (le_refl _)]
        _ = sign (countBelow T (j + 1)) * Mat.entry pauliZ idxOne idxOne := by
            rw [membershipIndex_of_not_mem T (j + 1) hmem]
        _ = sign (countBelow T (j + 1)) * 1 := by rw [z11]
        _ = sign (countBelow T (j + 1)) := mul_one _
        _ = sign (countBelow T (j + 2)) := by rw [countBelow_succ_succ_of_not_mem T j hmem]

/-- 本文 `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count`：すべての k ∈ {1,…,i-1} で
α_k = (σz)_{o_{M,T}(k),o_{M,T}(k)} なら P_{i-1} = ς(N_i(T))。 -/
theorem partialOrderedProduct_pauliZ_diagonal_eq_sign {M : ℕ} (T : PowerSet M) (i : ℕ) (hi1 : 1 ≤ i) (α : ℕ → ℂ)
    (hα : ∀ k : ℕ, 1 ≤ k → k ≤ i - 1 → α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k)) :
    partialOrderedProduct α (i - 1) = sign (countBelow T i) := by
  have h := partialOrderedProduct_pauliZ_diagonal T α (i - 1) hα
  rw [Nat.sub_add_cancel hi1] at h
  exact h

/-! ### 生成作用素の行列 -/

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の族 A_k：σz（k < m）、E_{2,1}（k = m）、I_2（k > m）。 -/
noncomputable def creationFactor (m k : ℕ) : Mat (Idx 2) :=
  if k < m then pauliZ else if k = m then matrixUnit idxTwo idxOne else Mat.one

theorem creationFactor_of_lt {m k : ℕ} (h : k < m) : creationFactor m k = pauliZ := if_pos h

theorem creationFactor_self (m : ℕ) : creationFactor m m = matrixUnit idxTwo idxOne := by
  unfold creationFactor
  rw [if_neg (lt_irrefl m), if_pos rfl]

theorem creationFactor_of_gt {m k : ℕ} (h : m < k) : creationFactor m k = Mat.one := by
  unfold creationFactor
  rw [if_neg (by omega), if_neg (by omega)]

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の準備：a ≠ b なら (σz)_{a,b} = 0_ℂ。 -/
theorem pauliZ_entry_of_ne {a b : Idx 2} (h : a ≠ b) : Mat.entry pauliZ a b = 0 := by
  obtain ⟨_, z12, z21, _⟩ := pauliZ_entries
  rcases idx_two_cases a with rfl | rfl <;> rcases idx_two_cases b with rfl | rfl
  · exact absurd rfl h
  · exact z12
  · exact z21
  · exact absurd rfl h

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の準備：a ≠ b なら (I_2)_{a,b} = δ_{a,b} = 0_ℂ。 -/
theorem one_two_entry_of_ne {a b : Idx 2} (h : a ≠ b) : Mat.entry (Mat.one : Mat (Idx 2)) a b = 0 := calc
  Mat.entry (Mat.one : Mat (Idx 2)) a b = kroneckerDelta a b := rfl
  _ = 0 := if_neg h

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product`：c_m = ⊠_{k=1}^{M} A_k。 -/
theorem creationMatrix_eq_kroneckerProduct (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    creationMatrix M m hm = kroneckerProduct M (creationFactor m) := Mat.ext fun S T => by
  -- α_k := (A_k)_{o_{M,S}(k),o_{M,T}(k)}
  let α := kroneckerFactor (creationFactor m) S T
  obtain ⟨d11, d12, d21, d22⟩ := kroneckerDelta_two_values
  -- 準備：k ≠ m で A_k は σz か I_2 なので、o_{M,S}(k) ≠ o_{M,T}(k) なら α_k = 0_ℂ
  have hoff : ∀ k : ℕ, k ≠ m → membershipIndex S k ≠ membershipIndex T k → α k = 0 := by
    intro k hkm hne
    rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
    · show Mat.entry (creationFactor m k) _ _ = 0
      rw [creationFactor_of_lt hlt]
      exact pauliZ_entry_of_ne hne
    · show Mat.entry (creationFactor m k) _ _ = 0
      rw [creationFactor_of_gt hgt]
      exact one_two_entry_of_ne hne
  by_cases hcond : m ∉ T.1 ∧ S = unionSingleton T m hm
  · -- m ∉ T かつ S = T ∪ {m} の場合
    obtain ⟨hmT, hS⟩ := hcond
    -- k ≠ m なら o_{M,S}(k) = o_{M,T}(k)
    have hoS : ∀ k : ℕ, k ≠ m → membershipIndex S k = membershipIndex T k := by
      intro k hkm
      apply membershipIndex_eq_of_iff
      rw [hS]
      exact mem_unionSingleton_iff_of_ne T m hm k hkm
    have hmS : m ∈ S.1 := by rw [hS]; exact self_mem_unionSingleton T m hm
    -- k < m なら α_k = (σz)_{o_{M,T}(k),o_{M,T}(k)}
    have hlt : ∀ k : ℕ, 1 ≤ k → k ≤ m - 1 →
        α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k) := by
      intro k _ hk
      show Mat.entry (creationFactor m k) (membershipIndex S k) (membershipIndex T k) = _
      rw [creationFactor_of_lt (by omega), hoS k (by omega)]
    -- k > m なら α_k = δ_{o_{M,T}(k),o_{M,T}(k)} = 1_ℂ
    have hgt : ∀ k : ℕ, m < k → k ≤ M → α k = 1 := by
      intro k hk _
      show Mat.entry (creationFactor m k) (membershipIndex S k) (membershipIndex T k) = 1
      rw [creationFactor_of_gt hk, hoS k (by omega)]
      exact if_pos rfl
    -- α_m = 1_ℂ
    have hαm : α m = 1 := calc
      α m = Mat.entry (matrixUnit idxTwo idxOne) idxTwo idxOne := by
          show Mat.entry (creationFactor m m) (membershipIndex S m) (membershipIndex T m) = _
          rw [creationFactor_self, membershipIndex_of_mem S m hmS, membershipIndex_of_not_mem T m hmT]
      _ = kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxOne := rfl
      _ = 1 * 1 := by rw [d11, d22]
      _ = 1 := mul_one 1
    calc Mat.entry (creationMatrix M m hm) S T
        = sign (countBelow T m) := creationMatrix_entry_of_cond hm ⟨hmT, hS⟩
      _ = partialOrderedProduct α (m - 1) := (partialOrderedProduct_pauliZ_diagonal_eq_sign T m hm.1 α hlt).symm
      _ = partialOrderedProduct α (m - 1) * 1 := (mul_one _).symm
      _ = partialOrderedProduct α (m - 1) * α m := by rw [hαm]
      _ = partialOrderedProduct α m := (partialOrderedProduct_of_pos α m hm.1).symm
      _ = orderedProduct M α := (orderedProduct_of_unit_factors_after M m hm.2 α hgt).symm
      _ = Mat.entry (kroneckerProduct M (creationFactor m)) S T := rfl
  · -- それ以外の場合：α_r = 0_ℂ となる r ∈ {1,…,M} がある
    have hr : ∃ r : ℕ, 1 ≤ r ∧ r ≤ M ∧ α r = 0 := by
      by_cases hmT : m ∈ T.1
      · -- m ∈ T のとき、o_{M,T}(m) = 2 なので α_m = δ_{2,o_{M,S}(m)} ·_ℂ δ_{1,2} = 0_ℂ
        refine ⟨m, hm.1, hm.2, ?_⟩
        calc α m = kroneckerDelta idxTwo (membershipIndex S m) * kroneckerDelta idxOne idxTwo := by
              show Mat.entry (creationFactor m m) (membershipIndex S m) (membershipIndex T m) = _
              rw [creationFactor_self, membershipIndex_of_mem T m hmT]; rfl
          _ = kroneckerDelta idxTwo (membershipIndex S m) * 0 := by rw [d12]
          _ = 0 := mul_zero _
      · by_cases hmS : m ∈ S.1
        · -- m ∉ T、m ∈ S、S ≠ T ∪ {m} のとき
          have hSne : S ≠ unionSingleton T m hm := fun h => hcond ⟨hmT, h⟩
          have hk : ∃ k : ℕ, 1 ≤ k ∧ k ≤ M ∧ ¬(k ∈ S.1 ↔ k ∈ (unionSingleton T m hm).1) := by
            by_contra hno
            apply hSne
            apply PowerSet.ext
            intro t ht1 htM
            by_contra hiff
            exact hno ⟨t, ht1, htM, hiff⟩
          obtain ⟨k, hk1, hkM, hiff⟩ := hk
          -- m ∈ S かつ m ∈ T ∪ {m} なので k ≠ m
          have hkm : k ≠ m := by
            intro h
            rw [h] at hiff
            exact hiff ⟨fun _ => self_mem_unionSingleton T m hm, fun _ => hmS⟩
          -- k ∈ S と k ∈ T は同値でない
          have hiff' : ¬(k ∈ S.1 ↔ k ∈ T.1) := by
            rw [← mem_unionSingleton_iff_of_ne T m hm k hkm]
            exact hiff
          exact ⟨k, hk1, hkM, hoff k hkm (membershipIndex_ne_of_not_iff S T k hiff')⟩
        · -- m ∉ T かつ m ∉ S のとき、o_{M,S}(m) = 1 なので α_m = δ_{2,1} ·_ℂ δ_{1,o_{M,T}(m)} = 0_ℂ
          refine ⟨m, hm.1, hm.2, ?_⟩
          calc α m = kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne (membershipIndex T m) := by
                show Mat.entry (creationFactor m m) (membershipIndex S m) (membershipIndex T m) = _
                rw [creationFactor_self, membershipIndex_of_not_mem S m hmS]; rfl
            _ = 0 * kroneckerDelta idxOne (membershipIndex T m) := by rw [d21]
            _ = 0 := zero_mul _
    obtain ⟨r, hr1, hrM, hαr⟩ := hr
    calc Mat.entry (creationMatrix M m hm) S T
        = 0 := creationMatrix_entry_of_not_cond hm hcond
      _ = orderedProduct M α := (orderedProduct_of_zero_factor M r hr1 hrM α hαr).symm
      _ = Mat.entry (kroneckerProduct M (creationFactor m)) S T := rfl

/-! ### 消滅作用素の行列 -/

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の族 A'_k：A_k（k ≠ m）、E_{1,2}（k = m）。 -/
noncomputable def annihilationFactor (m k : ℕ) : Mat (Idx 2) :=
  if k = m then matrixUnit idxOne idxTwo else creationFactor m k

theorem annihilationFactor_self (m : ℕ) : annihilationFactor m m = matrixUnit idxOne idxTwo := if_pos rfl

theorem annihilationFactor_of_ne {m k : ℕ} (h : k ≠ m) : annihilationFactor m k = creationFactor m k := if_neg h

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の準備：すべての k と a, b ∈ {1,2} で
(A'_k)_{a,b} = (A_k)_{b,a}。 -/
theorem annihilationFactor_entry (m k : ℕ) (a b : Idx 2) :
    Mat.entry (annihilationFactor m k) a b = Mat.entry (creationFactor m k) b a := by
  by_cases hkm : k = m
  · -- k = m のとき
    subst hkm
    calc Mat.entry (annihilationFactor k k) a b
        = Mat.entry (matrixUnit idxOne idxTwo) a b := by rw [annihilationFactor_self]
      _ = kroneckerDelta idxOne a * kroneckerDelta idxTwo b := rfl
      _ = kroneckerDelta idxTwo b * kroneckerDelta idxOne a := mul_comm _ _
      _ = Mat.entry (matrixUnit idxTwo idxOne) b a := rfl
      _ = Mat.entry (creationFactor k k) b a := by rw [creationFactor_self]
  · -- k ≠ m のとき、A_k は σz か I_2 で、a = b なら両辺は同じ成分、a ≠ b なら両辺とも 0_ℂ
    rw [annihilationFactor_of_ne hkm]
    by_cases hab : a = b
    · rw [hab]
    · rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
      · rw [creationFactor_of_lt hlt, pauliZ_entry_of_ne hab, pauliZ_entry_of_ne (Ne.symm hab)]
      · rw [creationFactor_of_gt hgt, one_two_entry_of_ne hab, one_two_entry_of_ne (Ne.symm hab)]

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product`：c_m^T = ⊠_{k=1}^{M} A'_k。 -/
theorem annihilationMatrix_eq_kroneckerProduct (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    annihilationMatrix M m hm = kroneckerProduct M (annihilationFactor m) := Mat.ext fun S T => calc
  Mat.entry (annihilationMatrix M m hm) S T
      = Mat.entry (creationMatrix M m hm) T S := rfl
  _ = Mat.entry (kroneckerProduct M (creationFactor m)) T S := by rw [creationMatrix_eq_kroneckerProduct M m hm]
  _ = orderedProduct M (fun k => Mat.entry (creationFactor m k) (membershipIndex T k) (membershipIndex S k)) := rfl
  _ = orderedProduct M (fun k => Mat.entry (annihilationFactor m k) (membershipIndex S k) (membershipIndex T k)) :=
      congrArg (orderedProduct M) (funext fun k => (annihilationFactor_entry m k _ _).symm)
  _ = Mat.entry (kroneckerProduct M (annihilationFactor m)) S T := rfl

end CliffordMatrixIsomorphism.Isomorphism
