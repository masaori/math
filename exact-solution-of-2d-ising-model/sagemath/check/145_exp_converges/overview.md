# SageMath Check: 145_exp_converges

## 対象

**対象ラベル**: `exp_converges` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.mjs`

- 範囲: 有限次元ノルム線型空間上の線型写像 X について Σ(1/n!)X^n が各点収束すること

各点収束を「任意のベクトル v について部分和が Cauchy であること」と「極限が exp(X)v に一致すること」で確認する。極限写像が線型であることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_pointwise.sage` | 部分和の Cauchy 性、極限 = exp(X)v、極限の線型性 | 84 | 9.249e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

次元は 2,4,9,16（ad_X を線型写像として扱う場面の n² に相当する次元を含む）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 145
```

実行ログは `sagemath/check/145_exp_converges/logs/` に保存してある（この表の数値はそのログから取った）。
