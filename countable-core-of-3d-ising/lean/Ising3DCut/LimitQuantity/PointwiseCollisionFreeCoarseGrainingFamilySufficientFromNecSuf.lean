/- 必要十分版を、サイト数と素指数データからなる有限箱データへ特殊化する。 -/
import Ising3DCut.LimitQuantity.PointwiseCollisionFreeCoarseGrainingFamilySufficient
import Ising3DCut.NecSuf.PointwiseCollisionFreeCoarseGrainingFamilySufficient

namespace Ising3DCut.LimitQuantity

open NullModel Filter Topology

/-- 具体版の有限箱データの一致を必要十分版から取り出す。 -/
theorem finiteBoxPrimeExponentData_eq_of_pointwise_collision_free_coarse_graining_viaNecSuf
    {P : ℕ → Type*} (tau : ∀ L, (ℕ × (ℕ → ℤ)) → P L)
    (hfree : ∀ L s t, tau L s = tau L t → s = t)
    {q q' : ℚ}
    (hagree : ∀ L : ℕ, 0 < L →
      tau L (finiteBoxPrimeExponentData L q) =
        tau L (finiteBoxPrimeExponentData L q')) :
    ∀ L : ℕ, 0 < L →
      finiteBoxPrimeExponentData L q = finiteBoxPrimeExponentData L q' := by
  intro L hL
  exact Ising3DCut.NecSuf.data_eq_of_pointwise_collision_free_coarse_graining
    tau (fun _ _ => True)
    (fun i a b _ _ hab => hfree i a b hab)
    (fun i => finiteBoxPrimeExponentData i q)
    (fun i => finiteBoxPrimeExponentData i q')
    (fun _ => True.intro) (fun _ => True.intro)
    (S := {i | 0 < i}) hagree L hL

/-- 具体版の十分性を、必要十分版から得た有限箱データの一致を通して導く。 -/
theorem limitQuantity_eq_of_pointwise_collision_free_coarse_graining_viaNecSuf
    {P : ℕ → Type*} (tau : ∀ L, (ℕ × (ℕ → ℤ)) → P L)
    (hfree : ∀ L s t, tau L s = tau L t → s = t)
    {q q' : ℚ} (hqpos : 0 < q) (hq'pos : 0 < q')
    (hagree : ∀ L : ℕ, 0 < L →
      tau L (finiteBoxPrimeExponentData L q) =
        tau L (finiteBoxPrimeExponentData L q'))
    (N : ℕ → ℕ) (ell ell' : ℝ)
    (hq : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (nhds ell))
    (hq' : Tendsto (rootSeq (finiteBoxValueSeq q') N) atTop (nhds ell')) : ell = ell' := by
  have hdata :=
    finiteBoxPrimeExponentData_eq_of_pointwise_collision_free_coarse_graining_viaNecSuf
      tau hfree hagree
  have hexponents : ∀ L : ℕ, 0 < L → ∀ p : ℕ, p.Prime →
      padicValRat p (evalAtRational q (partitionPolynomial L)) =
        padicValRat p (evalAtRational q' (partitionPolynomial L)) := by
    intro L hL p _
    exact congrFun (congrArg Prod.snd (hdata L hL)) p
  have hvalues := partitionPolynomial_evalAtRational_eq_of_prime_exponent_sequence_eq
    hqpos hq'pos hexponents
  exact limitQuantity_eq_of_finiteBox_eq N hvalues ell ell' hq hq'

end Ising3DCut.LimitQuantity
