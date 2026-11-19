# SageMath Check: real_twice_quotient_by_two_is_original

## 対象

**対象ラベル**: `real_twice_quotient_by_two_is_original` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_twice_quotient_by_two_is_original`（`ℝ` で `2·(b/2) = b`）
- 範囲: 主張と、証明の 5 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `2·(b/2) = 2·(b·2^{-1})`（`def_real_quotient`（`y → b, z → 2`）） | `check_proof_lines.sage` | `b` と `2` を有理関数体 `Frac(QQ[b, t])` の不定元 `b`・`t` に置き、恒等的に等しい | **PASS** | 厳密 |
| 2 行目 `= 2·(2^{-1}·b)`（乗法の交換律（`x → b, y → 2^{-1}`）） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 3 行目 `= (2·2^{-1})·b`（乗法の結合律を右辺から左辺へ） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 4 行目 `= 1·b`（乗法の逆元 `x·x^{-1} = 1`（`x → 2`）） | 同上 | 隣り合う行が恒等的に等しく、`t·t^{-1} = 1` | **PASS** | 厳密 |
| 5 行目 `= b`（乗法の単位元 `1·x = x`（`x → b`）） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 鎖の両端 | 同上 | `t = 2`、`b ∈ {0, 1, −3, 7/5}` で両端がともに `b` | **PASS** | 厳密 |
| 否定コントロール | 同上 | 4 行目の `1` を `2` にすると、1 行目の `2^{-1}` を `2` にすると等しくない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と有理関数体 `Frac(QQ[b, t])` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の有理関数としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_twice_quotient_by_two_is_original
```

実行ログは `logs/` に保存する（2026-11-19、SageMath 10.9）。
