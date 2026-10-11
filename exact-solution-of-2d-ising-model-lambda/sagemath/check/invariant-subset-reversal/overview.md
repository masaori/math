# 不変部分集合上の置換反転の行別検算

**対象ラベル**: `def_invariant_subset_reversal`, `claim_invariant_subset_reversal`

本文の24計算行（18等号・6同値）を一行一ファイルで調べる。空集合から六元集合までの全874置換と全ての不変部分集合を列挙した5,913組が入力である。不変部分集合は像の集合等号で選び、本文の所属同値と独立に照合する。逆置換を列の位置から求め、SageMath の置換の逆元でも照合する。`check_definitions.sage` は置換全体の独立列挙、反転の全単射性と逆写像、二度反転、空の添字集合、空部分集合と全体集合も調べる。

すべて有限集合と整数で扱い、実数体・複素数体・浮動小数点は使わない。有限個の検算であり、一般の有限集合についての証明は本文と Lean に置く。

| ファイル | 本文の計算行 | 局所条件 | 結果 | 確認数 |
|---|---|---|---|---|
| `check_inverse_membership_transport.sage` | 逆置換の所属に不変条件を使う | 全ての点 | PASS（2026-10-11） | 34,406 |
| `check_inverse_membership_cancel.sage` | 逆写像との合成を消す | 全ての点 | PASS（2026-10-11） | 34,406 |
| `check_backward_forward_inside_substitute.sage` | 内側で f の定義を代入 | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_backward_forward_inside_select.sage` | 内側で g の分岐を選ぶ | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_backward_forward_inside_cancel.sage` | 内側で g と f の合成を消す | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_backward_forward_outside_substitute.sage` | 外側で f の定義を代入 | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_backward_forward_outside_select.sage` | 外側で g の分岐を選ぶ | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_backward_forward_outside_cancel.sage` | 外側で g と f の合成を消す | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_inside_substitute.sage` | 内側で g の定義を代入 | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_inside_select.sage` | 内側で f の分岐を選ぶ | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_inside_cancel.sage` | 内側で f と g の合成を消す | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_outside_substitute.sage` | 外側で g の定義を代入 | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_outside_select.sage` | 外側で f の分岐を選ぶ | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_forward_backward_outside_cancel.sage` | 外側で f と g の合成を消す | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_reversal_membership_inside_substitute.sage` | 内側で反転した置換の所属を展開 | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_reversal_membership_inside_transport.sage` | 内側で逆置換の不変条件を使う | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_reversal_membership_outside_substitute.sage` | 外側で反転した置換の所属を展開 | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_reversal_membership_outside_transport.sage` | 外側で元の不変条件を使う | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_twice_inside_select.sage` | 内側で二度目の反転の分岐を選ぶ | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_twice_inside_inverse.sage` | 内側で証明した逆写像を代入 | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_twice_inside_backward.sage` | 内側で g の定義を代入 | 点が部分集合の内側 | PASS（2026-10-11） | 17,203 |
| `check_twice_outside_select.sage` | 外側で二度目の反転の分岐を選ぶ | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_twice_outside_forward.sage` | 外側で反転の写像を代入 | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |
| `check_twice_outside_definition.sage` | 外側で f の定義を代入 | 点が部分集合の外側 | PASS（2026-10-11） | 17,203 |

`check_definitions.sage` の結果: PASS（2026-10-11）。5,913組と独立列挙した874置換を確認した。24計算行は合計447,278確認で、全て通過した。

このディレクトリで実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```
