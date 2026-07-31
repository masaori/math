/-
# 抽象版: 基底のテンソル積は基底 / 行列単位の族は基底 / 基底は線型同型で移せる

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

具体版（人手証明と 1 対 1 に対応する主張）は
`Ising2D/Part002/Theorem000_TensorBasis.lean`（`Ising2D.tensorPowBasis` / `Ising2D.matTensorPowBasis`）
と `Ising2D/Representation.lean`（`Ising2D.matrixUnitBasis`）にあり、
両者を本ファイルの抽象版から得る導出は
`Ising2D/Part002/Theorem000_TensorBasisAbstract.lean` に置く。

## 抽象版が何を明らかにするか

1. **`<tensor_basis>` に「因子が全部同じであること」は効いていない。**
   各因子が別々の加群でよく、各々に基底があれば、添字の直積で添字づけられた族が
   テンソル積の基底になる（`piTensorBasis`）。人手証明が述べるテンソル**冪**の場合は
   その特殊化にすぎない（`tensorPowBasisOfBasis`）。
2. **係数が体であること・次元が有限であること・基底の添字集合が有限であることも効いていない。**
   係数は任意の可換半環でよく、加群は自由でありさえすればよい。
   有限性が要るのは**因子の添字**（テンソル積を取る個数）だけである。
3. **本プロジェクトが `<tensor_basis>` を実際に使う唯一の場所——
   「`cal(E) = { E_{IJ} }` は `Mat(2,ℂ)^{⊗M}` の基底である」——には、テンソル積が要らない。**
   要るのは
   * 行列単位の族が行列環の基底であること（`matrixUnitBasis`。任意の可換半環・任意の有限添字型）
   * 基底は線型同型で移せること（`basisOfLinearEquiv`）
   の 2 つだけで、テンソル積の一般論も、`2 × 2` であることも、複素数であることも効いていない。
   本プロジェクトは `Mat(2,ℂ)^{⊗M}` を Kronecker 表現 `Matrix (Conf M) (Conf M) ℂ` で実現する
   （README 2 節）ので、実際に使うのはこの経路である。
-/
import Mathlib.LinearAlgebra.Matrix.StdBasis
import Mathlib.LinearAlgebra.PiTensorProduct.Basis

open scoped TensorProduct
open Module

namespace Ising2D
namespace Abstract

section PiTensor

variable {K : Type*} [CommSemiring K]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {κ : ι → Type*} {V : ι → Type*}
variable [∀ i, AddCommMonoid (V i)] [∀ i, Module K (V i)]

/-- **`<tensor_basis>` の抽象版（因子ごとに別の加群でよい形）**。

各因子 `V i` が基底 `b i : Basis (κ i) K (V i)` をもてば、
`p ↦ ⨂ᵢ b i (p i)`（`p : ∀ i, κ i`）はテンソル積 `⨂[K] i, V i` の基底である。

mathlib の `Basis.piTensorProduct` そのものであり、
「因子が同一であること」も「係数が体であること」も要らないことを明示するために置く。 -/
noncomputable def piTensorBasis (b : ∀ i, Basis (κ i) K (V i)) :
    Basis (∀ i, κ i) K (⨂[K] i, V i) :=
  Basis.piTensorProduct b

@[simp]
theorem piTensorBasis_apply (b : ∀ i, Basis (κ i) K (V i)) (p : ∀ i, κ i) :
    piTensorBasis b p = ⨂ₜ[K] i, b i (p i) :=
  Basis.piTensorProduct_apply _ _

end PiTensor

section TensorPow

variable {K : Type*} [CommSemiring K]
variable {κ V : Type*} [AddCommMonoid V] [Module K V]

/-- **人手証明が述べているテンソル冪の場合**は、`piTensorBasis` で全因子を同じにしただけの
特殊化である（`Fin n` の有限性・等号判定可能性以外は何も足していない）。 -/
noncomputable def tensorPowBasisOfBasis (n : ℕ) (b : Basis κ K V) :
    Basis (Fin n → κ) K (⨂[K] (_ : Fin n), V) :=
  piTensorBasis fun _ => b

@[simp]
theorem tensorPowBasisOfBasis_apply (n : ℕ) (b : Basis κ K V) (p : Fin n → κ) :
    tensorPowBasisOfBasis n b p = ⨂ₜ[K] i, b (p i) :=
  piTensorBasis_apply _ _

end TensorPow

section Transport

variable {K : Type*} [Semiring K] {κ : Type*}
variable {V W : Type*} [AddCommMonoid V] [Module K V] [AddCommMonoid W] [Module K W]

/-- **基底は線型同型で移せる**（mathlib の `Basis.map`）。

「表現を取り替えても基底は基底のまま」という、本プロジェクトが
抽象テンソル冪 `AbstractTensorPow M` と Kronecker 表現 `TensorPow M` を行き来するときに
使う唯一の事実。テンソル積とは無関係で、係数は任意の半環でよい。 -/
noncomputable def basisOfLinearEquiv (b : Basis κ K V) (e : V ≃ₗ[K] W) : Basis κ K W :=
  b.map e

@[simp]
theorem basisOfLinearEquiv_apply (b : Basis κ K V) (e : V ≃ₗ[K] W) (i : κ) :
    basisOfLinearEquiv b e i = e (b i) :=
  Basis.map_apply _ _ _

end Transport

section MatrixUnits

variable (K : Type*) [Semiring K] (n : Type*) [Fintype n] [DecidableEq n]

/-- **行列単位の族 `{E_{IJ}}` は行列環の基底である**。

人手証明が `<tensor_basis>` を引いて正当化している
「`cal(E) = { E_{IJ} : I, J ∈ {1,2}^M }` は `Mat(2,ℂ)^{⊗M}` の基底」は、
Kronecker 表現ではこの事実の特殊化であって、テンソル積の一般論を要しない。
係数は任意の半環、添字は任意の有限型でよい。 -/
noncomputable def matrixUnitBasis : Basis (n × n) K (Matrix n n K) :=
  Matrix.stdBasis K n n

@[simp]
theorem matrixUnitBasis_apply (p : n × n) :
    matrixUnitBasis K n p = Matrix.single p.1 p.2 (1 : K) :=
  Matrix.stdBasis_eq_single _ _ _

end MatrixUnits

end Abstract
end Ising2D
