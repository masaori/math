# SageMath Check: i_times_negated_real_is_negation_of_i_times

## 対象

**対象ラベル**: `i_times_negated_real_is_negation_of_i_times`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_i_times_negated_real_is_negation_of_i_times`（`θ ∈ ℝ` で `i(-θ)_C = -(iθ_C)`）
- 範囲: 主張と、証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の六行 | `check_chain.sage` | 鎖の七つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。否定の対照: 符号を落とした `iθ` とは一致しない | **PASS** | 多項式として厳密等号 |

## 計算の帰属と範囲

`θ` を `QQ(i)` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、`θ` へ任意の実数を代入しても成り立つ（代入は環準同型である）。実数 `a` の包含の像 `a_C` は係数 `QQ ⊂ QQ(i)` の元として持つ。浮動小数点と `RR` / `CC` への脱出はない。積の結合律・可換律の適用は Sage の正規形で吸収されるので、確かめるのは各行に書かれた式（括弧・符号）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh i_times_negated_real_is_negation_of_i_times
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-09）。
