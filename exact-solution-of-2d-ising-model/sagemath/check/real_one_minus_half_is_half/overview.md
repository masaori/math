# SageMath Check: real_one_minus_half_is_half

## 対象

**対象ラベル**: `real_one_minus_half_is_half` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_one_minus_half_is_half`（`ℝ` で `1 − 1/2 = 1/2`）
- 範囲: 主張と、証明の 8 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `1 − 1/2 = 1 + (−1/2)`（`def_real_difference`） | `check_proof_lines.sage` | `2` を有理関数体 `Frac(QQ[t])` の不定元 `t` に置き、恒等的に等しい | **PASS** | 厳密 |
| 2 行目 `= 2·2^{-1} + (−1/2)`（乗法の逆元） | 同上 | `t·t^{-1} = 1` が `Frac(QQ[t])` で恒等的に成り立ち、行どうしが等しい | **PASS** | 厳密 |
| 3 行目 `= (1 + 1)·2^{-1} + (−1/2)`（`def_real_two`） | 同上 | `t = 2` のときに等しく、`t` のままでは等しくない（`2 = 1 + 1` を使う行であること） | **PASS** | 厳密 |
| 4〜8 行目（分配律・`def_real_quotient` を右辺から左辺へ・加法の結合律・加法の逆元・加法の単位元） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 鎖の両端 | 同上 | `QQ` で `1 − 1/2 = 1/2`、`t = 2` で 1 行目と 8 行目の右辺が `1/2` | **PASS** | 厳密 |
| 否定コントロール | 同上 | `t = 3` では両端が等しくない、分配律の行で項を 1 つ落とすと等しくない、3 行目は `t` のままでは等しくない | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と有理関数体 `Frac(QQ[t])` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の有理関数としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_one_minus_half_is_half
```

実行ログは `logs/` に保存する（2026-11-19、SageMath 10.9）。
