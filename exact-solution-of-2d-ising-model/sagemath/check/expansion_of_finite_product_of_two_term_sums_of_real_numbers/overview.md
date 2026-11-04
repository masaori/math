# SageMath Check: expansion_of_finite_product_of_two_term_sums_of_real_numbers

## 対象

**対象ラベル**: `expansion_of_finite_product_of_two_term_sums_of_real_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_expansion_of_finite_product_of_two_term_sums_of_real_numbers`（実数の二項の和の有限積の展開）
- 範囲: 主張と、帰納法の二つの鎖。有限積は `def_finite_product_of_real_numbers`、和は `def_sum_over_binary_words_of_real_numbers` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の 4 行と、`r → r+1` の 7 行 | `check_induction_lines.sage` | `a_j^{(e)}` を `QQ` 上の多項式環の不定元に置き、有限積を `a_1` から左へ掛け、和を定義の帰納法どおりに組んで、隣り合う行が一致することを確かめる。帰納法の仮定の行は `r` 個の場合を先に確かめる。独立な経路として、Sage の `prod` と全ての語の積の和とも比べる。否定コントロールとして、語を一つ落とした和は左辺と一致しないこと | **PASS** | `r = 1,…,6` で 50 個の等号。否定コントロール 6 件 |

## 計算の帰属と範囲

`a_j^{(e)}` は ℝ の元の代わりに `QQ` 上の多項式環の不定元で与えた。鎖が使うのは ℝ の和・積と二つの分配則だけで、どれも多項式環で成り立つので、厳密計算で確かめられる。浮動小数点はない。一般の `r` は人手証明の帰納法が担う。

## 確かめられない行と理由

`r = 1` の 2 行目・3 行目と、`r → r+1` の 5 行目・6 行目（語の成分の読み出しと積の定義を右辺から左辺へ使う行）は、検算でも同じ値を別の形で組むだけなので、写し間違いの検出にしか効かない。実質の比較は帰納法の仮定・分配の 2 行と、主張そのもの（独立な経路との照合を含む）である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh expansion_of_finite_product_of_two_term_sums_of_real_numbers
```

実行ログは `sagemath/check/expansion_of_finite_product_of_two_term_sums_of_real_numbers/logs/` に保存する（2026-11-04）。
