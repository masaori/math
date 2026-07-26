# SageMath Check: 250_def_partition_function_2d_ising

## 対象

**対象ラベル**: `def_partition_function_2d_ising` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.mjs`

- 範囲: 定義の健全性と、独立に計算できる特別な場合との一致

**独立経路を 3 つ用意している**。(1) N=1 では行内結合が定数になるので Z = e^{J′M}·(周期 M の 1 次元 Ising の tr(T^M))。(2) 行と列を入れ替えると Z(J,J′;M,N) = Z(J′,J;N,M)（転置対称性）。(3) M=1 では行間結合が定数になるので同様に 1 次元 Ising に帰着する。加えて J=J′=0 で Z = 2^{MN} になることも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_definition_sanity.sage` | 値域、J=J′=0、1 次元への帰着（N=1, M=1）、転置対称性 | 30 | 2.273e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

高温展開の先頭項との比較は、周期境界（N=2 では同じ対を 2 回数える等）で補正項が大きく有意な検証にならないので採っていない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 250
```

実行ログは `sagemath/check/250_def_partition_function_2d_ising/logs/` に保存してある（この表の数値はそのログから取った）。
