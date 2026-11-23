# SageMath Check: inclusion_nn_to_zz_preserves_product

## 対象

**対象ラベル**: `inclusion_nn_to_zz_preserves_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_nn_to_zz_preserves_product`（すべての `x, y ∈ ℕ` で `ι_{ℕ→ℤ}(x·y) = ι_{ℕ→ℤ}(x)·ι_{ℕ→ℤ}(y)`）
- 範囲: 主張と、証明の数学的帰納法の二つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `y = 0_ℕ` の鎖 `ι(x·0) = ι(0_ℕ) = 0_ℤ = 0_ℤ·ι(x) = ι(x)·0_ℤ = ι(x)·ι(0_ℕ)` | `check_proof_lines.sage` | `ι` を `inclusion_nn_to_zz` の二つの式だけで組み、`x = 0..40` で各段を `ZZ` で確かめる | **PASS** | 5 段、41 個の `x` |
| `y + 1_ℕ` の鎖 `ι(x(y + 1)) = ι(xy + x) = ι(xy) + ι(x) = ι(x)ι(y) + ι(x) = ι(x)ι(y) + ι(x)·1 = ι(x)(ι(y) + 1) = ι(x)ι(y + 1)` | 同上 | `x = 0..40`、`y = 0..39` で各段・帰納法の仮定・引く `inclusion_nn_to_zz_preserves_sum` の形を `ZZ` で確かめ、`int_zero_times_is_zero`・乗法の交換律・乗法の単位元・分配律の段の根拠の等式を `ZZ[a, b, c]` で恒等的に確かめる | **PASS** | 6 段、1640 組の `(x, y)`、恒等式 4 つ |
| 否定コントロール | 同上 | 帰納法の段で `ι(x)` を足し忘れると崩れる、分配律の段で `1_ℤ` の代わりに `ι(x)` を掛けると崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 整数 `ZZ` と多項式環 `ZZ[a, b, c]` だけで計算した。浮動小数点は使わない。
- 有限個の `(x, y)` で確かめたのは式変形の書き間違いの裏取りであり、証明ではない（すべての `x, y` についての主張は帰納法が与える）。
- `ι(x·0)`・`ι(x·y + x)` のように ℕ の式を引数に取る行は、Sage が引数の ℕ の計算を先に済ませるので、ℕ の積の再帰の式の段は数の上では書き間違いと区別できない。その段の正しさは本文と Lean の `rfl`（ℕ の積の定義の式）が受け持つ。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_nn_to_zz_preserves_product
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
