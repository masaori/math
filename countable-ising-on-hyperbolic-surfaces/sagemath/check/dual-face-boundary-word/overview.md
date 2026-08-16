# 双対面の向き付き境界語の検算

**対象ラベル**: `def_dual_face_boundary_word`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_dual_face_boundary_word`）
- 範囲: 各主頂点の角位置から頂点リンクの後者写像を作り、出発側の主辺と向きを対応する双対面の境界語へ移す有限構成
- 併せて検証: 双対辺端点写像に対する境界語の接続条件

## チェック一覧

実行日: 2026-08-17

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 二面三角形の球面と一面一頂点トーラスで、頂点リンクの後者写像、双対面境界語、双対端点の接続条件を照合する | PASS | 球面では各双対面が二辺境界となり、トーラスでは二つのループ双対辺が各二回現れる四辺境界となる |

## 備考

- 有限集合の列挙と等号だけを用いる厳密検算である。
- 一面一頂点トーラスは、同じ主面へ接続する双対辺の二端点が一致する場合と、同じ双対辺が一つの双対面境界へ複数回現れる場合を同時に検査する。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/dual-face-boundary-word/check_definition.sage
```
