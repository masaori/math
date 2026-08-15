# 頂点リンク単巡回述語の検算

**対象ラベル**: `def_finite_cellulation_vertex_links_are_cycles`

## 対象

- 構造化本文: 「頂点リンクが一つの巡回列であるための有限述語」
- 検算範囲: 各辺端に二つの角が接し、各頂点の全ての角が辺端の共有によって一つにつながるという有限述語
- 帰属: 有限集合、整数、真偽値。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 二面三角形の球面を受理し、一頂点で二球面を貼った非多様体と同方向の面貼りを拒否する | PASS | 三つの有限入力で期待する真偽値と一致した |

実行日: 2026-08-15

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-cellulation-vertex-links-are-cycles/check.sage
```
