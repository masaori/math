# SageMath Check: 190_exp_sum

## 対象

**対象ラベル**: `exp_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: Σ_{j=1}^{M} exp(2πijk/M) = M·δ^M_{(k,0)}

M = 1..12、k を −3M..3M で振る。k が M の倍数でないとき和が 0 になる（M ではない）ことも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_geometric_sum.sage` | 全 (M,k) と非自明性 | 491 | 7.877e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 190
```

実行ログは `sagemath/check/190_exp_sum/logs/` に保存してある（この表の数値はそのログから取った）。
