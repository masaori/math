# SageMath Check: inclusion_zz_to_rr_preserves_sum

## 対象

**対象ラベル**: `inclusion_zz_to_rr_preserves_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_preserves_sum`（`a, b ∈ ℤ` なら `ι(a+b) = ι(a)+ι(b)`）
- 範囲: `b = 0` の 3 行、`b → b+1`（`b ∈ ℤ_{≥0}`）の 5 行、`b → b-1`（`b ∈ ℤ_{≤0}`）の 12 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `b = 0`: `ι(a+0) = ι(a) = ι(a)+0 = ι(a)+ι(0)` | `check_proof_lines.sage` | `a = -30..30` で 3 個の等号（QQ） | **PASS** |
| `b → b+1`: `ι(a+(b+1)) = ι((a+b)+1) = ι(a+b)+1 = (ι(a)+ι(b))+1 = ι(a)+(ι(b)+1) = ι(a)+ι(b+1)` | `check_proof_lines.sage` | `a = -30..30`、`b = 0..30` で 5 個の等号（QQ。`ι(n+1) = ι(n)+1` は `inclusion_zz_to_rr_of_successor`） | **PASS** |
| `b → b-1`: `ι(a+(b-1)) = ι(a+(b-1))+0 = ι(a+(b-1))+(1+(-1)) = (ι(a+(b-1))+1)+(-1) = ι((a+(b-1))+1)+(-1) = ι(a+b)+(-1) = (ι(a)+ι(b))+(-1) = ι(a)+(ι(b)+(-1)) = ι(a)+(ι((b-1)+1)+(-1)) = ι(a)+((ι(b-1)+1)+(-1)) = ι(a)+(ι(b-1)+(1+(-1))) = ι(a)+(ι(b-1)+0) = ι(a)+ι(b-1)` | `check_proof_lines.sage` | `a = -30..30`、`b = -30..0` で 12 個の等号（QQ） | **PASS** |
| 主張 | `check_proof_lines.sage` | `a, b = -30..30` で主張と、組み込みの埋め込み `QQ(a+b)` との一致 | **PASS** |

等号は 39772 個。否定コントロール: 負の元の節を `ι'(-n) := ι(n)` に取り違えた写像 `ι'` では `ι'(1+(-1)) = 0 ≠ 2 = ι'(1)+ι'(-1)`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `-30 ≤ a, b ≤ 30`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の結合律・加法逆元をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_preserves_sum
```

実行ログは `logs/` に保存する。
