/-
# 対称化した和は偶である（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshIsEven.lean`）: `cosh_is_even`。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `cosh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `cosh_is_even`（4 段） | `symmetrized_sum_is_even'`（同じ 4 段） | 引数の側の符号反転が対合であること（`InvolutiveNeg`）と、値の側の和の交換則（`AddCommMagma`）だけ |

* 人手の 4 行は「`cosh` の定義」「`−(−x) = x`」「`ℝ` の加法の交換律」「`cosh` の定義を右辺から左辺へ」で、
  必要十分版の 4 段と同じ並びである。`cosh` の定義 `cosh y = (exp y + exp(−y))/2` は、仮定 `hh : ∀ y, h y = d (f y + f (−y))` として置く。
* `exp` の性質（指数法則・正値性）は効いていない（`f` は任意の写像でよい）。2 で割ることも効いていない（`d` は任意の写像でよく、`h` の値の型 `S` は和の型 `R` と違ってよい）。
  値の側の結合則・単位元・逆元も、引数の側の加法も効いていない。
* 対合性は外せない（2 段目の `−(−x) = x`）。和の交換則も外せない（3 段目）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`h(−x) = h x`**（具体版 `cosh_is_even`）。`h y = d(f y + f(−y))` と書ける `h` は偶である。 -/
theorem symmetrized_sum_is_even' {G R S : Type*} [InvolutiveNeg G] [AddCommMagma R]
    (f : G → R) (d : R → S) (h : G → S) (hh : ∀ y, h y = d (f y + f (-y))) (x : G) :
    h (-x) = h x :=
  calc h (-x)
      = d (f (-x) + f (-(-x))) := hh (-x)                -- `h` の定義（具体版の `cosh` の定義）
    _ = d (f (-x) + f x) := by rw [neg_neg]              -- `−(−x) = x`
    _ = d (f x + f (-x)) := by rw [add_comm (f (-x))]    -- 和の交換則
    _ = h x := (hh x).symm                               -- `h` の定義を右辺から左辺へ

end Ising2D.NecSuf
