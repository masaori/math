/-
# 必要十分版: `ad X` の固有ベクトルは `exp` 共役の固有ベクトル

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: `action_of_T_check_Vprime_on_check_psi`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_006_claim_action_T_check_Vprime` の Step 3〜5。具体版は
`Ising2D/Part016/Claim006_ActionTCheckVprime.lean`）。

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明は Step 3（`X̌^n ψ̌^† = ψ̌^† (X̌ + γ I)^n` の帰納法）、Step 4（有限和の極限）、
Step 5（`exp` の積公式 `theorem_exp_product`）の 3 段を踏むが、
**これらに効いているのは `ad X` が 1 次元部分空間 `span{a}` を保つことだけ**である。

* 帰納法（Step 3）も、部分和の収束（Step 4）も、可換な元の指数法則（Step 5）も、
  すでに `Ising2D/NecSuf/ExpConjugation.lean` の
  `exp_conj_two_dim_z`（`ad X` が `span{z,y}` を保つ場合の閉じた形）に含まれている。
  **`z = y = a` と置くだけ**で本ファイルの主張が出る
  （`cosh γ + γ · sinhc γ = cosh γ + sinh γ = e^γ`）。
  すなわち原文の Step 3〜5 は、008 章ですでに形式化した「2 次元不変部分空間」の
  **1 次元への退化**にすぎず、新しい解析は何も要らない。
* 台は **ℂ 上の完備ノルム環**であればよい。行列であることも有限次元性も、
  `X̌` が `ψ̌` の 2 次形式であることも、`γ` が実数であることも効いていない。
-/
import Ising2D.NecSuf.ExpConjugation

namespace Ising2D.NecSuf

open NormedSpace

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]

/-- `cosh c + sinh c = exp c`（ℂ 上）。 -/
theorem cosh_add_sinh_eq_exp (c : ℂ) : Complex.cosh c + Complex.sinh c = Complex.exp c := by
  rw [Complex.cosh, Complex.sinh]
  ring

/-- **必要十分版の本体**: `ad x` が `a` を固有ベクトルに持てば、`exp` 共役も同じ固有ベクトルを持つ。

`[x, a] = c · a  ⟹  exp(x) a exp(-x) = e^c · a`。 -/
theorem exp_conj_of_ad_eigen {x a : 𝔸} {c : ℂ} (h : adCLM x a = c • a) :
    exp x * a * exp (-x) = Complex.exp c • a := by
  have hs : c ^ 2 = c * c := sq c
  have := exp_conj_two_dim_z (x := x) (z := a) (y := a) (α := c) (β := c) (s := c) h h hs
  rw [this, mul_sinhc, ← add_smul, cosh_add_sinh_eq_exp]

/-- 上を「交換子の式」の形（`x * a - a * x = c • a`）で述べた版。 -/
theorem exp_conj_of_lie_eigen {x a : 𝔸} {c : ℂ} (h : x * a - a * x = c • a) :
    exp x * a * exp (-x) = Complex.exp c • a :=
  exp_conj_of_ad_eigen (by simpa using h)

end Ising2D.NecSuf
