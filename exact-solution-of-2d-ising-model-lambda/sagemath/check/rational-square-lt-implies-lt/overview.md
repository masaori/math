# SageMath Check: 非負有理数の平方の大小から大小

## 対象

**対象ラベル**: `claim_rational_square_lt_implies_lt`

- 実行日: 2026-10-11
- 本文: `structured-latex/content/main-text.ts` の「非負有理数の平方の大小から大小」。
- 結果: 行別七本を実行し、数値五本で52,200件を確認した。
  数値事例のない二行は数値PASSへ含めない。既存の統合検算も通過した。
- 帰属: `QQ` の厳密計算。浮動小数点は使わない。

## 行別の対応

主張は「任意の $p,q\in\mathbb{Q}$ について、$0\le p$ かつ $0\le q$ かつ
$p\cdot p<q\cdot q$ ならば $p<q$」。標本は既存の統合検算と同じく、
分子・分母が1から15の正の有理数と零の計144個である。

| ファイル | 本文の行または根拠 | 状態 | 結果 | Lean の対応 |
|---|---|---|---|---|
| `check_multiply_right_nonnegative.sage` | $qq\le pq$ | PASS | 10,440不等式 | `hqq_le_pq` |
| `check_multiply_left_nonnegative.sage` | $pq\le pp$ | PASS | 10,440不等式 | `hpq_le_pp` |
| `check_strict_square_assumption.sage` | $pp<qq$（平方の大小の仮定） | 数値事例なし | 数値PASSは0件 | `hSquare` |
| `check_square_chain_transitivity.sage` | $qq\le pp$（第一の鎖の推移律） | PASS | 10,440不等式 | `hqq_le_pp` |
| `check_strict_chain_contradiction.sage` | $pp<pp$（第二の鎖の推移律） | 数値事例なし | 数値PASSは0件 | `hSelf` |
| `check_strict_irreflexivity.sage` | $\lnot(pp<pp)$ | PASS | 144否定 | `lt_irrefl` / `hLtIrrefl` |
| `check_total_order.sage` | $\lnot(q\le p)\iff p<q$ | PASS | 20,736同値 | `lt_of_not_ge` / `hLtOfNotGe` |

三つの広義不等式は $0\le p,0\le q,q\le p$ だけから従う各行として検算し、
平方の狭義不等式は同時に仮定しない。非反射性と全順序性も、その順序の性質だけを検算する。
これらを背理法の全仮定の成立例とは数えない。
平方の大小の仮定と自己への狭義不等式の二行には、同時仮定を満たす有理数の事例がない。
仮定を一部外した標本や空の列挙をこの二行の数値PASSに数えず、Lean の該当行で確認する。

Lean 具体版と必要十分版は、$q\le p$ を仮定して二つの乗法単調性と二つの推移律を使い、
非反射性から $\lnot(q\le p)$ を得た後、全順序性で $p<q$ を得る。
導出版は、必要十分版の各仮定に有理数の演算と順序の性質を供給する。
公開定理の主張と仮定は変更していない。

## 実行記録

- 2026-08-13: 既存の `check.sage` が主張10,296組、背理法の鎖10,440組、
  全順序の同値20,736組で通過した。
- 2026-10-11: 行別七本を実行した。数値五本は31,320不等式・144否定・20,736同値でPASS。
  数値事例のない二行は数値PASSに含めない。既存の `check.sage` も同じ件数で通過した。
  対応する Lean 具体版・必要十分版・導出版の三モジュールの build も通過した。

これは有限個の標本の厳密検算であり、一般の有理数についての証明は本文と Lean に置く。

## 実行方法

このディレクトリで行別検算と既存の統合検算を実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```
