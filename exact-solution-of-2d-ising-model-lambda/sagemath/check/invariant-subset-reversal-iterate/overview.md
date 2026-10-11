# 不変部分集合上の反転と反復の行別検算

**対象ラベル**: `def_finite_map_iteration`, `claim_invariant_subset_reversal_iterate`

本文十二等号を一行一ファイルで調べる。不変部分集合上の反転の既存検算と同じ、空集合から六元集合までの全874置換と全不変部分集合の5,913組を使う。各点について、零回の反復と、帰納段階の回数が零から十二までの式を照合する。反復の値は点を一歩ずつ進めるループで計算する。

定義の検算は、空集合から四元集合までの全289写像について本文の再帰による値と点を進めるループの値を零回から十三回まで独立に比較する。置換に限らない写像、空の添字集合、空部分集合と全体集合も含む。有限集合と自然数だけを使い、浮動小数点は使わない。有限個の検算であり、一般の証明は本文と Lean に置く。

| ファイル | 本文の行 | 条件 | 結果 | 確認数 |
|---|---|---|---|---|
| `check_base_inside_unfold.sage` | 零回の反転を恒等写像へ展開 | 内側 | PASS（2026-10-11） | 17,203 |
| `check_base_inside_fold.sage` | 対応する写像の零回の反復へ戻す | 内側 | PASS（2026-10-11） | 17,203 |
| `check_successor_inside_unfold.sage` | 反転の反復から最初の一歩を出す | 内側 | PASS（2026-10-11） | 223,639 |
| `check_successor_inside_substitute.sage` | 内外に応じた一歩の定義を代入 | 内側 | PASS（2026-10-11） | 223,639 |
| `check_successor_inside_induction.sage` | 所属を保つ始点で帰納法の等式を照合 | 内側 | PASS（2026-10-11） | 223,639 |
| `check_successor_inside_fold.sage` | 最初の一歩を反復へ戻す | 内側 | PASS（2026-10-11） | 223,639 |
| `check_base_outside_unfold.sage` | 零回の反転を恒等写像へ展開 | 外側 | PASS（2026-10-11） | 17,203 |
| `check_base_outside_fold.sage` | 対応する写像の零回の反復へ戻す | 外側 | PASS（2026-10-11） | 17,203 |
| `check_successor_outside_unfold.sage` | 反転の反復から最初の一歩を出す | 外側 | PASS（2026-10-11） | 223,639 |
| `check_successor_outside_substitute.sage` | 内外に応じた一歩の定義を代入 | 外側 | PASS（2026-10-11） | 223,639 |
| `check_successor_outside_induction.sage` | 所属を保つ始点で帰納法の等式を照合 | 外側 | PASS（2026-10-11） | 223,639 |
| `check_successor_outside_fold.sage` | 最初の一歩を反復へ戻す | 外側 | PASS（2026-10-11） | 223,639 |
| `check_definitions.sage` | 反復の定義 | 全写像 | PASS（2026-10-11） | 289写像・15,596点の値 |

このディレクトリで実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

2026-10-11 に十三本すべて通過。本文十二等号は合計1,857,924確認、定義は289写像・15,596点の値を確認した。
