# SageMath Check: 122_mat_conj

## 対象

**対象ラベル**: `mat_conj` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`

- 範囲: T_B(A) := BAB^{-1} が線型写像であること

B は exp で作って正則性を保証している。加法性と斉次性を別々に確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_linearity.sage` | 線型性・加法性・B の正則性 | 300 | 8.433e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 122
```

実行ログは `sagemath/check/122_mat_conj/logs/` に保存してある（この表の数値はそのログから取った）。
