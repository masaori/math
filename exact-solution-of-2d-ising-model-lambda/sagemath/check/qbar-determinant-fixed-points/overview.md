# 零対角行列の行列式で不動点を持つ項の消去の行別検算

**対象ラベル**: `def_qbar_determinant_with_empty_index`, `def_fixed_point_free_permutations`, `claim_qbar_determinant_fixed_points`

本文の十一等号を一行一ファイルに対応させる。円分体 $\mathbb Q(\zeta_8)[x]$ の厳密計算を使い、浮動小数点も変数への代入も使わない。添字集合の大きさは零から六で、零行列・密行列・反対称な非対角成分を持つ行列・巡回する疎行列・上三角行列の五族を用意する。対角を零にした35行列が主張の入力である。

零対角性を使わない行は、対角を制限しない35行列でも検算する。特に因子の取り出し・行列式の展開・和の分割を、両辺が零である入力だけで検査しない。各行の局所条件を下表に示す。反対称性は主張の仮定にせず、反対称でない零対角行列も含める。

`check_definitions.sage` は Python の置換列挙と SageMath の置換列挙・不動点・符号を独立に比較し、874置換・322個の不動点を持たない置換・35零対角行列、および空集合の行列式と一要素集合の条件を確認する。2026-10-11 に実行し、すべて通過した。

| ファイル | 本文の等号 | 入力の局所条件 | 状態 | 等式数 |
|---|---|---|---|---|
| `check_product_split.sage` | 有限積から指定因子を取り出す | 対角を制限しない35行列、全置換・全添字 | PASS（2026-10-11） | 25,195 |
| `check_fixed_index.sage` | 不動点の等号を行列成分へ代入 | 対角を制限しない35行列、不動点の全組 | PASS（2026-10-11） | 4,365 |
| `check_zero_diagonal.sage` | 対角成分零を代入 | 零対角35行列、不動点の全組 | PASS（2026-10-11） | 4,365 |
| `check_zero_times_remainder.sage` | 零と残りの積の乗法 | 対角を制限しない35行列、不動点の全組 | PASS（2026-10-11） | 4,365 |
| `check_substitute_zero_product.sage` | 成分積零を符号付き項へ代入 | 零対角35行列、不動点を持つ全置換 | PASS（2026-10-11） | 2,760 |
| `check_weight_times_zero.sage` | 符号係数と零の乗法 | 35行列の全置換の符号係数 | PASS（2026-10-11） | 4,370 |
| `check_determinant_definition.sage` | 行列式の置換展開 | 零対角35行列と対角を制限しない35行列 | PASS（2026-10-11） | 70 |
| `check_split_permutation_sum.sage` | 不動点の有無で有限和を二分 | 零対角35行列と対角を制限しない35行列 | PASS（2026-10-11） | 70 |
| `check_replace_excluded_terms.sage` | 除外される各項を零へ置換 | 零対角35行列 | PASS（2026-10-11） | 35 |
| `check_sum_of_zeros.sage` | 零の有限和を零へ置換 | 対角を制限しない35行列、空の除外集合も含む | PASS（2026-10-11） | 35 |
| `check_add_zero.sage` | 加法の零元を除く | 対角を制限しない35行列 | PASS（2026-10-11） | 35 |

このディレクトリで実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

有限個の入力の検算であり、一般の有限集合についての証明は本文と Lean に置く。

実行結果: 十二本すべて PASS。十一等号の検算は計45,665等式。定義の列挙・符号・空添字の確認も通過した。
