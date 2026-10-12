import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriod

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 最小周期未満の回数での衝突は、それより短い正の帰還を与えて矛盾する。 -/
theorem finitePermutationIterate_injOn_period {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    Set.InjOn (fun n : ℕ => finiteMapIterate σ n i)
      (Set.Iio (finitePermutationMinimalPeriod σ i)) := by
  intro r hr t ht heq
  have no_lt (a b : ℕ) (hab : a < b) (hb : b < finitePermutationMinimalPeriod σ i)
      (hcollision : finiteMapIterate σ a i = finiteMapIterate σ b i) : False := by
    let d := b - a
    have hdpos : 0 < d := by dsimp [d]; omega
    have hsum : a + d = b := by dsimp [d]; omega
    have hdb : d ≤ b := Nat.sub_le b a
    have hdp : d < finitePermutationMinimalPeriod σ i := lt_of_le_of_lt hdb hb
    have hcomp : finiteMapIterate σ a (finiteMapIterate σ d i) =
        finiteMapIterate σ a i := by
      calc
        finiteMapIterate σ a (finiteMapIterate σ d i) =
            finiteMapIterate σ (a + d) i := (finiteMapIterate_add σ a d i).symm
        _ = finiteMapIterate σ b i := congrArg (fun k : ℕ => finiteMapIterate σ k i) hsum
        _ = finiteMapIterate σ a i := hcollision.symm
    have hreturn : finiteMapIterate σ d i = i := finitePermutationIterate_injective σ a hcomp
    have hminimal : finitePermutationMinimalPeriod σ i ≤ d :=
      (finitePermutationMinimalPeriod_spec σ i).2.2 d hdpos hreturn
    exact (not_le_of_gt hdp) hminimal
  rcases lt_trichotomy r t with h | h | h
  · exact (no_lt r t h ht heq).elim
  · exact h
  · exact (no_lt t r h hr heq.symm).elim

end Ising2DLambda.AlgebraicEigenvalue
