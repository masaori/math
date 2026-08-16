# 主一次コサイクルの係数移送が双対一次サイクルになることの検算

**対象ラベル**: `theorem_primal_cocycle_transport_is_dual_cycle`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_theorem_primal_cocycle_transport_is_dual_cycle`）
- 範囲: 双対一次境界行列が主二次境界行列の転置と一致し、主一次コサイクルの係数移送が双対一次境界で零へ写ること

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_transport.sage` | 二面三角形と、一面内の二出現から双対辺ループが生じる例について、双対 incidence と主二次境界の転置の成分一致、および式変形の各段を全係数写像で照合する | PASS | 全ての主一次コサイクルの移送が双対一次サイクルになった |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 同じ双対頂点を二端にもつ双対辺では、二つの端点寄与が `GF(2)` 上で相殺することも検算した。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-cocycle-transport-is-dual-cycle/check_transport.sage
```
