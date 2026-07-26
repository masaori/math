# SageMath Check: 143_brianhall_exc14

## 対象

**対象ラベル**: `brianhall_exc14` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.mjs`

- 範囲: e^{ad_X}(Y) の級数表示

142 と同じ 3 経路。加えて ad_X の n²×n² 行列表示が正しいこと（vec 版と交換子が一致すること）を単独で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_series.sage` | 級数表示と ad_X の行列表示 | 36 | 5.423e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 143
```

実行ログは `sagemath/check/143_brianhall_exc14/logs/` に保存してある（この表の数値はそのログから取った）。
