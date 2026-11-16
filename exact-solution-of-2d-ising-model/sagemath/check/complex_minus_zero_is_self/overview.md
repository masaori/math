# SageMath Check: complex_minus_zero_is_self

## 対象

**対象ラベル**: `complex_minus_zero_is_self` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_minus_zero_is_self`（複素数から 0 を引いても変わらない）
- 範囲: 主張 `z - 0_C = z` と、証明の四行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `z - 0_C = z + (-0_C)`（`def_complex_difference`、`w → 0_C`） | `check_chain_and_statement.sage` | `-0_C` を不定元の対 `(p, q)` に置いた本文の行 `z + (p, q)` へ、共通の準備の `-0_C` を代入すると共通の準備の差 `z - 0_C` に一致する | **PASS** | 厳密等号 |
| `= z + (-1_C) 0_C`（`multiply_by_minus_one`、`z → 0_C`） | 同上 | `0_C` の 2 つの成分を別々の不定元に置いた `(-1_C)(o1, o2)` が `(-o1, -o2)` で、`o1 = o2 = 0` で共通の準備の `-0_C` に一致する | **PASS** | 厳密等号 |
| `= z + 0_C`（`complex_times_zero_is_zero`、`z → -1_C`） | 同上 | `(-1_C) 0_C = 0_C`、その和が `z + 0_C` に一致する | **PASS** | 厳密等号 |
| `= z`（`complex_numbers_form_a_field` の加法の単位元） | 同上 | `z + (o1, o2) = (a + o1, b + o2)` が `o1 = o2 = 0` で `z` になる | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | 本文の差で `z - 0_C = z`。Sage の `QQ(i)`（独立な経路）で `w - 0 = w` を 5 つの `w` で見て、同じ `w` を対 `(x, y)` に直して本文の差で `(x, y)` に戻る。否定の対照: `z - 1_C ≠ z`、`0_C - z ≠ z`、`1_C (o1, o2) ≠ (-o1, -o2)`、第二行の成分を入れ替えた `(-o2, -o1)` と一致しない | **PASS** | 厳密等号 |

## 計算の帰属と範囲

ℂ は本文の `definition_of_cc` どおり実数の対で持ち（共通の準備 `_shared/complex_as_real_pairs.sage`）、`z = (a, b)` の `a, b` を
`QQ` 上の不定元に置いた。不定元で成り立つ等号は `a, b` に任意の実数を代入しても成り立つ。浮動小数点はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_minus_zero_is_self
```

実行ログは `sagemath/check/complex_minus_zero_is_self/logs/` に保存する。
