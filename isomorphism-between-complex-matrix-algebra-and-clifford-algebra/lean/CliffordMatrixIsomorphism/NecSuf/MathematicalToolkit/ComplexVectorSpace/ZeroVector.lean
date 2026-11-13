/-
節「ℂ-線型空間」のうち零ベクトルについての四つの主張の必要十分版。具体版
`MathematicalToolkit/ComplexVectorSpace/ZeroVector.lean` と同じ calc の行で書く。

各主張が実際に使う K の性質:

  zero_smul_eq_zero              0 + 0 = 0 だけ（加法の単位元の一般の形 a + 0 = a は要らない）
  smul_zero_eq_zero              0 + 0 = 0、a · 0 = 0
  IsLinearForm.map_zero          0 + 0 = 0、0 · a = 0
  IsLinearMap.map_zero           0 + 0 = 0
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w

variable {K : Type u} [Add K] [Mul K] [One K] [Zero K] {V : Type v} {U : Type w}

/-- 本文 `claim_zero_scalar_multiple_is_zero_vector` の必要十分版。 -/
theorem zero_smul_eq_zero (S : VectorSpace K V) (h00 : (0 : K) + 0 = 0) (x : V) :
    S.smul 0 x = S.zero := by
  obtain ⟨y', hy'⟩ := S.exists_add_inverse (S.smul 0 x)
  calc S.smul 0 x
      = S.add (S.smul 0 x) S.zero := by rw [S.add_zero (S.smul 0 x)]
    _ = S.add (S.smul 0 x) (S.add (S.smul 0 x) y') := by rw [hy']
    _ = S.add (S.add (S.smul 0 x) (S.smul 0 x)) y' := by
          rw [S.add_assoc (S.smul 0 x) (S.smul 0 x) y']
    _ = S.add (S.smul (0 + 0) x) y' := by rw [S.add_smul 0 0 x]
    _ = S.add (S.smul 0 x) y' := by rw [h00]
    _ = S.zero := hy'

/-- 本文 `claim_scalar_multiple_of_zero_vector_is_zero_vector` の必要十分版。 -/
theorem smul_zero_eq_zero (S : VectorSpace K V) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (l : K) : S.smul l S.zero = S.zero := calc
  S.smul l S.zero = S.smul l (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S h00 S.zero]
  _ = S.smul (l * 0) S.zero := by rw [S.smul_assoc l 0 S.zero]
  _ = S.smul 0 S.zero := by rw [hmul0 l]
  _ = S.zero := zero_smul_eq_zero S h00 S.zero

/-- 本文 `claim_linear_form_sends_zero_vector_to_zero` の必要十分版。 -/
theorem IsLinearForm.map_zero {S : VectorSpace K V} {g : V → K} (hg : IsLinearForm S g)
    (h00 : (0 : K) + 0 = 0) (h0mul : ∀ a : K, 0 * a = 0) : g S.zero = 0 := calc
  g S.zero = g (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S h00 S.zero]
  _ = 0 * g S.zero := by rw [hg.map_smul 0 S.zero]
  _ = 0 := by rw [h0mul (g S.zero)]

/-- 本文 `claim_linear_map_sends_zero_to_zero` の必要十分版。 -/
theorem IsLinearMap.map_zero {SV : VectorSpace K V} {SU : VectorSpace K U} {f : V → U}
    (hf : IsLinearMap SV SU f) (h00 : (0 : K) + 0 = 0) : f SV.zero = SU.zero := calc
  f SV.zero = f (SV.smul 0 SV.zero) := by rw [zero_smul_eq_zero SV h00 SV.zero]
  _ = SU.smul 0 (f SV.zero) := by rw [hf.map_smul 0 SV.zero]
  _ = SU.zero := zero_smul_eq_zero SU h00 (f SV.zero)

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
