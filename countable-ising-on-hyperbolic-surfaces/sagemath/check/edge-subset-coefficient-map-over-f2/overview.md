# 辺部分集合から `F_2` 辺係数写像への変換の検算

**対象ラベル**: `def_edge_subset_coefficient_map_over_f2`

## 対象

- 構造化本文: 「辺部分集合から `F_2` 辺係数写像への変換」
- 検算範囲: 有限辺部分集合を、所属する辺で `1`、所属しない辺で `0` を返す `GF(2)` 係数写像へ送る定義
- 帰属: 形式的な有限辺ラベル集合、有限冪集合、`GF(2)` 上の有限係数列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 三つの形式的辺ラベルの全ての部分集合について、各成分が定義の二場合と一致し、得られる係数列が `GF(2)` の全係数列を尽くすことを検査する | PASS | 八つの部分集合と八つの係数列が定義どおり一致した |

実行日: 2026-08-16

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/edge-subset-coefficient-map-over-f2/check_definition.sage
```
