# SageMath Check: 191_hatZ_hatY_M_periodicity

## 対象

**対象ラベル**: `hatZ_hatY_M_periodicity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: hatZ^{(−)}_M = hatZ^{(−)}_{−M}、hatY_M = hatY_{−M}

本文は μ = ±M の特殊値だけを述べているが、ここでは**一般の μ ∈ Z について M 周期であること**も確認している。加えて hatZ^{(+)} と hatZ^{(−)} の差が j=1 の項だけであること（差 = 2Z₁e^{−i2πμ/M}）も見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_periodicity.sage` | 特殊値と一般の周期性、両符号の差 | 206 | 1.328e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 191
```

実行ログは `sagemath/check/191_hatZ_hatY_M_periodicity/logs/` に保存してある（この表の数値はそのログから取った）。
