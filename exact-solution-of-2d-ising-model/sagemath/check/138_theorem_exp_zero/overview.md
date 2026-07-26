# SageMath Check: 138_theorem_exp_zero

## 対象

**対象ラベル**: `theorem_exp_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: exp(O) = I

scipy の expm と、級数を A⁰ = I の規約で足した結果の 2 経路。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_exp_zero.sage` | 両経路 | 12 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 138
```

実行ログは `sagemath/check/138_theorem_exp_zero/logs/` に保存してある（この表の数値はそのログから取った）。
