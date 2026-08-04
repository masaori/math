/-
# Cauchy–Binet の公式

## なぜこのファイルがあるか

`docs/external-theorem-criterion.md` の基準で「自分で証明する」に振り分けた外部定理の 1 つ。
matrix-tree 定理（全域木を数える定理）を書くための 2 段目であり、mathlib に無い
（cycle 31 step 1 の実測。`lean/logs/mathlib-gap-survey-cycle31-external.log`。
`CauchyBinet` / 語幹 `cauchy binet` が 3 段とも 0 件）。

## 何を証明するか

`A : Matrix m n R`、`B : Matrix n m R` について

* 第 1 段（`det_mul_eq_sum_over_maps`）
  `(A * B).det = ∑ f : m → n, (A.submatrix id f).det * ∏ i, B (f i) i`
* 第 2 段（`det_submatrix_eq_zero_of_not_injective`）
  `f` が単射でなければ `(A.submatrix id f).det = 0`
* 第 3 段（`det_mul_eq_sum_over_injective`）
  したがって和は単射な `f` だけを走る。

## 抽象度について

`docs/context/証明の書き方.md` の規律に従い、**可換環の上でそのまま述べる**。
体も整域も要らない（実際に使うのは分配則と行列式の交代性だけである）。
matrix-tree で使うのは `R = ℤ`、`B = Aᵀ` の場合だが、
その特殊化のために仮定を強める理由が無いので一般の可換環で書く。

## 限界（正直に書く）

**これは Cauchy–Binet の完成形ではない。** 完成形は和を
「`n` の `m` 元部分集合」で書いた形であり、そこへ至るには単射な `f` を像で束ねる段が要る。
本ファイルはその手前まで、すなわち**「和が単射な `f` だけを走る」ところまで**である。
残りの段は `outputs/reports/cycle31_ops_cauchy_binet.md` に書いた。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace IntegrableLattice

open Matrix Finset Equiv Equiv.Perm

variable {R : Type*} [CommRing R]
variable {m n : Type*} [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

-- `n` 上の等号判定は使わない（行列式の展開は `m` の置換だけを走る）。
omit [DecidableEq n] in
/--
**第 1 段: 行の多重線型性による展開。**

`(A * B) i j = ∑ k, A i k * B k j` を行列式の定義へ入れ、積と和を入れ替える。
`f : m → n` は「各行 `i` でどの `k` を選んだか」を表す。

人手証明の対応:
`det (A*B) = ∑_σ ε σ ∏_i (A*B) (σ i) i` （行列式の定義）
`= ∑_σ ε σ ∏_i (∑_k A (σ i) k * B k i)` （積の定義）
`= ∑_σ ε σ ∑_f ∏_i A (σ i) (f i) * B (f i) i` （積と和の入れ替え）
`= ∑_f (∑_σ ε σ ∏_i A (σ i) (f i)) * ∏_i B (f i) i` （和の順序交換と括り出し）
`= ∑_f det (A.submatrix id f) * ∏_i B (f i) i` （行列式の定義を逆向きに）
-/
theorem det_mul_eq_sum_over_maps (A : Matrix m n R) (B : Matrix n m R) :
    (A * B).det = ∑ f : m → n, (A.submatrix id f).det * ∏ i, B (f i) i := by
  -- 行列式の定義へ落とす。
  simp only [det_apply', Matrix.mul_apply, submatrix_apply, id_eq]
  -- 左辺: ∑_σ ε σ * ∏_i (∑_k A (σ i) k * B k i)
  -- 右辺: ∑_f (∑_σ ε σ * ∏_i A (σ i) (f i)) * ∏_i B (f i) i
  -- 左辺の内側の積を、積と和の入れ替えで f についての和にする。
  have expand : ∀ σ : Perm m,
      (∏ i, ∑ k : n, A (σ i) k * B k i)
        = ∑ f : m → n, ∏ i, A (σ i) (f i) * B (f i) i := by
    intro σ
    rw [Finset.prod_univ_sum]
    exact Finset.sum_congr (by simp) fun f _ => rfl
  simp only [expand]
  -- 各 σ の項で、符号を f についての和の中へ入れる。
  simp only [Finset.mul_sum]
  -- 和の順序を入れ替え、f を外側にする。
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun f _ => ?_
  -- f を固定したとき、σ についての和から ∏_i B (f i) i を括り出す。
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun σ _ => ?_
  rw [Finset.prod_mul_distrib]
  ring

-- `n` の有限性も等号判定も使わない（見るのは `m` 側の 2 つの列だけである）。
omit [Fintype n] [DecidableEq n] in
/--
**第 2 段: 単射でない `f` の寄与は消える。**

`f i₁ = f i₂`（`i₁ ≠ i₂`）なら `A.submatrix id f` の第 `i₁` 列と第 `i₂` 列が等しいので、
行列式の交代性から `0` になる。
-/
theorem det_submatrix_eq_zero_of_not_injective (A : Matrix m n R) {f : m → n}
    (hf : ¬Function.Injective f) : (A.submatrix id f).det = 0 := by
  -- 単射でないので、値が一致する相異なる 2 点が取れる。
  rw [Function.not_injective_iff] at hf
  obtain ⟨i₁, i₂, hval, hne⟩ := hf
  -- その 2 列が一致する。
  refine det_zero_of_column_eq hne fun k => ?_
  simp [submatrix_apply, hval]

/--
**第 3 段: 和は単射な `f` だけを走る。**

第 1 段と第 2 段を合わせたもの。Cauchy–Binet の完成形（`n` の `m` 元部分集合についての和）
へ進むには、ここから単射な `f` を像で束ねる段が要る。**その段は書いていない。**
-/
theorem det_mul_eq_sum_over_injective (A : Matrix m n R) (B : Matrix n m R) :
    (A * B).det
      = ∑ f ∈ Finset.univ.filter (fun f : m → n => Function.Injective f),
          (A.submatrix id f).det * ∏ i, B (f i) i := by
  rw [det_mul_eq_sum_over_maps A B]
  refine (Finset.sum_subset (Finset.filter_subset _ _) ?_).symm
  intro f _ hf
  -- 除外されたのは単射でない f であり、その項は第 2 段で 0 である。
  rw [Finset.mem_filter] at hf
  rw [det_submatrix_eq_zero_of_not_injective A (fun h => hf ⟨Finset.mem_univ f, h⟩), zero_mul]

/--
**第 3 段の系: 行の数が列の数を超えるなら行列式は `0`。**

単射 `m → n` が存在しないので、第 3 段の和が空になる。
matrix-tree で「小行列式を取る範囲」を決めるときに使う形である。
-/
theorem det_mul_eq_zero_of_card_lt (A : Matrix m n R) (B : Matrix n m R)
    (h : Fintype.card n < Fintype.card m) : (A * B).det = 0 := by
  rw [det_mul_eq_sum_over_injective A B]
  refine Finset.sum_eq_zero fun f hf => ?_
  rw [Finset.mem_filter] at hf
  exact absurd (Fintype.card_le_of_injective f hf.2) (not_le.mpr h)

end IntegrableLattice
