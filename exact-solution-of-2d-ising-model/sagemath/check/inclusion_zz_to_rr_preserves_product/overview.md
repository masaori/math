# SageMath Check: inclusion_zz_to_rr_preserves_product

## 対象

**対象ラベル**: `inclusion_zz_to_rr_preserves_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_preserves_product`（`a, b ∈ ℤ` なら `ι(ab) = ι(a)ι(b)`。`ι` は `inclusion_zz_to_rr`）
- 範囲: `b = 0` の 4 行、`b → b+1`（`b ∈ ℤ_{≥0}`）の 7 行、`b → b-1`（`b ∈ ℤ_{≤0}`）の 15 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `b = 0`: `ι(a·0) = ι(0) = 0 = ι(a)·0 = ι(a)ι(0)` | `check_proof_lines.sage` | `a = -30..30` で 4 個の等号（QQ。`x·0 = 0` は `real_times_zero_is_zero`） | **PASS** |
| `b → b+1`: `ι(a(b+1)) = ι(ab+a·1) = ι(ab+a) = ι(ab)+ι(a) = ι(a)ι(b)+ι(a) = ι(a)ι(b)+ι(a)·1 = ι(a)(ι(b)+1) = ι(a)ι(b+1)` | `check_proof_lines.sage` | `a = -30..30`、`b = 0..30` で 7 個の等号（QQ。和は `inclusion_zz_to_rr_preserves_sum`、`ι(n+1) = ι(n)+1` は `inclusion_zz_to_rr_of_successor`） | **PASS** |
| `b → b-1`: `ι(a(b-1)) = ι(a(b-1))+0 = ι(a(b-1))+(ι(a)+(-ι(a))) = (ι(a(b-1))+ι(a))+(-ι(a)) = ι(a(b-1)+a)+(-ι(a)) = ι((ab-a·1)+a)+(-ι(a)) = ι((ab-a)+a)+(-ι(a)) = ι(ab)+(-ι(a)) = ι(a)ι(b)+(-ι(a)) = ι(a)ι((b-1)+1)+(-ι(a)) = ι(a)(ι(b-1)+1)+(-ι(a)) = (ι(a)ι(b-1)+ι(a)·1)+(-ι(a)) = (ι(a)ι(b-1)+ι(a))+(-ι(a)) = ι(a)ι(b-1)+(ι(a)+(-ι(a))) = ι(a)ι(b-1)+0 = ι(a)ι(b-1)` | `check_proof_lines.sage` | `a = -30..30`、`b = -30..0` で 15 個の等号（QQ） | **PASS** |
| 主張 | `check_proof_lines.sage` | `a, b = -30..30` で主張と、組み込みの埋め込み `QQ(ab)` との一致 | **PASS** |

等号は 49288 個。否定コントロール: 定義の後者の節を `ι''(n+1) := ι''(n)+2` に取り違えた写像（`ι''(n) = 2n`）では `ι''(3·(-2)) = -12 ≠ -24 = ι''(3)ι''(-2)`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `-30 ≤ a, b ≤ 30`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の環の法則をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_preserves_product
```

実行ログは `logs/` に保存する。
