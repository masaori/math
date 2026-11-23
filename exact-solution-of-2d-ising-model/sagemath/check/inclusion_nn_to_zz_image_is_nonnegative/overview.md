# SageMath Check: inclusion_nn_to_zz_image_is_nonnegative

## 対象

**対象ラベル**: `inclusion_nn_to_zz_image_is_nonnegative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_nn_to_zz_image_is_nonnegative`（すべての `n ∈ ℕ` で `0_ℤ ≤ ι_{ℕ→ℤ}(n)`）
- 範囲: 主張と、証明の数学的帰納法の二つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `n = 0_ℕ` の鎖 `0_ℤ ≤ 0_ℤ = ι(0_ℕ)` | `check_proof_lines.sage` | `ι` を `inclusion_nn_to_zz` の二つの式だけで組み、各段を `ZZ` で確かめる | **PASS** | 2 段 |
| `n + 1_ℕ` の鎖 `0 = 0 + 0 ≤ 1 + 0 = 0 + 1 ≤ ι(n) + 1 = ι(n + 1_ℕ)` | 同上 | `n = 0..199` で各段の等号・不等号と帰納法の仮定を `ZZ` で確かめ、和の単位元・加法の交換律の段の根拠の等式を `ZZ[y]` で恒等的に確かめる | **PASS** | 200 個の `n`、恒等式 2 つ |
| 主張 | 同上 | `n = 0..200` で `0 ≤ ι(n)`、組んだ `ι` が `ZZ` への包含と一致すること | **PASS** | 201 個の `n` |
| 否定コントロール | 同上 | 再帰の式で 1 を引くと `n = 1` で結論が崩れる、`int_zero_at_most_one` を逆向きの `1 ≤ 0` と取り違えると 2 行目が `1 + 0 ≤ 0 + 0` になり崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 整数 `ZZ` と多項式環 `ZZ[y]` だけで計算した。浮動小数点は使わない。
- 有限個の `n` で確かめたのは式変形の書き間違いの裏取りであり、証明ではない（すべての `n` についての主張は帰納法が与える）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_nn_to_zz_image_is_nonnegative
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
