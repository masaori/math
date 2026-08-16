# 主一次余境界の係数移送が双対面境界空間になることの検算

**対象ラベル**: `theorem_primal_coboundary_transport_is_dual_boundary`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_theorem_primal_coboundary_transport_is_dual_boundary`）
- 範囲: 主一次余境界空間、双対二次境界行列、双対面境界空間、および主辺から双対辺への係数移送による両空間の一致

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_transport.sage` | 三角形と二本のループ辺をもつ一頂点例について、双対二次境界成分と主一次境界成分の対応、両包含、および全係数写像での移送式を照合する | PASS | 両例で移送後の主一次余境界空間と双対面境界空間が一致した |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。
- 主一次コサイクルの剰余類から双対第一ホモロジー類への写像は、この検算の対象に含めない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-coboundary-transport-is-dual-boundary/check_transport.sage
```
