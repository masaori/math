# SageMath Check: 135_real_exp_series_converges

## 対象

**対象ラベル**: `real_exp_series_converges` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: (1) 単調非減少・上に有界、(2) E_N(a) ≤ E(a)、(3) 剰余 R_N(a) → 0 と Σ_{m=p}^{q} a^m/m! ≤ R_{p-1}(a)

a = 0 から 20 まで振って、部分和の単調性・上界・剰余評価を確認する。(3) の部分和の評価は p,q の複数の組で見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_real_series.sage` | (1)〜(3) | 168 | 4.018e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 135
```

実行ログは `sagemath/check/135_real_exp_series_converges/logs/` に保存してある（この表の数値はそのログから取った）。
