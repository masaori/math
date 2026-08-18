# SageMath Check: 2 次元境界応答多項式の偶部分グラフ和

## 対象

**対象ラベル**: `claim_two_dimensional_boundary_response_even_subgraph_sum`

自由境界の $L'=1,L=2$ について、辺ごとの有限恒等式の展開後に現れるスピン和が、偶部分グラフでは $2^{\#V^{(2)}_L}$、それ以外では $0$ になることと、本文の整数係数多項式の等式を確認する。

## 結果

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check.sage` | 全配位と全辺部分集合の有限和を `ZZ` 上で直接比較 | PASS |
| `check_terminal_lattice_polygon_dimer_bijection.sage` | $L'=1,L=2$ の四角形で、偶部分グラフと terminal lattice の完全マッチングの往復写像を全列挙 | PASS |

terminal lattice では、四角形の各頂点を二つの terminal とその間の内部辺へ置き換え、元の辺を対応する terminal 間の外部辺にする。偶部分グラフからは、選ばれなかった元の辺に対応する外部辺と、二本とも選ばれた頂点の内部辺を取る。逆向きには、完全マッチングに外部辺が無い元の辺を選ぶ。全列挙により、両側がそれぞれ 2 元で、この二写像が互いに逆であることを確認した。

浮動小数点、無限和、非可算への脱出は使わない。Pfaffian の符号と多項式の一致はこの検証の対象外である。

**2026-08-18 実行: PASS。**

## 実行方法

```sh
sage sagemath/check/two-dimensional-boundary-response-even-subgraph-sum/check.sage
sage sagemath/check/two-dimensional-boundary-response-even-subgraph-sum/check_terminal_lattice_polygon_dimer_bijection.sage
```
