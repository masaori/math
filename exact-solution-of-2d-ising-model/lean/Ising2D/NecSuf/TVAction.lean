/-
# 必要十分版: exp 共役が 2 次元不変部分空間へ「行列で」作用すること

対応する人手証明のラベル:

* **`<extract_taylor_coefficient_of_Z_Y>`**
  （`structured-latex/content/008_TV1_hatZ_hatY_part1.ts` の
  `TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`）
* **`<ホロノミック量子場_p142下段_1>`**（同 `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`）
* **`<T_V_hatZ_hatY>`**（同 `TV1_hatZ_hatY_018_claim_T_V_action`）

**具体版は `Ising2D/Part008/Claim012_TVActions.lean`**（`Mat(2,ℂ)^{⊗M}` の
`hat(Z)_μ^{(-)}, hat(Y)_μ` について人手証明と 1 対 1 に対応する形で述べ、本ファイルの系として導出する）。

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

## 何が本質的か

* 人手証明は `<nesting_of_commutator_of_H_and_Z>`（`TV1_hatZ_hatY_002`）で
  `n` 重の入れ子交換子を偶奇で場合分けして計算し、`<extract_taylor_coefficient_of_Z_Y>` で
  その係数を cosh / sinh のテイラー級数と突き合わせている。この 2 段は
  **「`ad X` が `span{z, y}` を保つ」という 1 つの仮定に集約できる**
  （`Ising2D/NecSuf/ExpConjugation.lean` の `exp_conj_two_dim_z` / `..._y`）。
  入れ子交換子の偶奇の場合分けは、そちらの `adCLM_pow_even` / `adCLM_pow_odd_*` に対応する。
* 本ファイルが足すのはその**行列としての読み替え**だけである。すなわち
  「`(T z, T y) = (z, y) B`」という原文の行ベクトル記法における `B` が
  `!![cosh s, β sinhc s; α sinhc s, cosh s]` であること（`twoDimConjMat`）。
* **共役するのが `g` でも `c g`（`c ∈ ℂ^×`）でも結果は変わらない**
  （`conj_smul_eq`）。原文が `V_2 = (2s_2)^{M/2} exp(i K_2^* H_2)` のスカラー因子を
  「共役で打ち消し合う」として落としているのはこれ 1 本で、
  ノルムも完備性も指数関数も要らない（任意の ℂ-代数で成り立つ）。
* 行列であることも、有限次元であることも、テンソル冪であることも効いていない。
  必要なのは「ℂ 上の完備ノルム環」だけである。
-/
import Ising2D.NecSuf.ExpConjugation
import Mathlib.LinearAlgebra.Matrix.Notation

namespace Ising2D.NecSuf

open NormedSpace

/-! ## スカラー因子は共役で打ち消える -/

section ScalarCancel

variable {𝔸 : Type*} [Ring 𝔸] [Algebra ℂ 𝔸]

/-- **原文 `ホロノミック量子場_p142下段_1` の「`(2s_2)^{M/2}` のスカラーは共役で打ち消し合う」**。

`g` の逆元が `ginv` のとき、`c g` の逆元は `c⁻¹ ginv` であり、共役の結果は `g` による共役に等しい。
ノルムも完備性も指数関数も使わない（任意の ℂ-代数で成り立つ）。 -/
theorem conj_smul_eq {c : ℂ} (hc : c ≠ 0) (g a ginv : 𝔸) :
    (c • g) * a * (c⁻¹ • ginv) = g * a * ginv := by
  rw [smul_mul_assoc, smul_mul_smul_comm, mul_inv_cancel₀ hc, one_smul]

end ScalarCancel

/-! ## 2 次元不変部分空間への作用行列 -/

/-- `ad x z = α y`, `ad x y = β z`, `s^2 = αβ` のときの、共役 `a ↦ exp(x) a exp(-x)` の
`(z, y)` に関する作用行列

  `!![cosh s, β sinhc s; α sinhc s, cosh s]`

（原文の行ベクトル記法 `(T z, T y) = (z, y) B` における `B`。**列**が `T z`, `T y` の係数）。 -/
noncomputable def twoDimConjMat (α β s : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![Complex.cosh s, β * sinhc s;
     α * sinhc s, Complex.cosh s]

@[simp] theorem twoDimConjMat_zero_zero (α β s : ℂ) :
    twoDimConjMat α β s 0 0 = Complex.cosh s := rfl

@[simp] theorem twoDimConjMat_zero_one (α β s : ℂ) :
    twoDimConjMat α β s 0 1 = β * sinhc s := rfl

@[simp] theorem twoDimConjMat_one_zero (α β s : ℂ) :
    twoDimConjMat α β s 1 0 = α * sinhc s := rfl

@[simp] theorem twoDimConjMat_one_one (α β s : ℂ) :
    twoDimConjMat α β s 1 1 = Complex.cosh s := rfl

section TwoDim

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {x z y : 𝔸} {α β s : ℂ}

/-- **必要十分版の本体**（人手証明 `<ホロノミック量子場_p142下段_1>`）:
`ad x` が `span{z, y}` を保つとき、共役 `a ↦ exp(x) a exp(-x)` は `(z, y)` に
`twoDimConjMat α β s` で作用する。

結論の 2 式は、原文の行ベクトル記法 `(T z, T y) = (z, y) B` を成分で書き下したものであり、
具体版（`Ising2D.ActsBy`）の定義そのものである。 -/
theorem exp_conj_two_dim_actsBy (hz : adCLM x z = α • y) (hy : adCLM x y = β • z)
    (hs : s ^ 2 = α * β) :
    exp x * z * exp (-x)
        = twoDimConjMat α β s 0 0 • z + twoDimConjMat α β s 1 0 • y ∧
      exp x * y * exp (-x)
        = twoDimConjMat α β s 0 1 • z + twoDimConjMat α β s 1 1 • y := by
  refine ⟨exp_conj_two_dim_z hz hy hs, ?_⟩
  rw [exp_conj_two_dim_y hz hy hs, add_comm]
  rfl

end TwoDim

end Ising2D.NecSuf
