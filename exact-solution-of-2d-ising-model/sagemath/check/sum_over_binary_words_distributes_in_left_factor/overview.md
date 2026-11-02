# SageMath Check: sum_over_binary_words_distributes_in_left_factor

## 対象

**対象ラベル**: `sum_over_binary_words_distributes_in_left_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_sum_over_binary_words_distributes_in_left_factor`（`{0,1}^r` の上の和に右から行列を掛けると、各項に掛けた和になる）
- 範囲: 主張と、帰納法の二つの鎖。和は `def_sum_over_binary_words` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の三行と、`r → r+1` の四行 | `check_induction_lines.sage` | `{0,1}^r` の元をタプル、`(ε', e)` を末尾に `e` を付けたタプルとし、和を `def_sum_over_binary_words` の帰納法どおりに組んで、各行の項と帰納法の仮定を確かめる。独立な経路として Sage の和と積とも比べる。対照として、項ごとに右から掛ける行列を変えると一致しないこと | **PASS** | 形 `(m,n,p)` 4 通り × `r = 1, 2, 3` で 44 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環（`X_ε`・`C` の成分は不定元）で厳密に確かめた。浮動小数点はない。一般の `r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_over_binary_words_distributes_in_left_factor
```

実行ログは `sagemath/check/sum_over_binary_words_distributes_in_left_factor/logs/` に保存する（2026-11-02）。
