/-
# 1 次元開鎖のスピン和（必要十分版）

具体版: `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSums.lean`（人手 `open_chain_partition_sum`・
`open_chain_endpoint_product_sum` と 1 対 1）。具体版をこのファイルの系として導出するのは
`Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSumsFromNecSuf.lean`。

具体版と同じく、人手の `M_col` は Lean の `n + 2`、結合の添字 `m = 1,…,M_col-1` は `m : Fin (n + 1)`、
人手の `t_m(s)`・`Φ`・`ς` は具体版の `bondSpin`・`openChainPhiEquiv`・`varsigmaWordEquiv` である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `open_chain_partition_sum` の鎖の `人手 2`〜`人手 5`、`open_chain_endpoint_product_sum` の最後の鎖の `人手 2`〜`人手 5`（同じ並び） | `open_chain_weighted_sum_eq_sum_prod` の印 `人手 2`〜`人手 5` |
| `open_chain_partition_sum` の `人手 8`、`open_chain_endpoint_product_sum` の `人手 10`（`u` に依らない `c` の `{-1,1}` 上の和） | `sum_spinVal_const` |
| 上の二つと冪の行（`open_chain_partition_sum` の `人手 10`、`open_chain_endpoint_product_sum` の `人手 12`）を続けたもの | `open_chain_weighted_sum` |
| 二つの鎖の `人手 4` が引く `expansion_of_finite_product_of_two_term_sums_of_real_numbers` | `prod_add_eq_binWordSum'`（`finProdLeft_add_eq_binWordSum` を `Finset.prod` へ運んだもの） |
| `{-1,1}` 上の有限和 `sum_spinVal` | `sum_spinVal_addCommMonoid` |
| `open_chain_endpoint_product_sum` の Step 2 の `M_col = 2` の鎖（3 行） | `prod_mul_succ_of_two`（同じ 3 段） |
| 同 `M_col ≥ 3` の鎖（4 行）と、2 行目の「ℝ の乗法の可換性と結合性」 | `prod_mul_succ_of_ge_three`（同じ 4 段。1 段目の `t_m(s) := s(m)s(m+1)` は、ここでは左辺を読み直すだけの段）・`prod_mul_succ_rearrange`（同じ 5 段。`finite_product_of_real_products` の段は `finset_prod_mul_distrib'`） |
| 二つの鎖をまとめた `prod_bondSpin_eq_first_mul_last` | `prod_mul_succ_eq_first_mul_last` |

具体版の鎖のうち、重みに固有の行（`open_chain_partition_sum` の準備の鎖・`人手 1`・`人手 6`・`人手 7`・`人手 9`、
`open_chain_endpoint_product_sum` の `exp(KE(s))` の鎖・端点の積の鎖・`人手 1`・`人手 6`〜`人手 9`・`人手 11`）は、
重みを `g(t) = exp(Kt)`・`g(t) = t·exp(Kt)` に取ったときの読み替えなので、導出のファイルに置く。導出のファイルは、
具体版と同じ行の順で、`open_chain_weighted_sum_eq_sum_prod`・重みに固有の行・`sum_spinVal_const`・重みに固有の行・冪の行をつなぐ。

## 何が効いているか / 効いていないか

- **スピン和の本体（`open_chain_weighted_sum`）。** 効いているのは、Step 1 の二つの全単射 `Φ` と `ς` と、重みの値の側の
  次の構造だけである。
  - 加法の可換モノイド: `Φ`・`ς` による和の添字の付け替え（`Equiv.sum_comp`）と二重の和の読み替えは、足す順序を持たない
    `Finset.sum` の上で行う。`{0,1}^{M_col-1}` の上の和 `binWordSum` を `Finset.sum` で読む `binWordSum_eq_sum` もこれを使う。
  - 二つの分配律: `人手 4` の展開（`finProdLeft_add_eq_binWordSum` が仮定するのは `Distrib` だけ）と、`人手 8` の `c + c = 2c`。
  - `{-1,1}` が相異なる 2 元から成ること: `人手 8` の `{-1,1}` 上の和を `c + c` と読む段（`sum_spinVal_addCommMonoid` が
    `{0,1}` と `{-1,1}` の全単射 `spinIdxEquiv` を使う）。
  - 乗法の可換モノイド: 具体版と同じく有限積を足す順序を持たない `Finset.prod` で書くので、その定まり方に要る。展開の段は
    `Finset.prod` と左から掛ける有限積 `finProdLeft` をつなぐ `finset_prod_eq_finProdLeft'`（運ぶ段）を通すだけである。
    `人手 10` の冪は、人手の `x^n := Π_{j=1}^{n} x` を `Fin.prod_const` で読む。
  零の吸収律 `0·a = 0` は効いていないが、`Finset.sum`・`Finset.prod`・二つの分配律・`1 + 1 = 2` を同時に持つ Lean の型クラスは
  半環の系列しかないので、`CommSemiring` で受ける。
  重みの値について、実数であること、指数関数、`cosh`・`sinh` は効いていない。二つのスピン和は、重みを
  `g(t) = exp(Kt)` と `g(t) = t·exp(Kt)` に取った特殊化にすぎない。
  スピンの側 `𝔐 = Map({1,…,M_col},{-1,1})` は、具体版の `Φ`・`ς` をそのまま使うために人手の定義のまま固定した。
  そこで効くのは、`{-1,1}` が乗法で閉じることと `s·s = 1`（`Φ` の逆写像）、`ς` が `{0,1}` と `{-1,1}` の全単射であること、
  `{-1,1}` の元の個数 `2` だけで、
  `ℝ` の加法と順序は効いていない。
  `M_col ≥ 2` は、具体版と同じく結合の添字を `Fin (n + 1)` に取る手順のために置いた（主張そのものは `M_col = 1` でも
  `2 = 2·(g(1)+g(-1))^0` として成り立つ）。
- **端点因子の書き替え（`prod_mul_succ_eq_first_mul_last`）。** 効いているのは、値が可換モノイドに在ることと、
  中間のサイト `m = 2,…,M_col-1` での `x(m)x(m) = 1` だけである。`M_col = 2` の鎖は `x(m)x(m) = 1` を使わず
  （中間のサイトが無い）、`M_col ≥ 3` の鎖は乗法の可換性と結合性（`prod_mul_succ_rearrange`）と中間のサイトの
  `x(m)x(m) = 1` を使う。両端のサイトの `x·x = 1`、実数であること、値が `±1` であることは効いていない。
  `M_col ≥ 2` は具体版と同じく `M_col` を `n + 2` に取る形で入っている（`M_col = 1` では主張の積が空になる）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimOpenChainSpinSums
import Ising2D.NecSuf.BinaryWordSumAsFinsetSum
import Ising2D.NecSuf.FiniteProductOfProducts

namespace Ising2D.NecSuf

open Finset Ising2D

/-- `{-1,1}` 上の有限和（値は任意の加法可換モノイド）: `∑_{t∈{-1,1}} f(t) = f(1) + f(-1)`。 -/
theorem sum_spinVal_addCommMonoid {R : Type*} [AddCommMonoid R] (f : SpinVal → R) :
    ∑ x : SpinVal, f x = f ⟨1, Or.inl rfl⟩ + f ⟨-1, Or.inr rfl⟩ := by
  rw [← spinIdxEquiv.symm.sum_comp, Fin.sum_univ_two]
  congr 2

/-- 運ぶ段（人手の行は無い）: 乗法の可換モノイドの `Finset.prod` は左から掛ける有限積 `finProdLeft` である
（`def_finite_product_of_real_numbers` の 2 つの式が、どちらでも 2 つの節になる。ℝ の場合は `real_finset_prod_eq_finProdLeft`）。 -/
theorem finset_prod_eq_finProdLeft' {R : Type*} [CommMonoid R] :
    ∀ (m : ℕ) (y : Fin (m + 1) → R), ∏ j, y j = finProdLeft m y
  | 0, y => by rw [Fin.prod_univ_one, finProdLeft_zero]
  | m + 1, y => by
    rw [Fin.prod_univ_castSucc, finProdLeft_succ, finset_prod_eq_finProdLeft' m]

/-- 具体版の `人手 4` が引く `expansion_of_finite_product_of_two_term_sums_of_real_numbers` を、値が可換半環で積が
`Finset.prod` の形で述べたもの: `Π_{j=1}^{r}(a_j^{(1)} + a_j^{(0)}) = Σ_{ε∈{0,1}^r} Π_{j=1}^{r} a_j^{(ε_j)}`
（人手の `r` は Lean の `r + 1`）。証明は `finProdLeft_add_eq_binWordSum`（`Distrib` だけを仮定する）を運ぶだけである。 -/
theorem prod_add_eq_binWordSum' {R : Type*} [CommSemiring R] (r : ℕ) (a : Fin (r + 1) → Fin 2 → R) :
    ∏ j, (a j 1 + a j 0) = binWordSum r (fun ε => ∏ j, a j (ε j)) := by
  rw [finset_prod_eq_finProdLeft']
  simp only [finset_prod_eq_finProdLeft']
  exact finProdLeft_add_eq_binWordSum r a

/-- 具体版の `finite_product_of_real_products`（`Π_j(x_jy_j) = (Π_jx_j)(Π_jy_j)`）を、値が可換モノイドで積が `Finset.prod` の
形で述べたもの。証明は必要十分版 `finProdLeft_mul'`（`(ab)(cd) = (ac)(bd)` だけを仮定する）を運ぶだけである。 -/
theorem finset_prod_mul_distrib' {G : Type*} [CommMonoid G] (m : ℕ) (x y : Fin (m + 1) → G) :
    ∏ j, x j * y j = (∏ j, x j) * ∏ j, y j := by
  rw [finset_prod_eq_finProdLeft', finset_prod_eq_finProdLeft', finset_prod_eq_finProdLeft']
  exact finProdLeft_mul' mul_mul_mul_comm m x y

/-- 人手の `ς(1) = 1` を `{-1,1}` の元の等式として読む。 -/
theorem varsigma_one_eq : varsigma 1 = (⟨1, Or.inl rfl⟩ : SpinVal) := Subtype.ext coe_varsigma_one

/-- 人手の `ς(0) = -1` を `{-1,1}` の元の等式として読む。 -/
theorem varsigma_zero_eq : varsigma 0 = (⟨-1, Or.inr rfl⟩ : SpinVal) := Subtype.ext coe_varsigma_zero

/-- **必要十分版の本体の前半**: 値が可換半環 `R` の重み `g : {-1,1} → R` について
`∑_{s∈𝔐} Π_{m=1}^{M_col-1} g(t_m(s)) = ∑_{u∈{-1,1}} Π_{m=1}^{M_col-1}(g(1)+g(-1))`（人手の `M_col` は Lean の `n + 2`）。
具体版の二つの主張の最後の鎖の `人手 2`〜`人手 5` を、印を揃えて同じ並びで踏む。 -/
theorem open_chain_weighted_sum_eq_sum_prod {R : Type*} [CommSemiring R] {n : ℕ} (g : SpinVal → R) :
    ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), g (bondSpin s m)
      = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) :=
  calc ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), g (bondSpin s m)
      = ∑ u : SpinVal, ∑ τ : Fin (n + 1) → SpinVal, ∏ m : Fin (n + 1), g (τ m) := by
        rw [← Fintype.sum_prod_type']
        exact openChainPhiEquiv.sum_comp (fun y => ∏ m : Fin (n + 1), g (y.2 m))
                                                        -- 人手 2: Step 1 の全単射 `Φ` で和の添字を `s` から `(u; τ) = Φ(s)` へ付け替える
                                                        -- （`Fintype.sum_prod_type'` は組の上の和を `u` と `τ` の二重の和に読む運ぶ段）
    _ = ∑ u : SpinVal, binWordSum n (fun ε => ∏ m : Fin (n + 1), g (varsigma (ε m))) := by
        refine Finset.sum_congr rfl fun u _ => ?_
        rw [binWordSum_eq_sum]
        exact (varsigmaWordEquiv.sum_comp (fun τ => ∏ m : Fin (n + 1), g (τ m))).symm
                                                        -- 人手 3: Step 1 の全単射 `ε ↦ (ς(ε_1),…)` で内側の和の添字を付け替える
                                                        -- （`binWordSum_eq_sum` は `{0,1}^{M_col-1}` の上の和を `Finset.sum` で読む運ぶ段）
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (g (varsigma 1) + g (varsigma 0)) :=
        Finset.sum_congr rfl fun u _ =>
          (prod_add_eq_binWordSum' n (fun _ e => g (varsigma e))).symm
                                                        -- 人手 4: 二項の和の有限積の展開（`a_j^{(e)} → g(ς(e))`）を右辺から左辺へ、各 `u` の項へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) := by
        rw [varsigma_one_eq, varsigma_zero_eq]          -- 人手 5: `ς(1) = 1`、`ς(0) = -1` を各因子へ

/-- 具体版の `open_chain_partition_sum` の `人手 8`・`open_chain_endpoint_product_sum` の `人手 10` の必要十分版:
`u` に依らない `c` の `{-1,1}` 上の和は `c + c = 2c`。 -/
theorem sum_spinVal_const {R : Type*} [CommSemiring R] (c : R) : ∑ _u : SpinVal, c = 2 * c := by
  rw [sum_spinVal_addCommMonoid, ← two_mul]

/-- **必要十分版の本体**: `∑_{s∈𝔐} Π_{m=1}^{M_col-1} g(t_m(s)) = 2(g(1)+g(-1))^{M_col-1}`。
前半 `open_chain_weighted_sum_eq_sum_prod`（`人手 2`〜`人手 5`）、`sum_spinVal_const`（`{-1,1}` の上の和）、冪の行をつなぐ。 -/
theorem open_chain_weighted_sum {R : Type*} [CommSemiring R] {n : ℕ} (g : SpinVal → R) :
    ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), g (bondSpin s m)
      = 2 * (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) ^ (n + 1) :=
  calc ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), g (bondSpin s m)
      = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) :=
        open_chain_weighted_sum_eq_sum_prod g          -- 人手 2〜人手 5
    _ = 2 * ∏ _m : Fin (n + 1), (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) :=
        sum_spinVal_const _                             -- 人手 8（端点の主張では 人手 10）: `{-1,1}` の上の和
    _ = 2 * (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) ^ (n + 1) := by
        rw [Fin.prod_const]                             -- 人手 10（端点の主張では 人手 12）: `x^n := Π_{j=1}^{n} x`（`n → M_col-1`）

/-- 具体版 `prod_bondSpin_of_two` の必要十分版（`M_col = 2`。Lean の `n = 0`）:
`Π_{m=1}^{1}x(m)x(m+1) = x(1)x(2) = x(1)x(M_col)`。`x(m)x(m) = 1` は使わない。 -/
theorem prod_mul_succ_of_two {G : Type*} [CommMonoid G] (x : Fin 2 → G) :
    ∏ m : Fin 1, x m.castSucc * x m.succ = x 0 * x (Fin.last 1) :=
  calc ∏ m : Fin 1, x m.castSucc * x m.succ
      = x (0 : Fin 1).castSucc * x (0 : Fin 1).succ := Fin.prod_univ_one _
                                                        -- `def_finite_product_of_real_numbers`（`m → 1`）
    _ = x 0 * x 1 := rfl                                -- 添字 `m = 1` の `m`・`m+1` を読む段（具体版の `t_1(s) := s(1)s(2)` の段に当たる）
    _ = x 0 * x (Fin.last 1) := rfl                     -- `M_col = 2`（人手の `2` が Lean の `Fin.last 1`）

/-- 具体版 `prod_bondSpin_rearrange` の必要十分版（人手の `M_col` は Lean の `k + 3`、中間の添字は `j : Fin (k + 1)`）:
`Π_{m=1}^{M_col-1}x(m)x(m+1) = x(1)(Π_{m=2}^{M_col-1}x(m)x(m))x(M_col)`。具体版と同じ 5 段で、
具体版の `finite_product_of_real_products` の段は `finset_prod_mul_distrib'`（必要十分版 `finProdLeft_mul'` を運んだもの）である。 -/
theorem prod_mul_succ_rearrange {G : Type*} [CommMonoid G] (k : ℕ) (x : Fin (k + 3) → G) :
    ∏ m : Fin (k + 2), x m.castSucc * x m.succ
      = x 0 * (∏ j : Fin (k + 1), x j.succ.castSucc * x j.succ.castSucc) * x (Fin.last (k + 2)) :=
  calc ∏ m : Fin (k + 2), x m.castSucc * x m.succ
      = (∏ m : Fin (k + 2), x m.castSucc) * ∏ m : Fin (k + 2), x m.succ :=
        finset_prod_mul_distrib' (k + 1) _ _            -- 因子の並べ替え（具体版の `finite_product_of_real_products`）
    _ = (x 0 * ∏ j : Fin (k + 1), x j.succ.castSucc)
          * ((∏ j : Fin (k + 1), x j.castSucc.succ) * x (Fin.last (k + 2))) := by
        rw [Fin.prod_univ_succ (fun m : Fin (k + 2) => x m.castSucc),
          Fin.prod_univ_castSucc (fun m : Fin (k + 2) => x m.succ)]
        rfl                                             -- 先頭の因子 `x(1)` と末尾の因子 `x(M_col)` を外へ出す
    _ = (x 0 * ∏ j : Fin (k + 1), x j.succ.castSucc)
          * ((∏ j : Fin (k + 1), x j.succ.castSucc) * x (Fin.last (k + 2))) := by
        simp only [Fin.succ_castSucc]                   -- 中間のサイト `m = 2,…,M_col-1` の二つの書き方を揃える
    _ = x 0 * ((∏ j : Fin (k + 1), x j.succ.castSucc) * ∏ j : Fin (k + 1), x j.succ.castSucc)
          * x (Fin.last (k + 2)) := by
        rw [mul_assoc, mul_assoc, mul_assoc]            -- 乗法の結合性
    _ = x 0 * (∏ j : Fin (k + 1), x j.succ.castSucc * x j.succ.castSucc) * x (Fin.last (k + 2)) := by
        rw [← finset_prod_mul_distrib' k]               -- 因子の並べ替え（具体版の `finite_product_of_real_products` を右辺から左辺へ）

/-- 具体版 `prod_bondSpin_of_ge_three` の必要十分版（人手の `M_col` は Lean の `k + 3`）: 中間のサイトで `x(m)x(m) = 1` なら
`Π_{m=1}^{M_col-1}x(m)x(m+1) = x(1)x(M_col)`。具体版の 1 行目（`t_m(s) := s(m)s(m+1)`）に当たる段は、ここでは左辺がすでに
`x(m)x(m+1)` の形なので、左辺を読み直すだけの 1 段目として置く。 -/
theorem prod_mul_succ_of_ge_three {G : Type*} [CommMonoid G] (k : ℕ) (x : Fin (k + 3) → G)
    (hx : ∀ j : Fin (k + 1), x j.succ.castSucc * x j.succ.castSucc = 1) :
    ∏ m : Fin (k + 2), x m.castSucc * x m.succ = x 0 * x (Fin.last (k + 2)) :=
  calc ∏ m : Fin (k + 2), x m.castSucc * x m.succ
      = ∏ m : Fin (k + 2), x m.castSucc * x m.succ := rfl
                                                        -- 添字 `m` の `m`・`m+1` を読む段（具体版の `t_m(s) := s(m)s(m+1)` の段に当たる）
    _ = x 0 * (∏ j : Fin (k + 1), x j.succ.castSucc * x j.succ.castSucc) * x (Fin.last (k + 2)) :=
        prod_mul_succ_rearrange k x                     -- 乗法の可換性と結合性
    _ = x 0 * (∏ _j : Fin (k + 1), (1 : G)) * x (Fin.last (k + 2)) := by
        rw [Finset.prod_congr rfl fun j _ => hx j]      -- 中間のサイトの `x(m)x(m) = 1` を各 `m` へ同時適用
    _ = x 0 * x (Fin.last (k + 2)) := by
        rw [Finset.prod_const_one, mul_one]             -- `1` の有限積は `1`（と `a·1 = a`）

/-- **必要十分版**（具体版 `prod_bondSpin_eq_first_mul_last`）: 値が可換モノイド `G` の `x : {1,…,M_col} → G` が
中間のサイト `m = 2,…,M_col-1` で `x(m)x(m) = 1` を満たせば `Π_{m=1}^{M_col-1}x(m)x(m+1) = x(1)x(M_col)`
（人手の `M_col` は Lean の `n + 2`、中間のサイトは `j : Fin n` の `j.succ.castSucc`）。具体版と同じく `M_col = 2` と `M_col ≥ 3` に分ける。 -/
theorem prod_mul_succ_eq_first_mul_last {G : Type*} [CommMonoid G] : ∀ {n : ℕ} (x : Fin (n + 2) → G),
    (∀ j : Fin n, x j.succ.castSucc * x j.succ.castSucc = 1) →
      ∏ m : Fin (n + 1), x m.castSucc * x m.succ = x 0 * x (Fin.last (n + 1))
  | 0, x, _ => prod_mul_succ_of_two x
  | k + 1, x, hx => prod_mul_succ_of_ge_three k x hx

end Ising2D.NecSuf
