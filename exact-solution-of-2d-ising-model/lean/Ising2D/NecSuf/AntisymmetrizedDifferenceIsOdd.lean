/-
# 反対称化した差は奇である（**必要十分版**）

対応する人手証明のラベル（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimSinhIsOdd.lean`）: `sinh_is_odd`。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `sinh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `sinh_is_odd`（11 段） | `antisymmetrized_difference_is_odd'`（同じ 11 段） | 引数の側と値の側の符号反転が対合であること（`InvolutiveNeg`）、値の側の `a − b = a + (−b)`（`hsub`）・加法の交換律（`hcomm`）・和の符号反転が符号反転の和であること（`hnegadd`）、`d` が `m` と一致し（`hdm`）、`m` が符号反転と交換すること（`hm`）だけ |

* 人手の 11 行は「`sinh` の定義」「`real_double_negation`（`a → x`）」「`def_real_difference`」「加法の交換律」
  「`real_double_negation` を右辺から左辺へ」「`real_negation_of_sum_is_sum_of_negations` を右辺から左辺へ」「`def_real_difference` を右辺から左辺へ」
  「`def_real_quotient`」「`real_negation_times_is_negation_of_product`」「`def_real_quotient` を右辺から左辺へ」「`sinh` の定義を右辺から左辺へ」で、
  必要十分版の 11 段と同じ並びである。`sinh` の定義 `sinh y = (exp y − exp(−y))/2` は、仮定 `hh : ∀ y, h y = d (f y − f (−y))` として置く。
  2 で割ること `d := (· / 2)` と 2 の逆数を右から掛けること `m := (· · 2^{-1})` を分け、`def_real_quotient` を仮定 `hdm : ∀ r, d r = m r`、
  `real_negation_times_is_negation_of_product`（`t → 2^{-1}`）を仮定 `hm : ∀ r, m (−r) = −m r` として置く。
* `exp` の性質（指数法則・正値性）は効いていない（`f` は任意の写像でよい）。2 の逆数を掛けることのうち効いているのは符号反転と交換することだけで、
  加法性・単射性・`2 ≠ 0` は効いていない（`2 ≠ 0` は人手で `2^{-1}` が在るための前提で、`m` を与えた時点で要らない）。
  `h` の値の型 `S` は差の型 `R` と違ってよく、`S` には符号反転のほかに構造が要らない。
  値の側 `R` の加法の結合律・零・逆元の公理（`x + (−x) = 0`）は効いていない。引数の側の加法も効いていない。
* `hdm` と `hm` の組は、`d` が符号反転と交換すること（`∀ r, d (−r) = −d r`）と同値である（逆向きは `m := d`・`hdm := rfl` と置けば得る。
  `SymmetrizedAdditionFormulas.lean` の呼び出しはこの形で渡す）。2 つに分けたのは、具体版の 8〜10 段の手順を写すためである。
* 値の側の対合性・`hsub`・`hcomm`・`hnegadd` の 4 つは、合わせて 3〜7 段目の `a − b = −(b − a)` を出すためだけに効く。
  主張を示すだけなら、この等式 1 つを仮定に置けば足りる。4 つに分けたのは具体版と同じ手順を保つためで、
  以下の「外せない」は、この手順の段を立てるうえでの話である。
* 引数の側の対合性は外せない（2 段目の `−(−x) = x`）。値の側の対合性・`hsub`・`hcomm`・`hnegadd` も外せない
  （`Sub`・`Add`・`Neg` だけの型では、これらなしに 3〜7 段目を立てられない）。
  `hdm`・`hm` も外せない（`d` が符号反転と交換しなければ符号を外へ出せない）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`h(−x) = −h x`**（具体版 `sinh_is_odd`）。`h y = d(f y − f(−y))` と書け、`d` が符号反転と交換する写像 `m` と一致する `h` は奇である。 -/
theorem antisymmetrized_difference_is_odd' {G R S : Type*} [InvolutiveNeg G] [Add R] [Sub R] [InvolutiveNeg R] [Neg S]
    (hsub : ∀ a b : R, a - b = a + -b) (hcomm : ∀ a b : R, a + b = b + a)
    (hnegadd : ∀ a b : R, -(a + b) = -a + -b)
    (f : G → R) (d m : R → S) (hdm : ∀ r, d r = m r) (hm : ∀ r, m (-r) = -m r) (h : G → S)
    (hh : ∀ y, h y = d (f y - f (-y))) (x : G) :
    h (-x) = -h x :=
  calc h (-x)
      = d (f (-x) - f (-(-x))) := hh (-x)                -- `h` の定義（具体版の `sinh` の定義）
    _ = d (f (-x) - f x) := by rw [neg_neg]              -- `−(−x) = x`（具体版の `real_double_negation`（`a → x`））。
                                                        -- 加法の可換群は効かないので `neg_neg_of_addCommGroup` ではなく `InvolutiveNeg` の公理で読む
    _ = d (f (-x) + -f x) := by rw [hsub]                -- `a − b = a + (−b)`（具体版の `def_real_difference`）
    _ = d (-f x + f (-x)) := by rw [hcomm (f (-x))]      -- 加法の交換律
    _ = d (-f x + -(-f (-x))) := by rw [neg_neg (f (-x))] -- `−(−a) = a` を右辺から左辺へ（具体版の `real_double_negation`（`a → exp(−x)`））
    _ = d (-(f x + -f (-x))) := by rw [hnegadd]          -- `−(a + b) = (−a) + (−b)` を右辺から左辺へ
                                                        -- （具体版の `real_negation_of_sum_is_sum_of_negations`）
    _ = d (-(f x - f (-x))) := by rw [← hsub]            -- `a + (−b) = a − b`（具体版の `def_real_difference` を右辺から左辺へ）
    _ = m (-(f x - f (-x))) := hdm _                     -- `d = m`（具体版の `def_real_quotient`）
    _ = -m (f x - f (-x)) := hm _                        -- `m` は符号反転と交換する
                                                        -- （具体版の `real_negation_times_is_negation_of_product`（`t → 2^{-1}`））
    _ = -d (f x - f (-x)) := by rw [hdm]                 -- `m = d`（具体版の `def_real_quotient` を右辺から左辺へ）
    _ = -h x := by rw [← hh x]                           -- `h` の定義を右辺から左辺へ

end Ising2D.NecSuf
