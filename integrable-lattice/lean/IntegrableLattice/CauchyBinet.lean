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
* 第 4 段（`det_mul_eq_sum_over_subsets`）
  単射な `f` を像で束ねて、`n` の `k` 元部分集合についての和にする。これが完成形である。

第 4 段だけは `m = Fin k` とし、`n` に線形順序を仮定する。
部分集合から代表を一つ選ぶのに「小さい順に並べる」以外の手が無いためであり、
主張の内容が順序を要求しているわけではない（どの順序で並べても両辺は変わらない）。

## 抽象度について

`docs/context/証明の書き方.md` の規律に従い、**可換環の上でそのまま述べる**。
体も整域も要らない（実際に使うのは分配則と行列式の交代性だけである）。
matrix-tree で使うのは `R = ℤ`、`B = Aᵀ` の場合だが、
その特殊化のために仮定を強める理由が無いので一般の可換環で書く。

## 第 4 段の中身（mathlib に無かったところ）

**単射な `f : Fin k → n` は、順序を保つ埋め込みと置換の合成に一意に分かれる。**
すなわち `f = (s.orderEmbOfFin h) ∘ σ`（`s` は `f` の像、`σ` は `Fin k` の置換）である。
この同値そのものが mathlib に無いので、本ファイルで二つに分けて書いた
（`orderEmbOfFin_comp_injOn` が一意性、`exists_orderEmbOfFin_comp` が存在）。
材料の `Finset.orderEmbOfFin` と `Finset.range_orderEmbOfFin` は mathlib に在る。
-/
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Finset.Sort

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

/-!
## 第 4 段: 単射な写像を像で束ねる

ここからは `m = Fin k` とし、`n` に線形順序を仮定する（部分集合から代表を選ぶため）。
-/

section Subsets

variable {k : ℕ} [LinearOrder n]

-- `n` の有限性も等号判定も使わない（見るのは像と埋め込みの単射性だけである）。
omit [Fintype n] [DecidableEq n] in
/--
**第 4 段の素材（一意性）: 順序を保つ埋め込みと置換への分解は一意である。**

`s.orderEmbOfFin` の像はちょうど `s` なので、合成写像の像から `s` が読み取れる。
`s` が決まれば `orderEmbOfFin` は単射なので `σ` も決まる。
-/
theorem orderEmbOfFin_comp_injOn {s t : Finset n} {hs : s.card = k} {ht : t.card = k}
    {σ τ : Equiv.Perm (Fin k)}
    (h : (fun i => s.orderEmbOfFin hs (σ i)) = fun i => t.orderEmbOfFin ht (τ i)) :
    s = t ∧ σ = τ := by
  -- 合成写像の像は `s` である（`σ` は全射なので像を変えない）。
  have himg : ∀ (u : Finset n) (hu : u.card = k) (π : Equiv.Perm (Fin k)),
      Set.range (fun i => u.orderEmbOfFin hu (π i)) = (u : Set n) := by
    intro u hu π
    rw [show (fun i => u.orderEmbOfFin hu (π i)) = (u.orderEmbOfFin hu) ∘ π from rfl,
      Set.range_comp, π.surjective.range_eq, Set.image_univ, u.range_orderEmbOfFin hu]
  have hst : s = t := by
    have := himg s hs σ
    rw [h, himg t ht τ] at this
    exact Finset.coe_injective this.symm
  subst hst
  refine ⟨rfl, Equiv.ext fun i => ?_⟩
  -- `s` が同じなら `orderEmbOfFin` は単射なので置換も一致する。
  exact (s.orderEmbOfFin hs).injective (congrFun h i)

-- `n` の有限性は使わない（像を取るのに `Fin k` 側の有限性しか要らない）。
omit [Fintype n] in
/--
**第 4 段の素材（存在）: 単射な写像はこの形に書ける。**

像 `s` を取ると `s.card = k` であり、`s.orderEmbOfFin` の像がちょうど `s` なので、
各 `i` について `f i` を与える `Fin k` の元が取れる。その対応は単射なので置換である。
-/
theorem exists_orderEmbOfFin_comp {f : Fin k → n} (hf : Function.Injective f) :
    ∃ (s : Finset n) (hs : s.card = k) (σ : Equiv.Perm (Fin k)),
      (fun i => s.orderEmbOfFin hs (σ i)) = f := by
  classical
  -- 像を取る。単射なので位数はちょうど `k` である。
  have hs : (Finset.image f Finset.univ).card = k := by
    rw [Finset.card_image_of_injective _ hf, Finset.card_univ, Fintype.card_fin]
  -- `orderEmbOfFin` の像はちょうど像なので、各 `i` について添字が取れる。
  have hmem : ∀ i, f i ∈ Set.range ((Finset.image f Finset.univ).orderEmbOfFin hs) := by
    intro i
    rw [Finset.range_orderEmbOfFin]
    exact Finset.mem_coe.mpr (Finset.mem_image_of_mem f (Finset.mem_univ i))
  choose g hg using hmem
  -- その対応は単射（`f` が単射だから）なので、有限集合上では置換になる。
  have hginj : Function.Injective g := by
    intro i j hij
    apply hf
    rw [← hg i, ← hg j, hij]
  exact ⟨Finset.image f Finset.univ, hs,
    Equiv.ofBijective g (Finite.injective_iff_bijective.mp hginj), funext hg⟩

/--
**第 4 段（Cauchy–Binet の完成形）: 和を `n` の `k` 元部分集合で書く。**

`(A B).\det = \sum_{s} \det(A_{\cdot s})\det(B_{s\cdot})`（`s` は `n` の `k` 元部分集合）。

人手証明の対応:
第 3 段で和は単射な `f` だけを走る。単射な `f` は像 `s` と置換 `σ` の対に一意に対応し
（`orderEmbOfFin_comp_injOn` / `exists_orderEmbOfFin_comp`）、
`f = e_s ∘ σ` のとき `det (A.submatrix id f) = sign σ * det (A.submatrix id e_s)` である
（列の入れ替えは行列式の符号を変える）。`σ` について足すと
`∑_σ sign σ ∏_i B (e_s (σ i)) i = det (B.submatrix e_s id)` になる（行列式の定義）。
-/
theorem det_mul_eq_sum_over_subsets (A : Matrix (Fin k) n R) (B : Matrix n (Fin k) R) :
    (A * B).det = ∑ s : {s : Finset n // s.card = k},
      (A.submatrix id (s.1.orderEmbOfFin s.2)).det
        * (B.submatrix (s.1.orderEmbOfFin s.2) id).det := by
  classical
  -- 各部分集合の項を、置換についての和へ開く。
  have key : ∀ s : {s : Finset n // s.card = k},
      (A.submatrix id (s.1.orderEmbOfFin s.2)).det
          * (B.submatrix (s.1.orderEmbOfFin s.2) id).det
        = ∑ σ : Equiv.Perm (Fin k),
            (A.submatrix id fun i => s.1.orderEmbOfFin s.2 (σ i)).det
              * ∏ i, B (s.1.orderEmbOfFin s.2 (σ i)) i := by
    intro s
    rw [det_apply' (B.submatrix (s.1.orderEmbOfFin s.2) id), Finset.mul_sum]
    refine Finset.sum_congr rfl fun σ _ => ?_
    -- 列を `σ` で入れ替えた小行列の行列式は、符号だけ変わる。
    have hsub : (A.submatrix id fun i => s.1.orderEmbOfFin s.2 (σ i))
        = (A.submatrix id (s.1.orderEmbOfFin s.2)).submatrix id σ := rfl
    rw [hsub, det_permute']
    simp only [submatrix_apply, id_eq]
    ring
  calc (A * B).det
      = ∑ f ∈ Finset.univ.filter (fun f : Fin k → n => Function.Injective f),
          (A.submatrix id f).det * ∏ i, B (f i) i := det_mul_eq_sum_over_injective A B
    -- 単射な `f` の和と、（部分集合, 置換）の対の和を突き合わせる。
    _ = ∑ p : {s : Finset n // s.card = k} × Equiv.Perm (Fin k),
          (A.submatrix id fun i => p.1.1.orderEmbOfFin p.1.2 (p.2 i)).det
            * ∏ i, B (p.1.1.orderEmbOfFin p.1.2 (p.2 i)) i := by
        refine (Finset.sum_bij
          (fun p _ => (fun i => p.1.1.orderEmbOfFin p.1.2 (p.2 i) : Fin k → n)) ?_ ?_ ?_ ?_).symm
        · -- 合成は単射である。
          intro p _
          exact Finset.mem_filter.mpr ⟨Finset.mem_univ _,
            (p.1.1.orderEmbOfFin p.1.2).injective.comp p.2.injective⟩
        · -- 分解は一意である。
          intro p₁ _ p₂ _ h
          obtain ⟨hset, hperm⟩ := orderEmbOfFin_comp_injOn h
          exact Prod.ext (Subtype.ext hset) hperm
        · -- 単射な `f` はすべてこの形に書ける。
          intro f hf
          rw [Finset.mem_filter] at hf
          obtain ⟨s, hs, σ, hcomp⟩ := exists_orderEmbOfFin_comp hf.2
          exact ⟨(⟨s, hs⟩, σ), Finset.mem_univ _, hcomp⟩
        · intro p _
          rfl
    _ = ∑ s : {s : Finset n // s.card = k}, ∑ σ : Equiv.Perm (Fin k),
          (A.submatrix id fun i => s.1.orderEmbOfFin s.2 (σ i)).det
            * ∏ i, B (s.1.orderEmbOfFin s.2 (σ i)) i := Fintype.sum_prod_type _
    _ = _ := Finset.sum_congr rfl fun s _ => (key s).symm

end Subsets

end IntegrableLattice
