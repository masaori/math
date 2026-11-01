/-
# スカラー倍の単位行列は全行列と可換（具体版を必要十分版から導く）

具体版 `LemmaScalarIdentityCommutes.lean` の主張（人手 `<scalar_identity_commutes>`）を、
必要十分版 `Ising2D/NecSuf/ScalarCentral.lean` の `NecSuf.smul_one_sub_comm` を `S := ℂ`、`R := Mat(n,ℂ)` へ
特殊化して得る。`Mat(2,ℂ)^{⊗M}` の推奨表現 `TensorPow M` での系も同じ特殊化で置く。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutatorViaAnticommutators
import Ising2D.NecSuf.ScalarCentral
import Ising2D.Representation

namespace Ising2D

/-- `scalar_identity_commutes` を `NecSuf.smul_one_sub_comm`（`S := ℂ`、`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem scalar_identity_commutes_of_necSuf {n : ℕ} (c : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    matComm (c • (1 : Matrix (Fin n) (Fin n) ℂ)) A = 0 :=
  NecSuf.smul_one_sub_comm c A

/-- `TensorPow M`（`Mat(2,ℂ)^{⊗M}` の推奨表現）での系。 -/
theorem scalar_identity_commutes_tensorPow {M : ℕ} (c : ℂ) (A : TensorPow M) :
    (c • (1 : TensorPow M)) * A - A * (c • (1 : TensorPow M)) = 0 :=
  NecSuf.smul_one_sub_comm c A

end Ising2D
