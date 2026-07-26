# SageMath Check: 163_Z_Y_linearly_independent

## 対象

**対象ラベル**: `Z_Y_linearly_independent` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: {Z_1..Z_M, Y_1..Y_M} の C-線型独立性

各作用素を 4^M 次元ベクトルへ平坦化した (2M)×4^M 行列の特異値を見る。最小特異値が 0 から十分離れていることを確認し、条件数も記録する。重複を足してもランクが増えないことで判定が有意味であることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_rank.sage` | 数値ランクと最小特異値 | 12 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  M=2: 2M=4, sigma_min=2.000000e+00, sigma_max=2.000000e+00, cond=1.000
  M=3: 2M=6, sigma_min=2.828427e+00, sigma_max=2.828427e+00, cond=1.000
  M=4: 2M=8, sigma_min=4.000000e+00, sigma_max=4.000000e+00, cond=1.000
  M=5: 2M=10, sigma_min=5.656854e+00, sigma_max=5.656854e+00, cond=1.000
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 163
```

実行ログは `sagemath/check/163_Z_Y_linearly_independent/logs/` に保存してある（この表の数値はそのログから取った）。
