# SageMath Check: product_of_sums_of_two_squares_identity

## 対象

**対象ラベル**: `product_of_sums_of_two_squares_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_product_of_sums_of_two_squares_identity`（2 つの平方和の積の恒等式）
- 範囲: 主張 `(ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²)`（`a, b, c, d ∈ ℝ`）と、証明の 2 本の鎖（準備の `(ad)(bc) = (ac)(bd)` の五行と、主張の二十八行）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の鎖の五行 | `check_identity_chain.sage` | `(ad)(bc)` から `(ac)(bd)` までの六つの項を各行に書かれた式どおり（括弧も行のとおり）に組み、隣り合う項が等しい | **PASS** | 五行すべて厳密等号 |
| 主の鎖の二十八行 | 同上 | 主張の左辺から右辺までの二十九の項を各行に書かれた式どおり（括弧も行のとおり）に組み、隣り合う項が等しい。両端が主張の両辺に一致する | **PASS** | 二十八行すべて厳密等号 |
| 各行の根拠の等式 | 同上 | 両方の鎖の各行の根拠に書いた等式の形（二乗と積・差の定義・分配則・符号反転の等式・積と加法の結合律と可換則・加法の逆元・0 の単位元・冪の積）を関数として持ち、行に書いた代入（50 組。同じ代入を 2 箇所へ当てた行は 1 組。準備の等式 `(ad)(bc) = (ac)(bd)` を当てた行は準備の鎖が確かめる）から実例を作って両辺が等しい | **PASS** | 50 組すべて厳密等号 |
| 対照 | 同上 | 第 2 成分を `ad−bc` に誤ると恒等式は成り立たない | **PASS** | 対照は不一致 |

## 計算の帰属と範囲

`a, b, c, d` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。
多項式環は可換なので、ℝ の分配律・結合律・可換律のどれをどこへ当てたかは検算では区別できない。各行の式が等しいことと、各行が当てた等式の実例が成り立つことだけを確かめる（行の左の項のどの部分へ当てたかは目で確かめる）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh product_of_sums_of_two_squares_identity
```

実行ログは `sagemath/check/product_of_sums_of_two_squares_identity/logs/` に保存する（2026-11-17、2026-11-18 に鎖を 2 本・計三十三行にして再実行）。
