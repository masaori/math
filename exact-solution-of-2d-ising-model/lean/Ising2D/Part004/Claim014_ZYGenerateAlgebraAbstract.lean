/-
# `<Z_Y_generate_algebra>` — 具体版を抽象版の特殊化として導出する

対応する人手証明:
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` (`<Z_Y_generate_algebra>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.Z_Y_generate_algebra`（`Claim014_ZYGenerateAlgebra.lean`） | `Mat(2, ℂ)^{⊗M}`、Pauli 行列、クロネッカー積 |
| **抽象版** | `Abstract.eq_top_of_basis_mem` / `Abstract.map_mem_of_update_mem` / `Abstract.string_mem`（`Abstract/GeneratedByBasis.lean`） | 可換半環上の代数、モノイド準同型、部分多元環 |

原文の Step と抽象版の対応:

| 原文 | 抽象版 | 特殊化で埋めるもの |
| --- | --- | --- |
| Step 2（文字列の帰納法） | `Abstract.string_mem` | `σ^x_m = -√-1 (P_{m-1} Y_m)(P_{m-1} Z_m)` |
| Step 3 前半（`{I, σ^x, σ^y, σ^z}` が張る） | **抽象化しない** | `Ising2D.matrix_two_decomp`（2×2 の成分比較そのもの） |
| Step 3 後半（単項テンソル） | `Abstract.map_mem_of_update_mem` | `siteProd` がモノイド準同型であること |
| Step 3 後半（基底で全体） | `Abstract.eq_top_of_basis_mem` | `matrixUnitBasis` が基底であること |

したがって原文の証明に本質的なのは、上表右列の 4 つだけである。
何が効いていなかったかは `lean/docs/abstract-zy-generate.md` にまとめた。

**既存の具体版（`Claim014_ZYGenerateAlgebra.lean`）はそのまま残してある。**
本ファイルは同じ主張を抽象版から導いた別経路である。
-/
import Ising2D.Abstract.GeneratedByBasis
import Ising2D.Part004.Claim014_ZYGenerateAlgebra

namespace Ising2D

variable {M : ℕ}

/-! ## `siteProd` をモノイド準同型として束ねる

抽象版 `Abstract.map_mem_of_update_mem` が要求するのは、多重線型性ではなく
**モノイド準同型であること**だけである。`siteProd_one` と `siteProd_mul` がそれを与える。 -/

/-- `siteProd M` を「サイトごとの族のモノイド」から `Mat(2, ℂ)^{⊗M}` へのモノイド準同型として見た形。 -/
noncomputable def siteProdHom (M : ℕ) :
    (Fin M → Matrix (Fin 2) (Fin 2) ℂ) →* TensorPow M where
  toFun x := siteProd M x
  map_one' := siteProd_one M
  map_mul' := siteProd_mul M

@[simp]
theorem siteProdHom_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProdHom M x = siteProd M x := rfl

/-! ## Step 3 後半（単項テンソル）を抽象版から導く -/

/-- **具体版 `siteProd_mem` を抽象版の特殊化として導出した形**。

`Abstract.map_mem_of_update_mem` に `P := siteProdHom M`, `T := A.toSubmonoid` を代入し、
`siteOp k B = siteProd M (update 1 k B)`（`siteOp_apply`、定義から `rfl`）で読み替えるだけ。 -/
theorem siteProd_mem_of_abstract (A : Subalgebra ℂ (TensorPow M))
    (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (h : ∀ k, siteOp k (x k) ∈ A) :
    siteProd M x ∈ A := by
  refine Abstract.map_mem_of_update_mem (siteProdHom M) A.toSubmonoid x fun k => ?_
  have hk := h k
  rw [siteOp_apply] at hk
  exact hk

/-! ## Step 2（Jordan–Wigner 文字列の帰納法）を抽象版から導く -/

/-- 抽象版 `Abstract.string_mem` に渡す生成元の族（`ℕ` 全体へ延長した `Y`）。 -/
noncomputable def YExt (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Y (⟨n, h⟩ : Fin M) else 1

/-- 抽象版 `Abstract.string_mem` に渡す生成元の族（`ℕ` 全体へ延長した `Z`）。 -/
noncomputable def ZExt (M : ℕ) (n : ℕ) : TensorPow M :=
  if h : n < M then Z (⟨n, h⟩ : Fin M) else 1

/-- 抽象版の仮定 `hstep` の中身:
`P_{m+1} = P_m · (-√-1) (P_m Y_m)(P_m Z_m)`。

原文 Step 2 の `σ^z_m = P_{m-1} Z_m`, `σ^y_m = P_{m-1} Y_m`,
`σ^x_m = -√-1 σ^y_m σ^z_m` を 1 本にまとめたもの。ここで初めて
`P_{m-1} P_{m-1} = I` と Pauli 行列の関係式が効く。 -/
theorem xString_succ_of_ZY (n : ℕ) (h : n < M) :
    xString M (n + 1)
      = xString M n * ((-Complex.I) •
          ((xString M n * YExt M n) * (xString M n * ZExt M n))) := by
  rw [xString_succ n h, sigmaX_eq, sigmaY_eq_xString_mul, sigmaZ_eq_xString_mul, YExt, ZExt,
    dif_pos h, dif_pos h]

/-- **具体版 `xString_mem_adjoin`（原文 Step 2）を抽象版の特殊化として導出した形**。

`Abstract.string_mem` に `p := xString M`, `y := YExt M`, `z := ZExt M`,
`c := -√-1` を代入する。 -/
theorem xString_mem_adjoin_of_abstract :
    ∀ n : ℕ, n ≤ M → xString M n ∈ Algebra.adjoin ℂ (ZYSet M) := by
  refine Abstract.string_mem _ M (xString M) (YExt M) (ZExt M) (fun _ => -Complex.I)
    xString_zero (fun n hn => ?_) (fun n hn => ?_) (fun n hn => xString_succ_of_ZY n hn)
  · rw [YExt, dif_pos hn]; exact Y_mem_adjoin _
  · rw [ZExt, dif_pos hn]; exact Z_mem_adjoin _

theorem sigmaZ_mem_adjoin_of_abstract (k : Fin M) :
    sigmaZ k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaZ_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin_of_abstract _ (le_of_lt k.isLt)) (Z_mem_adjoin k)

theorem sigmaY_mem_adjoin_of_abstract (k : Fin M) :
    sigmaY k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaY_eq_xString_mul]
  exact mul_mem (xString_mem_adjoin_of_abstract _ (le_of_lt k.isLt)) (Y_mem_adjoin k)

theorem sigmaX_mem_adjoin_of_abstract (k : Fin M) :
    sigmaX k ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [sigmaX_eq]
  exact Subalgebra.smul_mem _
    (mul_mem (sigmaY_mem_adjoin_of_abstract k) (sigmaZ_mem_adjoin_of_abstract k)) _

/-- 原文 Step 3 前半（`siteOp_decomp`）は 2×2 複素行列の成分比較そのもので抽象化しない。
ここではそれを Step 2 の結果に載せるだけ。 -/
theorem siteOp_mem_adjoin_of_abstract (k : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k B ∈ Algebra.adjoin ℂ (ZYSet M) := by
  rw [siteOp_decomp]
  exact add_mem (add_mem (add_mem
    (Subalgebra.smul_mem _ (one_mem _) _)
    (Subalgebra.smul_mem _ (sigmaX_mem_adjoin_of_abstract k) _))
    (Subalgebra.smul_mem _ (sigmaY_mem_adjoin_of_abstract k) _))
    (Subalgebra.smul_mem _ (sigmaZ_mem_adjoin_of_abstract k) _)

/-! ## 結論 -/

/-- **`<Z_Y_generate_algebra>` を抽象版から導出した形**:
`{Z_1, …, Z_M, Y_1, …, Y_M}` が生成する ℂ-部分多元環は `Mat(2, ℂ)^{⊗M}` 全体である。

具体版 `Ising2D.Z_Y_generate_algebra` と同じ主張を、
`Abstract.string_mem`（Step 2）・`Abstract.map_mem_of_update_mem`（Step 3 後半の単項テンソル）・
`Abstract.eq_top_of_basis_mem`（Step 3 後半の基底の論法）の 3 つの抽象補題から得たもの。 -/
theorem Z_Y_generate_algebra_of_abstract (M : ℕ) : Algebra.adjoin ℂ (ZYSet M) = ⊤ := by
  refine Abstract.eq_top_of_basis_mem _ (matrixUnitBasis M) fun IJ => ?_
  rw [matrixUnitBasis_apply, E_eq_siteProd]
  exact siteProd_mem_of_abstract _ _ fun k => siteOp_mem_adjoin_of_abstract k _

end Ising2D
