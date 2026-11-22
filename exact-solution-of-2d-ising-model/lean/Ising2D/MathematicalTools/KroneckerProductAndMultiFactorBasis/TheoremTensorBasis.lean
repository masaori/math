/-
# 抽象テンソル冪の基底

mathlib の抽象テンソル冪 `⨂[K] (_ : Fin M), V` の基底を、`V` の基底から作る。
`Ising2D/Representation.lean` の `toMatrixAlgHom_basis` が使う。

本文の `tensor_basis`（`structured-latex/content/002_linear_space_general.ts`）は、行列単位のクロネッカー積の族が
`Mat(2^M, ℂ)` の基底であり、標準基底のクロネッカー積の族が `ℂ^{2^M}` の基底であるという具体的な主張で、
抽象テンソル積を置かない。このファイルの宣言はその具体版ではない。
-/
import Mathlib.LinearAlgebra.PiTensorProduct.Basis
import Mathlib.LinearAlgebra.Matrix.StdBasis
import Ising2D.Basic

open scoped TensorProduct
open Module

namespace Ising2D

variable {K : Type*} [CommSemiring K]
variable {V : Type*} [AddCommMonoid V] [Module K V]
variable {ι : Type*}

/-- **抽象テンソル冪の基底（一般形）**。本文の `tensor_basis`（行列単位のクロネッカー積の族が `Mat(2^M, ℂ)` の基底）の
具体版ではない（本文は抽象テンソル積を置かない）。

`b : Module.Basis ι K V` が `K`-加群 `V` の基底ならば、
`p ↦ b (p 0) ⊗ b (p 1) ⊗ ⋯ ⊗ b (p (M-1))`（`p : Fin M → ι`）は
テンソル冪 `V^{⊗M} = ⨂[K] (_ : Fin M), V` の基底である。

mathlib の `Basis.piTensorProduct` をテンソル**冪**（全成分が同一）へ特殊化しただけであり、
証明は mathlib の既存結果に完全に帰着する。 -/
noncomputable def tensorPowBasis (M : ℕ) (b : Basis ι K V) :
    Basis (Fin M → ι) K (⨂[K] (_ : Fin M), V) :=
  Basis.piTensorProduct fun _ => b

/-- `tensorPowBasis` の基底ベクトルが、実際に基底ベクトルのテンソル積になっていること。 -/
@[simp]
theorem tensorPowBasis_apply (M : ℕ) (b : Basis ι K V) (p : Fin M → ι) :
    tensorPowBasis M b p = ⨂ₜ[K] i, b (p i) :=
  Basis.piTensorProduct_apply _ _

/-- `tensorPowBasis` による座標表示。 -/
@[simp]
theorem tensorPowBasis_repr_tprod_apply (M : ℕ) (b : Basis ι K V)
    (x : Fin M → V) (p : Fin M → ι) :
    (tensorPowBasis M b).repr (⨂ₜ[K] i, x i) p = ∏ i : Fin M, b.repr (x i) (p i) :=
  Basis.piTensorProduct_repr_tprod_apply _ _ _

/-- **`tensorPowBasis` を `Mat(2, ℂ)` に適用した系**。本文の `tensor_basis` の具体版ではない。

`Mat(2, ℂ)` の標準基底（行列単位 `E_{ij}`）から作られる族
`p ↦ E_{p(0)} ⊗ ⋯ ⊗ E_{p(M-1)}` は `Mat(2, ℂ)^{⊗M}` の ℂ-基底である。

`toMatrixAlgHom_basis`（`Ising2D/Representation.lean`）が、行列表現の行列単位へ写ることを述べる。 -/
noncomputable def matTensorPowBasis (M : ℕ) :
    Basis (Fin M → Fin 2 × Fin 2) ℂ (AbstractTensorPow M) :=
  tensorPowBasis M (Matrix.stdBasis ℂ (Fin 2) (Fin 2))

@[simp]
theorem matTensorPowBasis_apply (M : ℕ) (p : Fin M → Fin 2 × Fin 2) :
    matTensorPowBasis M p = ⨂ₜ[ℂ] i, Matrix.single (p i).1 (p i).2 (1 : ℂ) := by
  rw [matTensorPowBasis, tensorPowBasis_apply]
  exact congrArg _ (funext fun i => Matrix.stdBasis_eq_single ℂ (p i).1 (p i).2)

end Ising2D
