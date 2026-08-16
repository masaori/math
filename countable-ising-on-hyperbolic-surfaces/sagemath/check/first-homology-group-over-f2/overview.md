# `F_2` 上の第一ホモロジー群の検算

**対象ラベル**: `def_first_homology_group_over_f2`

## 対象

- 構造化本文: 「`F_2` 上の第一ホモロジー群」
- 検算範囲: 一次サイクル空間を面境界空間の剰余集合へ分割した有限商と、各サイクルをその剰余集合へ送る商写像
- 併せて検証: `def_first_cycle_space_over_f2`、`def_face_boundary_space_over_f2`
- 帰属: 形式的な有限ラベル集合と `GF(2)` 上の有限行列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_quotient_set_and_map.sage` | 四元の一次サイクル空間を二元の面境界空間で割り、二つの剰余集合からなる商と、商写像の全射性、および二サイクルが同じ像をもつことと差が面境界であることの同値を全列挙する | PASS | 商は二元、商写像の像は商全体であり、全てのサイクル対で剰余集合判定が一致した |

実行日: 2026-08-16

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/first-homology-group-over-f2/check_quotient_set_and_map.sage
```
