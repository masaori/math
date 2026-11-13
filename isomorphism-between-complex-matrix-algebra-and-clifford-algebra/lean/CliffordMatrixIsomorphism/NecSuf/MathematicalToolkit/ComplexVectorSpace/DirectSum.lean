/-
節「ℂ-線型空間」のうち二つの線型空間の直和の必要十分版。具体版
`MathematicalToolkit/ComplexVectorSpace/DirectSum.lean` と同じ行で書く。

各主張が実際に使う K の性質:

  directSumVectorSpace       なし（八つの公理は成分の公理だけから従う）
  embedFirst_isLinearMap     0 + 0 = 0、a · 0 = 0（準備の λ · 0_{V₂} = 0_{V₂}）
  embedSecond_isLinearMap    0 + 0 = 0、a · 0 = 0（`smul_zero_eq_zero`）
  pair_eq_add_embed          なし
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w

variable {K : Type u} [Add K] [Mul K] [One K] {V₁ : Type v} {V₂ : Type w}

namespace DirectSum

variable (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂)

/-- 本文 `def_direct_sum_of_two_vector_spaces` の成分ごとの加法。 -/
def add (p q : V₁ × V₂) : V₁ × V₂ := (S₁.add p.1 q.1, S₂.add p.2 q.2)

/-- 本文 `def_direct_sum_of_two_vector_spaces` の成分ごとのスカラー倍。 -/
def smul (μ : K) (p : V₁ × V₂) : V₁ × V₂ := (S₁.smul μ p.1, S₂.smul μ p.2)

/-- 本文 `def_direct_sum_of_two_vector_spaces` の成分ごとの零。 -/
def zero : V₁ × V₂ := (S₁.zero, S₂.zero)

end DirectSum

/-- 本文 `claim_direct_sum_of_two_vector_spaces_is_complex_vector_space`。 -/
def directSumVectorSpace (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂) :
    VectorSpace K (V₁ × V₂) where
  add := DirectSum.add S₁ S₂
  smul := DirectSum.smul S₁ S₂
  zero := DirectSum.zero S₁ S₂
  add_assoc p q r := calc
    DirectSum.add S₁ S₂ (DirectSum.add S₁ S₂ p q) r
        = DirectSum.add S₁ S₂ (S₁.add p.1 q.1, S₂.add p.2 q.2) r := rfl
    _ = (S₁.add (S₁.add p.1 q.1) r.1, S₂.add (S₂.add p.2 q.2) r.2) := rfl
    _ = (S₁.add p.1 (S₁.add q.1 r.1), S₂.add p.2 (S₂.add q.2 r.2)) := by
          rw [S₁.add_assoc p.1 q.1 r.1, S₂.add_assoc p.2 q.2 r.2]
    _ = DirectSum.add S₁ S₂ p (S₁.add q.1 r.1, S₂.add q.2 r.2) := rfl
    _ = DirectSum.add S₁ S₂ p (DirectSum.add S₁ S₂ q r) := rfl
  add_comm p q := calc
    DirectSum.add S₁ S₂ p q = (S₁.add p.1 q.1, S₂.add p.2 q.2) := rfl
    _ = (S₁.add q.1 p.1, S₂.add q.2 p.2) := by rw [S₁.add_comm p.1 q.1, S₂.add_comm p.2 q.2]
    _ = DirectSum.add S₁ S₂ q p := rfl
  add_zero p := calc
    DirectSum.add S₁ S₂ p (DirectSum.zero S₁ S₂) = DirectSum.add S₁ S₂ p (S₁.zero, S₂.zero) := rfl
    _ = (S₁.add p.1 S₁.zero, S₂.add p.2 S₂.zero) := rfl
    _ = (p.1, p.2) := by rw [S₁.add_zero p.1, S₂.add_zero p.2]
    _ = p := rfl
  exists_add_inverse p := by
    obtain ⟨x₁', h₁⟩ := S₁.exists_add_inverse p.1
    obtain ⟨x₂', h₂⟩ := S₂.exists_add_inverse p.2
    exact ⟨(x₁', x₂'), calc
      DirectSum.add S₁ S₂ p (x₁', x₂') = (S₁.add p.1 x₁', S₂.add p.2 x₂') := rfl
      _ = (S₁.zero, S₂.zero) := by rw [h₁, h₂]
      _ = DirectSum.zero S₁ S₂ := rfl⟩
  smul_assoc l μ p := calc
    DirectSum.smul S₁ S₂ (l * μ) p = (S₁.smul (l * μ) p.1, S₂.smul (l * μ) p.2) := rfl
    _ = (S₁.smul l (S₁.smul μ p.1), S₂.smul l (S₂.smul μ p.2)) := by
          rw [S₁.smul_assoc l μ p.1, S₂.smul_assoc l μ p.2]
    _ = DirectSum.smul S₁ S₂ l (S₁.smul μ p.1, S₂.smul μ p.2) := rfl
    _ = DirectSum.smul S₁ S₂ l (DirectSum.smul S₁ S₂ μ p) := rfl
  one_smul p := calc
    DirectSum.smul S₁ S₂ 1 p = (S₁.smul 1 p.1, S₂.smul 1 p.2) := rfl
    _ = (p.1, p.2) := by rw [S₁.one_smul p.1, S₂.one_smul p.2]
    _ = p := rfl
  smul_add l p q := calc
    DirectSum.smul S₁ S₂ l (DirectSum.add S₁ S₂ p q)
        = DirectSum.smul S₁ S₂ l (S₁.add p.1 q.1, S₂.add p.2 q.2) := rfl
    _ = (S₁.smul l (S₁.add p.1 q.1), S₂.smul l (S₂.add p.2 q.2)) := rfl
    _ = (S₁.add (S₁.smul l p.1) (S₁.smul l q.1), S₂.add (S₂.smul l p.2) (S₂.smul l q.2)) := by
          rw [S₁.smul_add l p.1 q.1, S₂.smul_add l p.2 q.2]
    _ = DirectSum.add S₁ S₂ (S₁.smul l p.1, S₂.smul l p.2) (S₁.smul l q.1, S₂.smul l q.2) := rfl
    _ = DirectSum.add S₁ S₂ (DirectSum.smul S₁ S₂ l p) (DirectSum.smul S₁ S₂ l q) := rfl
  add_smul l μ p := calc
    DirectSum.smul S₁ S₂ (l + μ) p = (S₁.smul (l + μ) p.1, S₂.smul (l + μ) p.2) := rfl
    _ = (S₁.add (S₁.smul l p.1) (S₁.smul μ p.1), S₂.add (S₂.smul l p.2) (S₂.smul μ p.2)) := by
          rw [S₁.add_smul l μ p.1, S₂.add_smul l μ p.2]
    _ = DirectSum.add S₁ S₂ (S₁.smul l p.1, S₂.smul l p.2) (S₁.smul μ p.1, S₂.smul μ p.2) := rfl
    _ = DirectSum.add S₁ S₂ (DirectSum.smul S₁ S₂ l p) (DirectSum.smul S₁ S₂ μ p) := rfl

section Embedding

variable [Zero K]

/-- 本文 `def_embedding_into_first_component_of_direct_sum`：in_1(x) := (x, 0_{V₂})。 -/
def embedFirst (S₂ : VectorSpace K V₂) (x : V₁) : V₁ × V₂ := (x, S₂.zero)

/-- 本文 `def_embedding_into_second_component_of_direct_sum`：in_2(y) := (0_{V₁}, y)。 -/
def embedSecond (S₁ : VectorSpace K V₁) (y : V₂) : V₁ × V₂ := (S₁.zero, y)

/-- 本文 `claim_embedding_into_first_component_is_linear_map`。準備の λ ·_{V₂} 0_{V₂} = 0_{V₂} は
本文と同じ四行（零のスカラー倍・スカラー倍の結合法則・λ·0 = 0・零のスカラー倍）で示す。 -/
theorem embedFirst_isLinearMap (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂)
    (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0) :
    IsLinearMap S₁ (directSumVectorSpace S₁ S₂) (embedFirst S₂) where
  map_add x y := calc
    embedFirst S₂ (S₁.add x y) = (S₁.add x y, S₂.zero) := rfl
    _ = (S₁.add x y, S₂.add S₂.zero S₂.zero) := by rw [S₂.add_zero S₂.zero]
    _ = DirectSum.add S₁ S₂ (x, S₂.zero) (y, S₂.zero) := rfl
    _ = DirectSum.add S₁ S₂ (embedFirst S₂ x) (embedFirst S₂ y) := rfl
  map_smul l x := by
    have hzero : S₂.smul l S₂.zero = S₂.zero := calc
      S₂.smul l S₂.zero = S₂.smul l (S₂.smul 0 S₂.zero) := by rw [zero_smul_eq_zero S₂ h00 S₂.zero]
      _ = S₂.smul (l * 0) S₂.zero := by rw [S₂.smul_assoc l 0 S₂.zero]
      _ = S₂.smul 0 S₂.zero := by rw [hmul0 l]
      _ = S₂.zero := zero_smul_eq_zero S₂ h00 S₂.zero
    calc embedFirst S₂ (S₁.smul l x) = (S₁.smul l x, S₂.zero) := rfl
      _ = (S₁.smul l x, S₂.smul l S₂.zero) := by rw [hzero]
      _ = DirectSum.smul S₁ S₂ l (x, S₂.zero) := rfl
      _ = DirectSum.smul S₁ S₂ l (embedFirst S₂ x) := rfl

/-- 本文 `claim_embedding_into_second_component_is_linear_map`。λ ·_{V₁} 0_{V₁} = 0_{V₁} は
本文と同じく `claim_scalar_multiple_of_zero_vector_is_zero_vector`（`smul_zero_eq_zero`）を引く。 -/
theorem embedSecond_isLinearMap (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂)
    (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0) :
    IsLinearMap S₂ (directSumVectorSpace S₁ S₂) (embedSecond S₁) where
  map_add y z := calc
    embedSecond S₁ (S₂.add y z) = (S₁.zero, S₂.add y z) := rfl
    _ = (S₁.add S₁.zero S₁.zero, S₂.add y z) := by rw [S₁.add_zero S₁.zero]
    _ = DirectSum.add S₁ S₂ (S₁.zero, y) (S₁.zero, z) := rfl
    _ = DirectSum.add S₁ S₂ (embedSecond S₁ y) (embedSecond S₁ z) := rfl
  map_smul l y := calc
    embedSecond S₁ (S₂.smul l y) = (S₁.zero, S₂.smul l y) := rfl
    _ = (S₁.smul l S₁.zero, S₂.smul l y) := by rw [smul_zero_eq_zero S₁ h00 hmul0 l]
    _ = DirectSum.smul S₁ S₂ l (S₁.zero, y) := rfl
    _ = DirectSum.smul S₁ S₂ l (embedSecond S₁ y) := rfl

omit [Zero K] in
/-- 本文 `claim_direct_sum_element_is_sum_of_embedded_components`：(x, y) = in_1(x) +_{V₁⊕V₂} in_2(y)。 -/
theorem pair_eq_add_embed (S₁ : VectorSpace K V₁) (S₂ : VectorSpace K V₂) (x : V₁)
    (y : V₂) :
    (x, y) = DirectSum.add S₁ S₂ (embedFirst S₂ x) (embedSecond S₁ y) := calc
  (x, y) = (S₁.add x S₁.zero, y) := by rw [S₁.add_zero x]
  _ = (S₁.add x S₁.zero, S₂.add y S₂.zero) := by rw [S₂.add_zero y]
  _ = (S₁.add x S₁.zero, S₂.add S₂.zero y) := by rw [S₂.add_comm y S₂.zero]
  _ = DirectSum.add S₁ S₂ (x, S₂.zero) (S₁.zero, y) := rfl
  _ = DirectSum.add S₁ S₂ (embedFirst S₂ x) (S₁.zero, y) := rfl
  _ = DirectSum.add S₁ S₂ (embedFirst S₂ x) (embedSecond S₁ y) := rfl

end Embedding

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
