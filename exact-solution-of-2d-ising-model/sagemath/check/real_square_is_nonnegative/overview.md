# SageMath Check: real_square_is_nonnegative

## 対象

**対象ラベル**: `real_square_is_nonnegative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_square_is_nonnegative`（`r ∈ ℝ` について `0 ≤ r^2`）
- 範囲: 主張と、証明の二つの場合の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0 ≤ r` の場合の鎖 `0 ≤ r r = r^2` | `check_proof_lines.sage` | 等号を `QQ[r, nr]` で、不等号を有理数の標本で | **PASS** | 厳密 1 段、標本 |
| `¬(0 ≤ r)` の場合の `r ≤ 0`（全順序）と鎖 `0 = r + (−r) ≤ 0 + (−r) = −r`、`0 ≤ (−r)(−r) = r r = r^2` | 同上 | 等号の 3 段は `QQ[r, nr]`（`nr` は `−r`）でイデアル `(r + nr)` への所属、または恒等的。不等号の段と全順序は有理数の標本 | **PASS** | 厳密 3 段、標本 |
| 主張 `0 ≤ r^2` | 同上 | 有理数の標本 183 件 | **PASS** | 成り立つ |
| 否定コントロール | 同上 | 加法の逆元を外すと `(−r)(−r) = r r` が出ない。符号反転どうしの積の段を `(−r) r` にすると負の `r` で崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と多項式環 `QQ[r, nr]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: 不等号の段は有理数の標本で公理の形を確かめるだけで、`ℝ` の順序の公理からの証明ではない。
  検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_square_is_nonnegative
```

実行ログは `logs/` に保存する（2026-11-28、SageMath 10.9）。
