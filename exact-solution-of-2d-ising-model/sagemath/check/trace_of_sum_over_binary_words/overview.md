# SageMath Check: trace_of_sum_over_binary_words

## 対象

**対象ラベル**: `trace_of_sum_over_binary_words` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_trace_of_sum_over_binary_words`（`{0,1}^r` の上の行列の和のトレースは、各項のトレースの和）
- 範囲: 主張と、準備の鎖・帰納法の二つの鎖。行列の和は `def_sum_over_binary_words`、複素数の和は
  `def_sum_over_binary_words_of_complex_numbers` の帰納法どおりに組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の三行（`tr(A+B) = tr(1A+1B) = 1tr(A)+1tr(B) = tr(A)+tr(B)`） | `check_induction_lines.sage` | `A, B` の成分を不定元に置き、和・スカラー倍・トレースを本文の成分の式で組んで隣り合う行を比べる。独立な経路として Sage の和と `trace` とも比べる | **PASS** | `n = 1,…,4` で 12 行 |
| `r = 1` の三行と、`r → r+1` の四行 | 同上 | `{0,1}^r` の元をタプル、`(ε', e)` を末尾に `e` を付けたタプルとし、二つの和を定義の帰納法どおりに組んで各行と帰納法の仮定を確かめる。独立な経路として Sage の和と `trace` とも比べる。対照として、右辺の和から一つの項を落とすと一致しないこと | **PASS** | `n = 1, 2, 3` × `r = 1, 2, 3` で 33 行 |

各鎖の 1 行目（`def_sum_over_binary_words` の展開）と最後の行（複素数の和の定義を右辺から左辺へ）は、同じ再帰関数で組むので構成上一致し、写し間違いの検出にだけ効く。実質の比較は、準備の鎖、帰納法の仮定、各項への準備の鎖、Sage の `trace`・和との独立な経路である。

## 計算の帰属と範囲

`QQ` 上の多項式環（`B_ε` の成分は不定元）で厳密に確かめた。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_of_sum_over_binary_words
```

実行ログは `sagemath/check/trace_of_sum_over_binary_words/logs/` に保存する（2026-11-03）。
