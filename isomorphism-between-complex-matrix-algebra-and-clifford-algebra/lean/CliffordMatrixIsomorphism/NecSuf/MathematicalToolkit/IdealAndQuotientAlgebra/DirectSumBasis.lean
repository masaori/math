/-
二つの基底を並べた族が直和の基底であることの主張の必要十分版。具体版
`MathematicalToolkit/IdealAndQuotientAlgebra/DirectSumBasis.lean` と同じ def・calc の行で、係数 ℂ を型の変数 K に替えて書く。

実際に使う K の性質は 0 + 0 = 0 と a · 0 = 0 だけである。どちらも成分への埋め込み写像が線型写像であること
（λ · 0 = 0 の準備）と、線型写像が有限集合の上の和を値の和へ移すこと（0 · x = 0 を経由する）から来る。
一次独立と張ることの段は、K の公理を一つも使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.DirectSum
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {V₁ : Type u} {V₂ : Type v}

/-- 本文 `claim_basis_of_direct_sum_of_two_vector_spaces` の族 c：c(i) := in_1(b_i)（i ≤ n）、c(n+j) := in_2(b'_j)。 -/
def concatenatedFamily (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂) (n : ℕ)
    (b : ℕ → V₁) (b' : ℕ → V₂) (k : ℕ) : V₁ × V₂ :=
  if k ≤ n then embedFirst S₂ (b k) else embedSecond S₁ (b' (k - n))

theorem concatenatedFamily_of_le (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂) (n : ℕ)
    (b : ℕ → V₁) (b' : ℕ → V₂) (i : ℕ) (hi : i ≤ n) :
    concatenatedFamily S₁ S₂ n b b' i = embedFirst S₂ (b i) := by
  unfold concatenatedFamily
  rw [if_pos hi]

theorem concatenatedFamily_add (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂) (n : ℕ)
    (b : ℕ → V₁) (b' : ℕ → V₂) (j : ℕ) (hj : 1 ≤ j) :
    concatenatedFamily S₁ S₂ n b b' (n + j) = embedSecond S₁ (b' j) := by
  unfold concatenatedFamily
  rw [if_neg (by omega), Nat.add_sub_cancel_left]

/-- 本文 `claim_basis_of_direct_sum_of_two_vector_spaces` の証明の「成分の等式」：
Σ_{k=1}^{n+n'} κ_k · c_k = (Σ_{i=1}^{n} κ_i ·_{V₁} b_i, Σ_{j=1}^{n'} κ_{n+j} ·_{V₂} b'_j)。 -/
theorem linearCombination_concatenatedFamily [Zero K] (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂)
    (n n' : ℕ) (b : ℕ → V₁) (b' : ℕ → V₂) (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0)
    (κ : ℕ → K) :
    linearCombination (directSumVectorSpace S₁ S₂) (n + n') κ (concatenatedFamily S₁ S₂ n b b')
      = (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b') := by
  let S := directSumVectorSpace S₁ S₂
  let c := concatenatedFamily S₁ S₂ n b b'
  have hc1 : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (κ k) (c k) = S.smul (κ k) (embedFirst S₂ (b k)) := by
    intro k _ hkn
    show S.smul (κ k) (concatenatedFamily S₁ S₂ n b b' k) = _
    rw [concatenatedFamily_of_le S₁ S₂ n b b' k hkn]
  have hc2 : ∀ j : ℕ, 1 ≤ j → j ≤ n' →
      S.smul (κ (n + j)) (c (n + j)) = S.smul (κ (n + j)) (embedSecond S₁ (b' j)) := by
    intro j hj _
    show S.smul (κ (n + j)) (concatenatedFamily S₁ S₂ n b b' (n + j)) = _
    rw [concatenatedFamily_add S₁ S₂ n b b' j hj]
  calc linearCombination S (n + n') κ c
      = S.add (linearCombination S n κ c)
          (linearCombination S n' (fun j => κ (n + j)) (fun j => c (n + j))) :=
        linearCombination_split S n n' c κ
    _ = S.add (linearCombination S n κ (fun i => embedFirst S₂ (b i)))
          (linearCombination S n' (fun j => κ (n + j)) (fun j => embedSecond S₁ (b' j))) := by
        rw [linearCombination_eq_of_terms_eq S n c (fun i => embedFirst S₂ (b i)) κ κ hc1,
          linearCombination_eq_of_terms_eq S n' (fun j => c (n + j)) (fun j => embedSecond S₁ (b' j))
            (fun j => κ (n + j)) (fun j => κ (n + j)) hc2]
    _ = S.add (sumOverFiniteSet S (isFiniteSet_idx n) (fun i => κ i.1) (fun i => embedFirst S₂ (b i.1)))
          (sumOverFiniteSet S (isFiniteSet_idx n') (fun j => κ (n + j.1))
            (fun j => embedSecond S₁ (b' j.1))) := by
        rw [sumOverFiniteSet_idx S n κ (fun i => embedFirst S₂ (b i)),
          sumOverFiniteSet_idx S n' (fun j => κ (n + j)) (fun j => embedSecond S₁ (b' j))]
    _ = S.add (embedFirst S₂ (sumOverFiniteSet S₁ (isFiniteSet_idx n) (fun i => κ i.1) (fun i => b i.1)))
          (embedSecond S₁ (sumOverFiniteSet S₂ (isFiniteSet_idx n') (fun j => κ (n + j.1))
            (fun j => b' j.1))) := by
        rw [(embedFirst_isLinearMap S₁ S₂ h00 hmul0).map_sumOverFiniteSet h00 (isFiniteSet_idx n) (fun i => κ i.1)
            (fun i => b i.1),
          (embedSecond_isLinearMap S₁ S₂ h00 hmul0).map_sumOverFiniteSet h00 (isFiniteSet_idx n')
            (fun j => κ (n + j.1)) (fun j => b' j.1)]
    _ = S.add (embedFirst S₂ (linearCombination S₁ n κ b))
          (embedSecond S₁ (linearCombination S₂ n' (fun j => κ (n + j)) b')) := by
        rw [sumOverFiniteSet_idx S₁ n κ b, sumOverFiniteSet_idx S₂ n' (fun j => κ (n + j)) b']
    _ = (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b') :=
        (pair_eq_add_embed S₁ S₂ _ _).symm

/-- 本文 `claim_basis_of_direct_sum_of_two_vector_spaces`：b が V₁ の基底、b' が V₂ の基底なら、
c は V₁ ⊕ V₂ の基底である。一次独立と張ることを、どちらも成分の等式から示す。 -/
theorem concatenatedFamily_isBasisFamily [Zero K] (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂)
    (n n' : ℕ) (b : ℕ → V₁) (b' : ℕ → V₂) (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0)
    (hb : IsBasisFamily S₁ n b)
    (hb' : IsBasisFamily S₂ n' b') :
    IsBasisFamily (directSumVectorSpace S₁ S₂) (n + n') (concatenatedFamily S₁ S₂ n b b') where
  linearlyIndependent := by
    intro κ hκ
    have hpair : (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b')
        = (S₁.zero, S₂.zero) := calc
      (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b')
          = linearCombination (directSumVectorSpace S₁ S₂) (n + n') κ (concatenatedFamily S₁ S₂ n b b') :=
          (linearCombination_concatenatedFamily S₁ S₂ n n' b b' h00 hmul0 κ).symm
      _ = (directSumVectorSpace S₁ S₂).zero := hκ
      _ = (S₁.zero, S₂.zero) := rfl
    have h1 : linearCombination S₁ n κ b = S₁.zero := (Prod.mk.inj hpair).1
    have h2 : linearCombination S₂ n' (fun j => κ (n + j)) b' = S₂.zero := (Prod.mk.inj hpair).2
    intro k hk1 hkn
    by_cases hk : k ≤ n
    · exact hb.linearlyIndependent κ h1 k hk1 hk
    · have hj := hb'.linearlyIndependent (fun j => κ (n + j)) h2 (k - n) (by omega) (by omega)
      have hk' : n + (k - n) = k := by omega
      rw [hk'] at hj
      exact hj
  spans := by
    intro p
    obtain ⟨μ, hμ⟩ := hb.spans p.1
    obtain ⟨ν, hν⟩ := hb'.spans p.2
    let κ : ℕ → K := fun k => if k ≤ n then μ k else ν (k - n)
    have hκ1 : ∀ i : ℕ, 1 ≤ i → i ≤ n → S₁.smul (κ i) (b i) = S₁.smul (μ i) (b i) := by
      intro i _ hin
      show S₁.smul (if i ≤ n then μ i else ν (i - n)) (b i) = S₁.smul (μ i) (b i)
      rw [if_pos hin]
    have hκ2 : ∀ j : ℕ, 1 ≤ j → j ≤ n' → S₂.smul (κ (n + j)) (b' j) = S₂.smul (ν j) (b' j) := by
      intro j hj _
      show S₂.smul (if n + j ≤ n then μ (n + j) else ν (n + j - n)) (b' j) = S₂.smul (ν j) (b' j)
      rw [if_neg (by omega), Nat.add_sub_cancel_left]
    refine ⟨κ, ?_⟩
    calc linearCombination (directSumVectorSpace S₁ S₂) (n + n') κ (concatenatedFamily S₁ S₂ n b b')
        = (linearCombination S₁ n κ b, linearCombination S₂ n' (fun j => κ (n + j)) b') :=
          linearCombination_concatenatedFamily S₁ S₂ n n' b b' h00 hmul0 κ
      _ = (linearCombination S₁ n μ b, linearCombination S₂ n' ν b') := by
          rw [linearCombination_eq_of_terms_eq S₁ n b b κ μ hκ1,
            linearCombination_eq_of_terms_eq S₂ n' b' b' (fun j => κ (n + j)) ν hκ2]
      _ = (p.1, p.2) := by rw [hμ, hν]
      _ = p := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
