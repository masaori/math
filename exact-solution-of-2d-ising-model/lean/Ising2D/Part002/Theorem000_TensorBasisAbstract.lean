/-
# `<tensor_basis>` の具体版を抽象版から導く

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

抽象版は `Ising2D/Abstract/TensorPowerBasis.lean`。本ファイルは
`exact-solution-of-2d-ising-model/README.md` 4 節の規約
「抽象版から具体版が特殊化で得られる場合は、その導出を明示的に書く」に従って、
既存の具体版（`Ising2D.tensorPowBasis` / `Ising2D.matTensorPowBasis` /
`Ising2D.matrixUnitBasis`）が抽象版の特殊化であることを明示する。
**既存の `Theorem000_TensorBasis.lean` と `Representation.lean` は編集していない。**

## 何が具体で何が抽象か（判断の根拠）

本プロジェクトの本文は抽象テンソル積を使わず、`Mat(2,ℂ)^{⊗M}` を
**具体的な Kronecker 表現 `TensorPow M = Matrix (Conf M) (Conf M) ℂ`** で扱う（README 2 節）。
したがって人手証明 `<tensor_basis>` が実際に使われるのは
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
「`cal(E) = { E_{IJ} }` は基底である」1 箇所であり、その具体版は
`Ising2D.matrixUnitBasis`（行列単位の族）である。
本ファイルではこれを、テンソル積を一切使わない抽象版
`Abstract.matrixUnitBasis` の特殊化として得る（`matrixUnitBasis_eq_abstract`）。

抽象テンソル冪 `AbstractTensorPow M` 側の基底 `matTensorPowBasis` も、
基底の移送 `Abstract.basisOfLinearEquiv` で Kronecker 表現へ運べる
（`kroneckerTensorPowBasis`）。この 2 つの基底の存在が、人手証明 Step 3 後半で
「基底を全部含む部分空間は全体」と言うときに必要なものすべてである。
-/
import Ising2D.Abstract.TensorPowerBasis
import Ising2D.Representation

open scoped TensorProduct
open Module

namespace Ising2D

variable (M : ℕ)

/-! ## テンソル冪の基底: 具体版は抽象版の特殊化 -/

/-- 具体版 `Ising2D.tensorPowBasis` は、抽象版
`Abstract.tensorPowBasisOfBasis`（各因子が別の加群でよい形の特殊化）そのものである。 -/
theorem tensorPowBasis_eq_abstract {K : Type*} [CommSemiring K]
    {V : Type*} [AddCommMonoid V] [Module K V] {ι : Type*} (b : Basis ι K V) :
    tensorPowBasis M b = Abstract.tensorPowBasisOfBasis M b :=
  rfl

/-- `Mat(2,ℂ)` の行列単位の基底からテンソル冪の基底を作る具体版
`Ising2D.matTensorPowBasis` も、抽象版の特殊化である。 -/
theorem matTensorPowBasis_eq_abstract :
    matTensorPowBasis M
      = Abstract.tensorPowBasisOfBasis M (Matrix.stdBasis ℂ (Fin 2) (Fin 2)) :=
  rfl

/-! ## 本文が実際に使う基底: テンソル積を使わずに得られる -/

/-- **本プロジェクトが `<tensor_basis>` を使う唯一の場所の具体版**
（`Ising2D.matrixUnitBasis`、行列単位 `E_{IJ}` の族が `TensorPow M` の基底であること）は、
テンソル積の一般論ではなく、抽象版 `Abstract.matrixUnitBasis`
（任意の可換半環・任意の有限添字型で成り立つ）の特殊化である。 -/
theorem matrixUnitBasis_eq_abstract :
    matrixUnitBasis M = Abstract.matrixUnitBasis ℂ (Conf M) :=
  rfl

/-- 上を人手証明の記号 `E_{IJ}` の形で述べたもの。 -/
theorem abstract_matrixUnitBasis_apply_eq_E (IJ : Conf M × Conf M) :
    Abstract.matrixUnitBasis ℂ (Conf M) IJ = E IJ.1 IJ.2 :=
  matrixUnitBasis_apply IJ

/-! ## 抽象テンソル冪側の基底を Kronecker 表現へ移す -/

/-- 抽象テンソル冪 `AbstractTensorPow M` の基底
（`<tensor_basis>` そのものの形）を ℂ-代数同型 `tensorPowAlgEquiv` で
Kronecker 表現 `TensorPow M` へ移した基底。

移送に使う事実は「基底は線型同型で移せる」`Abstract.basisOfLinearEquiv` の 1 つだけ。 -/
noncomputable def kroneckerTensorPowBasis :
    Basis (Fin M → Fin 2 × Fin 2) ℂ (TensorPow M) :=
  Abstract.basisOfLinearEquiv (matTensorPowBasis M) (tensorPowAlgEquiv M).toLinearEquiv

/-- 移送した基底の像は、各サイトに行列単位を載せた積 `siteProd` である
（人手証明 Step 3 後半の `σ_1^{a_1} ⋯ σ_M^{a_M} = e_1 ⊗ ⋯ ⊗ e_M` に対応）。 -/
@[simp]
theorem kroneckerTensorPowBasis_apply (p : Fin M → Fin 2 × Fin 2) :
    kroneckerTensorPowBasis M p
      = siteProd M (fun i => Matrix.single (p i).1 (p i).2 (1 : ℂ)) := by
  rw [kroneckerTensorPowBasis, Abstract.basisOfLinearEquiv_apply]
  rw [matTensorPowBasis_apply]
  exact tensorPowAlgEquiv_tprod M _

end Ising2D
