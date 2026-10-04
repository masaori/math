# SageMath Check: 偶部分グラフに対応するスピン単項式の和

## 対象

**対象ラベル**: `claim_even_subgraph_spin_sum`

- 併せて検証: `def_edge_subset_incidence_count`、`def_even_edge_subset`、`def_edge_subset_spin_sum`
- 範囲: 辺の部分集合の各頂点における端点の偶奇と、全配位にわたるスピン単項式の和

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_monomial_regrouping.sage` | 各配位について辺スピン積を頂点ごとの冪の積へ並べ替える一行 | PASS | $L=1,2$ の全4,104組の配位と辺部分集合（2026-10-04 実行） |
| `check.sage` | $L=1,2$ は全辺部分集合・全配位、$L=3$ は全辺部分集合について頂点ごとの厳密因数分解を検査する | PASS | 偶部分グラフなら $2^{L^2}$、それ以外なら $0$ |

2026-10-04 に `check.sage` を実行し、追加した並べ替えの全4,104組、
$L=1,2$ の全260辺部分集合、$L=3$ の全262,144辺部分集合が通過した（終了コード0）。

## 備考

端点を辺の両端の番号つきで数えるため、$L=1$ の自己ループも次数へ二回寄与する。すべて `ZZ` の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/even-subgraph-spin-sum/check.sage
```

`check.sage` は行別検査 `check_monomial_regrouping.sage` も実行する。

**2026-08-12 実行: すべて通過。**

### 記録

- 2026-08-22: 本文から「偶部分グラフ生成多項式 $P_L(y)$」を削除した（どこからも引かれておらず、
  高温展開の多項式 $H_L$ は $P_L$ を経由せず直接定義されている）。この検証の該当部分も外した。
- 2026-10-04: この環境の `sage <file>` は `__file__` を Sage パッケージの位置として渡し、
  共有定義の読み込みで `OSError` になった。既存の micromamba の `sage` 環境にある Python から
  `sage.all` と `sage.repl.preparse.preparse` を読み込み、検査ファイルの絶対パスを `__file__` に指定して実行した。
