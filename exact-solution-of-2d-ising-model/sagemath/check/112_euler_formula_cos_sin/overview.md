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
| — | `check_exp_negated_argument_line.sage` | 証明の準備の `exp(-iθ)` の鎖の 1 行目 `exp(-(iθ_C)) = exp(i(-θ)_C)`（根拠は `i_times_negated_real_is_negation_of_i_times` を右辺から左辺へ。その主張の鎖は `sagemath/check/i_times_negated_real_is_negation_of_i_times/` が確かめる）。`QQ(i)[t]` で exp の引数どうしが厳密に等しいことだけを確かめ、exp の値は組まない。対照: 符号を落とした `iθ_C` とは一致しない | 1 | 厳密 | **PASS** |
| — | `check_quotient_lines.sage` | 証明の二つの鎖の先頭 5 行ずつ（`cos θ = 1_C cos θ = (2_C^{-1}2_C)cos θ = 2_C^{-1}(2_C cos θ) = (2_C cos θ)2_C^{-1} = (2_C cos θ)/2_C`、`sin θ` は `2_C i` で同じ形）。根拠は積の単位元・`multiplicative_group_of_cc` の逆元・積の結合律・可換律・`def_complex_quotient`。`QQ(i)(c, s)`（`c, s` は `(cos θ)_C, (sin θ)_C` の不定元）で商を `z w^{-1}` と組み、隣り合う行の等号と、次の行の分子 `(cos θ + i sin θ) ± (cos θ - i sin θ)` との一致を確かめる。対照: 逆元を掛け忘れた行、割る数を取り違えた行とは一致しない | 6 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 112
```

実行ログは `sagemath/check/112_euler_formula_cos_sin/logs/` に保存してある（この表の数値はそのログから取った）。
