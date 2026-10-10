# 多項式行列式のスカラー倍の行別検算

**対象ラベル**: `claim_polynomial_determinant_scalar`

本文の九等号を各一ファイルへ対応させる。円分体 $\mathbb Q(\zeta_8)[x]$ 上の多項式のまま厳密に比較し、浮動小数点や変数への値の代入は使わない。添字集合の大きさは1・2・3・4。零行列・単位行列・上三角行列・非有理係数の密行列・行が等しい行列と、スカラー $0,1,-1,x,x^2+\zeta_8$ の組を用いる（100入力）。大きさ二以上では行が等しい行列は特異である。

中間六行は全825置換項を個別に比べた後、100入力の総和も比較する。最初と最後の行は SageMath の行列式との比較で、置換和だけを両辺に使わない。この有限検算は一般の有限集合についての証明ではない。一般の証明は本文と Lean の具体版・必要十分版に置く。

| ファイル | 本文の等号 | 状態 | 結果 |
|---|---|---|---|
| `check_row_expansion.sage` | 行指定の行列式の定義 | PASS | 100 等式 |
| `check_scalar_entries.sage` | スカラー倍の成分 | PASS | 925 等式 |
| `check_split_product.sage` | 有限積の積の分離 | PASS | 925 等式 |
| `check_constant_product.sage` | 同じ元の有限積を冪へ書き換え | PASS | 925 等式 |
| `check_associate_left.sage` | 左への結合 | PASS | 925 等式 |
| `check_commute_weight.sage` | 符号係数と冪の交換 | PASS | 925 等式 |
| `check_associate_right.sage` | 右への結合 | PASS | 925 等式 |
| `check_factor_sum.sage` | 有限和から共通因子を取り出す | PASS | 100 等式 |
| `check_determinant_definition.sage` | 行列式の定義へ戻す | PASS | 100 等式 |

このディレクトリで次を実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

2026-10-10 実行: 全9本、計5,850等式が PASS。
