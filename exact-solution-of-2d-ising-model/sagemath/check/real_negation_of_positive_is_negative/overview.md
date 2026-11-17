# SageMath Check: real_negation_of_positive_is_negative

## 対象

**対象ラベル**: `real_negation_of_positive_is_negative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_negation_of_positive_is_negative`（`ℝ` で `0 < a` なら `−a < 0`）
- 範囲: 主張と、証明の鎖 `−a = 0 + (−a) < a + (−a) = 0`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖 `−a = 0 + (−a) < a + (−a) = 0`（加法の単位元を右辺から左辺へ、順序と加法の両立、`def_real_difference` の加法の逆元） | `check_proof_lines.sage` | `QQ[a, na]`（`na` は `−a`）で、等号は恒等的、またはイデアル `(a + na)` に入る。不等号は差が `a − 0` で同じ `c = −a` を足しただけ | **PASS** | 厳密 3 段 |
| 順序と加法の両立（公理の形） | 同上 | 有理数の標本 | **PASS** | 50 件 |
| 主張 `0 < a ⇒ −a < 0` と鎖の各値 | 同上 | `QQ` と `AA` の正の標本 | **PASS** | 13 件 |
| 否定コントロール | 同上 | 加法の逆元の前提を外すと `a + (−a) = 0` は成り立たない。`0 < a` を外すと主張は偽（`a = −2`） | **PASS** | 2 件 |
| ℝ の単位元を引く行（`set_and_algebra_notation`）: `−a = 0 + (−a)（0 + x = x の x → −a を右辺から左辺へ）` | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈の穴にそれを入れたものと `QQ` 上の多項式環（または分数体）で等しいことを確かめる。多項式環は式を正規化するので、形の左右と「右辺から左辺へ」の向きは区別できず、それはレビューの目視で確かめた。対照（`0 + 1 ≠ 0`・`2·3 ≠ 3`） | **PASS** | 厳密（1 行） |

## 計算の帰属と範囲

- **厳密**: `QQ`・`AA` と多項式環 `QQ[a, na]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: 不等号の段は有理数の標本で公理の形を確かめるだけで、ℝ の順序体の公理からの証明ではない。
  検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_negation_of_positive_is_negative
```

実行ログは `logs/` に保存する（2026-11-17、SageMath 10.9）。
