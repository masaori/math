# SageMath Check: int_negation_times_is_negation_of_product

## 対象

**対象ラベル**: `int_negation_times_is_negation_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_negation_times_is_negation_of_product`（`x, t ∈ ℤ` について `(−x)·t = −(x·t)`）
- 範囲: 主張と、証明の 7 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 7 行の鎖（`(−x)t = (−x)t + 0 = (−x)t + (xt + (−(xt))) = ((−x)t + xt) + (−(xt)) = ((−x) + x)t + (−(xt)) = 0t + (−(xt)) = 0 + (−(xt)) = −(xt)`） | `check_proof_lines.sage` | 5 行目の `0`（`(−x) + x` を置き換えた `0`）を `ZZ[x, t, o]` の不定元 `o` に置き、`(−y) + y = 0` を当てる段と `int_zero_times_is_zero` を当てる段以外の 5 段が恒等的に等しいこと、その 2 段の前後の差がそれぞれ `((−x) + x − o)t` と `o·t` で `o = 0` で消えることを確かめる | **PASS** | 厳密（等号 7 個） |
| 各行の根拠の形（和の単位元 `y + 0 = y`・`0 + y = y`、加法の逆元 `y + (−y) = 0`・`(−y) + y = 0`、加法の結合律、分配律 `(y + z)s = ys + zs`） | 同上 | 行に書いた代入で形の両辺を作って等しいことを確かめる。多項式環は式を正規化するので、形の左右と「右辺から左辺へ」の向きは区別できず、それはレビューの目視で確かめる | **PASS** | 厳密（6 つ） |
| 主張 `(−x)·t = −(x·t)` | 同上 | 整数 `−15..15` の全ての組で、`o = 0` を代入した全ての行と主張が `−(xt)` に等しいこと | **PASS** | 961 件 |
| 否定コントロール | 同上 | `o` が一般の値なら `0t = 0` の段は成り立たない。分配律の段で `x` を `1` に取り違えると 4 行目と一致しない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `ZZ[x, t, o]` と `ZZ` だけで計算した。浮動小数点は使わない。
- 範囲外: 検算は式変形の書き間違いの裏取りであり、証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_negation_times_is_negation_of_product
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
