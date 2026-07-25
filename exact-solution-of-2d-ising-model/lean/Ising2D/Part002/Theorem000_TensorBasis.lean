/-
# テンソル積の基底は基底のテンソル積

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

## 原文ステートメントについての注意（要修正点）

原文は

> $V$: $m$次元$K$-線型空間、$E = {e_1, …, e_m}$: $V$の基底とするとき、
> $forall (i_1, …, i_m) in {1, …, m}^m$、$e_{i_1} ⊗ … ⊗ e_{i_m}$ は $V^{⊗m}$ の基底である

と書かれているが、これは 2 点で不正確である。

1. 「各 $(i_1, …, i_m)$ について $e_{i_1} ⊗ … ⊗ e_{i_m}$ が基底」ではない。基底なのは
   **族全体** $\{e_{i_1} ⊗ ⋯ ⊗ e_{i_M}\}_{(i_1,…,i_M)}$ であって、その個々の元ではない。
2. 添字 $m$ が「$V$ の次元」と「テンソル冪の階数」の両方に使われている。両者は独立なので
   区別しなければならない（以下では基底の添字集合を `ι`、階数を `M` とする）。

実際に本プロジェクトが使うのは修正後の主張（族が基底）であり
（`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` の Step 1 で
`cal(E) = { E_(I J) : I, J ∈ {1,2}^M }` が基底であることの根拠として引用される）、
以下ではそれを形式化する。
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

/-- **`<tensor_basis>` の形式化（一般形）**。

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

/-- **`<tensor_basis>` を `Mat(2, ℂ)` に適用した系**。

`Mat(2, ℂ)` の標準基底（行列単位 `E_{ij}`）から作られる族
`p ↦ E_{p(0)} ⊗ ⋯ ⊗ E_{p(M-1)}` は `Mat(2, ℂ)^{⊗M}` の ℂ-基底である。

これは `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` の Step 1 で
「`cal(E)` は `Mat(2,ℂ)^{⊗M}` の基底である」と主張されているものそのもの。 -/
noncomputable def matTensorPowBasis (M : ℕ) :
    Basis (Fin M → Fin 2 × Fin 2) ℂ (AbstractTensorPow M) :=
  tensorPowBasis M (Matrix.stdBasis ℂ (Fin 2) (Fin 2))

@[simp]
theorem matTensorPowBasis_apply (M : ℕ) (p : Fin M → Fin 2 × Fin 2) :
    matTensorPowBasis M p = ⨂ₜ[ℂ] i, Matrix.single (p i).1 (p i).2 (1 : ℂ) := by
  rw [matTensorPowBasis, tensorPowBasis_apply]
  exact congrArg _ (funext fun i => Matrix.stdBasis_eq_single ℂ (p i).1 (p i).2)

end Ising2D
