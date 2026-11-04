# SageMath Check: real_sum_over_binary_words_distributes_in_left_factor

## 対象

**対象ラベル**: `real_sum_over_binary_words_distributes_in_left_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_sum_over_binary_words_distributes_in_left_factor`（`{0,1}^r` の上の実数の和に右から実数を掛けると、各項に掛けた和になる）
- 範囲: 主張と、帰納法の二つの鎖。和は `def_sum_over_binary_words_of_real_numbers` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 3 行と、`r → r+1` の 4 行 | `check_induction_lines.sage` | `x_ε`・`c` を `QQ` 上の多項式環の不定元に置き、和を定義の帰納法どおりに組んで、隣り合う行が一致することを確かめる。帰納法の仮定の行は `r − 1` の族 `ε' ↦ x_{(ε',1)} + x_{(ε',0)}` の場合を先に確かめる。否定コントロールとして、分配則の行で `x_{(ε',0)}c` を落とすと一致しないこと | **PASS** | `r = 1,…,5` で 28 個の等号。否定コントロール 4 件 |

## 計算の帰属と範囲

`x_ε`・`c` は ℝ の元の代わりに `QQ` 上の多項式環の不定元で与えた。鎖が使うのは ℝ の和・積と分配則 `(a + b)c = ac + bc` だけで、どれも多項式環で成り立つので、厳密計算で確かめられる。浮動小数点はない。一般の `r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_sum_over_binary_words_distributes_in_left_factor
```

実行ログは `sagemath/check/real_sum_over_binary_words_distributes_in_left_factor/logs/` に保存する（2026-11-04）。
