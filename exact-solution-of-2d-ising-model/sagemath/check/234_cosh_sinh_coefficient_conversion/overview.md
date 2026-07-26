# SageMath Check: 234_cosh_sinh_coefficient_conversion

## 対象

**対象ラベル**: `cosh_sinh_coefficient_conversion` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: (i/2)K₁H₁^{(±)} 版と iK₂*H₂ 版の n 重交換子の係数

196（nesting）は K₁H₁ 版だが、こちらは指数の肩に実際に現れる (i/2)K₁H₁ と iK₂*H₂ の版。n = 0..6 で係数 iK₁ⁿ / K₁ⁿ、−i(2K₂*)ⁿ / (2K₂*)ⁿ を確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_conversion.sage` | (h1.z) と (h2.z−) の係数変換 | 1134 | 1.771e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 234
```

実行ログは `sagemath/check/234_cosh_sinh_coefficient_conversion/logs/` に保存してある（この表の数値はそのログから取った）。
