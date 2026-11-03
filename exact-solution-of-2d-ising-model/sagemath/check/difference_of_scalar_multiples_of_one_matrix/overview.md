# SageMath Check: difference_of_scalar_multiples_of_one_matrix

## 対象

**対象ラベル**: `difference_of_scalar_multiples_of_one_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_difference_of_scalar_multiples_of_one_matrix`（一つの行列のスカラー倍の差は係数の差によるスカラー倍に等しい）
- 範囲: 主張 `aA − bA = (a − b)A` と、証明の `(i,k)` 成分の九行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の九行 | `check_entry_chain.sage` | 鎖の項を各行に書かれた式どおりに組み（複素数の符号反転は `multiply_by_minus_one` の `(-1)·z`）、隣り合う項が等しい | **PASS** | 9 通りの大きさ、全成分（36 成分）で厳密等号 |
| 主張そのもの | 同上 | 本文の定義で組んだ左辺を、Sage 組み込みのスカラー倍と差（独立な経路）と比べる。否定コントロールとして `(b − a)A` とは一致しないことも確かめる | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`a, b` と `A` の成分（`m, n ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ。
浮動小数点と `RR` / `CC` への脱出はない。積の結合律・分配律の行は、可換な多項式環の上では構成上いつも一致するので、写し間違いの検出だけに効く。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh difference_of_scalar_multiples_of_one_matrix
```

実行ログは `sagemath/check/difference_of_scalar_multiples_of_one_matrix/logs/` に保存する（2026-11-03）。
