# SageMath Check: 二次体の三分律（少なくとも一つ）

**対象ラベル**: `claim_quadratic_trichotomy_at_least_one`

本文の混合符号四鎖の十二行と、両係数が非正の場合の六行を対応させる。
主張・四つの符号の場合・平方比較による分岐・既存の本文参照は保つ。
全て `QQ` / `QQbar` の厳密計算であり、浮動小数点は使わない。

## 行別の対応

| ファイル | 本文の行 | ステータス | 結果 |
|---|---|---|---|
| `check_nonpositive_first_double_negation.sage` | $a=-(-a)$ | PASS | 195 有理数組 |
| `check_nonpositive_first_assumption_substitution.sage` | $-(-a)=-0$ | 数値事例なし | Leanの仮定代入で確認。数値PASSに数えない |
| `check_nonpositive_first_neg_zero.sage` | $-0=0$ | PASS | 195 有理数組 |
| `check_nonpositive_second_double_negation.sage` | $b=-(-b)$ | PASS | 195 有理数組 |
| `check_nonpositive_second_assumption_substitution.sage` | $-(-b)=-0$ | 数値事例なし | Leanの仮定代入で確認。数値PASSに数えない |
| `check_nonpositive_second_neg_zero.sage` | $-0=0$ | PASS | 195 有理数組 |
| `check_positive_negative_direct_associate.sage` | $(2b)b=2(bb)$ | PASS | 66 有理数組 |
| `check_positive_negative_direct_assumption.sage` | $2(bb)<aa$ | PASS | 66 有理数組 |
| `check_positive_negative_negated_square.sage` | $(-a)(-a)=aa$ | PASS | 103 有理数組 |
| `check_positive_negative_negated_assumption.sage` | $aa<2(bb)$ | PASS | 103 有理数組 |
| `check_positive_negative_negated_coefficient_square.sage` | $2(bb)=2((-b)(-b))$ | PASS | 103 有理数組 |
| `check_positive_negative_negated_associate.sage` | $2((-b)(-b))=(2(-b))(-b)$ | PASS | 103 有理数組 |
| `check_negative_positive_direct_assumption.sage` | $aa<2(bb)$ | PASS | 103 有理数組 |
| `check_negative_positive_direct_associate.sage` | $2(bb)=(2b)b$ | PASS | 103 有理数組 |
| `check_negative_positive_negated_associate.sage` | $(2(-b))(-b)=2((-b)(-b))$ | PASS | 66 有理数組 |
| `check_negative_positive_negated_coefficient_square.sage` | $2((-b)(-b))=2(bb)$ | PASS | 66 有理数組 |
| `check_negative_positive_negated_assumption.sage` | $2(bb)<aa$ | PASS | 66 有理数組 |
| `check_negative_positive_negated_square.sage` | $aa=(-a)(-a)$ | PASS | 66 有理数組 |
| `check.sage` | 主張・場合分け・表示・混合符号の既存統合検算 | PASS | 主張1,458組、網羅729組、逆元表示1,458組、混合338組 |

標本は既存統合検算と同じ、分子 $-6,\ldots,6$、分母 $1,2,3$ の相異なる有理数27個である。
混合符号の四鎖は、それぞれの符号と平方比較を満たす組だけを使う。
不等号の四行は分岐条件の確認であり、既存の平方の不一致の証明を置き換えるものではない。

非正の場合は $a\le0$、$b\le0$、$(a,b)\ne(0,0)$ を満たす組を使う。
二重負号と零の負号の四行は背理仮定を使わない恒等式として検算する。
背理仮定 $(-a,-b)=(0,0)$ を同時に満たす数値事例は存在しないため、
その成分の代入二行は**数値事例なし、Leanの仮定代入で確認**とし、数値PASSへ含めない。

Lean具体版と必要十分版は、負号の積・結合則・仮定の代入を本文と同じ行へ分ける。
必要十分版の `Ring`・`LinearOrder`・`IsStrictOrderedRing` と混合符号の平方不一致の仮定は保つ。
導出版は具体的な有理数係数と平方不一致を供給する既存の形を保つ。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、
$\xi\in P_s$、$\xi=0$、$-\xi\in P_s$ の少なくとも一つが成り立つ」。

- **main**: 全標本（分子 $-6..6$、分母 $1..3$ の有理数の組 $(a,b)$）と
  $t^2-2$ の両方の根 $s$ で、三つの場合の少なくとも一つが成り立つ。
  正錐の判定は表示 $(a,b)$ だけに依存する（`claim_quadratic_representation_unique`）ので、
  $\xi\in P_s$ は三条件を $(a,b)$ に、$-\xi\in P_s$ は $(-a,-b)$ に当てて判定する。
  $\xi=0$ は `QQbar` の厳密等号で判定する。
- **cover**: 証明の四つの場合（$0\le a\wedge0\le b$、$a\le0\wedge b\le0$、
  $0<a\wedge b<0$、$a<0\wedge0<b$）がすべての標本を覆う（場合分けの網羅性の裏取り）。
- **neg**: $-(a+b\cdot s)=(-a)+(-b)\cdot s$ が `QQbar` の厳密等号で成り立つ
  （`claim_quadratic_negation_representation` の表示の裏取り）。
- **mixed**: 符号が混合する標本では $b\ne0$ かつ $a\cdot a\ne2\cdot(b\cdot b)$
  （`claim_rational_square_ne_double_square` の再確認）。さらに逆元側の二本の鎖の各段
  （$(-a)\cdot(-a)=a\cdot a$、$2\cdot(b\cdot b)=2\cdot((-b)\cdot(-b))=2\cdot(-b)\cdot(-b)$）と、
  大小の向きごとに正錐の第二・第三条件が実際に成り立つことを検査する。

## 実行記録

2026-10-10: 行別18本と既存統合検算1本の全19ファイルを実行した。
数値検算する16行は計1,794件（等式1,456件、不等式338件）で全てPASS。
背理仮定の代入二行は数値事例なしとして数値PASSへ含めない。
既存統合検算も、主張1,458組・符号の場合分け729組・逆元表示1,458組・混合符号338組で通過した。
Lean具体版・必要十分版・導出版の三モジュールのビルドも通過した。

## 実行方法

プロジェクト直下で、読み込むファイルを `__file__` へ明示する。

```sh
sage -c "import glob; fs=sorted(glob.glob('sagemath/check/quadratic-trichotomy-at-least-one/check*.sage')); exec('for f in fs:\n    __file__ = f\n    load(f)')"
```
