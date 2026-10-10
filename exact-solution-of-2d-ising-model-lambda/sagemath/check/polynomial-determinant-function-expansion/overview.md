# 多項式行列積の行列式の添字写像展開の行別検算

**対象ラベル**: `claim_polynomial_determinant_function_expansion`

本文の十等号を各一ファイルへ対応させる。円分体 $\mathbb Q(\zeta_8)[x]$ の多項式として比較し、値の代入や浮動小数点を使わない。添字集合の大きさは1・2・3、それぞれ対角と三角の組・非有理係数の密行列の組・符号付き疎行列の組の三種類（計9入力）。全ての添字写像と置換を列挙する。

全体の等号に加え、行列積の各成分、各置換での展開と分配、各写像と置換での積の分離・結合・交換、各写像での因子の取り出しも比較する。総和の相殺だけで個々の項の誤りを隠さないためである。この有限検算は一般の有限集合についての証明ではなく、一般の証明は本文と Lean にある。

| ファイル | 本文の等号 | 状態 | 結果 |
|---|---|---|---|
| `check_row_expansion.sage` | 行指定の行列式の定義 | PASS | 9 等式 |
| `check_matrix_product_entries.sage` | 行列積の成分 | PASS | 51 等式 |
| `check_product_of_sums.sage` | 有限和の積の添字写像展開 | PASS | 36 等式 |
| `check_distribute_sign.sage` | 符号係数の分配 | PASS | 36 等式 |
| `check_swap_sums.sage` | 有限和の順序交換 | PASS | 9 等式 |
| `check_split_product.sage` | 有限積の分離 | PASS | 522 等式 |
| `check_associate_left.sage` | 左への括弧の付け替え | PASS | 522 等式 |
| `check_commute_sign.sage` | 符号係数と左因子の交換 | PASS | 522 等式 |
| `check_associate_right.sage` | 右への括弧の付け替え | PASS | 522 等式 |
| `check_factor_inner_sum.sage` | 内側の和から左因子を取り出す | PASS | 105 等式 |

各ファイルを `sage <ファイル>` で個別に実行できる。一括実行はこのディレクトリで次を使う。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

2026-10-10 実行: 全10本、計2334等式が PASS。
