/-
節「ℂ-線型空間」のうち零ベクトルについての四つの主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                         このファイル
  claim_zero_scalar_multiple_is_zero_vector            zero_smul_eq_zero
  claim_scalar_multiple_of_zero_vector_is_zero_vector  smul_zero_eq_zero
  claim_linear_form_sends_zero_vector_to_zero          IsComplexLinearForm.map_zero
  claim_linear_map_sends_zero_to_zero                  IsComplexLinearMap.map_zero

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/ZeroVector.lean`、導出版は `ComplexVectorSpaceFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u} {U : Type v}

/-- 本文 `claim_zero_scalar_multiple_is_zero_vector`：0_ℂ ·_V x = 0_V。
y' は加法の逆元の存在から選ぶ（本文と同じ）。 -/
theorem zero_smul_eq_zero (S : ComplexVectorSpace V) (x : V) : S.smul 0 x = S.zero := by
  obtain ⟨y', hy'⟩ := S.exists_add_inverse (S.smul 0 x)
  calc S.smul 0 x
      = S.add (S.smul 0 x) S.zero := by rw [S.add_zero (S.smul 0 x)]
    _ = S.add (S.smul 0 x) (S.add (S.smul 0 x) y') := by rw [hy']
    _ = S.add (S.add (S.smul 0 x) (S.smul 0 x)) y' := by
          rw [S.add_assoc (S.smul 0 x) (S.smul 0 x) y']
    _ = S.add (S.smul (0 + 0) x) y' := by rw [S.add_smul 0 0 x]
    _ = S.add (S.smul 0 x) y' := by rw [_root_.add_zero (0 : ℂ)]
    _ = S.zero := hy'

/-- 本文 `claim_scalar_multiple_of_zero_vector_is_zero_vector`：λ ·_V 0_V = 0_V。 -/
theorem smul_zero_eq_zero (S : ComplexVectorSpace V) (l : ℂ) : S.smul l S.zero = S.zero := calc
  S.smul l S.zero = S.smul l (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S S.zero]
  _ = S.smul (l * 0) S.zero := by rw [S.smul_assoc l 0 S.zero]
  _ = S.smul 0 S.zero := by rw [mul_zero l]
  _ = S.zero := zero_smul_eq_zero S S.zero

/-- 本文 `claim_linear_form_sends_zero_vector_to_zero`：g(0_V) = 0_ℂ。 -/
theorem IsComplexLinearForm.map_zero {S : ComplexVectorSpace V} {g : V → ℂ}
    (hg : IsComplexLinearForm S g) : g S.zero = 0 := calc
  g S.zero = g (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S S.zero]
  _ = 0 * g S.zero := by rw [hg.map_smul 0 S.zero]
  _ = 0 := by rw [zero_mul (g S.zero)]

/-- 本文 `claim_linear_map_sends_zero_to_zero`：f(0_V) = 0_U。 -/
theorem IsComplexLinearMap.map_zero {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {f : V → U} (hf : IsComplexLinearMap SV SU f) : f SV.zero = SU.zero := calc
  f SV.zero = f (SV.smul 0 SV.zero) := by rw [zero_smul_eq_zero SV SV.zero]
  _ = SU.smul 0 (f SV.zero) := by rw [hf.map_smul 0 SV.zero]
  _ = SU.zero := zero_smul_eq_zero SU (f SV.zero)

end CliffordMatrixIsomorphism.ComplexVectorSpace
