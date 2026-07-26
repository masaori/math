# SageMath Check: 139_scalar_identity_commutes

## 対象

**対象ラベル**: `scalar_identity_commutes` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: [cI, A] = 0

一般の W では [W,A] ≠ 0 になること（主張が非自明であること）も確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_scalar.sage` | 恒等式と非自明性 | 104 | 1.776e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 139
```

実行ログは `sagemath/check/139_scalar_identity_commutes/logs/` に保存してある（この表の数値はそのログから取った）。
