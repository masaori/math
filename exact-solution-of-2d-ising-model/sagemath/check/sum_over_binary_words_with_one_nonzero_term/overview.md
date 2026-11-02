# SageMath Check: sum_over_binary_words_with_one_nonzero_term

## 対象

**対象ラベル**: `sum_over_binary_words_with_one_nonzero_term` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_sum_over_binary_words_with_one_nonzero_term`（`{0,1}^r` の上の和で、一つの項以外が零行列なら、和はその項に等しい）
- 範囲: 主張と、帰納法の鎖（`r = 1` の二つの場合、`r → r+1` の前提の確認・二行・`e = 1`・`e = 0` の場合）。和は `def_sum_over_binary_words` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の二つの場合の三行ずつと、`r → r+1` の `δ' ≠ δ` の三行（`C_{δ'}` の定義の行を含む）・本体の四行・二つの場合の三行ずつ | `check_induction_lines.sage` | `{0,1}^r` の元をタプル、`(ε', e)` を末尾に `e` を付けたタプルとし、`ε'` の項だけを不定元の行列、他を零行列とした族について、和を `def_sum_over_binary_words` の帰納法どおりに組んで各行と帰納法の仮定を確かめる。独立な経路として Sage の和とも比べる。対照として、`ε'` 以外に零でない項があると一致しないこと | **PASS** | 形 `(m,n)` 4 通り × `r = 1..4` × 全ての `ε'` で 2496 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環（`B_{ε'}` の成分は不定元）で厳密に確かめた。浮動小数点はない。一般の `r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_over_binary_words_with_one_nonzero_term
```

実行ログは `sagemath/check/sum_over_binary_words_with_one_nonzero_term/logs/` に保存する（2026-11-02）。
