# SageMath Check: sin_of_negated_real

## 対象

**対象ラベル**: `sin_of_negated_real`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_sin_of_negated_real`（`θ ∈ ℝ` で `(sin(-θ))_C = -(sin θ)_C`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の六行 | `check_chain.sage` | 各行を書かれた式どおりに組み、隣り合う行が有理関数として等しく、最終行が `euler_formula_cos_sin` の `(sin θ)_C` の式の符号反転に等しい。否定の対照: `b − a ≠ a − b`、符号を落とした `(sin θ)_C` とは一致しない | **PASS** | 厳密 |

## 計算の帰属と範囲

`exp` を引数の多項式で引く記号にし、`exp(iθ_C)`・`exp(-(iθ_C))` を `QQ(i)` 上の有理関数体の不定元 `Ep`・`Em` に置いた。各行の `exp` の引数は行に書かれた式どおりに組み、引く主張（`i_times_negated_real_is_negation_of_i_times`・`negation_of_i_times_negated_real_is_i_times`）の等号は引数の多項式の等号として確かめた。浮動小数点はない。

## 確かめられない行と理由

- 第 1 行と最終行は `euler_formula_cos_sin` を当てはめる行で、その主張は全実数上の cos・sin（本文で未整備）を前提にしている。検算は当てはめの形を確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sin_of_negated_real
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-09）。
