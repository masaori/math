/-
# `exp(-A)exp(A) = I`（必要十分版）

具体版: `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfNegativeIsLeftInverse.lean`
（人手 `exp_of_negative_is_left_inverse`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfNegativeIsLeftInverseFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `neg_matrix_mul_self_apply`（`mat_mult` → 符号反転の定義 → `-x = (-1)x` → 積の可換律 → 積の結合律 → `(-1)x = -x` → 符号反転の定義 → `mat_mult`） | `neg_matrix_mul_self_apply'`（同じ並び。4 段目は `(-1)x = x(-1)`） |
| `neg_matrix_mul_self_comm` | `neg_matrix_mul_self_comm'` |
| `neg_matrix_add_self_apply`（和の定義 → 符号反転の定義 → `-x = (-1)x` → 左単位元 → 分配律 → `(-1)+1 = 0` の 4 段 → `0x = 0` → 零行列の定義） | `neg_matrix_add_self_apply'`（`(-1)+1 = 0` の 4 段は 1 段） |
| `neg_matrix_add_self` | `neg_matrix_add_self'` |
| `matrixExp_neg_mul_matrixExp`（指数の積公式 → `(-A)+A = O` → `exp(O) = I`） | `matrixExp_neg_mul_matrixExp'`（同じ並び） |

## 何が効いているか / 効いていないか

- **係数の積の可換律は効いていない。** 具体版の準備の第一の鎖の 4 段目は `ℂ` の積の可換律を `(-1)·A_{kj}` に当てるが、
  効いているのは「`-1` が全ての係数と可換であること」だけである。これは環なら必ず成り立つ
  （`(-1)x = -x = x(-1)`、`neg_one_mul`・`mul_neg_one`。`mul_neg_one` は左分配律から出る `x(-y) = -(xy)` と右単位元 `x1 = x` による）。
  準備の補題の係数は非可換な環 `R` でよい。
- 準備の 2 本の鎖（`neg_one_mul_comm'` から `neg_matrix_add_self'` まで）は係数を環 `R`（`Ring`）に取るだけで、
  ノルム・完備性・`ℚ` 上の代数・添字の `DecidableEq` は仮定しない。第一の鎖は行列の積の和のために添字の `Fintype` を取り、
  第二の鎖は添字に何も要らない。効いているのは、環の公理のうち積の結合律・左単位元・右分配律・`0x = 0`・`(-1)+1 = 0` と、
  符号反転が `-x = (-1)x` であること（人手の `multiply_by_minus_one` の定義。環では `neg_one_mul`）である。
  右単位元と左分配律は、上の `-1` の可換性（`neg_one_mul_comm'` の `mul_neg_one`）を通じて第一の鎖に効いている。
  `(-1)+1 = 0` は加法の逆元の公理（`neg_add_cancel`）である。加法の結合律・交換律は、行列の積の有限和（`Finset.sum`）が
  和を定めるために型として要るだけで、鎖の段には現れない。
- 指数の段に効いているのは、可換な 2 つの元の指数法則（`theorem_exp_product`）と `exp(O) = I`（`theorem_exp_zero`）だけである。
  この 2 つは mathlib の `Matrix.exp_add_of_commute`・`NormedSpace.exp_zero` を引き、具体版と同じ扱いにする。
  `Matrix.exp_add_of_commute` が係数に要求する完備なノルム環・`ℚ` 上の代数（級数が収束するための構造）は残す。
  これを外すと `exp` の級数が定義されない。
- **係数が `ℂ` であること、体であること、行列の添字が `Fin n` であることは効いていない。** 添字は任意の有限型でよい
  （有限性は行列の積の和と指数の級数のノルムに要る）。
-/
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D.NecSuf

open Matrix

section Preparation

variable {ι : Type*} {R : Type*} [Ring R]

/-- 環では `-1` は全ての元と可換である（具体版の積の可換律の段の代わり）。 -/
theorem neg_one_mul_comm' (x : R) : (-1) * x = x * (-1) := by
  rw [neg_one_mul, mul_neg_one]

/-- **`((-A)A)_{kl} = (A(-A))_{kl}`**（具体版 `neg_matrix_mul_self_apply`）。 -/
theorem neg_matrix_mul_self_apply' [Fintype ι] (A : Matrix ι ι R) (k l : ι) :
    ((-A) * A) k l = (A * (-A)) k l :=
  calc ((-A) * A) k l
      = ∑ j, (-A) k j * A j l := rfl                                            -- 行列の積の定義
    _ = ∑ j, (-A k j) * A j l := rfl                                            -- 符号反転の定義を各項へ
    _ = ∑ j, ((-1) * A k j) * A j l :=                                          -- `-x = (-1)x` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [neg_one_mul])
    _ = ∑ j, (A k j * (-1)) * A j l :=                                          -- `-1` は可換（各項へ）
        Finset.sum_congr rfl (fun j _ => by rw [neg_one_mul_comm'])
    _ = ∑ j, A k j * ((-1) * A j l) :=                                          -- 積の結合律を各項へ
        Finset.sum_congr rfl (fun j _ => mul_assoc _ _ _)
    _ = ∑ j, A k j * (-A j l) :=                                                -- `(-1)x = -x` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [neg_one_mul])
    _ = ∑ j, A k j * (-A) j l := rfl                                            -- 符号反転の定義を各項へ
    _ = (A * (-A)) k l := rfl                                                   -- 行列の積の定義

/-- **`(-A)A = A(-A)`**（具体版 `neg_matrix_mul_self_comm`）。 -/
theorem neg_matrix_mul_self_comm' [Fintype ι] (A : Matrix ι ι R) : (-A) * A = A * (-A) :=
  Matrix.ext (neg_matrix_mul_self_apply' A)   -- 全ての成分が一致する

/-- **`((-A)+A)_{kl} = O_{kl}`**（具体版 `neg_matrix_add_self_apply`）。 -/
theorem neg_matrix_add_self_apply' (A : Matrix ι ι R) (k l : ι) :
    ((-A) + A) k l = (0 : Matrix ι ι R) k l :=
  calc ((-A) + A) k l
      = (-A) k l + A k l := rfl                                                 -- 和の定義
    _ = (-A k l) + A k l := rfl                                                 -- 符号反転の定義
    _ = (-1) * A k l + A k l := by rw [neg_one_mul]                             -- `-x = (-1)x`
    _ = (-1) * A k l + 1 * A k l := by rw [one_mul]                             -- 左単位元
    _ = ((-1) + 1) * A k l := (add_mul _ _ _).symm                              -- 右分配律
    _ = 0 * A k l := by rw [neg_add_cancel]                                     -- `(-1)+1 = 0`
    _ = 0 := zero_mul _                                                         -- `0x = 0`
    _ = (0 : Matrix ι ι R) k l := rfl                                           -- 零行列の定義

/-- **`(-A)+A = O`**（具体版 `neg_matrix_add_self`）。 -/
theorem neg_matrix_add_self' (A : Matrix ι ι R) : (-A) + A = 0 :=
  Matrix.ext (neg_matrix_add_self_apply' A)   -- 全ての成分が一致する

end Preparation

section Exponential

/-! 指数の段だけが、級数を定義するための完備なノルム環・`ℚ` 上の代数（`Matrix.exp_add_of_commute` の仮定）と、
単位行列 `1` を作るための添字の `DecidableEq` を要る。 -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸]

/-- **`exp(-A)exp(A) = I`**（具体版 `matrixExp_neg_mul_matrixExp`）。 -/
theorem matrixExp_neg_mul_matrixExp' (A : Matrix ι ι 𝔸) :
    NormedSpace.exp (-A) * NormedSpace.exp A = 1 :=
  calc NormedSpace.exp (-A) * NormedSpace.exp A
      = NormedSpace.exp ((-A) + A) :=                                           -- 可換な 2 つの元の指数法則と `(-A)A = A(-A)`
        (Matrix.exp_add_of_commute (-A) A (neg_matrix_mul_self_comm' A)).symm
    _ = NormedSpace.exp (0 : Matrix ι ι 𝔸) := by rw [neg_matrix_add_self']     -- `(-A)+A = O`
    _ = 1 := NormedSpace.exp_zero                                               -- `exp(O) = I`

end Exponential

end Ising2D.NecSuf
