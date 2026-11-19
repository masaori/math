/-
# 反対称化した差は奇である（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimSinhIsOdd.lean`）: `sinh_is_odd`。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `sinh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `sinh_is_odd`（5 段） | `antisymmetrized_difference_is_odd'`（同じ 5 段） | 引数の側の符号反転が対合であること（`InvolutiveNeg`）、値の側の `a − b = −(b − a)`（`hns`）、`d` が符号反転と交換すること（`hd`）だけ |

* 人手の 5 行は「`sinh` の定義」「`−(−x) = x`」「`a − b = −(b − a)`」「分子の符号を分数の外へ出す」「`sinh` の定義を右辺から左辺へ」で、
  必要十分版の 5 段と同じ並びである。`sinh` の定義 `sinh y = (exp y − exp(−y))/2` は、仮定 `hh : ∀ y, h y = d (f y − f (−y))` として置く。
  4 段目の「分子の符号を分数の外へ出す」`(−a)/2 = −(a/2)` は、仮定 `hd : ∀ r, d (−r) = −d r` として置く（具体版では `d := (· / 2)`、`hd := neg_div 2`）。
* `exp` の性質（指数法則・正値性）は効いていない（`f` は任意の写像でよい）。2 で割ることのうち効いているのは符号反転と交換することだけで、
  `d` のほかの性質（加法性・単射性）は効いていない。`h` の値の型 `S` は差の型 `R` と違ってよく、`S` には符号反転のほかに構造が要らない。
  値の側 `R` には差と符号反転だけがあればよく、加法・零・結合律・交換律は効いていない。引数の側の加法も効いていない。
* 対合性は外せない（2 段目の `−(−x) = x`）。`hns` も外せない（`Sub` と `Neg` だけでは差と符号反転が無関係で 3 段目が成り立たない）。
  `hd` も外せない（`d` が符号反転と交換しなければ符号を外へ出せない）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`h(−x) = −h x`**（具体版 `sinh_is_odd`）。`h y = d(f y − f(−y))` と書け、`d` が符号反転と交換する `h` は奇である。 -/
theorem antisymmetrized_difference_is_odd' {G R S : Type*} [InvolutiveNeg G] [Sub R] [Neg R] [Neg S]
    (hns : ∀ a b : R, a - b = -(b - a))
    (f : G → R) (d : R → S) (hd : ∀ r, d (-r) = -d r) (h : G → S)
    (hh : ∀ y, h y = d (f y - f (-y))) (x : G) :
    h (-x) = -h x :=
  calc h (-x)
      = d (f (-x) - f (-(-x))) := hh (-x)                -- `h` の定義（具体版の `sinh` の定義）
    _ = d (f (-x) - f x) := by rw [neg_neg]              -- `−(−x) = x`
    _ = d (-(f x - f (-x))) := by rw [hns]               -- `a − b = −(b − a)`
    _ = -d (f x - f (-x)) := hd (f x - f (-x))           -- 分子の符号を外へ出す（`d` が符号反転と交換する）
    _ = -h x := by rw [← hh x]                           -- `h` の定義を右辺から左辺へ

end Ising2D.NecSuf
