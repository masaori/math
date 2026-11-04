# SageMath Check: real_inclusion_preserves_sum_over_binary_words

## 対象

**対象ラベル**: `real_inclusion_preserves_sum_over_binary_words` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_inclusion_preserves_sum_over_binary_words`（`{0,1}^r` の上の実数の和の包含は、包含の和に等しい）
- 範囲: 主張と、証明の帰納法の `r = 1` の 3 行・`r → r + 1` の 4 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 3 行（ℂ の和の定義・`real_inclusion_preserves_sum`・ℝ の和の定義） | `check_induction_lines.sage` | `x_ε` を不定元に置き、隣り合う行が等しい | **PASS** | 3 個の等号 |
| `r → r + 1` の 4 行（ℂ の和の定義・`real_inclusion_preserves_sum` を各項へ・帰納法の仮定・ℝ の和の定義） | 同上 | `r + 1 = 2,…,5` で隣り合う行が等しい。帰納法の仮定も各 `r` で、族 `ε' ↦ x_{(ε',1)} + x_{(ε',0)}` について確かめた。最後の行を Sage の `sum` と比べた。否定コントロールは、帰納法の仮定の行の族を `x_{(ε',1)} + x_{(ε',1)}` に替えると次の行と外れること（4 件）と、項を一つ落とすと和が変わること（5 件。こちらは `real_sum` が各項に依ることを見るだけで、証明の行は見ない） | **PASS** | 16 個の等号 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち、ℂ の和（`def_sum_over_binary_words_of_complex_numbers`）と ℝ の和（`def_sum_over_binary_words_of_real_numbers`）は、どちらも定義の帰納法どおりに（最後の成分で `1` を `0` より先に）足す別々の関数で組んだ。`x_ε` は `QQ` 上の多項式環の不定元である。

## 確かめられない行と理由

一般の `r` は検算の範囲外で、人手証明の帰納法が担う。和の定義を展開する行（`r = 1` の 1 行目と 3 行目、`r → r + 1` の 1 行目と 4 行目）は、和を定義どおりに組む関数どうしの比較なので、検算では同語反復である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_sum_over_binary_words
```

実行ログは `sagemath/check/real_inclusion_preserves_sum_over_binary_words/logs/` に保存する。
