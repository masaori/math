# 双対辺の端点写像の検算

**対象ラベル**: `def_dual_edge_endpoint_map`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_dual_edge_endpoint_map`）
- 範囲: 各主辺の向きごとの一意な面境界出現から、対応する双対辺の始点と終点を選ぶ有限写像
- 併せて検証: 同じ主面に二つの主辺出現が属する場合、双対辺の二端点が一致し得ること

## チェック一覧

実行日: 2026-08-17

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 二面三角形と同一面自己接続の二例で、向きごとの出現の一意性と双対端点の定義を照合する | PASS | 各向きが一つの主辺出現を選び、相異なる二面と同一面自己接続の両場合で双対端点が定義どおりになる |

## 備考

- 有限集合の列挙と等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。
- 端点の相異なりは検証対象に含めない。同じ主面に逆向きの二出現がある場合は、双対辺の二端点が一致する。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/dual-edge-endpoint-map/check_definition.sage
```
