# SageMath Check: expansion_of_finite_product_of_two_term_sums

## 対象

**対象ラベル**: `expansion_of_finite_product_of_two_term_sums` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_expansion_of_finite_product_of_two_term_sums`（二項の和の有限積の展開）
- 範囲: 主張と、帰納法の二つの鎖。有限積は `def_finite_product_of_matrices`、和は `def_sum_over_binary_words` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の四行と、`r → r+1` の七行 | `check_induction_lines.sage` | 有限積を `A_1` から左へ掛け（空の積は使わない）、`{0,1}^r` の上の和を定義の帰納法どおりに組んで、各行の項が隣どうし一致することを確かめる。独立な経路として、Sage の積と和で全ての語の積を足したものとも比べる。対照として、語を一つ落とした和は一致しないこと | **PASS** | `n = 1, 2` × `r = 1, 2, 3` で 36 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環（`A_j^{(e)}` の成分は不定元）で厳密に確かめた。不定元の行列は互いに可換でないので、因子の可換性を使わずに成り立つことも確かめている。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh expansion_of_finite_product_of_two_term_sums
```

実行ログは `sagemath/check/expansion_of_finite_product_of_two_term_sums/logs/` に保存する（2026-11-02）。
