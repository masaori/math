# SageMath Check: inclusion_nn_to_zz_preserves_order

## 対象

**対象ラベル**: `inclusion_nn_to_zz_preserves_order` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_nn_to_zz_preserves_order`（`x, y ∈ ℕ` が `x ≤ y` なら `ι_{ℕ→ℤ}(x) ≤ ι_{ℕ→ℤ}(y)`）
- 範囲: 主張と、証明の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| ℕ の順序と和で `x + d = y` の `d` を取る | `check_proof_lines.sage` | `x ≤ y`（`x, y = 0..60`）の各組で、`x + d = y` を満たす `d` が `0..60` にただ一つあることを数える | **PASS** | 1891 組 |
| 鎖 `ι(x) = 0 + ι(x) ≤ ι(d) + ι(x) = ι(x) + ι(d) = ι(x + d) = ι(y)` | 同上 | `ι` を `inclusion_nn_to_zz` の二つの式だけで組み、同じ組で等号の段は等しく、`≤` の段は `≤` が成り立つことを `ZZ` で確かめる。根拠の `inclusion_nn_to_zz_image_is_nonnegative`・`inclusion_nn_to_zz_preserves_sum` もその組で確かめ、和の単位元・加法の交換律の等式を `ZZ[a, b]` で恒等的に確かめる | **PASS** | 5 段、恒等式 2 つ |
| 否定コントロール | 同上 | `x > y` の組では結論が崩れる、`≤` の段を等号と取り違えると `d ≥ 1` で崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 整数 `ZZ` と多項式環 `ZZ[a, b]` だけで計算した。浮動小数点は使わない。
- 有限個の `(x, y)` で確かめたのは式変形の書き間違いの裏取りであり、証明ではない。
- ℕ の順序と和（`x ≤ y ⇔ ∃d, x + d = y`）は外から持ち込む性質で、検算は範囲の中で `d` が一つ見つかることだけを数える。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_nn_to_zz_preserves_order
```

実行ログは `logs/` に保存する（2026-11-24、SageMath 10.9）。
