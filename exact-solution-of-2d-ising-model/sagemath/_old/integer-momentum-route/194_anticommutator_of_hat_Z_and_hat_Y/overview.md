# SageMath Check: 194_anticommutator_of_hat_Z_and_hat_Y

## 対象

**対象ラベル**: `anticommutator_of_hat_Z_and_hat_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/007_hatZ_hatY_anticommutation.ts`

- 範囲: hat の反交換関係 4 式（同符号・異符号・hatZ と hatY・hatY どうし）

異符号の式に現れる補正項 −2exp(−i(2π/M)(μ+ν))·2I の係数と符号まで含めて確認する。μ+ν が M の倍数になる場合とならない場合の両方を含む全 (μ,ν) で回している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_four_relations.sage` | 4 式 × 全 (μ,ν) × M=2..5 | 1512 | 7.065e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 194
```

実行ログは `sagemath/check/194_anticommutator_of_hat_Z_and_hat_Y/logs/` に保存してある（この表の数値はそのログから取った）。
