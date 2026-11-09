# SageMath Check: 112_euler_formula_cos_sin

## 対象

**対象ラベル**: `euler_formula_cos_sin` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: cos θ = (e^{iθ}+e^{−iθ})/2、sin θ = (e^{iθ}−e^{−iθ})/(2i)

e^{iθ} を cos,sin から作った側と、numpy の複素指数で計算した側の 2 経路で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_euler.sage` | 両式と e^{iθ} = cos θ + i sin θ | 150 | 0.000e+00 | **PASS** |
| — | `check_negated_i_theta_chain.sage` | 証明の準備の `-(iθ_C) = i(-θ)_C` の 6 行の鎖（主張の読みの `-iθ` を Euler の公式の `φ = -θ` の形へ書き換える段）。`QQ(i)[t]` で各行の式どおりに組み、隣り合う項が厳密に等しい。それを使う exp の 1 行は、exp の引数どうしが等しいことを確かめるだけで exp の値は組まない。対照: 符号を落とした `iθ_C` とは一致しない | 6 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 112
```

実行ログは `sagemath/check/112_euler_formula_cos_sin/logs/` に保存してある（この表の数値はそのログから取った）。
