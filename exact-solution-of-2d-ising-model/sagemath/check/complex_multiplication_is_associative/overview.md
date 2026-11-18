# SageMath Check: complex_multiplication_is_associative

## 対象

**対象ラベル**: `complex_multiplication_is_associative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_complex_multiplication_is_associative`（ℂ の積の結合律）
- 範囲: 主張 `(z·w)·u = z·(w·u)`（`z, w, u ∈ ℂ`。`0_ℂ` を含む）と、証明の十九行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の十九行 | `check_component_chain.sage` | 鎖の二十の項を各行に書かれた式どおり（括弧も行のとおり）に組み（積は `definition_of_cc` の式どおり `_prelude.sage` で組む）、隣り合う項が等しい | **PASS** | 十九行すべて厳密等号 |
| 各行の根拠の等式 | 同上 | 第 4〜第 16 の等号の根拠に書いた等式の形（差の定義・分配則・符号反転の等式・積と加法の結合則・加法の可換則）を関数として持ち、行に書いた代入（34 組。同じ代入を 2 箇所へ当てた差の定義は 1 組）から実例を作って両辺が等しい | **PASS** | 34 組すべて厳密等号 |
| 対照 | 同上 | 積の第 2 成分の符号を誤った積では結合の仕方で値が変わる | **PASS** | 対照は不一致 |

## 計算の帰属と範囲

`a, b, c, d, e, f` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
鎖は不定元で成り立つので、`0_ℂ` を含む全ての元で成り立つ（主張が `ℂ^×` に限らないことの根拠はこれである）。
浮動小数点と `RR` / `CC` への脱出はない。
多項式環は可換なので、ℝ の分配律・結合律・可換律のどれをどこへ当てたかは検算では区別できない。各行の式が等しいことと、各行が当てた等式の実例が成り立つことだけを確かめる（行の左の項のどの部分へ当てたかは目で確かめる）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_multiplication_is_associative
```

実行ログは `sagemath/check/complex_multiplication_is_associative/logs/` に保存する（2026-11-17、2026-11-18 に鎖を十九行にして再実行）。
