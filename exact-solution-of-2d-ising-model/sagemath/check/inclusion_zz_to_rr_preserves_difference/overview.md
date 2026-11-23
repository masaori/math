# SageMath Check: inclusion_zz_to_rr_preserves_difference

## 対象

**対象ラベル**: `inclusion_zz_to_rr_preserves_difference` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_preserves_difference`（`a, b ∈ ℤ` なら `ι(a-b) = ι(a)-ι(b)`。`ι` は `inclusion_zz_to_rr`）
- 範囲: 証明の 9 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `ι(a-b) = ι(a-b)+0 = ι(a-b)+(ι(b)+(-ι(b))) = (ι(a-b)+ι(b))+(-ι(b)) = ι((a-b)+b)+(-ι(b)) = ι((a+(-b))+b)+(-ι(b)) = ι(a+((-b)+b))+(-ι(b)) = ι(a+0)+(-ι(b)) = ι(a)+(-ι(b)) = ι(a)-ι(b)` | `check_proof_lines.sage` | `a, b = -30..30` で 9 個の等号（QQ。和は `inclusion_zz_to_rr_preserves_sum`、6 行目は `def_int_difference`、7〜9 行目は ℤ の和の結合律・加法逆元・和の単位元、最後の行は `def_real_difference`）と、`def_int_difference` の式 `a - b = a + (-b)`（ZZ） | **PASS** |
| 主張 | `check_proof_lines.sage` | `a, b = -30..30` で主張と、組み込みの埋め込み `QQ(a-b)` との一致 | **PASS** |

等号は 44652 個。否定コントロール: 定義の符号反転の節を `ι''(-n) := ι(n)` に取り違えた写像（`ι''(n) = |n|`）では `ι''(1-3) = 2 ≠ -2 = ι''(1)-ι''(3)`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `-30 ≤ a, b ≤ 30`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の環の法則をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_preserves_difference
```

実行ログは `logs/` に保存する。
