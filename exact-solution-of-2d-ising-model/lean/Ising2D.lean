/-
# Ising2D — 2次元 Ising 模型の厳密解の機械的証明

人手証明（`exact-solution-of-2d-ising-model/parts/**/*.typ`）に対応する Lean 4 + mathlib4 の
形式化。ファイルと人手証明の対応規約は `lean/README.md` を参照。
-/
import Ising2D.Basic
import Ising2D.Part000.Claim045_ConjugationIsRingHom
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Ising2D.Part002.Theorem000_TensorBasis
import Ising2D.Part002.Lemma001_ScalarIdentityCommutes
import Ising2D.Part002.Lemma003_CentralizerIsScalar
import Ising2D.Representation
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.Part004.Claim014_ZYGenerateAlgebra
import Ising2D.Part006.Claim000_AnticommutatorZY
import Ising2D.Part004.Claim001_ZYLinearlyIndependent
import Ising2D.Part004.Claim008_ExpSum
import Ising2D.Part004.Definition009_HatZHatY
import Ising2D.Part004.Claim012_HatPeriodicity
import Ising2D.Part004.Claim013_RecoverZY
import Ising2D.Part007.Claim000_AnticommutatorHatZHatY
import Ising2D.Part004.Definition010_H1H2V1V2
import Ising2D.Part008.Definition016_TV
import Ising2D.Part008.Definition019_ThetaGamma
import Ising2D.Part008.Claim027_EigenATheta
