/-
# `Mat(2, ℂ)^{⊗M}` の 2 通りの表現とその一致

人手証明で `Mat(2, CC)^(times.o M)` と書かれている対象を Lean で表す方法として、
本ファイルでは

* `AbstractTensorPow M = ⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ`（抽象テンソル冪）
* `TensorPow M = Matrix (Conf M) (Conf M) ℂ`（スピン配置で添字づけた行列環 = Kronecker 表現）

の 2 つを実際に構成し、両者が **ℂ-代数として同型**であることを証明する
（`Ising2D.tensorPowAlgEquiv`）。

同型を作ってあるので、どちらの表現で述べた命題も他方へ移送できる。
そのうえで、以降の証明の土台としては `TensorPow M` を推奨する。理由は
`Ising2D/Basic.lean` の docstring および `lean/README.md` を参照。
-/
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Data.Matrix.Basis
import Mathlib.LinearAlgebra.Multilinear.Basic
import Ising2D.Abstract.MatrixUnits
import Ising2D.Part002.Theorem000_TensorBasis

open scoped TensorProduct
open Module

namespace Ising2D

section Bridge

variable (M : ℕ)

/-- 各サイトの行列を成分ごとに掛け合わせる多重線型写像

`(x_0, …, x_{M-1}) ↦ [ (s, t) ↦ ∏_{i} (x_i)_{s(i), t(i)} ]`。

これは Kronecker 積 `x_0 ⊗ₖ ⋯ ⊗ₖ x_{M-1}` を、添字を `Fin (2^M)` ではなく
スピン配置 `Conf M` で書いたものにほかならない。 -/
noncomputable def siteProd :
    MultilinearMap ℂ (fun _ : Fin M => Matrix (Fin 2) (Fin 2) ℂ) (TensorPow M) :=
  (Matrix.ofLinearEquiv ℂ).toLinearMap.compMultilinearMap <|
    MultilinearMap.pi fun s : Conf M => MultilinearMap.pi fun t : Conf M =>
      (MultilinearMap.mkPiAlgebra ℂ (Fin M) ℂ).compLinearMap fun i =>
        Matrix.entryLinearMap ℂ ℂ (s i) (t i)

@[simp]
theorem siteProd_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (s t : Conf M) :
    siteProd M x s t = ∏ i : Fin M, x i (s i) (t i) := rfl

/-- `siteProd` は単位元を単位元に送る。 -/
theorem siteProd_one : siteProd M 1 = 1 := by
  ext s t
  simp only [siteProd_apply, Pi.one_apply, Matrix.one_apply]
  rw [Finset.prod_boole]
  simp [funext_iff]

/-- `siteProd` は積を保つ。証明の要は `Finset.prod_univ_sum`
（積と和の入れ替えで、行列積の添字和がスピン配置全体の和になる）。 -/
theorem siteProd_mul (x y : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (x * y) = siteProd M x * siteProd M y := by
  ext s t
  simp only [siteProd_apply, Pi.mul_apply, Matrix.mul_apply]
  rw [Finset.prod_univ_sum, Fintype.piFinset_univ]
  exact Finset.sum_congr rfl fun u _ => Finset.prod_mul_distrib

/-- 抽象テンソル冪から行列表現への ℂ-代数準同型。 -/
noncomputable def toMatrixAlgHom : AbstractTensorPow M →ₐ[ℂ] TensorPow M :=
  PiTensorProduct.liftAlgHom (siteProd M) (siteProd_one M) (siteProd_mul M)

@[simp]
theorem toMatrixAlgHom_tprod (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    toMatrixAlgHom M (⨂ₜ[ℂ] i, x i) = siteProd M x := by
  simp [toMatrixAlgHom]

/-- 多重添字 `p : Fin M → Fin 2 × Fin 2` と行列単位の添字対 `(I, J) : Conf M × Conf M` の対応。 -/
def confPairEquiv : (Fin M → Fin 2 × Fin 2) ≃ Conf M × Conf M :=
  Equiv.arrowProdEquivProdArrow _ _ _

/-- `toMatrixAlgHom` は、抽象テンソル冪の基底（`matTensorPowBasis`）を
行列環の標準基底（行列単位）へ全単射に写す。 -/
theorem toMatrixAlgHom_basis (p : Fin M → Fin 2 × Fin 2) :
    toMatrixAlgHom M (matTensorPowBasis M p) =
      Matrix.stdBasis ℂ (Conf M) (Conf M) (confPairEquiv M p) := by
  rw [matTensorPowBasis_apply, toMatrixAlgHom_tprod, Matrix.stdBasis_eq_single]
  ext s t
  simp only [siteProd_apply, Matrix.single_apply, confPairEquiv,
    Equiv.arrowProdEquivProdArrow_apply]
  rw [Finset.prod_boole]
  simp [funext_iff, forall_and]

/-- **`Mat(2, ℂ)^{⊗M}` の 2 通りの表現は ℂ-代数として同型**。

抽象テンソル冪 `⨂[ℂ] (_ : Fin M), Mat(2, ℂ)` と、スピン配置で添字づけた行列環
`Matrix (Conf M) (Conf M) ℂ` は ℂ-代数同型である。
同型写像は `⨂ₜ x ↦ [ (s,t) ↦ ∏_i (x_i)_{s(i)t(i)} ]`（= Kronecker 積）。 -/
noncomputable def tensorPowAlgEquiv : AbstractTensorPow M ≃ₐ[ℂ] TensorPow M := by
  refine AlgEquiv.ofBijective (toMatrixAlgHom M) ?_
  have h : (toMatrixAlgHom M).toLinearMap =
      ((matTensorPowBasis M).equiv (Matrix.stdBasis ℂ (Conf M) (Conf M))
        (confPairEquiv M) : AbstractTensorPow M ≃ₗ[ℂ] TensorPow M).toLinearMap := by
    refine (matTensorPowBasis M).ext fun p => ?_
    rw [AlgHom.toLinearMap_apply, LinearEquiv.coe_coe, Basis.equiv_apply,
      toMatrixAlgHom_basis]
  have : ⇑(toMatrixAlgHom M) =
      ⇑((matTensorPowBasis M).equiv (Matrix.stdBasis ℂ (Conf M) (Conf M)) (confPairEquiv M)) :=
    congrArg (fun f : AbstractTensorPow M →ₗ[ℂ] TensorPow M => ⇑f) h
  rw [this]
  exact LinearEquiv.bijective _

@[simp]
theorem tensorPowAlgEquiv_tprod (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    tensorPowAlgEquiv M (⨂ₜ[ℂ] i, x i) = siteProd M x :=
  toMatrixAlgHom_tprod M x

/-- 添字を `Fin (2^M)` にした Kronecker 表現 `Matrix (Fin (2^M)) (Fin (2^M)) ℂ` は、
`TensorPow M` の**添字の付け替えにすぎない**（`finFunctionFinEquiv : (Fin M → Fin 2) ≃ Fin (2^M)`）。

したがって「`Fin (2^M)` 添字」と「スピン配置添字」は表現力として同じであり、
サイト局所演算子を書くのに添字変換が要らない分だけ後者が扱いやすい、という差だけになる。 -/
noncomputable def toFinPowAlgEquiv :
    TensorPow M ≃ₐ[ℂ] Matrix (Fin (2 ^ M)) (Fin (2 ^ M)) ℂ :=
  Matrix.reindexAlgEquiv ℂ ℂ finFunctionFinEquiv

end Bridge

section MatrixUnits

variable {M : ℕ}

/-- 人手証明 `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
行列単位 `E_{IJ}`（推奨表現 `TensorPow M` の側）。 -/
noncomputable abbrev E (I J : Conf M) : TensorPow M := Matrix.single I J (1 : ℂ)

/-- `E_{IJ}` の族は `TensorPow M` の ℂ-基底である（`<tensor_basis>` の帰結にあたる部分）。 -/
noncomputable def matrixUnitBasis (M : ℕ) : Basis (Conf M × Conf M) ℂ (TensorPow M) :=
  Matrix.stdBasis ℂ (Conf M) (Conf M)

theorem matrixUnitBasis_apply (IJ : Conf M × Conf M) :
    matrixUnitBasis M IJ = E IJ.1 IJ.2 :=
  Matrix.stdBasis_eq_single _ _ _

/-- 人手証明 003 Step 2 の積公式 `E_{IJ} E_{KL} = δ_{JK} E_{IL}`。

抽象版は `Ising2D/Abstract/MatrixUnits.lean` の
`Ising2D.Abstract.single_mul_single_eq_ite`（係数は任意の半環、添字は 4 つとも別の型でよい）。
ここではその特殊化として、係数 `ℂ`・添字 `Conf M` の場合を人手証明の記法で述べる。 -/
theorem E_mul_E (I J K L : Conf M) :
    E I J * E K L = if J = K then E I L else 0 :=
  Abstract.single_mul_single_eq_ite I J K L

/-- 人手証明 003 Step 2 の単位元の展開 `I = Σ_P E_{PP}`。

抽象版は `Ising2D.Abstract.one_eq_sum_single`（係数は任意の半環、添字は任意の有限型）。 -/
theorem one_eq_sum_E : (1 : TensorPow M) = ∑ P : Conf M, E P P :=
  Abstract.one_eq_sum_single

end MatrixUnits

section Exponential

/-!
## 行列指数関数が使えること（表現選択の決め手）

人手証明の主対象である転送行列
`V_1 = exp(√(-1) K_1 (σ^z_1 σ^z_2 + ⋯))`,
`V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^* (σ^x_1 + ⋯))`
（`parts/004_転送行列/000_definition_転送行列の記号の定義.typ`）は指数関数を含む。

`TensorPow M = Matrix (Conf M) (Conf M) ℂ` では mathlib の
`Mathlib.Analysis.Normed.Algebra.MatrixExponential` がそのまま適用できる。
一方 `AbstractTensorPow M` には `NormedRing` インスタンスが無いため
`NormedSpace.exp` を適用できない（`⨂[ℂ] i, A i` に入るのは
`Mathlib.Analysis.Normed.Module.PiTensorProduct.*` のセミノルムのみ）。
-/

/-- 推奨表現では行列指数関数がそのまま定義できる。 -/
noncomputable def matExp {M : ℕ} (A : TensorPow M) : TensorPow M := NormedSpace.exp A

/-- 共役と指数関数の交換 `T_U(exp A) = exp(T_U A)`。
`parts/000_計算公式/045_claim_共役写像は環準同型.typ` の共役写像 `T_U` と
`parts/003_線型写像のexp` 以降で必要になる関係で、mathlib の `Matrix.exp_units_conj`
に直結する。 -/
theorem matExp_units_conj {M : ℕ} (U : (TensorPow M)ˣ) (A : TensorPow M) :
    matExp ((U : TensorPow M) * A * ((U⁻¹ : (TensorPow M)ˣ) : TensorPow M)) =
      (U : TensorPow M) * matExp A * ((U⁻¹ : (TensorPow M)ˣ) : TensorPow M) :=
  Matrix.exp_units_conj U A

end Exponential

end Ising2D
