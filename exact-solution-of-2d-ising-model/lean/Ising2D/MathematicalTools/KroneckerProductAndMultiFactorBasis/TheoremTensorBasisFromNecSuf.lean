/-
# `<tensor_basis>` の具体版を必要十分版から導く

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

必要十分版は `Ising2D/NecSuf/TensorPowerBasis.lean`。本ファイルは
`exact-solution-of-2d-ising-model/README.md` 4 節の規約
「必要十分版から具体版が特殊化で得られる場合は、その導出を明示的に書く」に従って、
既存の具体版（`Ising2D.tensorPowBasis` / `Ising2D.matTensorPowBasis` /
`Ising2D.matrixUnitBasis`）が必要十分版の特殊化であることを明示する。
**既存の `TheoremTensorBasis.lean` と `Representation.lean` は編集していない。**

## 何が具体で何が抽象か（判断の根拠）

本プロジェクトの本文は抽象テンソル積を使わず、`Mat(2,ℂ)^{⊗M}` を
**具体的な Kronecker 表現 `TensorPow M = Matrix (Conf M) (Conf M) ℂ`** で扱う（README 2 節）。
人手証明 `<tensor_basis>` (1) が使われるのは
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
「`cal(E) = { E_{IJ} }` は基底である」であり、その具体版は
`Ising2D.matrixUnitBasis`（行列単位の族）である。
本ファイルではこれを、テンソル積を一切使わない必要十分版
`NecSuf.matrixUnitBasis` の特殊化として得る（`matrixUnitBasis_eq_necSuf`）。

抽象テンソル冪 `AbstractTensorPow M` 側の基底 `matTensorPowBasis` も、
基底の移送 `NecSuf.basisOfLinearEquiv` で Kronecker 表現へ運べる
（`kroneckerTensorPowBasis`）。同じ移送を `Mat(2,ℂ)` の任意の基底で行ったものが `<tensor_basis>` (2) の
`kroneckerTensorPowBasisOf` である（`<Z_Y_generate_algebra>` は張ることだけを使うので、これではなく
`ClaimKroneckerFamilyOfSpanningFamilySpans.lean` を引く）。
-/
import Ising2D.NecSuf.TensorPowerBasis
import Ising2D.Representation

open scoped TensorProduct
open Module

namespace Ising2D

variable (M : ℕ)

/-! ## 本文が実際に使う基底: 人手証明と同じ成分比較で得られる -/

/-- **`<tensor_basis>` (1) を使う場所の具体版**
（行列単位 `E_{IJ}` の族が `TensorPow M` の基底であること）を、
必要十分版 `NecSuf.matrixUnitBasis`（人手証明 Step 1 と同じ成分比較で証明したもの。
係数は任意の可換環、添字は任意の有限型でよい）の特殊化として得る。 -/
noncomputable def EBasis : Basis (Conf M × Conf M) ℂ (TensorPow M) :=
  NecSuf.matrixUnitBasis ℂ (Conf M)

/-- 上の基底の元が、人手証明の記号 `E_{IJ}` そのものであること。 -/
@[simp]
theorem EBasis_apply (IJ : Conf M × Conf M) : EBasis M IJ = E IJ.1 IJ.2 :=
  NecSuf.matrixUnitBasis_apply IJ

/-- 既存の具体版 `Ising2D.matrixUnitBasis`（mathlib の `Matrix.stdBasis` を使ったもの）と、
人手証明の論法で作った `EBasis` が同じ族であることの確認。 -/
theorem coe_EBasis_eq_matrixUnitBasis : ⇑(EBasis M) = ⇑(matrixUnitBasis M) := by
  funext IJ
  rw [EBasis_apply, matrixUnitBasis_apply]

/-- 人手証明 Step 1 の成分比較そのもの（`A = Σ_{IJ} A_{IJ} E_{IJ}`）を、
本プロジェクトの記号で述べたもの。 -/
theorem matrix_eq_sum_E (A : TensorPow M) :
    A = ∑ IJ : Conf M × Conf M, A IJ.1 IJ.2 • E IJ.1 IJ.2 :=
  NecSuf.matrix_eq_sum_smul_single A

/-! ## 抽象テンソル冪側の基底を Kronecker 表現へ移す -/

/-- 抽象テンソル冪 `AbstractTensorPow M` の基底
（`<tensor_basis>` そのものの形）を ℂ-代数同型 `tensorPowAlgEquiv` で
Kronecker 表現 `TensorPow M` へ移した基底。

移送に使う事実は「基底は線型同型で移せる」`NecSuf.basisOfLinearEquiv` の 1 つだけ。 -/
noncomputable def kroneckerTensorPowBasis :
    Basis (Fin M → Fin 2 × Fin 2) ℂ (TensorPow M) :=
  NecSuf.basisOfLinearEquiv (matTensorPowBasis M) (tensorPowAlgEquiv M).toLinearEquiv

/-- 移送した基底の像は、各サイトに行列単位を載せた積 `siteProd` である
（人手 `Z_Y_generate_algebra` の Step 3 後半の `E_1 ⋯ E_M = e_1 ⊠ ⋯ ⊠ e_M` と形は同じだが、
ここでの各因子は行列単位で、人手の `{I, σ^x, σ^y, σ^z}` の元ではない）。 -/
@[simp]
theorem kroneckerTensorPowBasis_apply (p : Fin M → Fin 2 × Fin 2) :
    kroneckerTensorPowBasis M p
      = siteProd M (fun i => Matrix.single (p i).1 (p i).2 (1 : ℂ)) := by
  rw [kroneckerTensorPowBasis, NecSuf.basisOfLinearEquiv_apply]
  rw [matTensorPowBasis_apply]
  exact tensorPowAlgEquiv_tprod M _

/-! ## `<tensor_basis>` (2): `Mat(2, ℂ)` の任意の基底のクロネッカー積 -/

/-- 人手 `<tensor_basis>` (2) のクロネッカー積の形: `Mat(2, ℂ)` の任意の ℂ-基底 `b`（添字 `ι`。
人手の `𝓑 = {b_1, …, b_4}` では `ι = {1, 2, 3, 4}`）について、多重添字 `p = (a_1, …, a_M)` で
添字づけた族 `b_{a_1} ⊠ ⋯ ⊠ b_{a_M}` は `TensorPow M`（人手の `Mat(2^M, ℂ)`）の ℂ-基底である。

抽象テンソル冪の基底 `tensorPowBasis M b` を `tensorPowAlgEquiv` で移したもので、
移送に使う事実は `NecSuf.basisOfLinearEquiv` の 1 つだけである。`tensorPowBasis` は
mathlib の `Basis.piTensorProduct` の特殊化で、人手 `<tensor_basis>` の Step 4
（行列単位を `b` で展開し、`kronecker_multilinear` を因子ごとに当て、元数と次元の一致で基底とする）
の 1 対 1 の形式化ではない。添字の型 `ι` を任意にしたのは、移送元の `tensorPowBasis` が任意の添字で述べられているためで、
人手 (2) の `𝓑 = {b_1, …, b_4}` は `ι = Fin 4` に当たる。 -/
noncomputable def kroneckerTensorPowBasisOf {ι : Type*} (b : Basis ι ℂ (Matrix (Fin 2) (Fin 2) ℂ)) :
    Basis (Fin M → ι) ℂ (TensorPow M) :=
  NecSuf.basisOfLinearEquiv (tensorPowBasis M b) (tensorPowAlgEquiv M).toLinearEquiv

/-- 上の基底の元は、各サイトに `b_{a_i}` を載せた積 `siteProd`（人手の `b_{a_1} ⊠ ⋯ ⊠ b_{a_M}`）である。 -/
@[simp]
theorem kroneckerTensorPowBasisOf_apply {ι : Type*} (b : Basis ι ℂ (Matrix (Fin 2) (Fin 2) ℂ))
    (p : Fin M → ι) :
    kroneckerTensorPowBasisOf M b p = siteProd M (fun i => b (p i)) := by
  rw [kroneckerTensorPowBasisOf, NecSuf.basisOfLinearEquiv_apply, tensorPowBasis_apply]
  exact tensorPowAlgEquiv_tprod M _

end Ising2D
