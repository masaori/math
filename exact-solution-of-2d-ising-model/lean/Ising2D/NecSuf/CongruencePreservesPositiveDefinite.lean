/-
# 左逆行列をもつ `B` による `B^*(AB)` は正定値（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimCongruencePreservesPositiveDefinite.lean`
（人手 `conjugate_bilinear_value_of_congruence`・`congruence_preserves_positive_definite`）。具体版をこのファイルの
特殊化として導くのは `.../ClaimCongruencePreservesPositiveDefiniteFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `conjugate_bilinear_value_of_congruence` の 14 段 | `conjBilin_congruence'`（同じ並びの 14 段） |
| `conjTranspose_conjTranspose_apply` の 6 段（成分 `(a,b)` で共役を 2 回） | `conjTranspose_conjTranspose_apply'` の 3 段（共役を 2 回取ると戻る `star_star` の 1 段に、具体版の 3〜6 段目が当たる） |
| `mulVec_zero_apply` の 5 段 | `mulVec_zero_apply'`（同じ並びの 5 段） |
| `congruence_isHermitian` の 5 段 | `congruence_isHermitian'`（同じ並びの 5 段） |
| `mulVec_ne_zero_of_left_inverse` の 5 段 | `mulVec_ne_zero_of_left_inverse'`（同じ並びの 5 段） |
| `congruence_preserves_positive_definite` の正値性の 2 段 | `congruence_preserves_pos'`（同じ 2 段） |

## 何が効いているか / 効いていないか

- **正値性の段（`x ≠ 0` なら `x^*(B^*(AB))x` が正）に効いているのは、`(Bx)^*A(Bx)` と値が同じであること
  （`conjugate_bilinear_value_of_congruence`）と、`B'B = I` から `Bx ≠ 0` が出ることだけである。** 「正である」の中身は
  使わないので、任意の述語 `P : R → Prop` について「零でない全ての `x` で `P(x^*Ax)`」が「零でない全ての `x` で
  `P(x^*(B^*(AB))x)`」に移る形で述べる。係数の順序、`ℝ`、包含 `(·)_ℂ` は効いていない。**`A` のエルミート性も正値性の段には
  効いていない**（エルミート性の段にだけ効く）。
- `x^*(B^*(AB))y = (Bx)^*A(By)` の鎖に効いているのは、係数の可換半環の公理（分配律・積の結合律と可換律・和の順序の入れ替え）と、
  共役が積と和を保つこと（`star_mul'`・`star_sum`。`StarRing`）だけである。積の可換律は鎖の 8 行目（`\overline{x_k}` と
  `\overline{B_{jk}}` の入れ替え）と 11 行目（`\overline{B_{jk}x_k} = \overline{B_{jk}}\,\overline{x_k}`）で使う。
  可換でない係数では `\overline{B_{jk}x_k} = \overline{x_k}\,\overline{B_{jk}}` となり、8 行目を飛ばす別の手順で同じ等式が出るが、
  それは具体版と別の論法なのでここでは採らない（`CommSemiring` を外すと、この手順の 8 行目と 11 行目が通らない）。
  符号反転・逆元は使わないので、環でなく半環でよい。
- `B'B = I` から `Bx ≠ 0` に効いているのは、係数の半環の公理（積の結合律、`1` が単位元、`0` が積を零にする）だけである。
  共役も可換律も使わない。そのうち準備の `B'0 = 0`（`mulVec_zero_apply'`）に効いているのは `0` が積を零にすることと零の和だけで、
  積の結合律も単位元も効かない（`NonUnitalNonAssocSemiring`）。
- エルミート性の段に効いているのは、共役転置が積の順を逆にすること（`Matrix.conjTranspose_mul`、`StarRing`）と、共役を 2 回取ると
  戻ること（`star_star`）と、行列の積の結合律だけである。係数の積の可換律も単位元も使わない（`NonUnitalSemiring`）。
  準備の `(B^*)^* = B`（`conjTranspose_conjTranspose_apply'`）に効いているのは共役の対合性だけで、係数の演算は効かない（`InvolutiveStar`）。
- 添字は `Fin n` でなくてよい。有限で（和のため）、等号が決定可能（単位行列 `1` のため）なら何でもよい。
-/
import Ising2D.NecSuf.TraceOfPositiveDefinite
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference
import Mathlib.LinearAlgebra.Matrix.ConjTranspose

namespace Ising2D.NecSuf

open Matrix

variable {ι : Type*}

section Bilinear

variable {R : Type*} [CommSemiring R] [StarRing R]

/-- **`x^*(B^*(AB))y = (Bx)^*A(By)`**（具体版 `conjugate_bilinear_value_of_congruence`。14 段の並びは同じ）。 -/
theorem conjBilin_congruence' [Fintype ι] (A B : Matrix ι ι R) (x y : ι → R) :
    conjBilin' x (Bᴴ * (A * B)) y = conjBilin' (B *ᵥ x) A (B *ᵥ y) :=
  calc conjBilin' x (Bᴴ * (A * B)) y
      = ∑ k, ∑ l, (star (x k) * (Bᴴ * (A * B)) k l) * y l := rfl                -- `x^*Ay` の式
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, Bᴴ k j * (A * B) j l) * y l := rfl         -- 行列の積の定義
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, star (B j k) * (A * B) j l) * y l := rfl   -- 共役転置の定義を各項へ
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, star (B j k) * ∑ m, A j m * B m l) * y l := rfl -- 行列の積の定義を各項へ
    _ = ∑ k, ∑ l, ∑ j, ∑ m, (star (x k) * (star (B j k) * (A j m * B m l))) * y l := by
        simp only [Finset.mul_sum, Finset.sum_mul]                                -- 分配律
    _ = ∑ k, ∑ l, ∑ j, ∑ m, star (x k) * star (B j k) * A j m * B m l * y l := by
        simp only [← mul_assoc]                                                   -- 積の結合律を各項へ
    _ = ∑ j, ∑ m, ∑ k, ∑ l, star (x k) * star (B j k) * A j m * B m l * y l := by
        refine (Finset.sum_congr rfl fun _ _ => Finset.sum_comm).trans ?_          -- 和の順序の入れ替え
        refine (Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_comm).trans ?_
        refine Finset.sum_comm.trans ?_
        exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ j, ∑ m, ∑ k, ∑ l, star (B j k) * star (x k) * A j m * B m l * y l := by
        simp only [mul_comm (star (x _)) (star (B _ _))]                          -- 積の可換律を各項へ
    _ = ∑ j, ∑ m, ∑ k, ∑ l, (star (B j k) * star (x k) * A j m) * (B m l * y l) := by
        simp only [mul_assoc (star (B _ _) * star (x _) * A _ _)]                 -- 積の結合律を各項へ
    _ = ∑ j, ∑ m, (∑ k, star (B j k) * star (x k)) * A j m * (∑ l, B m l * y l) := by
        refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun m _ => ?_ -- 分配律
        rw [Finset.sum_mul, Finset.sum_mul_sum]
    _ = ∑ j, ∑ m, (∑ k, star (B j k * x k)) * A j m * (∑ l, B m l * y l) := by
        simp only [star_mul']                                                     -- 共役は積を保つ（可換）
    _ = ∑ j, ∑ m, star (∑ k, B j k * x k) * A j m * (∑ l, B m l * y l) := by
        simp only [star_sum]                                                      -- 共役は和を保つ
    _ = ∑ j, ∑ m, star ((B *ᵥ x) j) * A j m * (B *ᵥ y) m := rfl                  -- 行列と数ベクトルの積の定義
    _ = conjBilin' (B *ᵥ x) A (B *ᵥ y) := rfl                                     -- `x^*Ay` の式

end Bilinear

section Semiring

/-- `(B'0)_k = 0_k`（具体版 `mulVec_zero_apply`。5 段の並びは同じ。共役を使わない）。 -/
theorem mulVec_zero_apply' {R : Type*} [NonUnitalNonAssocSemiring R] [Fintype ι] (B' : Matrix ι ι R) (k : ι) :
    (B' *ᵥ (0 : ι → R)) k = (0 : ι → R) k :=
  calc (B' *ᵥ (0 : ι → R)) k
      = ∑ j, B' k j * (0 : ι → R) j := rfl                                        -- 行列と数ベクトルの積の定義
    _ = ∑ j, B' k j * (0 : R) := rfl                                              -- 零ベクトルの成分を各項へ
    _ = ∑ _j : ι, (0 : R) := by simp only [mul_zero]                             -- `0` は積を零にする
    _ = 0 := Finset.sum_const_zero                                                -- 零の有限和
    _ = (0 : ι → R) k := rfl                                                      -- 零ベクトルの成分

/-- `B'B = I`、`x ≠ 0` なら `Bx ≠ 0`（具体版 `mulVec_ne_zero_of_left_inverse`。5 段の並びは同じ）。 -/
theorem mulVec_ne_zero_of_left_inverse' {R : Type*} [Semiring R] [Fintype ι] [DecidableEq ι] {B B' : Matrix ι ι R} (hB : B' * B = 1)
    {x : ι → R} (hx : x ≠ 0) : B *ᵥ x ≠ 0 := by
  intro hBx
  apply hx
  calc x
      = (1 : Matrix ι ι R) *ᵥ x := (one_mulVec_eq x).symm                          -- 左単位元
    _ = (B' * B) *ᵥ x := by rw [hB]                                               -- `B'B = I`
    _ = B' *ᵥ (B *ᵥ x) := (Matrix.mulVec_mulVec _ _ _).symm                       -- 積の結合律
    _ = B' *ᵥ 0 := by rw [hBx]                                                    -- `Bx = 0` の仮定
    _ = 0 := funext (mulVec_zero_apply' B')                                       -- `B'0 = 0`

end Semiring

section Hermitian

/-- `((B^*)^*)_{kl} = B_{kl}`（具体版 `conjTranspose_conjTranspose_apply`。具体版の 3〜6 段目（成分 `(a,b)` で
共役を 2 回取ると戻る）が、ここでは共役の対合性 `star_star` の 1 段に当たる）。 -/
theorem conjTranspose_conjTranspose_apply' {R : Type*} [InvolutiveStar R] (B : Matrix ι ι R) (k l : ι) : Bᴴᴴ k l = B k l :=
  calc Bᴴᴴ k l
      = star (Bᴴ l k) := rfl                                                      -- 共役転置の定義
    _ = star (star (B k l)) := rfl                                                -- 共役転置の定義
    _ = B k l := star_star _                                                      -- 共役を 2 回取ると戻る

/-- `(B^*(AB))^* = B^*(AB)`（具体版 `congruence_isHermitian`。5 段の並びは同じ）。 -/
theorem congruence_isHermitian' {R : Type*} [NonUnitalSemiring R] [StarRing R] [Fintype ι] {A : Matrix ι ι R} (hA : Aᴴ = A) (B : Matrix ι ι R) :
    (Bᴴ * (A * B))ᴴ = Bᴴ * (A * B) :=
  calc (Bᴴ * (A * B))ᴴ
      = (A * B)ᴴ * Bᴴᴴ := Matrix.conjTranspose_mul _ _                           -- 共役転置は積の順を逆にする
    _ = (Bᴴ * Aᴴ) * Bᴴᴴ := by rw [Matrix.conjTranspose_mul A B]                 -- 共役転置は積の順を逆にする
    _ = (Bᴴ * A) * Bᴴᴴ := by rw [hA]                                             -- `A^* = A`
    _ = (Bᴴ * A) * B := by rw [Matrix.ext (conjTranspose_conjTranspose_apply' B)] -- `(B^*)^* = B`
    _ = Bᴴ * (A * B) := Matrix.mul_assoc _ _ _                                    -- 積の結合律

end Hermitian

section Positive

variable {R : Type*} [CommSemiring R] [StarRing R]

/-- **正値性の段**（具体版 `congruence_preserves_positive_definite` の正値性。2 段の並びは同じ）:
`B'B = I` のもとで、零でない全ての `x` について `x^*Ax` が述語 `P` を満たすなら、`x^*(B^*(AB))x` も `P` を満たす。 -/
theorem congruence_preserves_pos' [Fintype ι] [DecidableEq ι] (P : R → Prop) {A B B' : Matrix ι ι R} (hB : B' * B = 1)
    (hA : ∀ x : ι → R, x ≠ 0 → P (conjBilin' x A x)) (x : ι → R) (hx : x ≠ 0) :
    P (conjBilin' x (Bᴴ * (A * B)) x) := by
  rw [conjBilin_congruence' A B x x]                                             -- `x^*(B^*(AB))x = (Bx)^*A(Bx)`（`y = x`）
  exact hA (B *ᵥ x) (mulVec_ne_zero_of_left_inverse' hB hx)                      -- `Bx ≠ 0` と `A` の正値性

end Positive

end Ising2D.NecSuf
