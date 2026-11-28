/-
# `ε` の固有空間への射影子を必要十分版の特殊化として導く

正本: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
（ラベル **`epsilon_projector_properties`**・**`epsilon_projector_commutes_with_epsilon_commuting_matrix`**）

具体版は `ClaimEpsilonProjectors.lean` の一般形 `epsProj M η = (1/2)(I + ηε)` の性質
`epsProj_sq`・`epsProj_mul_epsProj_neg`・`epsProj_add_epsProj_neg` と、`ClaimEpsilonCommutes.lean` の
`commute_epsProj_of_commute_epsilon` である（`P^{(+)}` はその `η = 1`）。ここではこの一般形の 4 本を、
必要十分版 `NecSuf/Projector.lean` の対合から作る射影子 `invProj e = ⅟2 (1 + e)` を
`R = Mat(2^{M_col}, ℂ)`、`e = ηε` に特殊化して導く。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimEpsilonCommutes
import Ising2D.NecSuf.Projector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- `TensorPow M = Mat(2^M, ℂ)` では `2` は可逆で、逆元は `(1/2) I`。 -/
noncomputable instance instInvertibleTwoTensorPow : Invertible (2 : TensorPow M) where
  invOf := (1 / 2 : ℂ) • (1 : TensorPow M)
  invOf_mul_self := by
    have h2 : (2 : TensorPow M) = (2 : ℂ) • (1 : TensorPow M) := by
      rw [← Algebra.algebraMap_eq_smul_one, map_ofNat]
    rw [h2, smul_mul_smul_comm, one_mul]
    norm_num
  mul_invOf_self := by
    have h2 : (2 : TensorPow M) = (2 : ℂ) • (1 : TensorPow M) := by
      rw [← Algebra.algebraMap_eq_smul_one, map_ofNat]
    rw [h2, smul_mul_smul_comm, one_mul]
    norm_num

theorem invOf_two_tensorPow : ⅟(2 : TensorPow M) = (1 / 2 : ℂ) • (1 : TensorPow M) := rfl

/-- 一般形 `epsProj M η` は必要十分版の射影子 `NecSuf.invProj (ηε)`。 -/
theorem epsProj_eq_invProj (η : ℂ) :
    epsProj M η = NecSuf.invProj (η • epsilon M) := by
  rw [epsProj, NecSuf.invProj, invOf_two_tensorPow, smul_mul_assoc, one_mul]

/-- 具体版 `epsProj_sq` の必要十分版 `NecSuf.invProj_sq` からの導出。 -/
theorem epsProj_sq_of_necSuf {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M η = epsProj M η := by
  rw [epsProj_eq_invProj]
  exact NecSuf.invProj_sq (eta_smul_epsilon_sq hη)

/-- 具体版 `epsProj_mul_epsProj_neg` の必要十分版 `NecSuf.invProj_mul_invProj_neg` からの導出。 -/
theorem epsProj_mul_epsProj_neg_of_necSuf {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M (-η) = 0 := by
  have h : epsProj M (-η) = NecSuf.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact NecSuf.invProj_mul_invProj_neg (eta_smul_epsilon_sq hη)

/-- 具体版 `epsProj_add_epsProj_neg` の必要十分版 `NecSuf.invProj_add_invProj_neg` からの導出。 -/
theorem epsProj_add_epsProj_neg_of_necSuf (η : ℂ) :
    epsProj M η + epsProj M (-η) = 1 := by
  have h : epsProj M (-η) = NecSuf.invProj (-(η • epsilon M)) := by
    rw [epsProj_eq_invProj, neg_smul]
  rw [epsProj_eq_invProj, h]
  exact NecSuf.invProj_add_invProj_neg _

/-- 具体版 `commute_epsProj_of_commute_epsilon` の必要十分版 `NecSuf.commute_invProj` からの導出。 -/
theorem commute_epsProj_of_commute_epsilon_of_necSuf {a : TensorPow M} (η : ℂ)
    (h : Commute a (epsilon M)) : Commute a (epsProj M η) := by
  rw [epsProj_eq_invProj]
  exact NecSuf.commute_invProj (h.smul_right η)

end Ising2D
