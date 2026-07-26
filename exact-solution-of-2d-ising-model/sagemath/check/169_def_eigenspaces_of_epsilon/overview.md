# SageMath Check: 169_def_eigenspaces_of_epsilon

## 対象

**対象ラベル**: `def_eigenspaces_of_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: ε² = I、固有値 ±1、F^{(±)} の次元がそれぞれ 2^{M−1}

ε = σ^x_1…σ^x_M であることと、固有値分解から両固有空間の次元を数える。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_eigenspaces.sage` | ε²=I、固有値、次元、ε の積表示 | 25 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  M=1: dim F^(+)=1, dim F^(-)=1, 2^(M-1)=1
  M=2: dim F^(+)=2, dim F^(-)=2, 2^(M-1)=2
  M=3: dim F^(+)=4, dim F^(-)=4, 2^(M-1)=4
  M=4: dim F^(+)=8, dim F^(-)=8, 2^(M-1)=8
  M=5: dim F^(+)=16, dim F^(-)=16, 2^(M-1)=16
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 169
```

実行ログは `sagemath/check/169_def_eigenspaces_of_epsilon/logs/` に保存してある（この表の数値はそのログから取った）。
