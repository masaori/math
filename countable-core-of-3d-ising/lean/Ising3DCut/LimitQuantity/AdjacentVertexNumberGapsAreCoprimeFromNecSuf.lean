/-
必要十分版から、具体版の「隣接する二つの箱の頂点数の差は次の差と互いに素である」を導く。
-/
import Ising3DCut.LimitQuantity.AdjacentVertexNumberGapsAreCoprime
import Ising3DCut.NecSuf.AdjacentVertexNumberGapsAreCoprime

namespace Ising3DCut.LimitQuantity

/-- 具体版を必要十分版の特殊化として導いた版。 -/
theorem adjacent_vertex_number_gaps_are_coprime_viaNecSuf (L : ℕ) :
    Nat.Coprime (vertexNumberGap L) (vertexNumberGap (L + 1)) := by
  apply Ising3DCut.NecSuf.coprime_of_add_one_and_prime_divisors_of_offset_dvd_base
    (vertexNumberGap L) (vertexNumberGap (L + 1)) (3 * L * (L + 1)) (6 * (L + 1))
  · exact vertexNumberGap_eq_three_mul_mul_succ_add_one L
  · exact vertexNumberGap_succ_eq_add_six_mul_succ L
  · intro p hp hpOffset
    rcases dvd_two_or_three_or_succ_of_dvd_six_mul_succ p L hp hpOffset with hsucc | h2 | h3
    · exact Dvd.dvd.mul_left hsucc (3 * L)
    · have hp2 : p = 2 := (Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp h2
      exact hp2 ▸ two_dvd_three_mul_mul_succ L
    · have hp3 : p = 3 := (Nat.prime_dvd_prime_iff_eq hp Nat.prime_three).mp h3
      have h3d : (3 : ℕ) ∣ 3 * L * (L + 1) :=
        Dvd.dvd.mul_right (Dvd.intro L rfl) (L + 1)
      exact hp3 ▸ h3d

end Ising3DCut.LimitQuantity
