/-
# 非対角成分が 0 の行列で両側から挟んだ行列の成分（必要十分版）

人手 `W_has_positive_entries`（`structured-latex/content/011_max_eigenvalue.ts`）の Step 3 の必要十分版。
具体版: `Ising2D/Part011/ClaimPhysicalWHasPositiveEntries.lean`
（`physicalSymTransferR_apply_configBasisIso`・`W_has_positive_entries_physical`）。
具体版をこのファイルの系として導出するのは `Ising2D/Part011/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| Step 3 の式変形（`W` の定義、行列の積の定義、`j ≠ ι(μ)` の項が `0`、`k ≠ ι(μ')` の項が `0`） | `sandwich_apply_of_offDiag_zero` の式変形の各行 |
| Step 3 の「3 つの因子はいずれも正なので積も正」 | `sandwich_apply_pos` |

## 何が効いているか / 効いていないか

- **成分の式（`sandwich_apply_of_offDiag_zero`）。** 効いているのは、添字が有限であること（行列の積の有限和）、
  係数の加法が可換モノイドで `0` が乗法で吸収されること（`0·x = x·0 = 0`）、
  および挟む行列 `B` の非対角成分が `0` であることだけである。分配律は効いていない（式変形は行列の積の定義を開き、
  `0` の項を落とすだけ）。それでも仮定のクラスが分配律を含む `NonUnitalNonAssocSemiring` なのは、
  加法の可換モノイドと「`0` が乗法で吸収されること」を共通の `0` で束ね、行列の積も定義できる最小のクラスが mathlib に無いためである。係数の乗法の結合律・可換律・単位元は効いていない
  （式の形 `(B_{ii}V_{ij})B_{jj}` は積の並びと括弧を具体版の Step 3 のまま保つ）。
  添字の等号の判定可能性も効いていない（和を 1 項に潰すのに使うのは `i ≠ j` の項が `0` であることだけ）。
  `B` の対角成分が何か（具体版の `exp(½K_1∑μ(m)μ(m+1))`）も、`V` の成分が何か（具体版の `exp(K_2∑μ(m)μ'(m))`）も効いていない。
- **正値性（`sandwich_apply_pos`）。** 上に加えて、係数に前順序があり、正の元どうしの積が正であることだけが効く。
  仮定の `PosMulStrictMono`（正の元を左から掛けると狭義単調）はそれより強いが、`mul_pos` が要求するクラスなので置いている。実数であること、指数関数の正値性は、具体版で `B` の対角成分と `V` の成分が
  正であることを示すところ（Step 1・Step 2）にだけ効いており、Step 3 には効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.Order.Ring.Defs

namespace Ising2D.NecSuf

open Matrix

variable {n R : Type*} [Fintype n] [NonUnitalNonAssocSemiring R]

/-- 具体版 Step 3 の式変形: `B` の非対角成分が `0` なら `(BVB)_{ij} = (B_{ii}V_{ij})B_{jj}`。 -/
theorem sandwich_apply_of_offDiag_zero {B V : Matrix n n R} (hBoff : ∀ i j : n, i ≠ j → B i j = 0)
    (i j : n) : (B * V * B) i j = B i i * V i j * B j j := by
  calc (B * V * B) i j
      = ∑ k : n, (∑ l : n, B i l * V l k) * B k j := by
        -- (∵ 行列の積の定義)
        rw [Matrix.mul_apply]
        simp only [Matrix.mul_apply]
    _ = ∑ k : n, (B i i * V i k) * B k j := by
        -- (∵ `B` の対角性で `l ≠ i` の項は 0)
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [Finset.sum_eq_single i (fun l _ hl => by rw [hBoff i l (Ne.symm hl), zero_mul])
          (fun h => absurd (Finset.mem_univ i) h)]
    _ = B i i * V i j * B j j := by
        -- (∵ `B` の対角性で `k ≠ j` の項は 0)
        rw [Finset.sum_eq_single j (fun k _ hk => by rw [hBoff k j hk, mul_zero])
          (fun h => absurd (Finset.mem_univ j) h)]

/-- 具体版 Step 3 の結論: `B` の非対角成分が `0`・対角成分が正、`V` の成分が正なら `(BVB)_{ij} > 0`。 -/
theorem sandwich_apply_pos [Preorder R] [PosMulStrictMono R] {B V : Matrix n n R}
    (hBoff : ∀ i j : n, i ≠ j → B i j = 0) (hBdiag : ∀ i : n, 0 < B i i)
    (hV : ∀ i j : n, 0 < V i j) (i j : n) : 0 < (B * V * B) i j := by
  rw [sandwich_apply_of_offDiag_zero hBoff]
  exact mul_pos (mul_pos (hBdiag i) (hV i j)) (hBdiag j)

end Ising2D.NecSuf
