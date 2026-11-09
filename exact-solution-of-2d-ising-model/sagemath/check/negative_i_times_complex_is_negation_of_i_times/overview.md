# SageMath Check: negative_i_times_complex_is_negation_of_i_times

## 対象

**対象ラベル**: `negative_i_times_complex_is_negation_of_i_times`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_negative_i_times_complex_is_negation_of_i_times`（`z ∈ ℂ` で `(-i)z = -(iz)`）
- 範囲: 主張と、証明の三行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の三行 | `check_chain.sage` | 鎖の四つの項を各行に書かれた式どおりに組み、隣り合う項が等しい | **PASS** | 多項式として厳密等号 |
| 主張そのもの | 同上 | 左辺を Sage 組み込みの符号反転（独立な経路）で組んだ `-(iz)` と比べる。否定コントロールとして、符号を落とした `iz` とは一致しないことも確かめる | **PASS** | 多項式として厳密等号 |

## 計算の帰属と範囲

`z` を `QQ(i)` 上の多項式環の不定元 `zr + i·zi` に置いた。不定元で成り立つ多項式の等号は、`z` へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。符号反転は `multiply_by_minus_one` のとおり `(-1_C)·w` で組んだ。
鎖の項は多項式環の元なので、積の結合律の適用は Sage の正規形で吸収される。この検査が確かめるのは、各行に書かれた式（括弧・符号）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh negative_i_times_complex_is_negation_of_i_times
```

実行ログは `logs/` に保存する（2026-11-09）。
