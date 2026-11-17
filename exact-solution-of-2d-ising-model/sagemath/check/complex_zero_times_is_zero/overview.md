# SageMath Check: complex_zero_times_is_zero

## 対象

**対象ラベル**: `complex_zero_times_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_zero_times_is_zero`（複素数に 0 を左から掛けると 0 になる）
- 範囲: 主張 `0_C z = 0_C` と、証明の六行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0_C z = (0,0)(a,b)`（包含写像の略記） | `check_chain_and_statement.sage` | 共通の準備の `iota(0)` が `(0, 0)` である | **PASS** | 厳密等号 |
| `= (0·a − 0·b, 0·b + 0·a)`（複素数の積の定義） | 同上 | 実数の 0 を不定元 `o` に置き、共通の準備の積 `(o, o)(a, b)` と、本文の行を写した `(o·a − o·b, o·b + o·a)` が等しい | **PASS** | 厳密等号 |
| `= (0 − 0, 0 + 0)`（`real_zero_times_is_zero` を 4 箇所） | 同上 | 第二行の 4 つの積がそれぞれ `o = 0` で 0 になり、第二行へ `o = 0` を代入した対が `(0 − 0, 0 + 0)` に等しい | **PASS** | 厳密等号 |
| `= (0, 0 + 0)`、`= (0, 0)`、`= 0_C` | 同上 | 各行の対を組み、隣り合う対が等しい。実数の定数の計算なので組んだ時点で一致し、確かめているのは対の写し間違いだけである | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | Sage の `QQ(i)`（独立な経路）で `0·w = 0` を 5 つの `w` で見て、同じ `w` を対 `(x, y)` に直して本文の積で `(0, 0)` になる | **PASS** | 厳密等号 |
| 鎖の `(0, 0 + 0) = (0, 0)`（`0` は ℝ の加法の単位元。`x + 0 = x` の `x → 0`。`set_and_algebra_notation`） | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入どおりに `QQ` の等号で。対照（`0 + 1 ≠ 0`） | **PASS** | 厳密（1 行） |

## 計算の帰属と範囲

ℂ は本文の `definition_of_cc` どおり実数の対で持ち（共通の準備 `_shared/complex_as_real_pairs.sage`）、`z = (a, b)` の `a, b` を
`QQ` 上の不定元に置いた。不定元で成り立つ等号は `a, b` に任意の実数を代入しても成り立つ。浮動小数点はない。
第三行の根拠 `real_zero_times_is_zero`（`ℝ` で `0·x = 0`。2026-11-14 に主張として足し、`sagemath/check/real_zero_times_is_zero/` が鎖を確かめる）、第四行の `0 − 0 = 0` は `real_minus_zero_is_self`（`a → 0`。2026-11-15 に名前だけの根拠から替えた。`sagemath/check/real_minus_zero_is_self/` が鎖を確かめる）、第五行の `0 + 0 = 0` は `ℝ` の体の性質で、検算はこれを多項式環 `QQ[a, b]` の演算として使う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_zero_times_is_zero
```

実行ログは `sagemath/check/complex_zero_times_is_zero/logs/` に保存する。
