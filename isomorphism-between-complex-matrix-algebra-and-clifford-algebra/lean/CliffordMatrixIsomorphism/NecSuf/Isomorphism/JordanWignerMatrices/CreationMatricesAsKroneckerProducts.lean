/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、生成作用素・消滅作用素の行列をクロネッカー積で書く
三つの主張の必要十分版。具体版 `Isomorphism/JordanWignerMatrices/CreationMatricesAsKroneckerProducts.lean` と同じ def と
calc の行で、係数 ℂ を型の変数 K に、符号 ς を定める -1_ℂ を K の元 n に替えて書く（生成作用素の行列の必要十分版と同じ n）。
σz の (2,2) 成分は本文どおり -_ℂ 1_ℂ（K の `Neg` の記号で `-1`）である。

  本文のラベル                                                      このファイル                       使う K の性質
  claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count
                                                                    partialOrderedProduct_pauliZ_diagonal・
                                                                    …_eq_sign                          a · 1 = a、-1 がどの元とも交換すること、
                                                                                                       -1 = n
  claim_creation_operator_matrix_is_kronecker_product               creationFactor・
                                                                    creationMatrix_eq_kroneckerProduct 上の三つと、a · 0 = 0、0 · a = 0、
                                                                                                       乗法の結合法則
  claim_annihilation_operator_matrix_is_kronecker_product           annihilationFactor・
                                                                    annihilationMatrix_eq_kroneckerProduct
                                                                                                       上の六つと、0 と 1 がどの元とも交換すること

削れなかった仮定:
- -1 = n（部分積の主張）: 本文の「-_ℂ 1_ℂ と -1_ℂ はどちらも 1_ℂ の加法の逆元」の行。σz の成分 -_ℂ 1_ℂ と、ς を定める -1_ℂ
  （必要十分版の n）を同じ元として読むのに要る。ℂ では加法の逆元が一つしかないことから出るが、K に加法の公理を置かない
  必要十分版では、この行が使う等式そのものを仮定に置く（章「クリフォード代数」の仮定 `CliffordLaws K n` と a + (-a) = 0 があれば
  加法の公理から出る。`ConjugatedIsomorphism.lean` の `neg_one_eq_n`）。
- -1 がどの元とも交換すること（部分積の主張）: 具体版の ς(N_{i-1}(T)) ·_ℂ (-_ℂ 1_ℂ) = (-_ℂ 1_ℂ) ·_ℂ ς(N_{i-1}(T))
  （ℂ の乗法の交換法則）の行。ς の値と -1 の交換だけが要り、乗法の交換法則全体は要らない。
- a · 0 = 0、0 · a = 0、乗法の結合法則（生成作用素の行列）: 0 の因子の主張（`orderedProduct_of_zero_factor`）の仮定と、
  α_m = δ_{2,o_{M,S}(m)} · δ_{1,2} = … · 0 = 0、δ_{2,1} · … = 0 の行。
- 0 と 1 がどの元とも交換すること（消滅作用素の行列）: 具体版の δ_{1,a} ·_ℂ δ_{2,b} = δ_{2,b} ·_ℂ δ_{1,a}（ℂ の乗法の交換法則）の行。
  δ の値は 0 か 1 なので、0 と 1 の交換で足りる（`MatrixUnits.kroneckerDelta_mul_comm`）。
- 部分積の主張は i ≤ M を使わない（具体版と同じ）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.PauliMatrices
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.CreationMatrices

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet PowerSet.ext idxOne idxTwo idxOne_ne_idxTwo isFiniteSet_two
  membershipIndex membershipIndex_of_mem membershipIndex_of_not_mem)
open CliffordMatrixIsomorphism.NecSuf.Isomorphism (idx_two_cases membershipIndex_eq_of_iff membershipIndex_ne_of_not_iff
  countBelow countBelow_one countBelow_succ_succ_of_mem countBelow_succ_succ_of_not_mem unionSingleton
  mem_unionSingleton_iff_of_ne self_mem_unionSingleton)

universe uK

variable {K : Type uK} [Mul K] [One K] [Zero K] [Neg K]

omit [Zero K] [Neg K] in
/-- 本文 `def_ordered_product_in_complex_numbers` の必要十分版：m ≥ 1 なら P_m = P_{m-1} · α_m。 -/
theorem partialOrderedProduct_of_pos (a : ℕ → K) (m : ℕ) (hm : 1 ≤ m) :
    partialOrderedProduct a m = partialOrderedProduct a (m - 1) * a m := by
  obtain ⟨j, rfl⟩ : ∃ j, m = j + 1 := ⟨m - 1, by omega⟩
  rfl

/-! ### z の Pauli 行列の対角成分の部分積 -/

/-- 本文 `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count` の帰納法の主張の必要十分版。 -/
theorem partialOrderedProduct_pauliZ_diagonal (hmul1 : ∀ a : K, a * 1 = a)
    (hcomm_neg_one : ∀ a : K, a * (-1) = (-1) * a) (n : K) (hn : (-1 : K) = n) {M : ℕ} (T : PowerSet M) (α : ℕ → K) :
    ∀ j : ℕ, (∀ k : ℕ, 1 ≤ k → k ≤ j → α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k)) →
      partialOrderedProduct α j = sign n (countBelow T (j + 1))
  | 0, _ => calc
    partialOrderedProduct α 0 = 1 := rfl
    _ = sign n 0 := rfl
    _ = sign n (countBelow T 1) := by rw [countBelow_one]
  | j + 1, hα => by
    have ih := partialOrderedProduct_pauliZ_diagonal hmul1 hcomm_neg_one n hn T α j
      (fun k hk1 hkj => hα k hk1 (by omega))
    obtain ⟨z11, _, _, z22⟩ := (pauliZ_entries : _ ∧ _ ∧ _ ∧ Mat.entry (pauliZ : Mat K (Idx 2)) idxTwo idxTwo = -1)
    by_cases hmem : j + 1 ∈ T.1
    · calc partialOrderedProduct α (j + 1)
          = partialOrderedProduct α j * α (j + 1) := rfl
        _ = sign n (countBelow T (j + 1)) * α (j + 1) := by rw [ih]
        _ = sign n (countBelow T (j + 1))
              * Mat.entry pauliZ (membershipIndex T (j + 1)) (membershipIndex T (j + 1)) := by
            rw [hα (j + 1) (by omega) (le_refl _)]
        _ = sign n (countBelow T (j + 1)) * Mat.entry pauliZ idxTwo idxTwo := by
            rw [membershipIndex_of_mem T (j + 1) hmem]
        _ = sign n (countBelow T (j + 1)) * (-1) := by rw [z22]
        _ = (-1) * sign n (countBelow T (j + 1)) := hcomm_neg_one _
        _ = n * sign n (countBelow T (j + 1)) := by rw [hn]
        _ = sign n (countBelow T (j + 1) + 1) := (sign_succ n _).symm
        _ = sign n (countBelow T (j + 2)) := by rw [countBelow_succ_succ_of_mem T j hmem]
    · calc partialOrderedProduct α (j + 1)
          = partialOrderedProduct α j * α (j + 1) := rfl
        _ = sign n (countBelow T (j + 1)) * α (j + 1) := by rw [ih]
        _ = sign n (countBelow T (j + 1))
              * Mat.entry pauliZ (membershipIndex T (j + 1)) (membershipIndex T (j + 1)) := by
            rw [hα (j + 1) (by omega) (le_refl _)]
        _ = sign n (countBelow T (j + 1)) * Mat.entry pauliZ idxOne idxOne := by
            rw [membershipIndex_of_not_mem T (j + 1) hmem]
        _ = sign n (countBelow T (j + 1)) * 1 := by rw [z11]
        _ = sign n (countBelow T (j + 1)) := hmul1 _
        _ = sign n (countBelow T (j + 2)) := by rw [countBelow_succ_succ_of_not_mem T j hmem]

/-- 本文 `claim_partial_product_of_pauli_z_diagonal_entries_is_sign_of_count` の必要十分版。 -/
theorem partialOrderedProduct_pauliZ_diagonal_eq_sign (hmul1 : ∀ a : K, a * 1 = a)
    (hcomm_neg_one : ∀ a : K, a * (-1) = (-1) * a) (n : K) (hn : (-1 : K) = n) {M : ℕ} (T : PowerSet M) (i : ℕ)
    (hi1 : 1 ≤ i) (α : ℕ → K)
    (hα : ∀ k : ℕ, 1 ≤ k → k ≤ i - 1 → α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k)) :
    partialOrderedProduct α (i - 1) = sign n (countBelow T i) := by
  have h := partialOrderedProduct_pauliZ_diagonal hmul1 hcomm_neg_one n hn T α (i - 1) hα
  rw [Nat.sub_add_cancel hi1] at h
  exact h

/-! ### 生成作用素の行列 -/

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の族 A_k の必要十分版。 -/
def creationFactor (m k : ℕ) : Mat K (Idx 2) :=
  if k < m then pauliZ else if k = m then matrixUnit idxTwo idxOne else Mat.one

theorem creationFactor_of_lt {m k : ℕ} (h : k < m) : (creationFactor m k : Mat K (Idx 2)) = pauliZ := if_pos h

theorem creationFactor_self (m : ℕ) : (creationFactor m m : Mat K (Idx 2)) = matrixUnit idxTwo idxOne := by
  unfold creationFactor
  rw [if_neg (lt_irrefl m), if_pos rfl]

theorem creationFactor_of_gt {m k : ℕ} (h : m < k) : (creationFactor m k : Mat K (Idx 2)) = Mat.one := by
  unfold creationFactor
  rw [if_neg (by omega), if_neg (by omega)]

omit [Mul K] in
theorem pauliZ_entry_of_ne {a b : Idx 2} (h : a ≠ b) : Mat.entry (pauliZ : Mat K (Idx 2)) a b = 0 := by
  obtain ⟨_, z12, z21, _⟩ := (pauliZ_entries : _ ∧ _ ∧ _ ∧ Mat.entry (pauliZ : Mat K (Idx 2)) idxTwo idxTwo = -1)
  rcases idx_two_cases a with rfl | rfl <;> rcases idx_two_cases b with rfl | rfl
  · exact absurd rfl h
  · exact z12
  · exact z21
  · exact absurd rfl h

omit [Mul K] [Neg K] in
theorem one_two_entry_of_ne {a b : Idx 2} (h : a ≠ b) : Mat.entry (Mat.one : Mat K (Idx 2)) a b = 0 := calc
  Mat.entry (Mat.one : Mat K (Idx 2)) a b = kroneckerDelta a b := rfl
  _ = 0 := if_neg h

/-- 本文 `claim_creation_operator_matrix_is_kronecker_product` の必要十分版。 -/
theorem creationMatrix_eq_kroneckerProduct (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (h0mul : ∀ a : K, 0 * a = 0) (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hcomm_neg_one : ∀ a : K, a * (-1) = (-1) * a) (n : K) (hn : (-1 : K) = n) (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    creationMatrix n M m hm = kroneckerProduct M (creationFactor m) := Mat.ext fun S T => by
  let α := kroneckerFactor (creationFactor m : ℕ → Mat K (Idx 2)) S T
  obtain ⟨d11, d12, d21, d22⟩ := (kroneckerDelta_two_values : _ ∧ _ ∧ _ ∧ (kroneckerDelta idxTwo idxTwo : K) = 1)
  have hoff : ∀ k : ℕ, k ≠ m → membershipIndex S k ≠ membershipIndex T k → α k = 0 := by
    intro k hkm hne
    rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
    · show Mat.entry (creationFactor m k : Mat K (Idx 2)) _ _ = 0
      rw [creationFactor_of_lt hlt]
      exact pauliZ_entry_of_ne hne
    · show Mat.entry (creationFactor m k : Mat K (Idx 2)) _ _ = 0
      rw [creationFactor_of_gt hgt]
      exact one_two_entry_of_ne hne
  by_cases hcond : m ∉ T.1 ∧ S = unionSingleton T m hm
  · obtain ⟨hmT, hS⟩ := hcond
    have hoS : ∀ k : ℕ, k ≠ m → membershipIndex S k = membershipIndex T k := by
      intro k hkm
      apply membershipIndex_eq_of_iff
      rw [hS]
      exact mem_unionSingleton_iff_of_ne T m hm k hkm
    have hmS : m ∈ S.1 := by rw [hS]; exact self_mem_unionSingleton T m hm
    have hlt : ∀ k : ℕ, 1 ≤ k → k ≤ m - 1 →
        α k = Mat.entry pauliZ (membershipIndex T k) (membershipIndex T k) := by
      intro k _ hk
      show Mat.entry (creationFactor m k : Mat K (Idx 2)) (membershipIndex S k) (membershipIndex T k) = _
      rw [creationFactor_of_lt (by omega), hoS k (by omega)]
    have hgt : ∀ k : ℕ, m < k → k ≤ M → α k = 1 := by
      intro k hk _
      show Mat.entry (creationFactor m k : Mat K (Idx 2)) (membershipIndex S k) (membershipIndex T k) = 1
      rw [creationFactor_of_gt hk, hoS k (by omega)]
      exact if_pos rfl
    have hαm : α m = 1 := calc
      α m = Mat.entry (matrixUnit idxTwo idxOne : Mat K (Idx 2)) idxTwo idxOne := by
          show Mat.entry (creationFactor m m : Mat K (Idx 2)) (membershipIndex S m) (membershipIndex T m) = _
          rw [creationFactor_self, membershipIndex_of_mem S m hmS, membershipIndex_of_not_mem T m hmT]
      _ = kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxOne := rfl
      _ = 1 * 1 := by rw [d11, d22]
      _ = 1 := hmul1 1
    calc Mat.entry (creationMatrix n M m hm) S T
        = sign n (countBelow T m) := creationMatrix_entry_of_cond n hm ⟨hmT, hS⟩
      _ = partialOrderedProduct α (m - 1) :=
          (partialOrderedProduct_pauliZ_diagonal_eq_sign hmul1 hcomm_neg_one n hn T m hm.1 α hlt).symm
      _ = partialOrderedProduct α (m - 1) * 1 := (hmul1 _).symm
      _ = partialOrderedProduct α (m - 1) * α m := by rw [hαm]
      _ = partialOrderedProduct α m := (partialOrderedProduct_of_pos α m hm.1).symm
      _ = orderedProduct M α := (orderedProduct_of_unit_factors_after hmul1 M m hm.2 α hgt).symm
      _ = Mat.entry (kroneckerProduct M (creationFactor m)) S T := rfl
  · have hr : ∃ r : ℕ, 1 ≤ r ∧ r ≤ M ∧ α r = 0 := by
      by_cases hmT : m ∈ T.1
      · refine ⟨m, hm.1, hm.2, ?_⟩
        calc α m = kroneckerDelta idxTwo (membershipIndex S m) * kroneckerDelta idxOne idxTwo := by
              show Mat.entry (creationFactor m m : Mat K (Idx 2)) (membershipIndex S m) (membershipIndex T m) = _
              rw [creationFactor_self, membershipIndex_of_mem T m hmT]; rfl
          _ = kroneckerDelta idxTwo (membershipIndex S m) * 0 := by rw [d12]
          _ = 0 := hmul0 _
      · by_cases hmS : m ∈ S.1
        · have hSne : S ≠ unionSingleton T m hm := fun h => hcond ⟨hmT, h⟩
          have hk : ∃ k : ℕ, 1 ≤ k ∧ k ≤ M ∧ ¬(k ∈ S.1 ↔ k ∈ (unionSingleton T m hm).1) := by
            by_contra hno
            apply hSne
            apply PowerSet.ext
            intro t ht1 htM
            by_contra hiff
            exact hno ⟨t, ht1, htM, hiff⟩
          obtain ⟨k, hk1, hkM, hiff⟩ := hk
          have hkm : k ≠ m := by
            intro h
            rw [h] at hiff
            exact hiff ⟨fun _ => self_mem_unionSingleton T m hm, fun _ => hmS⟩
          have hiff' : ¬(k ∈ S.1 ↔ k ∈ T.1) := by
            rw [← mem_unionSingleton_iff_of_ne T m hm k hkm]
            exact hiff
          exact ⟨k, hk1, hkM, hoff k hkm (membershipIndex_ne_of_not_iff S T k hiff')⟩
        · refine ⟨m, hm.1, hm.2, ?_⟩
          calc α m = kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne (membershipIndex T m) := by
                show Mat.entry (creationFactor m m : Mat K (Idx 2)) (membershipIndex S m) (membershipIndex T m) = _
                rw [creationFactor_self, membershipIndex_of_not_mem S m hmS]; rfl
            _ = 0 * kroneckerDelta idxOne (membershipIndex T m) := by rw [d21]
            _ = 0 := h0mul _
    obtain ⟨r, hr1, hrM, hαr⟩ := hr
    calc Mat.entry (creationMatrix n M m hm) S T
        = 0 := creationMatrix_entry_of_not_cond n hm hcond
      _ = orderedProduct M α :=
          (orderedProduct_of_zero_factor hmassoc (fun a => by rw [hmul0 a, h0mul a]) h0mul M r hr1 hrM α hαr).symm
      _ = Mat.entry (kroneckerProduct M (creationFactor m)) S T := rfl

/-! ### 消滅作用素の行列 -/

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の族 A'_k の必要十分版。 -/
def annihilationFactor (m k : ℕ) : Mat K (Idx 2) :=
  if k = m then matrixUnit idxOne idxTwo else creationFactor m k

theorem annihilationFactor_self (m : ℕ) : (annihilationFactor m m : Mat K (Idx 2)) = matrixUnit idxOne idxTwo :=
  if_pos rfl

theorem annihilationFactor_of_ne {m k : ℕ} (h : k ≠ m) :
    (annihilationFactor m k : Mat K (Idx 2)) = creationFactor m k := if_neg h

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の準備の必要十分版：(A'_k)_{a,b} = (A_k)_{b,a}。 -/
theorem annihilationFactor_entry (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) (m k : ℕ)
    (a b : Idx 2) :
    Mat.entry (annihilationFactor m k : Mat K (Idx 2)) a b = Mat.entry (creationFactor m k : Mat K (Idx 2)) b a := by
  by_cases hkm : k = m
  · subst hkm
    calc Mat.entry (annihilationFactor k k : Mat K (Idx 2)) a b
        = Mat.entry (matrixUnit idxOne idxTwo : Mat K (Idx 2)) a b := by rw [annihilationFactor_self]
      _ = kroneckerDelta idxOne a * kroneckerDelta idxTwo b := rfl
      _ = kroneckerDelta idxTwo b * kroneckerDelta idxOne a := MatrixUnits.kroneckerDelta_mul_comm h0 h1 _ _ _
      _ = Mat.entry (matrixUnit idxTwo idxOne : Mat K (Idx 2)) b a := rfl
      _ = Mat.entry (creationFactor k k : Mat K (Idx 2)) b a := by rw [creationFactor_self]
  · rw [annihilationFactor_of_ne hkm]
    by_cases hab : a = b
    · rw [hab]
    · rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
      · rw [creationFactor_of_lt hlt, pauliZ_entry_of_ne hab, pauliZ_entry_of_ne (Ne.symm hab)]
      · rw [creationFactor_of_gt hgt, one_two_entry_of_ne hab, one_two_entry_of_ne (Ne.symm hab)]

/-- 本文 `claim_annihilation_operator_matrix_is_kronecker_product` の必要十分版。 -/
theorem annihilationMatrix_eq_kroneckerProduct (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (h0mul : ∀ a : K, 0 * a = 0) (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hcomm_neg_one : ∀ a : K, a * (-1) = (-1) * a) (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1)
    (n : K) (hn : (-1 : K) = n) (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    annihilationMatrix n M m hm = kroneckerProduct M (annihilationFactor m) := Mat.ext fun S T => calc
  Mat.entry (annihilationMatrix n M m hm) S T
      = Mat.entry (creationMatrix n M m hm) T S := rfl
  _ = Mat.entry (kroneckerProduct M (creationFactor m)) T S := by
      rw [creationMatrix_eq_kroneckerProduct hmul1 hmul0 h0mul hmassoc hcomm_neg_one n hn M m hm]
  _ = orderedProduct M (fun k => Mat.entry (creationFactor m k : Mat K (Idx 2)) (membershipIndex T k)
        (membershipIndex S k)) := rfl
  _ = orderedProduct M (fun k => Mat.entry (annihilationFactor m k : Mat K (Idx 2)) (membershipIndex S k)
        (membershipIndex T k)) :=
      congrArg (orderedProduct M) (funext fun k => (annihilationFactor_entry h0 h1 m k _ _).symm)
  _ = Mat.entry (kroneckerProduct M (annihilationFactor m)) S T := rfl

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
