# 主一次コサイクルから双対一次サイクルへの係数移送写像の検算

**対象ラベル**: `def_primal_cocycle_to_dual_cycle_transport`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_primal_cocycle_to_dual_cycle_transport`）
- 範囲: 主辺係数移送の主一次コサイクル空間への制限について、始域、双対一次サイクル空間という終域、作用が定義どおりであること

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 二面三角形と双対辺ループが生じる一面例について、全ての主一次コサイクルを列挙し、制限写像の像が双対一次サイクル空間に属し、作用が既存の係数移送と一致することを照合する | PASS | 始域、終域、作用が二つの有限例で定義どおりに一致した |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。
- 第一ホモロジー類への作用はこの検算の対象に含めない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-cocycle-to-dual-cycle-transport/check_definition.sage
```
