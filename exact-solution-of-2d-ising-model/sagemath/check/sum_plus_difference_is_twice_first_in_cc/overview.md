# SageMath Check: sum_plus_difference_is_twice_first_in_cc

## 対象

**対象ラベル**: `sum_plus_difference_is_twice_first_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_sum_plus_difference_is_twice_first_in_cc`（`a, b ∈ ℂ` で `(a+b) + (a-b) = 2_ℂ a`）
- 範囲: 主張と、証明の鎖の全行（11 行目が引く `one_plus_one_is_two_in_cc` の鎖は `sagemath/check/one_plus_one_is_two_in_cc/` が確かめる）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_chain.sage` | `ℂ` を実数の対、和を成分ごと、積を `definition_of_cc` の式、符号反転を `multiply_by_minus_one` の `(-1_C)` との積、差を `def_complex_difference` の `z + (-w)` として、鎖の各項を各行に書かれた式どおりに組み、隣り合う項が等しい。1 行目（差を定義どおりに開く行）は組み方から自明に等しい。中身のある検算は 2〜11 行目である。否定の対照を 2 件置く（7 行目の `b + (-b)` を `b` に替える、結論を `2_C b` に替える） | **PASS** | 対の成分の多項式としての厳密等号 |

## 計算の帰属と範囲

複素数の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ（代入は環準同型である）。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_plus_difference_is_twice_first_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-11）。
