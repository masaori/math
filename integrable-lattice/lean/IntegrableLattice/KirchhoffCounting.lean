/-
# Kirchhoff の右辺が「数え上げ」であること — cycle 33 step 3

対応する人手証明: Kirchhoff の matrix-tree 定理（外部定理。台帳は
`structured-latex/tools/external-theorem-coverage.ts`）。

## この file が埋める穴

cycle 32 step 3 は符号付き接続行列の**全単模性**を証明し（`IncidenceUnimodular.lean`）、
report にこう書いていた——

> Cauchy–Binet を当てると $\det L_0=\sum_S\det(D_S)^2$ になり、全単模性を入れると各項が $0$ か $1$ になる。
> つまり全単模性だけで「Kirchhoff の右辺が数え上げである」ことが確定する。

**ただし、そう書いただけで主張としては書いていなかった。** 同じ report の「限界」にそう明記してある——

> 全単模性と「接続行列がその形をしている」を繋いで「$D$ の小行列式が $0,\pm1$」の形にした主張は書いていない。

この file がその繋ぎを書く。使うのは既に在る 2 つだけである:

* `CauchyBinet.det_mul_eq_sum_over_subsets`（cycle 31–32 で自前で証明した）
* `IncidenceUnimodular.det_eq_zero_or_one_or_neg_one_of_incidenceColumns`（cycle 32 step 3）

## 何が言えて、何が残るか（射程を先に書く）

言えるのは **$\det L_0$ が「ある性質をもつ辺集合の個数」に等しいこと**である。
その性質は「行を 1 つ落とした接続行列の、その辺集合に対応する小行列式が $0$ でないこと」であり、
**それが「全域木であること」と同値だという組合せの主張は、この file では証明していない。**
そこが matrix-tree の残りである。

したがって matrix-tree 定理そのものは**まだ完了していない**。この file が完了させるのは
「右辺が数え上げの形をしている」という段だけである。

## 形式化しなかったもの

* **小行列式が $0$ でないことと「全域木であること」の同値**。これが残りの本体で、
  グラフの連結性と閉路を型に用意することになる。この file では書いていない。
* **指標分解**（塔の各レベルへ分ける段）。これも別である。
-/
import Mathlib
import IntegrableLattice.CauchyBinet
import IntegrableLattice.IncidenceUnimodular
import IntegrableLattice.MultigraphLaplacian

namespace IntegrableLattice
namespace KirchhoffCounting

open Finset Matrix

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E] [LinearOrder E]

/-! ## 段 1: 行を落とした接続行列の小行列式は `0, 1, -1` のいずれか -/

omit [Fintype E] [DecidableEq E] [LinearOrder E] in
/--
**行を落としても列の形は保たれるので、小行列式は $0,\pm1$ のいずれかである。**

`r : Fin k → V` は残す行（根を除いた頂点の並べ方）、`c : Fin k → E` は取り出す列（辺集合）である。
`r` が単射であることだけを使う（同じ行を 2 度取ると列の形が壊れるため）。
-/
theorem det_submatrix_incMatrixSigned_eq_zero_or_one_or_neg_one
    (s t : E → V) {k : ℕ} (r : Fin k → V) (hr : Function.Injective r) (c : Fin k → E) :
    ((incMatrixSigned s t).submatrix r c).det = 0 ∨
      ((incMatrixSigned s t).submatrix r c).det = 1 ∨
      ((incMatrixSigned s t).submatrix r c).det = -1 := by
  classical
  refine det_eq_zero_or_one_or_neg_one_of_incidenceColumns k _ fun j => ?_
  -- 第 `j` 列は、元の接続行列の第 `c j` 列を `r` で拾ったものである。
  have h := (isIncidenceColumn_incMatrixSigned (s := s) (t := t) (c j)).comp_injective r hr
  exact h

/-! ## 段 2: 小行列式の 2 乗は `0` か `1` -/

omit [Fintype E] [DecidableEq E] [LinearOrder E] in
/-- $0,\pm1$ を 2 乗すると $0$ か $1$ になる。**ここが「数え上げになる」ことの本体**である。 -/
theorem sq_det_submatrix_eq_zero_or_one
    (s t : E → V) {k : ℕ} (r : Fin k → V) (hr : Function.Injective r) (c : Fin k → E) :
    ((incMatrixSigned s t).submatrix r c).det * ((incMatrixSigned s t).submatrix r c).det = 0 ∨
      ((incMatrixSigned s t).submatrix r c).det *
          ((incMatrixSigned s t).submatrix r c).det = 1 := by
  rcases det_submatrix_incMatrixSigned_eq_zero_or_one_or_neg_one s t r hr c with h | h | h <;>
    rw [h] <;> norm_num

/-! ## 段 3: Cauchy–Binet を当てて、右辺を数え上げの形にする -/

/--
**$\det(D_0 D_0^{\mathsf T})$ は「小行列式が $0$ でない辺集合」の個数に等しい。**

`D₀ := (incMatrixSigned s t).submatrix r id` は、根を除いた頂点（`r` で並べた `k` 個）に
行を絞った接続行列である。人手証明の $\det L_0=\sum_S\det(D_S)^2$ に、
各項が $0$ か $1$ であること（段 2）を入れた形になっている。

**これが「Kirchhoff の右辺が数え上げである」ことの中身**であり、
その数え上げが全域木の個数だという同定は**この file では証明していない**（上の射程を見よ）。
-/
theorem det_mul_transpose_eq_card
    (s t : E → V) {k : ℕ} (r : Fin k → V) (hr : Function.Injective r) :
    ((incMatrixSigned s t).submatrix r id *
        ((incMatrixSigned s t).submatrix r id)ᵀ).det =
      ((Finset.univ : Finset {S : Finset E // S.card = k}).filter fun S =>
          ((incMatrixSigned s t).submatrix r (S.1.orderEmbOfFin S.2)).det ≠ 0).card := by
  classical
  set D := (incMatrixSigned s t).submatrix r id with hD
  -- Cauchy–Binet。転置の小行列式は元の小行列式に等しいので、各項が 2 乗になる。
  rw [det_mul_eq_sum_over_subsets D Dᵀ]
  have hterm : ∀ S : {S : Finset E // S.card = k},
      (D.submatrix id (S.1.orderEmbOfFin S.2)).det *
          (Dᵀ.submatrix (S.1.orderEmbOfFin S.2) id).det =
        if (D.submatrix id (S.1.orderEmbOfFin S.2)).det ≠ 0 then 1 else 0 := by
    intro S
    have htr : (Dᵀ.submatrix (S.1.orderEmbOfFin S.2) id).det
        = (D.submatrix id (S.1.orderEmbOfFin S.2)).det := by
      rw [← Matrix.det_transpose (D.submatrix id (S.1.orderEmbOfFin S.2))]
      rfl
    rw [htr]
    have hsq := sq_det_submatrix_eq_zero_or_one s t r hr (S.1.orderEmbOfFin S.2)
    have hsub : D.submatrix id (S.1.orderEmbOfFin S.2)
        = (incMatrixSigned s t).submatrix r (S.1.orderEmbOfFin S.2) := rfl
    rw [hsub]
    rcases hsq with h | h
    · rw [h]
      have hz : ((incMatrixSigned s t).submatrix r (S.1.orderEmbOfFin S.2)).det = 0 := by
        rcases det_submatrix_incMatrixSigned_eq_zero_or_one_or_neg_one s t r hr
          (S.1.orderEmbOfFin S.2) with h0 | h1 | h1
        · exact h0
        · rw [h1] at h; norm_num at h
        · rw [h1] at h; norm_num at h
      simp [hz]
    · rw [h]
      have hnz : ((incMatrixSigned s t).submatrix r (S.1.orderEmbOfFin S.2)).det ≠ 0 := by
        intro h0
        rw [h0] at h; norm_num at h
      simp [hnz]
  simp only [hterm]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const]
  simp [hD]

end KirchhoffCounting
end IntegrableLattice
