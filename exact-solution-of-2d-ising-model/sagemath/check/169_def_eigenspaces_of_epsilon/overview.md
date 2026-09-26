# SageMath Check: 169_def_eigenspaces_of_epsilon

## 対象

**対象ラベル**: `def_eigenspaces_of_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: `def_even_eigenvectors_of_epsilon` の F^{(+)} = {f ∈ ℂ^{2^M} | εf = f} が ℂ^{2^M} の ℂ-部分線型空間であること
  （本文は `even_eigenspace_is_complex_subspace` を引いて述べる統合結果）

乱数で作った F^{(+)} の元 f = x + εx、g について、零ベクトル・和 f+g・複素スカラー倍 af が εh = h を満たすことを確かめる。
あわせて ε = σ^x_1…σ^x_M の積表示と、観測として dim F^{(+)} = 2^{M−1} を出力する（次元は本文の主張ではない）。
部分空間性の一行ずつの厳密検証は `check/even_eigenspace_is_complex_subspace/` にある。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_eigenspaces.sage` | ε の積表示、F^{(+)} の零・和・スカラー倍についての閉性、次元（観測） | 75 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  M=1: dim F^(+)=1, 2^(M-1)=1
  M=2: dim F^(+)=2, 2^(M-1)=2
  M=3: dim F^(+)=4, 2^(M-1)=4
  M=4: dim F^(+)=8, 2^(M-1)=8
  M=5: dim F^(+)=16, 2^(M-1)=16
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 169
```

実行ログは `sagemath/check/169_def_eigenspaces_of_epsilon/logs/` に保存してある（この表の数値はそのログから取った。2026-09-26、SageMath 10.9）。

## (−) セクターの退避に伴う更新（2026-09-26）

本文の主張が F^{(+)} だけになったので、F^{(−)} の次元と固有値 ±1 の判定を外し、F^{(+)} の部分空間性を確かめる形に書き直した。
書き直す前の両符号版は `sagemath/_old/minus-sector/169_def_eigenspaces_of_epsilon/` にある。
