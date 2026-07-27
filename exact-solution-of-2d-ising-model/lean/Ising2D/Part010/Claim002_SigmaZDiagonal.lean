/-
# `σ^z_m` の基底 `f_{ι(μ)}` への作用（対角性）

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_002_claim_sigma_z_diagonal_action`（ラベル **`sigma_z_diagonal_action`**）

原文の主張は `σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}`、および
`σ^z_m σ^z_{m'} f_{ι(μ)} = μ(m) μ(m') f_{ι(μ)}`、
「これらはすべて基底 `(f_I)` に関して対角行列である」。

Lean では添字型 `Conf M` がスピン配置そのものなので、
「対角行列である」を `Matrix.diagonal` の形の等式として先に証明し
（`sigmaZ_eq_diagonal`）、基底ベクトルへの作用（原文の式そのもの）を
その系として得る（`sigmaZ_mulVec_basisVec`）。

抽象版: `Ising2D/Abstract/SiteDiagonal.lean`（同じラベル `sigma_z_diagonal_action`）。
そこで確かめたとおり、効いているのは「サイトごとの積 `siteProd` の成分が因子の成分の積である」
ことと「Pauli 行列 `σ^z` が対角行列であること」だけで、`σ^z` の具体的な成分も
複素数であることも効いていない。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.Part010.Definition001_ConfigBasisIso
import Ising2D.Abstract.SiteDiagonal

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 各因子が対角行列なら、クロネッカー積も対角行列で、対角成分は因子の対角成分の積。

（抽象版 `Ising2D.Abstract.prod_diagonal_entry` の特殊化として証明する。） -/
theorem siteProd_diagonal (d : Fin M → Fin 2 → ℂ) :
    siteProd M (fun i => Matrix.diagonal (d i)) =
      Matrix.diagonal (fun I : Conf M => ∏ i : Fin M, d i (I i)) := by
  ext s t
  rw [siteProd_apply]
  by_cases h : s = t
  · subst h
    rw [Matrix.diagonal_apply_eq]
    exact Finset.prod_congr rfl fun i _ => Matrix.diagonal_apply_eq _ _
  · rw [Matrix.diagonal_apply_ne _ h]
    exact Abstract.prod_entry_eq_zero_of_ne
      (fun i => (Matrix.diagonal (d i) : Matrix (Fin 2) (Fin 2) ℂ))
      (fun _ _ _ hab => Matrix.diagonal_apply_ne _ hab) s t h

/-- `σ^z = diagonal (sgn)`。原文の `σ^z e_1 = e_1`, `σ^z e_2 = -e_2` にあたる。 -/
theorem pauliZ_eq_diagonal : pauliZ = Matrix.diagonal sgnC := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliZ, Matrix.diagonal, sgnC, sgn]

/-- **`σ^z_m` は基底 `(f_I)` に関して対角行列で、`f_I` の固有値は `sgn(I m)`。**
原文 `sigma_z_diagonal_action` の行列としての言い換え。 -/
theorem sigmaZ_eq_diagonal (m : Fin M) :
    sigmaZ m = Matrix.diagonal (fun I : Conf M => sgnC (I m)) := by
  have h : (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ)
      = fun i => Matrix.diagonal (fun k => if i = m then sgnC k else 1) := by
    funext i
    by_cases hi : i = m
    · subst hi; simp [pauliZ_eq_diagonal]
    · simp [hi, Matrix.diagonal_one]
  rw [sigmaZ, siteOp_apply, h, siteProd_diagonal]
  congr 1
  funext I
  simp

/-- **原文の `σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}`。** -/
theorem sigmaZ_mulVec_basisVec (m : Fin M) (I : Conf M) :
    sigmaZ m *ᵥ basisVec I = sgnC (I m) • basisVec I := by
  rw [sigmaZ_eq_diagonal, basisVec, Matrix.diagonal_mulVec_single, mul_one]
  funext J
  by_cases h : J = I
  · subst h; simp
  · simp [Pi.single_apply, h]

/-- 原文の `σ^z_m σ^z_{m'} f_{ι(μ)} = μ(m) μ(m') f_{ι(μ)}`。 -/
theorem sigmaZ_mul_sigmaZ_eq_diagonal (m m' : Fin M) :
    sigmaZ m * sigmaZ m' = Matrix.diagonal (fun I : Conf M => sgnC (I m) * sgnC (I m')) := by
  rw [sigmaZ_eq_diagonal, sigmaZ_eq_diagonal, Matrix.diagonal_mul_diagonal]

theorem sigmaZ_mul_sigmaZ_mulVec_basisVec (m m' : Fin M) (I : Conf M) :
    (sigmaZ m * sigmaZ m') *ᵥ basisVec I = (sgnC (I m) * sgnC (I m')) • basisVec I := by
  rw [← Matrix.mulVec_mulVec, sigmaZ_mulVec_basisVec, Matrix.mulVec_smul,
    sigmaZ_mulVec_basisVec, smul_smul, mul_comm]

/-- 原文の主張をスピン配置 `μ ∈ 𝔐` の言葉で書いた形
（`sgn(ι(μ)(m)) = μ(m)` を代入したもの）。 -/
theorem sigmaZ_mulVec_basisVec_spin (m : Fin M) (μ : SpinConf M) :
    sigmaZ m *ᵥ basisVec (configBasisIso M μ) =
      (((μ m : ℝ) : ℂ)) • basisVec (configBasisIso M μ) := by
  rw [sigmaZ_mulVec_basisVec, sgnC_configBasisIso]

end Ising2D
