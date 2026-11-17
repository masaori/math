# SageMath Check: product_of_sums_of_two_squares_identity

## 対象

**対象ラベル**: `product_of_sums_of_two_squares_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_product_of_sums_of_two_squares_identity`（2 つの平方和の積の恒等式）
- 範囲: 主張 `(ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²)`（`a, b, c, d ∈ ℝ`）と、証明の五行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の五行 | `check_identity_chain.sage` | 鎖の六つの項を各行に書かれた式どおりに組み、隣り合う項が等しい。第 3 の等号の根拠（`-2abcd` と `2abcd` の和が `0`）も確かめる | **PASS** | 五行すべて厳密等号 |
| 対照 | 同上 | 第 2 成分を `ad−bc` に誤ると恒等式は成り立たない | **PASS** | 対照は不一致 |

## 計算の帰属と範囲

`a, b, c, d` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。
多項式環は可換なので、ℝ の分配律・結合律・可換律のどれをどこへ当てたかは検算では区別できない。各行の式が等しいことだけを確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh product_of_sums_of_two_squares_identity
```

実行ログは `sagemath/check/product_of_sums_of_two_squares_identity/logs/` に保存する（2026-11-17）。
