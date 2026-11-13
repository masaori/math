# SageMath Check: complex_zero_plus_is_original

## 対象

**対象ラベル**: `complex_zero_plus_is_original` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_zero_plus_is_original`（複素数に 0 を左から足しても変わらない）
- 範囲: 主張 `0_C + z = z` と、証明の四行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0_C + z = (0,0) + (a,b)`（包含写像の略記） | `check_chain_and_statement.sage` | 共通の準備の `iota(0)` が `(0, 0)` である | **PASS** | 厳密等号 |
| `= (0 + a, 0 + b)`（複素数の和の定義） | 同上 | 実数の 0 を不定元 `o` に置き、共通の準備の和 `(o, o) + (a, b)` と、本文の行を写した `(o + a, o + b)` が等しい | **PASS** | 厳密等号 |
| `= (a, b)`（`ℝ` で `0 + x = x` を 2 箇所） | 同上 | 第二行へ `o = 0` を代入した対が `(a, b)` に等しい | **PASS** | 厳密等号 |
| `= z` | 同上 | `(a, b)` が `z` の置き方そのものである | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | 本文の和で `0_C + z = z`。Sage の `QQ(i)`（独立な経路）で `0 + w = w` を 5 つの `w` で見て、同じ `w` を対 `(x, y)` に直して本文の和で `(x, y)` に戻る。否定の対照: `1_C + z ≠ z` | **PASS** | 厳密等号 |

## 計算の帰属と範囲

ℂ は本文の `definition_of_cc` どおり実数の対で持ち（共通の準備 `_shared/complex_as_real_pairs.sage`）、`z = (a, b)` の `a, b` を
`QQ` 上の不定元に置いた。不定元で成り立つ等号は `a, b` に任意の実数を代入しても成り立つ。浮動小数点はない。
第三行の根拠「`ℝ` で `0 + x = x`」は `ℝ` の体の性質で、検算はこれを多項式環 `QQ[a, b, o]` の演算として使う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_zero_plus_is_original
```

実行ログは `sagemath/check/complex_zero_plus_is_original/logs/` に保存する。
