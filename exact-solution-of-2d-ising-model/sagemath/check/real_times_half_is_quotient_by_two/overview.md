# SageMath Check: real_times_half_is_quotient_by_two

## 対象

**対象ラベル**: `real_times_half_is_quotient_by_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_times_half_is_quotient_by_two`（`ℝ` で `a·(1/2) = a/2`）
- 範囲: 主張と、証明の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `a·(1/2) = a·(1·2^{-1})`（`def_real_quotient`（`y → 1, z → 2`）） | `check_proof_lines.sage` | `a` と `2` を有理関数体 `Frac(QQ[a, t])` の不定元 `a`・`t` に置き、恒等的に等しい | **PASS** | 厳密 |
| 2 行目 `= a·2^{-1}`（乗法の単位元 `1·x = x`（`x → 2^{-1}`）） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 3 行目 `= a/2`（`def_real_quotient`（`y → a, z → 2`）を右辺から左辺へ） | 同上 | 隣り合う行が恒等的に等しい | **PASS** | 厳密 |
| 鎖の両端 | 同上 | `t = 2`、`a ∈ {0, 1, −3, 7/5}` で両端がともに `a/2` | **PASS** | 厳密 |
| 否定コントロール | 同上 | 2 行目の `1` を `2` にすると、3 行目の `2^{-1}` を `2` にすると等しくない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と有理関数体 `Frac(QQ[a, t])` だけで計算した。浮動小数点は使わない。
- 範囲外: `QQ` 係数の有理関数としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_times_half_is_quotient_by_two
```

実行ログは `logs/` に保存する（2026-11-19、SageMath 10.9）。
