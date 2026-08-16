import Ising3DCut.AllEdgeVariablesToOneIndeterminate
import Ising3DCut.NullModel.PartitionValueAtOne

/-!
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版（第二歩）。

破れ数の冪の配位和 `Σ_σ X ^ #B(σ)` を水準集合ごとに束ね、多重度の定義により
自由境界の分配多項式 `Z_L(X) = Σ_m Ω_L(m) X^m` に一致することを示す。
-/

namespace Ising3DCut.NullModel

open Polynomial

/-- 破れ数は `0` 以上 `#E_L` 以下なので、配位和は水準集合ごとの和へ束ねられる。 -/
theorem sum_X_pow_brokenCount_eq_partitionPolynomial (L : ℕ) :
    ∑ σ : Config L, (Polynomial.X : Polynomial ℤ) ^ brokenCount σ = partitionPolynomial L := by
  have hmaps :
      ∀ σ ∈ (Finset.univ : Finset (Config L)),
        brokenCount σ ∈ Finset.range (Fintype.card (Edge L) + 1) := by
    intro σ _
    rw [Finset.mem_range, Nat.lt_succ_iff, brokenCount]
    exact Finset.card_le_univ _
  rw [← Finset.sum_fiberwise_of_maps_to hmaps]
  unfold partitionPolynomial
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Finset.sum_congr rfl (fun σ hσ => by
        rw [(Finset.mem_filter.mp hσ).2]),
      Finset.sum_const, multiplicity]
  have hcard : Fintype.card (LevelSet L m) = (levelSetFinset L m).card :=
    Fintype.card_coe _
  rw [hcard, levelSetFinset, ← Polynomial.C_mul_X_pow_eq_monomial, nsmul_eq_mul]
  simp

end Ising3DCut.NullModel
