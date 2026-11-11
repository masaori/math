# SageMath Check: complex_times_negation_is_negation_of_product_in_cc

## 対象

**対象ラベル**: `complex_times_negation_is_negation_of_product_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_complex_times_negation_is_negation_of_product_in_cc`（`z, w ∈ ℂ` で `z(-w) = -(zw)`）
- 範囲: 主張と、証明の鎖の全行（5 行）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_chain.sage` | `ℂ` を実数の対、和・積を `definition_of_cc` の式、符号反転を `multiply_by_minus_one` の `(-1_C)` との積として、鎖の各項を各行に書かれた式どおりに組み、隣り合う項が等しい。`multiply_by_minus_one` を開く行（1・5 行目）は、符号反転を `(-1_C)` との積で組んでいるので組み方から自明に等しい。中身のある検算は 2〜4 行目 である。否定の対照を 1 件置く | **PASS** | 対の成分の多項式としての厳密等号 |

## 計算の帰属と範囲

複素数の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ（代入は環準同型である）。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_times_negation_is_negation_of_product_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-11）。
