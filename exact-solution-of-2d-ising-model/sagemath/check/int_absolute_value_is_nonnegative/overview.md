# SageMath Check: int_absolute_value_is_nonnegative

## 対象

**対象ラベル**: `int_absolute_value_is_nonnegative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_absolute_value_is_nonnegative`（`x ∈ ℤ` について `0 ≤ |x|`）
- 範囲: 主張と、証明の二つの場合の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0 ≤ x` の場合の鎖 `0 ≤ x = |x|` | `check_proof_lines.sage` | 整数の標本で、場合の仮定と `def_int_absolute_value` の場合分けの式 | **PASS** | 41 件 |
| `¬(0 ≤ x)` の場合の `x ≤ 0`（全順序）と鎖 `0 = x + (−x) ≤ 0 + (−x) = −x = |x|` | 同上 | 等号の 2 段は `ZZ[x, nx]`（`nx` は `−x`）でイデアル `(x + nx)` への所属、または恒等的。不等号の段と全順序は整数の標本 | **PASS** | 厳密 2 段、標本 200 件 |
| 主張 `0 ≤ |x|` と Sage の `abs` との一致 | 同上 | 整数の標本 | **PASS** | 81 件 |
| 否定コントロール | 同上 | 加法の逆元を外すと `0 = x + (−x)` が出ない。場合分けの二つ目の式を `x` にすると主張が崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `ZZ` と多項式環 `ZZ[x, nx]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: 不等号の段は整数の標本で公理の形を確かめるだけで、`ℤ` の順序の公理からの証明ではない。
  検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_absolute_value_is_nonnegative
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
