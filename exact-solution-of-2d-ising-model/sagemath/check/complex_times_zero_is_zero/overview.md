# SageMath Check: complex_times_zero_is_zero

## 対象

**対象ラベル**: `complex_times_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_times_zero_is_zero`（複素数に 0 を右から掛けると 0 になる）
- 範囲: 主張 `z 0_C = 0_C` と、証明の六行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `z 0_C = (a,b)(0,0)`（包含写像の略記） | `check_chain_and_statement.sage` | 共通の準備の `iota(0)` が `(0, 0)` である | **PASS** | 厳密等号 |
| `= (a·0 − b·0, a·0 + b·0)`（複素数の積の定義） | 同上 | 実数の 0 を不定元 `o` に置き、共通の準備の積 `(a, b)(o, o)` と、本文の行を写した `(a·o − b·o, a·o + b·o)` が等しい | **PASS** | 厳密等号 |
| `= (0 − 0, 0 + 0)`（`x·0 = 0` を 4 箇所） | 同上 | 第二行の 4 つの積がそれぞれ `o = 0` で 0 になり、第二行へ `o = 0` を代入した対が `(0 − 0, 0 + 0)` に等しい | **PASS** | 厳密等号 |
| `= (0, 0 + 0)`、`= (0, 0)`、`= 0_C` | 同上 | 各行の対を組み、隣り合う対が等しい。実数の定数の計算なので組んだ時点で一致し、確かめているのは対の写し間違いだけである | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | Sage の `QQ(i)`（独立な経路）で `w·0 = 0` を 5 つの `w` で見て、同じ `w` を対 `(x, y)` に直して本文の積で `(0, 0)` になる | **PASS** | 厳密等号 |

## 計算の帰属と範囲

ℂ は本文の `definition_of_cc` どおり実数の対で持ち（共通の準備 `_shared/complex_as_real_pairs.sage`）、`z = (a, b)` の `a, b` を
`QQ` 上の不定元に置いた。不定元で成り立つ等号は `a, b` に任意の実数を代入しても成り立つ。浮動小数点はない。
第三行の根拠「`ℝ` で `x·0 = 0`」・第四行の `0 − 0 = 0`・第五行の `0 + 0 = 0` は `ℝ` の体の性質で、検算はこれを多項式環 `QQ[a, b]` の演算として使う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_times_zero_is_zero
```

実行ログは `sagemath/check/complex_times_zero_is_zero/logs/` に保存する。
