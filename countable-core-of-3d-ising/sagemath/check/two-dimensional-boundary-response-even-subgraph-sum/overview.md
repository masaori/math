# SageMath Check: 2 次元境界応答多項式の偶部分グラフ和

## 対象

**対象ラベル**: `claim_two_dimensional_boundary_response_even_subgraph_sum`

自由境界の $L'=1,L=2$ について、辺ごとの有限恒等式の展開後に現れるスピン和が、偶部分グラフでは $2^{\#V^{(2)}_L}$、それ以外では $0$ になることと、本文の整数係数多項式の等式を確認する。

## 結果

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check.sage` | 全配位と全辺部分集合の有限和を `ZZ` 上で直接比較 | PASS |

浮動小数点、無限和、非可算への脱出は使わない。

**2026-08-18 実行: PASS。**

## 実行方法

```sh
sage sagemath/check/two-dimensional-boundary-response-even-subgraph-sum/check.sage
```
