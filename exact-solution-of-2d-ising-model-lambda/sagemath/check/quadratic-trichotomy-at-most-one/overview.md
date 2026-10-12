# SageMath Check: 二次体の三分律（高々一つ）

## 対象

**対象ラベル**: `claim_quadratic_trichotomy_at_most_one`

- 実行日: 2026-08-13
- 結果: 通過（高々一つの判定 1458 組、零表示が三条件を満たさないこと 3 件、
  書き直しの同値 729 組、九つの組み合わせの排他 6561 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 行別の対応

符号の六同値・組の非零の四同値・平方比較の六同値は、既存と同じ有理数27個の全729組を使う。
混合二場合の結合等号も、背理仮定を使わない恒等式として全729組を使う。
零表示の四等号は、二次体 $K=\mathbb Q[r]/(r^2-2)$ の元の多項式代表から係数を取り出す。
$s=r$ と $s=-r$ の両方で $\xi=0$ の表示を調べ、各行2件を数える。
零の表示を求めるこの計算では、正錐への所属という背理仮定は使っていない。

| ファイル | 本文の行 | 状態 | 結果 |
|---|---|---|---|
| `check_zero_neg_representation.sage` | rep_s(-ξ)=(-a,-b) | PASS | 2 行 |
| `check_zero_representation_substitution.sage` | (-a,-b)=(-0,-0) | PASS | 2 行 |
| `check_zero_first_negation.sage` | (-0,-0)=(0,-0) | PASS | 2 行 |
| `check_zero_second_negation.sage` | (0,-0)=(0,0) | PASS | 2 行 |
| `check_sign_nonnegative_first.sage` | 0≤-a ⇔ a≤0 | PASS | 729 行 |
| `check_sign_nonnegative_second.sage` | 0≤-b ⇔ b≤0 | PASS | 729 行 |
| `check_sign_positive_first.sage` | 0<-a ⇔ a<0 | PASS | 729 行 |
| `check_sign_negative_second.sage` | -b<0 ⇔ 0<b | PASS | 729 行 |
| `check_sign_negative_first.sage` | -a<0 ⇔ 0<a | PASS | 729 行 |
| `check_sign_positive_second.sage` | 0<-b ⇔ b<0 | PASS | 729 行 |
| `check_negated_pair_definition.sage` | (-a,-b)≠(0,0) ⇔ ¬(-a=0 ∧ -b=0) | PASS | 729 行 |
| `check_negated_pair_first_zero.sage` | ¬(-a=0 ∧ -b=0) ⇔ ¬(a=0 ∧ -b=0) | PASS | 729 行 |
| `check_negated_pair_second_zero.sage` | ¬(a=0 ∧ -b=0) ⇔ ¬(a=0 ∧ b=0) | PASS | 729 行 |
| `check_negated_pair_reconstruction.sage` | ¬(a=0 ∧ b=0) ⇔ (a,b)≠(0,0) | PASS | 729 行 |
| `check_negated_second_associate.sage` | (2(-b))(-b)<(-a)(-a) ⇔ 2((-b)(-b))<(-a)(-a) | PASS | 729 行 |
| `check_negated_second_second_square.sage` | 2((-b)(-b))<(-a)(-a) ⇔ 2(bb)<(-a)(-a) | PASS | 729 行 |
| `check_negated_second_first_square.sage` | 2(bb)<(-a)(-a) ⇔ 2(bb)<aa | PASS | 729 行 |
| `check_negated_third_first_square.sage` | (-a)(-a)<(2(-b))(-b) ⇔ aa<(2(-b))(-b) | PASS | 729 行 |
| `check_negated_third_associate.sage` | aa<(2(-b))(-b) ⇔ aa<2((-b)(-b)) | PASS | 729 行 |
| `check_negated_third_second_square.sage` | aa<2((-b)(-b)) ⇔ aa<2(bb) | PASS | 729 行 |
| `check_mixed_positive_negative_associate.sage` | 2(bb)=(2b)b | PASS | 729 行 |
| `check_mixed_negative_positive_associate.sage` | (2b)b=2(bb) | PASS | 729 行 |
| `check_same_nonnegative_first_zero.sage` | a=0（両方第一条件の第一成分） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_same_nonnegative_second_zero.sage` | b=0（両方第一条件の第二成分） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_same_nonnegative_first_substitution.sage` | (a,b)=(0,b)（両方第一条件の第一成分の代入） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_same_nonnegative_second_substitution.sage` | (0,b)=(0,0)（両方第一条件の第二成分の代入） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_nonnegative_positive_negative_contradiction.sage` | ¬(a<0)（第一条件・第二条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_nonnegative_negative_positive_contradiction.sage` | ¬(b<0)（第一条件・第三条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_positive_negative_nonnegative_contradiction.sage` | ¬(0<a)（第二条件・第一条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_same_positive_negative_contradiction.sage` | ¬(a<0)（両方第二条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_negative_positive_nonnegative_contradiction.sage` | ¬(0<b)（第三条件・第一条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_same_negative_positive_contradiction.sage` | ¬(0<a)（両方第三条件の矛盾） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_positive_negative_forward_assumption.sage` | (2b)b<aa（第二条件・第三条件の元の仮定） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_positive_negative_backward_assumption.sage` | aa<2(bb)（第二条件・第三条件の逆元の仮定） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_positive_negative_transitivity.sage` | 2(bb)<2(bb)（第二条件・第三条件の推移律） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_negative_positive_forward_assumption.sage` | aa<(2b)b（第三条件・第二条件の元の仮定） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_negative_positive_backward_assumption.sage` | 2(bb)<aa（第三条件・第二条件の逆元の仮定） | 数値事例なし | Leanで確認、数値PASSは0件 |
| `check_mixed_negative_positive_transitivity.sage` | aa<aa（第三条件・第二条件の推移律） | 数値事例なし | Leanで確認、数値PASSは0件 |

九場合の同時仮定を満たす数値事例は存在しない。その下での成分の零、仮定代入、
符号の矛盾、自己への狭義不等式という16行は**数値事例なし・Leanで確認**とする。
空の標本や、同時仮定から一部を除いた標本を、それら16行の数値PASSへ含めない。
二つの結合等号の数値検算も、九場合の成立例とは数えない。
既存の `check.sage` は全標本で九つの同時成立を直接否定する有限検算として保つ。

Lean具体版と必要十分版は、零表示、逆元側の条件の書き直し、九場合を本文と同じ順に辿る。
必要十分版の `Ring`・`LinearOrder`・`IsStrictOrderedRing` と公開宣言の型は保つ。
導出版は、具体的な有理数係数と零・逆元の表示を供給する既存の適用を保つ。

## 実行記録

2026-10-12: 通常 CLI で元の行別ファイルを実行すると、`__file__` が SageMath 本体の場所を指し、`_prelude.sage` を見つけられず終了することを再現した。補助ファイルが無い場合は起動引数の入力パスを用いるよう22本を修正した。統合1本と行別38本をすべて別プロセスの通常 CLI で再実行し、全39本が通過した。数値22行13,130件、数値事例なし16行、既存統合の各件数は変わらない。

2026-10-10: 行別38本と既存統合1本の全39ファイルを実行した。
数値22行は全13,130件（等式1,466件・同値11,664件）でPASS。
数値事例なしの16行は数値PASSへ含めない。
既存統合検算も、主張1,458組・零条件3件・条件書き換え729組・九場合の排他6,561組で通過した。
Lean具体版・必要十分版・導出版の三モジュールのビルドも通過した。

## 何を確かめるか

主張は「$s\cdot s=\iota(2)$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、
$\xi\in P_s$、$\xi=0$、$-\xi\in P_s$ のうち同時に成り立つものは高々一つ」。

- **main**: 全標本（分子 $-6..6$、分母 $1..3$ の有理数の組 $(a,b)$）と
  $t^2-2$ の両方の根 $s$ で、三つの場合のうち成り立つものが 1 個以下である。
  正錐の判定は表示 $(a,b)$ だけに依存する（`claim_quadratic_representation_unique`）ので、
  $\xi\in P_s$ は三条件を $(a,b)$ に、$-\xi\in P_s$ は $(-a,-b)$ に当てて判定する。
  $\xi=0$ は `QQbar` の厳密等号で判定する。
- **zero**: 組 $(0,0)$ は正錐の三条件のどれも満たさない（証明の準備の裏取り）。
- **trans**: 証明が使う「$(-a,-b)$ の三条件の $(a,b)$ の言葉への書き直し」が全標本で同値
  （第一 $\iff a\le0\wedge b\le0\wedge(a,b)\ne(0,0)$、
  第二 $\iff a<0\wedge0<b\wedge2\cdot(b\cdot b)<a\cdot a$、
  第三 $\iff 0<a\wedge b<0\wedge a\cdot a<2\cdot(b\cdot b)$）。
- **pairs**: $(a,b)$ が満たす条件と $(-a,-b)$ が満たす条件の九つの組み合わせのどれも、
  同時に満たす標本が存在しない（証明の九つの場合の矛盾の裏取り）。

## 実行方法

プロジェクト直下から各ファイルを通常起動する。

```sh
for file in sagemath/check/quadratic-trichotomy-at-most-one/check*.sage; do
  sage "$file" || exit 1
done
```
