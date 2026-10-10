# 多項式の有限和の積の添字写像展開の行別検算

**対象ラベル**: `claim_polynomial_product_of_sums`

本文の25等号を各1ファイルへ対応させる。円分体 $\mathbb Q(\zeta_8)[x]$ で多項式として比較し、値の代入や浮動小数点を使わない。有限集合の大きさはそれぞれ0〜3、係数族は零を含む定数・非有理係数の二次式・符号と非有理根を含む積の3種類（計48入力）。帰納段では全ての部分集合と追加点を取り、両逆写像と重みは全写像を列挙する。空集合・空の値域・途中の位置への挿入も含む。

この有限検算は一般の主張の証明ではない。一般の有限集合に対する証明は本文と Lean の帰納法にある。

| ファイル | 本文の等号 | 状態 | 結果 |
|---|---|---|---|
| `check_empty_product.sage` | 空積の値 | PASS | 48 等式 |
| `check_empty_function_unique.sage` | 空写像の一意性 | PASS | 48 等式 |
| `check_empty_weight.sage` | 空写像の重み | PASS | 48 等式 |
| `check_split_insert_definition.sage` | 値と制限への分解 | PASS | 768 等式 |
| `check_split_insert_new_value.sage` | 追加点の値 | PASS | 768 等式 |
| `check_split_insert_restriction.sage` | 元の写像への制限 | PASS | 768 等式 |
| `check_insert_split_new_definition.sage` | 逆向きの追加点での分解 | PASS | 768 等式 |
| `check_insert_split_new_value.sage` | 逆向きの追加点での値 | PASS | 768 等式 |
| `check_insert_split_old_definition.sage` | 逆向きの旧点での分解 | PASS | 984 等式 |
| `check_insert_split_old_value.sage` | 逆向きの旧点での値 | PASS | 984 等式 |
| `check_insert_split_old_restriction.sage` | 制限写像の評価 | PASS | 984 等式 |
| `check_weight_definition.sage` | 拡張した写像の重みの定義 | PASS | 768 等式 |
| `check_weight_factor.sage` | 追加点の因子の分離 | PASS | 768 等式 |
| `check_weight_insert_values.sage` | 挿入写像の各点での値 | PASS | 768 等式 |
| `check_weight_original.sage` | 元の写像の重み | PASS | 768 等式 |
| `check_induction_product_insert.sage` | 帰納段の有限積の分離 | PASS | 204 等式 |
| `check_induction_hypothesis.sage` | 帰納法の仮定の代入 | PASS | 204 等式 |
| `check_induction_sum_mul.sage` | 左因子の和の分配 | PASS | 204 等式 |
| `check_induction_mul_sum.sage` | 右因子の和の分配 | PASS | 204 等式 |
| `check_induction_product_index.sage` | 直積による添字付け | PASS | 204 等式 |
| `check_induction_weight.sage` | 拡張写像の重みへの置換 | PASS | 204 等式 |
| `check_induction_reindex.sage` | 全単射による再添字付け | PASS | 204 等式 |
| `check_conclusion_induction.sage` | 全体集合への帰納法の適用 | PASS | 48 等式 |
| `check_conclusion_weight.sage` | 結論の重みの定義 | PASS | 48 等式 |
| `check_conclusion_functions.sage` | 写像集合の定義 | PASS | 48 等式 |

各ファイルは `sage <ファイル>` で個別に実行できる。一括実行はこのディレクトリで次を使う。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

2026-10-10 実行: 全25本、計11580等式が PASS。初回の一括実行と個別実行は、Sage CLI の `__file__` が入力ファイルを指さず、共通定義の読込前に ERROR となった。一括ランナーでパスを明示し、個別実行では `sys.argv[0]` から入力の所在を得るようにした。検算の式・入力・判定は変えていない。
