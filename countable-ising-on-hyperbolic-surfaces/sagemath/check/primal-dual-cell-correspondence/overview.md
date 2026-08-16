# 主セルと双対セルの対応データの検算

**対象ラベル**: `def_primal_dual_cell_correspondence`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_primal_dual_cell_correspondence`）
- 範囲: 二面三角形の球面と同じセル数をもつ形式的有限ラベル集合に対する、主面から双対頂点、主辺から双対辺、主頂点から双対面への三つの全単射

## チェック一覧

実行日: 2026-08-17

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 主セルと双対セルのラベル集合の分離、三つの写像の単射性・全射性、対応元の復元を照合する | PASS | 主面・主辺・主頂点が、それぞれ別の双対頂点・双対辺・双対面ラベル集合へ全単射で移る |

## 備考

- この検算はセルラベルの対応だけを扱う。双対辺の端点写像と双対面の境界語は後続の別ブロックの対象である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-dual-cell-correspondence/check_definition.sage
```
